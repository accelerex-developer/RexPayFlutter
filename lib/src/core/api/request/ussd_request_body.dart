import 'package:rexpay/src/models/bank.dart';
import 'package:rexpay/src/models/charge.dart';

class USSDChargeRequestBody {
  final String _paymentChannel = "USSD";
  final String _customerName;
  final String _reference;
  final String _amount;
  final String _email;
  final String _callBackUrl;
  final String _currency;
  String? _paymentUrlReference;
  Bank? _bank;

  USSDChargeRequestBody(Charge charge)
      : _customerName = charge.customerName ?? "",
        _reference = charge.reference ?? "",
        _callBackUrl = charge.callBackUrl ?? "",
        _currency = charge.currency ?? "NGN",
        _amount = charge.amount.toString(),
        _email = charge.email ?? "";

  Map<String, dynamic> toChargeUSSDJson() {
    return {
      "currency": _currency,
      // "reference": _reference,
      "reference": _paymentUrlReference,
      "amount": _amount,
      "userId": _email,
      "callbackUrl": _callBackUrl,
      "paymentChannel": _paymentChannel,
      "bankCode": _bank?.code ?? "",
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

  void setBank(Bank? bank) {
    _bank = bank;
  }

  void setPaymentUrlReference(String reference) {
    _paymentUrlReference = reference;
  }
}
