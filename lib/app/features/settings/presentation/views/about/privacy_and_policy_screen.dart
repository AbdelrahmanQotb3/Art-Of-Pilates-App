import 'package:art_of_pilates/app/core/util/app_colors.dart';
import 'package:art_of_pilates/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrivacyAndPolicyScreen extends StatelessWidget {
  const PrivacyAndPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: _buildAppBar(context),
      body: _buildBody(locale),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(
          Icons.arrow_back_ios_new_outlined,
          color: AppColors.accentColor,
        ),
      ),
    );
  }

  Widget _buildBody(AppLocalizations locale) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Screen Title
          Text(
            locale.privacyPolicyTitle,
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.accentColor,
            ),
          ),
          SizedBox(height: 20.h),

          // Main Policy Description
          Text(
            locale.privacyPolicyDescription,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.accentColor,
              height: 1.6,
            ),
          ),
          SizedBox(height: 32.h),

          // External Link Link
          Center(
            child: GestureDetector(
              onTap: () {
                // Handle opening URL if required (e.g., using url_launcher)
              },
              child: Text(
                locale.privacyPolicyMoreDetails,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.accentColor,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
