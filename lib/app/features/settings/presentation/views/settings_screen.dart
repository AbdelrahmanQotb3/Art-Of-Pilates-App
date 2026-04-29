import 'package:art_of_pilates/app/config/di/di.dart';
import 'package:art_of_pilates/app/core/util/app_colors.dart';
import 'package:art_of_pilates/app/core/util/app_locale.dart';
import 'package:art_of_pilates/app/features/home/domain/use_cases/navigate_to_profile_screen_use_case.dart';
import 'package:art_of_pilates/app/features/settings/domain/use_cases/navigate_to_about_app_screen_use_case.dart';
import 'package:art_of_pilates/app/features/settings/domain/use_cases/navigate_to_delete_Account_screen_use_case.dart';
import 'package:art_of_pilates/app/features/settings/domain/use_cases/navigate_to_display_screen_use_case.dart';
import 'package:art_of_pilates/app/features/settings/domain/use_cases/navigate_to_languages_screen_use_case.dart';
import 'package:art_of_pilates/app/features/settings/domain/use_cases/navigate_to_notifications_screen_use_case.dart';
import 'package:art_of_pilates/app/features/settings/presentation/view_model/settings_states.dart';
import 'package:art_of_pilates/app/features/settings/presentation/view_model/settings_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late final SettingsViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = getIt<SettingsViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: viewModel,
      child: BlocListener<SettingsViewModel, SettingsStates>(
        listenWhen: (prev, curr) => prev.logoutState != curr.logoutState,
        listener: (context, state) {
          if (state.logoutState?.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.logoutState!.errorMessage!),
                backgroundColor: AppColors.redColor,
              ),
            );
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: _buildAppBar(context),
          body: _buildBody(context),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final locale = appLocale(context);
    return AppBar(
      backgroundColor: AppColors.primary,
      centerTitle: true,
      title: Text(
        locale.settings,
        style: const TextStyle(
          color: AppColors.whiteColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: IconButton(
        onPressed: () => NavigateToProfileScreenUseCase.call(context),
        icon: const Icon(
          Icons.arrow_back_ios_new_outlined,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final locale = appLocale(context);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                locale.settings,
                style: TextStyle(
                  fontSize: 18.sp,
                  color: AppColors.accentColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.h),
              _buildSettingRow(
                locale.appLanguage,
                () => NavigateToLanguagesScreenUseCase.call(context),
              ),
              _buildSettingRow(
                locale.notificationsSettings,
                () => NavigateToNotificationsScreenUseCase.call(context),
              ),
              _buildSettingRow(
                locale.appDisplay,
                () => NavigateToDisplayScreenUseCase.call(context),
              ),
              _buildSettingRow(
                locale.deleteYourAccount,
                () => NavigateToDeleteAccountScreenUseCase.call(context),
              ),
              _buildSettingRow(
                locale.aboutTheApp,
                () => NavigateToAboutAppScreenUseCase.call(context),
              ),
            ],
          ),
        ),
        const Spacer(),
        _buildLogoutRow(context),
      ],
    );
  }

  Widget _buildSettingRow(String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.accentColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.accentColor,
              size: 14.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutRow(BuildContext context) {
    final locale = appLocale(context);
    return BlocBuilder<SettingsViewModel, SettingsStates>(
      buildWhen: (prev, curr) => prev.logoutState != curr.logoutState,
      builder: (context, state) {
        final isLoading = state.logoutState?.isLoading ?? false;

        return InkWell(
          onTap: isLoading ? null : () => _showLogoutConfirmation(context),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 24.h),
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              border: Border(
                top: BorderSide(color: AppColors.accentColor, width: 0.5.h),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isLoading)
                  SizedBox(
                    width: 20.w,
                    height: 20.h,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.redColor,
                    ),
                  )
                else
                  Icon(
                    Icons.logout_rounded,
                    color: AppColors.redColor,
                    size: 20.sp,
                  ),
                SizedBox(width: 8.w),
                Text(
                  locale.logout,
                  style: TextStyle(
                    color: AppColors.redColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    final locale = appLocale(context);
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.backgroundColor,
        title: Text(
          locale.logout,
          style: TextStyle(
            color: AppColors.accentColor,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
        content: Text(
          locale.logoutConfirmation,
          style: TextStyle(
            color: AppColors.accentColor,
            fontSize: 14.sp,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              locale.cancel,
              style: TextStyle(color: AppColors.accentColor),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              viewModel.logout(context);
            },
            child: Text(
              locale.logout,
              style: TextStyle(
                color: AppColors.redColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
