import 'package:art_of_pilates/app/core/util/app_colors.dart';
import 'package:art_of_pilates/app/core/util/app_images.dart';
import 'package:art_of_pilates/app/core/util/app_locale.dart';
import 'package:art_of_pilates/app/features/profile/domain/use_cases/navigate_to_settings_screen_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutAppScreen extends StatefulWidget {
  const AboutAppScreen({super.key});

  @override
  State<AboutAppScreen> createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen> {
  String _version = '';

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    final info = await PackageInfo.fromPlatform();
    setState(() => _version = 'Version ${info.version}.${info.buildNumber}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: () => NavigateToSettingsScreenUseCase.call(context),
        icon: const Icon(
          Icons.arrow_back_ios_new_outlined,
          color: AppColors.accentColor,
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final locale = appLocale(context);
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            locale.welcomeToOurApp,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.accentColor,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            locale.welcomeToOurAppSubtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.accentColor,
              height: 1.5,
            ),
          ),
          SizedBox(height: 28.h),

          Image.asset(
            AppImages.aboutAppIllustration,
            height: 180.h,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 28.h),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              locale.aboutTheApp,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.accentColor,
              ),
            ),
          ),
          SizedBox(height: 12.h),

          Text(
            locale.aboutTheAppDescription1,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.accentColor,
              height: 1.6,
            ),
          ),
          SizedBox(height: 12.h),

          Text(
            locale.aboutTheAppDescription2,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.accentColor,
              height: 1.6,
            ),
          ),
          SizedBox(height: 32.h),

          _buildLink(
            locale.termsOfService,
            onTap: () {
              // TODO: open terms of service
            },
          ),
          SizedBox(height: 16.h),
          _buildLink(
            locale.privacyPolicy,
            onTap: () {
              // TODO: open privacy policy
            },
          ),
          SizedBox(height: 16.h),
          _buildLink(
            locale.openSourceLicenses,
            onTap: () {
              showLicensePage(context: context);
            },
          ),
          SizedBox(height: 32.h),

          Text(
            _version,
            style: TextStyle(fontSize: 12.sp, color: AppColors.accentColor),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  Widget _buildLink(String label, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14.sp, color: AppColors.accentColor),
      ),
    );
  }
}
