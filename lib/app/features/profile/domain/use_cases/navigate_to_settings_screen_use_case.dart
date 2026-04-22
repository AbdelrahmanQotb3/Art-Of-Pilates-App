import 'package:art_of_pilates/app/core/routes/routes.dart';
import 'package:flutter/material.dart';

class NavigateToSettingsScreenUseCase {

  static void call(BuildContext context) {
    Navigator.pushNamed(context, Routes.settingsScreen);
  }
}