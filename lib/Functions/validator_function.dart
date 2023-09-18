import 'package:flutter/material.dart';
import 'package:form_validation/form_validation.dart';


String? validateField(String value, String fieldLabel, BuildContext context) {
  if (fieldLabel.contains("Number")) {
    final validator = Validator(
        validators: [
          RequiredValidator(),
          NumberValidator(),
          MaxLengthValidator(length: 10),
          MinLengthValidator(length: 10),
        ]
    );
    return validator.validate(
         label: fieldLabel, value: value);
  } else if(fieldLabel.contains("E-mail")) {
    final validator = Validator(
        validators: [
          RequiredValidator(),
          EmailValidator()
        ]
    );
    return validator.validate(
         label: fieldLabel, value: value);
  }
  else {
    final validator = Validator(validators: [RequiredValidator()]);
    return validator.validate(
         label: fieldLabel, value: value);
  }
}