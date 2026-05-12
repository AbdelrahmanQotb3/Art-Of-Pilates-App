import 'dart:math';

import 'package:art_of_pilates/app/config/di/di.dart';
import 'package:art_of_pilates/app/core/util/exceptions/abstract/app_exception.dart';
import 'package:art_of_pilates/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class SignupException extends AppException {
  String error;
  SignupException({required this.error});
  @override
  Widget? createButtons() {
    return null;
  }

  @override
  String createErrorMessage() {
    return error;
  }
}

class SignupWithGoogleException extends AppException {
  @override
  Widget? createButtons() {
    return null;
  }

  @override
  String createErrorMessage() {
    BuildContext context = getIt<BuildContext>();
    return AppLocalizations.of(context)!.signupWithGoogleErrorMessage;
  }
}
