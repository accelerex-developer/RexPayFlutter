import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rexpay/src/core/common/my_strings.dart';
import 'package:rexpay/src/models/card.dart';
import 'package:rexpay/src/views/input/base_field.dart';

class CVCField extends BaseTextField {
  CVCField({
    Key? key,
    required PaymentCard? card,
    required FormFieldSetter<String> onSaved,
  }) : super(
          key: key,
          labelText: 'CVV',
          hintText: '123',
          onSaved: onSaved,
          obscureText: true,
          validator: (String? value) => validateCVC(value, card),
          initialValue: card != null && card.cvc != null ? card.cvc.toString() : null,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            new LengthLimitingTextInputFormatter(4),
          ],
        );

  static String? validateCVC(String? value, PaymentCard? card) {
    if (value == null || value.trim().isEmpty) return Strings.invalidCVC;

    return card!.validCVC(value) ? null : Strings.invalidCVC;
  }
}
