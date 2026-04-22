import 'package:art_of_pilates/app/core/routes/routes.dart';
import 'package:flutter/material.dart';

class NavigateToAboutAppScreenUseCase {

  static void call(BuildContext context) {
    Navigator.pushReplacementNamed(context, Routes.aboutAppScreen);
  }
}