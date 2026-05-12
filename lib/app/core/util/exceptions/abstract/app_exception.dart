import 'package:art_of_pilates/app/core/util/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

abstract class AppException implements Exception {
  String? message;
  int exceptionCode;

  AppException({this.message, this.exceptionCode = -1});

  Widget? createButtons();

  String createErrorMessage();

  Widget? createTitleIcon() => SizedBox(
    width: 24,
    height: 24,
    child: SvgPicture.asset(AppImages.warningIcon),
  );
  @override
  String toString() {
    if (message != null && message!.isNotEmpty) {
      return message!;
    } else {
      return runtimeType.toString();
    }
  }
}
