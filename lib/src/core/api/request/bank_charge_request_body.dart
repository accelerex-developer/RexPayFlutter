import 'package:rexpay/src/core/api/request/base_request_body.dart';
import 'package:rexpay/src/models/bank.dart';
import 'package:rexpay/src/models/charge.dart';

class BankChargeRequestBody {
  String _customerName;
  String _reference;
  String _amount;
  String _email;
  String _callBackUrl;
  String _currency;

  BankChargeRequestBody(Charge charge)
      : _customerName = charge.customerName ?? "",
        _reference = charge.reference ?? "",
        _callBackUrl = charge.callBackUrl ?? "",
        _currency = charge.currency ?? "NGN",
        // Charge.amount is in minor units (e.g. kobo); convert to main unit for API
        _amount = (charge.amount / 100).toStringAsFixed(2),
        _email = charge.email ?? "";

  Map<String, dynamic> toChargeBankJson() {
    return {
      "customerName": _customerName,
      "reference": _reference,
      "amount": _amount,
      "customerId": _email,
    };
  }

  Map<String, dynamic> toInitialJson() {
    return {
      "reference": _reference,
      "amount": _amount,
      "currency": _currency,
      "userId": _email,
      "callbackUrl": _callBackUrl,
      "metadata": {
        "email": _email,
        "customerName": _customerName,
      }
    };
  }
}
