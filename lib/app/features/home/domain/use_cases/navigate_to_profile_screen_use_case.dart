import 'package:art_of_pilates/app/core/routes/routes.dart';
import 'package:flutter/material.dart';

class NavigateToProfileScreenUseCase {

  static void call(BuildContext context) {
    Navigator.pushNamed(context, Routes.profileScreen);
  }
}