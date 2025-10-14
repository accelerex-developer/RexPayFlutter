import 'package:rexpay/src/core/common/my_strings.dart';
import 'package:rexpay/src/core/common/rexpay.dart';

class CheckoutResponse {
  /// A user readable message. If the transaction was not successful, this returns the
  /// cause of the error.
  String message;

  /// Transaction reference. Might be null for failed transaction transactions
  String? reference;

  /// The status of the transaction. A successful response returns true and false
  /// otherwise
  String status;

  /// The means of payment. It may return [CheckoutMethod.bank] or [CheckoutMethod.card]
  CheckoutMethod method;

  Map<String, dynamic> serverResponse;

  CheckoutResponse.defaults()
      : message = Strings.userTerminated,
        status = "",
        serverResponse = {},
        method = CheckoutMethod.selectable;

  CheckoutResponse({required this.message, required this.reference, required this.status, required this.method, required this.serverResponse});

  @override
  String toString() {
    return 'CheckoutResponse{message: $message, reference: $reference, status: $status, method: $method}';
  }
}
