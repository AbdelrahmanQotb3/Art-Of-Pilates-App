import 'package:art_of_pilates/app/config/di/di.dart';
import 'package:art_of_pilates/app/core/util/exceptions/abstract/app_exception.dart';
import 'package:art_of_pilates/l10n/app_localizations.dart';
import 'package:flutter/src/widgets/framework.dart';

class SigninException extends AppException {
  String error;
  SigninException({required this.error});

  @override
  Widget? createButtons() {
    return null;
  }

  @override
  String createErrorMessage() {
    return error;
  }
}

class SigninWithGoogleException extends AppException {
  @override
  Widget? createButtons() {
    return null;
  }

  @override
  String createErrorMessage() {
    BuildContext context = getIt<BuildContext>();
    return AppLocalizations.of(context)!.signinWithGoogleErrorMessage;
  }
}
