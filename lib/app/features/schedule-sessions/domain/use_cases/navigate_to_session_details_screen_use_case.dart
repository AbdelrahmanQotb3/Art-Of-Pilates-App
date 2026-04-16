import 'package:art_of_pilates/app/core/routes/routes.dart';
import 'package:flutter/material.dart';

class NavigateToSessionDetailsScreenUseCase {
  static void call(BuildContext context, String sessionId) {
    Navigator.pushNamed(context, Routes.sessionDetailsScreen, arguments: sessionId);
  }
}