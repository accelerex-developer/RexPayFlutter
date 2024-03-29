// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:rexpay/src/core/api/model/transaction_api_response.dart';
// import 'package:rexpay/src/core/api/request/bank_charge_request_body.dart';
// import 'package:rexpay/src/core/api/service/contracts/banks_service_contract.dart';
// import 'package:rexpay/src/core/common/exceptions.dart';
// import 'package:rexpay/src/core/common/my_strings.dart';
// import 'package:rexpay/src/core/common/rexpay.dart';
// import 'package:rexpay/src/models/auth_keys.dart';
// import 'package:rexpay/src/models/charge.dart';
// import 'package:rexpay/src/models/checkout_response.dart';
// import 'package:rexpay/src/transaction/base_transaction_manager.dart';

// class BankTransactionManager extends BaseTransactionManager {
//   BankChargeRequestBody? chargeRequestBody;
//   final BankServiceContract service;

//   BankTransactionManager({
//     required this.service,
//     required Charge charge,
//     required BuildContext context,
//     required AuthKeys authKeys,
//   }) : super(
//           charge: charge,
//           context: context,
//           authKeys: authKeys,
//         );

//   Future<CheckoutResponse> chargeBank() async {
//     await initiate();
//     return sendCharge();
//   }

//   @override
//   postInitiate() {
//     chargeRequestBody = BankChargeRequestBody(charge);
//   }

//   @override
//   Future<CheckoutResponse> sendChargeOnServer() {
//     return _getTransactionId();
//   }

//   Future<CheckoutResponse> _getTransactionId() async {
//     // String? id = await service.getTransactionId(chargeRequestBody!.accessCode);
//     // if (id == null || id.isEmpty) {
//     //   return notifyProcessingError('Unable to verify access code');
//     // }

//     // chargeRequestBody!.transactionId = id;
//     return _chargeAccount();
//   }

//   Future<CheckoutResponse> _chargeAccount() {
//     Future<TransactionApiResponse> future = service.chargeBank(chargeRequestBody, authKeys);
//     return handleServerResponse(future);
//   }

//   @override
//   Future<CheckoutResponse> handleApiResponse(TransactionApiResponse response) async {
//     var auth = response.auth;

//     if (response.status == 'success') {
//       setProcessingOff();
//       return onSuccess(transaction);
//     }

//     if (auth == 'failed' || auth == 'timeout') {
//       return notifyProcessingError(new ChargeException(response.message));
//     }

//     // if (auth == 'birthday') {
//     //   return getBirthdayFrmUI(response);
//     // }

//     if (auth == 'payment_token' || auth == 'registration_token') {
//       return getOtpFrmUI(response: response);
//     }

//     return notifyProcessingError(RexpayException(response.message ?? Strings.unKnownResponse));
//   }

//   @override
//   Future<CheckoutResponse> handleOtpInput(String token, TransactionApiResponse? response) {
//     // chargeRequestBody!.token = token;
    
//     return _handleOtpInput();
//   }

//   @override
//   Future<CheckoutResponse> _handleOtpInput()  async {
//     return CheckoutResponse(
//       message: "",
//       method: CheckoutMethod.selectable,
//       reference: "",
//       status: false,
//       verify: false,
//     );
//   }

//   // @override
//   // Future<CheckoutResponse> handleBirthdayInput(String birthday, TransactionApiResponse response) {
//   //   chargeRequestBody!.birthday = birthday;
//   //   return _chargeAccount();
//   // }

//   @override
//   CheckoutMethod checkoutMethod() => CheckoutMethod.bank;
// }
