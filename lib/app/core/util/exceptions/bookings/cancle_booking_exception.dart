import 'package:art_of_pilates/app/core/util/exceptions/abstract/app_exception.dart';
import 'package:flutter/material.dart';

class CancleBookingException extends AppException {
  String error;
  CancleBookingException({required this.error});

  @override
  Widget? createButtons() {
    return null;
  }

  @override
  String createErrorMessage() {
    return error;
  }
}