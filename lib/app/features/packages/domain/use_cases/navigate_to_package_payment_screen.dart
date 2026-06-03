import 'package:art_of_pilates/app/features/packages/domain/model/packages_model.dart';
import 'package:art_of_pilates/app/features/payment/presentation/views/payment_screen.dart';
import 'package:flutter/material.dart';

class NavigateToPackagePaymentScreen {
  static void call(BuildContext context, PricingPlanEntity plan, DateTime startDate) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PaymentScreen(plan: plan, startDate: startDate),
      ),
    );
  }
}
