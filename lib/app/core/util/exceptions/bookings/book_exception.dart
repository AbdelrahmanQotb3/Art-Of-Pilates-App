import 'package:art_of_pilates/app/core/util/exceptions/abstract/app_exception.dart';
import 'package:flutter/src/widgets/framework.dart';

class BookException extends AppException {
  String error;
  BookException({required this.error});
  @override
  Widget? createButtons() {
    return null;
  }

  @override
  String createErrorMessage() {
    return error;
  }
  
}