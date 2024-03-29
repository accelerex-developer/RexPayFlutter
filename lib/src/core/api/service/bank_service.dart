import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:rexpay/src/core/api/model/transaction_api_response.dart';
import 'package:rexpay/src/core/api/request/bank_charge_request_body.dart';
import 'package:rexpay/src/core/api/service/base_service.dart';
import 'package:rexpay/src/core/api/service/contracts/banks_service_contract.dart';
import 'package:rexpay/src/core/common/exceptions.dart';
import 'package:rexpay/src/core/constants/constants.dart';
import 'package:rexpay/src/models/auth_keys.dart';

class BankService with BaseApiService implements BankServiceContract {
  @override
  Future<TransactionApiResponse> getTransactionStatus(String transRef, AuthKeys authKeys) async {
    Response response = await apiPostRequests(
      "${getBaseUrl(authKeys.mode)}cps/v1/getTransactionStatus",
      {"transactionReference": transRef},
      header: {'authorization': 'Basic ${base64Encode(utf8.encode('${authKeys.username}:${authKeys.password}'))}'},
    );

    var body = response.data;
    var statusCode = response.statusCode;

    if (statusCode == HttpStatus.ok) {
      return TransactionApiResponse.fromGetTransactionStatus(body!);
    } else {
      throw ChargeException('Bank transaction failed with '
          'status code: $statusCode and response: $body');
    }
  }

  @override
  Future<TransactionApiResponse> chargeBank(BankChargeRequestBody? credentials, AuthKeys authKeys) async {
    try {
      Response response = await apiPostRequests(
        "${getBaseUrl(authKeys.mode)}cps/v1/initiateBankTransfer",
        credentials!.toChargeBankJson(),
        header: {'authorization': 'Basic ${base64Encode(utf8.encode('${authKeys.username}:${authKeys.password}'))}'},
      );

      var body = response.data;
      var statusCode = response.statusCode;

      if (statusCode == HttpStatus.ok) {
        return TransactionApiResponse.fromChargeCardMap(body!);
      } else {
        throw ChargeException('Bank transaction failed with '
            'status code: $statusCode and response: $body');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TransactionApiResponse> createPayment(BankChargeRequestBody? credentials, AuthKeys authKeys) async {
    try {
      Response response = await apiPostRequests(
        "${getBaseUrl(authKeys.mode, type: 'pgs')}pgs/payment/v2/createPayment",
        credentials!.toInitialJson(),
        header: {'authorization': 'Basic ${base64Encode(utf8.encode('${authKeys.username}:${authKeys.password}'))}'},
      );

      var body = response.data;
      var statusCode = response.statusCode;

      if (statusCode == HttpStatus.ok) {
        return TransactionApiResponse.fromCreateTransaction(body!);
      } else {
        throw ChargeException('Bank transaction failed with '
            'status code: $statusCode and response: $body');
      }
    } catch (e) {
      rethrow;
    }
  }

  String getBaseUrl(Mode mode, {String type = 'cps'}) {
    if (mode == Mode.live) {
      if (type == 'pgs') {
         return "$LIVE_PGS_BASE_URL/api/";
      }
      return "$LIVE_CPS_BASE_URL/api/";
    }
    return "$TEST_BASE_URL/api/";
  }
}
