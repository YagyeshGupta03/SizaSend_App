import 'package:flutter/material.dart';
import 'package:form_validation/form_validation.dart';



String? validateField(String value, String fieldLabel, BuildContext context) {
  if (fieldLabel.contains("Number")) {
    final validator = Validator(
        validators: [
          const RequiredValidator(),
          const NumberValidator(),
          // const MaxLengthValidator(length: 10),
          // const MinLengthValidator(length: 9),
        ]
    );
    return validator.validate(
        label: fieldLabel, value: value);
  } else if(fieldLabel.contains("E-mail")) {
    final validator = Validator(
        validators: [
          const RequiredValidator(),
          const EmailValidator()
        ]
    );
    return validator.validate(
        label: fieldLabel, value: value);
  }
  else {
    final validator = Validator(validators: [const RequiredValidator()]);
    return validator.validate(
        label: fieldLabel, value: value);
  }
}