import 'package:rexpay/src/models/charge.dart';

class BankChargeRequestBody {
  final String _customerName;
  final String _reference;
  final String _amount;
  final String _email;
  final String _callBackUrl;
  final String _currency;

  BankChargeRequestBody(Charge charge)
      : _customerName = charge.customerName ?? "",
        _reference = charge.reference ?? "",
        _callBackUrl = charge.callBackUrl ?? "",
        _currency = charge.currency ?? "NGN",
        _amount = charge.amount.toString(),
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
