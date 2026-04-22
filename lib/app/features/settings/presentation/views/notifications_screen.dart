import 'package:art_of_pilates/app/core/util/app_colors.dart';
import 'package:art_of_pilates/app/core/util/app_locale.dart';
import 'package:art_of_pilates/app/features/profile/domain/use_cases/navigate_to_settings_screen_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  PreferredSizeWidget? _buildAppBar(BuildContext context) {
    final locale = appLocale(context);
    return AppBar(
      backgroundColor: AppColors.primary,
      centerTitle: true,
      title: Text(
        locale.notificationsSettings,
        style: const TextStyle(
          color: AppColors.whiteColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: IconButton(
        onPressed: () => NavigateToSettingsScreenUseCase.call(context),
        icon: const Icon(
          Icons.arrow_back_ios_new_outlined,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final locale = appLocale(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: Column(
        children: [
          _buildNotificationOption(
            icon: Icons.smartphone_outlined,
            title: locale.pushNotifications,
            onTap: () {},
          ),
          SizedBox(height: 10.h),
          _buildNotificationOption(
            icon: Icons.email_outlined,
            title: locale.emailNotifications,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 4.w),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.accentColor,
              size: 24.sp,
            ),
            SizedBox(width: 16.w),
            Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.accentColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.accentColor,
              size: 16.sp,
            ),
          ],
        ),
      ),
    );
  }
}