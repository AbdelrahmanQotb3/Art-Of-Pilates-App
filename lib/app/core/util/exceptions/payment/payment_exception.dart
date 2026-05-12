import 'package:art_of_pilates/app/core/util/exceptions/abstract/app_exception.dart';
import 'package:flutter/widgets.dart';

class PaymentException extends AppException {
  final String error;

  PaymentException({required this.error});

  @override
  String createErrorMessage() {
    return error;
  }

  @override
  Widget? createButtons() {
    return null;
  }
}
