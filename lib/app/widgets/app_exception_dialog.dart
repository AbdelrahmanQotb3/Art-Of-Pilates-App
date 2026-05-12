import 'package:art_of_pilates/app/core/util/exceptions/abstract/app_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppExceptionDialog extends StatelessWidget {
  final AppException exception;

  const AppExceptionDialog({super.key, required this.exception});

  static Future<void> show(BuildContext context, AppException exception) {
    return showDialog(
      context: context,
      builder: (_) => AppExceptionDialog(exception: exception),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      title: Row(
        children: [
          if (exception.createTitleIcon() != null)
            SizedBox(
              width: 24.w,
              height: 24.h,
              child: exception.createTitleIcon()!,
            ),
          if (exception.createTitleIcon() != null) SizedBox(width: 8.w),
          const Text('Error'),
        ],
      ),
      content: Text(exception.createErrorMessage()),
      actions: [
        exception.createButtons() ??
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
      ],
    );
  }
}
