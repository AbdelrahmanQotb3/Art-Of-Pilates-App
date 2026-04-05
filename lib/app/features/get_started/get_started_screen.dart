import 'package:art_of_pilates/app/core/routes/routes.dart';
import 'package:art_of_pilates/app/core/util/app_colors.dart';
import 'package:art_of_pilates/app/core/util/app_images.dart';
import 'package:art_of_pilates/app/core/util/app_locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = appLocale(context);

    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 80.h, left: 20.w, right: 20.w),
              child: Column(
                children: [
                  Text(
                    locale.appName,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    locale.appTagline,
                    style: TextStyle(fontSize: 14.sp, color: AppColors.primary),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 130.h),
              child: Image.asset(
                AppImages.splashLogo,
                width: 100.w,
                height: 100.h,
              ),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.signinScreen);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: Size(260.w, 30.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: Text(
                locale.getStarted,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              child: Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: AppColors.blackColor,
                    height: 1.5,
                  ),
                  children: [
                    TextSpan(text: locale.termsPart1),
                    TextSpan(
                      text: locale.termsOfUse,
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                        decorationColor: AppColors.blackColor,
                        decorationThickness: 1.5,
                      ),
                    ),
                    TextSpan(text: locale.termsPart2),
                    TextSpan(
                      text: locale.privacyPolicy,
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                        decorationColor: AppColors.blackColor,
                        decorationThickness: 1.5,
                      ),
                    ),
                    TextSpan(text: locale.termsPart3),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}