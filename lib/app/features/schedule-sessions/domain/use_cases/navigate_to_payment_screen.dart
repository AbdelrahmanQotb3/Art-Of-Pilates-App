import 'package:art_of_pilates/app/core/routes/routes.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/domain/model/sessions_model.dart';
import 'package:flutter/material.dart';

class NavigateToPaymentScreen {
  static void call(BuildContext context, SessionEntity session) {
    Navigator.pushNamed(context, Routes.paymentScreen, arguments: session);
  }
}
