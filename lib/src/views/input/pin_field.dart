import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rexpay/src/core/common/my_strings.dart';
import 'package:rexpay/src/views/input/base_field.dart';


class PinField extends BaseTextField {
  PinField({
    Key? key,
    required FormFieldSetter<String> onSaved,
    int pinLength = 4,
  }) : super(
          key: key,
          labelText: 'PIN',
          hintText: '1234',
          onSaved: onSaved,
          validator: (String? value) => validatePin(value, pinLength),
          initialValue: null,
          obscureText: true,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            new LengthLimitingTextInputFormatter(4),
          ],
        );

  static String? validatePin(String? value, int pinLength) {
    if (value == null || value.trim().isEmpty || value.length != pinLength) return Strings.invalidPin;

    return null;
  }
}
