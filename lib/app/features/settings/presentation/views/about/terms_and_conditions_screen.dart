import 'package:art_of_pilates/app/core/util/app_colors.dart';
import 'package:art_of_pilates/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

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
        onPressed: () {
          // Navigates back to AboutAppScreen or simply use Navigator.pop(context)
          Navigator.of(context).pop();
        },
        icon: const Icon(
          Icons.arrow_back_ios_new_outlined,
          color: AppColors.accentColor,
        ),
      ),
    );
  }

  Widget _buildBody(AppLocalizations locale) {
    final terms = _getTerms(locale);

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Screen Title
          Text(
            locale.termsAndConditionsTitle,
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.accentColor,
            ),
          ),
          SizedBox(height: 12.h),

          // Header Agreement Note
          Text(
            locale.termsAgreementNote,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.accentColor,
              height: 1.5,
            ),
          ),
          SizedBox(height: 20.h),

          ...terms.map((term) {
            return Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '• ',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.accentColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      term,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.accentColor,
                        height: 1.6,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  List<String> _getTerms(AppLocalizations locale) {
    return [
      locale.termsBullet1,
      locale.termsBullet2,
      locale.termsBullet3,
      locale.termsBullet4,
      locale.termsBullet5,
      locale.termsBullet6,
      locale.termsBullet7,
      locale.termsBullet8,
      locale.termsBullet9,
      locale.termsBullet10,
      locale.termsBullet11,
    ];
  }
}
