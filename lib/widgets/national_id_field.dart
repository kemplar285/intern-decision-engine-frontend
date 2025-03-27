import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../colors.dart';

// A custom text form field widget for national ID input
class NationalIdTextFormField extends StatelessWidget {
  // Properties for initial value, on changed event handler and validator function
  final String? initialValue;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  static const int loanMaximumPeriodInYears = 4;
  static const int currentExpectedLifespanEurope = 81;

  const NationalIdTextFormField({
    super.key,
    this.initialValue,
    this.onChanged,
    this.validator,
  });

  bool isCustomerWithingAgeRange(String idCode) {
    if (idCode.length != 11) {
      return false; // Invalid ID code length
    }

    try {
      int yearPrefix = int.parse(idCode.substring(0, 1));
      int year = int.parse(idCode.substring(1, 3));
      int currentYear = DateTime.now().year;
      int birthYear;

      if (yearPrefix == 1 || yearPrefix == 2) {
        birthYear = 1800 + year;
      } else if (yearPrefix == 3 || yearPrefix == 4) {
        birthYear = 1900 + year;
      } else if (yearPrefix == 5 || yearPrefix == 6) {
        birthYear = 2000 + year;
      } else {
        return false; // Invalid prefix
      }

      int age = currentYear - birthYear;

      // Adjust age if birthday hasn't occurred yet this year.
      int birthMonth = int.parse(idCode.substring(3, 5));
      int birthDay = int.parse(idCode.substring(5, 7));
      int currentMonth = DateTime.now().month;
      int currentDay = DateTime.now().day;

      if (currentMonth < birthMonth ||
          (currentMonth == birthMonth && currentDay < birthDay)) {
        age--;
      }

      return age >= 18 &&
          age <= currentExpectedLifespanEurope - loanMaximumPeriodInYears;
    } catch (e) {
      return false; // Invalid ID code format
    }
  }

  // Builds the text form field widget with customized decoration and validation
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      style: const TextStyle(color: AppColors.textColor),
      decoration: const InputDecoration(
        labelText: 'National ID code',
        labelStyle: TextStyle(color: AppColors.textColor),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.textColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.textColor),
        ),
      ),
      cursorColor: AppColors.textColor,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'\d')),
        LengthLimitingTextInputFormatter(11),
      ],
      keyboardType: TextInputType.number,

      // Rudimentary client side verification of the ID code
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a National ID.';
            }
            if (value.length != 11) {
              return 'National ID is 11 digits long.';
            }
            if (!isCustomerWithingAgeRange(value)) {
              return 'Loan was not approved due to age constraints.';
            }
            return null;
          },
      onChanged: onChanged,

      // Set autovalidate mode to trigger validation on user interaction
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
