import 'package:rexpay/src/core/api/model/transaction_api_response.dart';
import 'package:rexpay/src/core/api/request/ussd_request_body.dart';
import 'package:rexpay/src/models/auth_keys.dart';
import 'package:rexpay/src/models/bank.dart';

abstract class USSDServiceContract {
  Future<TransactionApiResponse> createPayment(USSDChargeRequestBody? credentials, AuthKeys authKeys);

  Future<TransactionApiResponse> chargeUSSD(USSDChargeRequestBody? credentials, AuthKeys authKeys);

  Future<TransactionApiResponse> getPaymantDetails(String transRef, AuthKeys authKeys);

  Future<List<Bank>?>? fetchSupportedBanks(USSDChargeRequestBody? credentials, AuthKeys authKeys);
}
