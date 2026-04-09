import 'package:art_of_pilates/app/core/routes/routes.dart';
import 'package:flutter/material.dart';

class NavigateToServiceDetailsScreenUseCase {
  static void call(BuildContext context, String serviceId) {
    Navigator.pushNamed(context, Routes.serviceDetailsScreen , arguments: serviceId,);
  }
}
