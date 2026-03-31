import 'package:art_of_pilates/app/core/util/app_locale.dart';
import 'package:art_of_pilates/app/core/util/app_regex.dart';
import 'package:flutter/material.dart';

class AppValidators {
  static String? validateEmail(String? value, BuildContext context) {
    if (value == null || value.trim().isEmpty) {
      return appLocale(context).enterYourEmail;
    } else if (!AppRegex.isEmailValid(value.trim())) {
      return appLocale(context).thisEmailIsNotValid;
    }
    return null;
  }

  static String? validatePassword(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return appLocale(context).enterYourPassword;
    } else if (!AppRegex.hasMinLength(value)) {
      return appLocale(context).passwordMinLength;
    } else if (!AppRegex.hasUpperCase(value)) {
      return appLocale(context).passwordUpperCase;
    } else if (!AppRegex.hasLowerCase(value)) {
      return appLocale(context).passwordLowerCase;
    } else if (!AppRegex.hasNumber(value)) {
      return appLocale(context).passwordNumber;
    } else if (!AppRegex.hasSpecialCharacter(value)) {
      return appLocale(context).passwordSpecialChar;
    }
    return null;
  }

  static String? validateConfirmPassword(
    String? value,
    String? originalPassword,
    BuildContext context,
  ) {
    if (value == null || value.isEmpty) {
      return appLocale(context).confirmPasswordRequired;
    } else if (value != originalPassword) {
      return appLocale(context).passwordNotMatched;
    }

    return null;
  }

  static String? validateUserName(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return appLocale(context).userNameRequired;
    }
    return null;
  }

  static String? validateNumberPhone(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return appLocale(context).phoneNumberRequired;
    }
    return null;
  }

  static String? validateFirstName(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return appLocale(context).firstNameRequired;
    }
    return null;
  }

  static String? validateLastName(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return appLocale(context).lastNameRequired;
    }
    return null;
  }
}
