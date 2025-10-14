import 'package:rexpay/rexpay.dart';
import 'package:rexpay/src/core/api/model/transaction_api_response.dart';
import 'package:rexpay/src/core/api/request/bank_charge_request_body.dart';

abstract class BankServiceContract {
  Future<TransactionApiResponse> createPayment(BankChargeRequestBody? credentials, AuthKeys authKeys);

  Future<TransactionApiResponse> chargeBank(BankChargeRequestBody? requestBody, AuthKeys authKeys);

  Future<TransactionApiResponse> getTransactionStatus(String transRef, AuthKeys authKeys);

}
