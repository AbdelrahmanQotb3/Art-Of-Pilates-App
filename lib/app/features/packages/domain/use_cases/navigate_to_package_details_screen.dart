import 'package:art_of_pilates/app/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class NavigateToPackageDetailsScreenUseCase {
  void call(BuildContext context, int packageId) {
    Navigator.pushNamed(
      context,
      Routes.packageDetailsScreen,
      arguments: packageId,
    );
  }
}
