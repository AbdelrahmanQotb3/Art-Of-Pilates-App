import 'package:art_of_pilates/app/core/routes/routes.dart';
import 'package:art_of_pilates/app/features/packages/domain/model/packages_model.dart';
import 'package:flutter/material.dart';

class NavigateToPackagePaymentScreen {
  static void call(BuildContext context, PricingPlanEntity plan) {
    Navigator.pushNamed(context, Routes.paymentScreen, arguments: plan);
  }
}
