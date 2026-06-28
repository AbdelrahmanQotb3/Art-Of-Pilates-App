import 'package:art_of_pilates/app/core/routes/pages.dart';
import 'package:art_of_pilates/app/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class NavigateToPrivacyAndPolicyScreenUseCase {
  static void call(BuildContext context) {
    Navigator.pushNamed(context, Routes.privacyPolicyScreen);
  }
}