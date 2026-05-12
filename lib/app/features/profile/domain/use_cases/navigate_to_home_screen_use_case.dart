import 'package:art_of_pilates/app/core/routes/routes.dart';
import 'package:flutter/material.dart';

class NavigateToHomeScreenUseCase {
  static void call(BuildContext context, {int initialTabIndex = 0}) =>
      Navigator.pushReplacementNamed(
        context,
        Routes.homeScreen,
        arguments: initialTabIndex,
      );
}
