import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rexpay/src/core/api/model/transaction_api_response.dart';
import 'package:rexpay/src/core/api/request/card_request_body.dart';
import 'package:rexpay/src/core/api/request/validate_request_body.dart';
import 'package:rexpay/src/core/api/service/contracts/cards_service_contract.dart';
import 'package:rexpay/src/core/common/exceptions.dart';
import 'package:rexpay/src/core/common/my_strings.dart';
import 'package:rexpay/src/core/common/rexpay.dart';
import 'package:rexpay/src/models/auth_keys.dart';
import 'package:rexpay/src/models/charge.dart';
import 'package:rexpay/src/models/checkout_response.dart';
import 'package:rexpay/src/transaction/base_transaction_manager.dart';

class CardTransactionManager extends BaseTransactionManager {
  late ValidateRequestBody validateRequestBody;
  late CardRequestBody chargeRequestBody;
  final CardServiceContract service;
  // var _invalidDataSentRetries = 0;

  CardTransactionManager({
    required Charge charge,
    required this.service,
    required BuildContext context,
    required AuthKeys authKeys,
  })  : assert(charge.card != null, 'please add a card to the charge before ' 'calling chargeCard'),
        super(
          charge: charge,
          context: context,
          authKeys: authKeys,
        );

  @override
  postInitiate() {
    chargeRequestBody = CardRequestBody(charge, authKeys);
    validateRequestBody = ValidateRequestBody();
  }

  Future<CheckoutResponse> _validate() async {
    try {
      return _validateChargeOnServer();
    } catch (e) {
      return notifyProcessingError(e);
    }
  }

  Future<CheckoutResponse> _validateChargeOnServer() {
    Future<TransactionApiResponse> future = service.authorizeCharge(chargeRequestBody, authKeys);
    return handleServerResponse(future);
  }

  @override
  Future<CheckoutResponse> sendChargeOnServer() {
    
    Future<TransactionApiResponse> future = service.chargeCard(chargeRequestBody, authKeys);
    return handleServerResponse(future);
  }

  @override
  Future<CheckoutResponse> handleApiResponse(TransactionApiResponse apiResponse) async {
    var status = apiResponse.status;
    if (status == '1' || status == 'success') {
      setProcessingOff();
      return onSuccess(transaction);
    }

    if (status == '2') {
      return getPinFrmUI();
    }

    return notifyProcessingError(RexpayException(Strings.unKnownResponse));
  }


  @override
  Future<CheckoutResponse> handleOtpInput(String otp, TransactionApiResponse? response) {
    validateRequestBody.token = otp;
    return _validate();
  }

  @override
  CheckoutMethod checkoutMethod() => CheckoutMethod.card;
}
