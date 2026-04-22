import 'package:art_of_pilates/app/config/di/di.dart';
import 'package:art_of_pilates/app/core/util/app_colors.dart';
import 'package:art_of_pilates/app/core/util/app_locale.dart';
import 'package:art_of_pilates/app/core/util/session_manager.dart';
import 'package:art_of_pilates/app/features/profile/domain/use_cases/navigate_to_settings_screen_use_case.dart';
import 'package:art_of_pilates/app/features/profile/presentation/view_model/profile_states.dart';
import 'package:art_of_pilates/app/features/profile/presentation/view_model/profile_view_model.dart';
import 'package:art_of_pilates/app/features/settings/domain/use_cases/navigate_to_signin_screen_use_case.dart';
import 'package:art_of_pilates/app/features/settings/presentation/view_model/settings_states.dart';
import 'package:art_of_pilates/app/features/settings/presentation/view_model/settings_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  late final ProfileViewModel profileViewModel;
  late final SettingsViewModel settingsViewModel;

  @override
  void initState() {
    super.initState();
    profileViewModel = getIt<ProfileViewModel>();
    profileViewModel.getUserProfile();
    settingsViewModel = getIt<SettingsViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: profileViewModel),
        BlocProvider.value(value: settingsViewModel),
      ],
      child: BlocListener<SettingsViewModel, SettingsStates>(
        listenWhen: (prev, curr) =>
            prev.deleteAccountState != curr.deleteAccountState,
        listener: (context, state) async {
          if (state.deleteAccountState?.isLoading == false &&
              state.deleteAccountState?.errorMessage == null &&
              state.deleteAccountState?.data == null) {
            await getIt<SessionManager>().clearSession();
            if (!context.mounted) return;
            NavigateToSigninScreenUseCase.call(context);
          }
          if (state.deleteAccountState?.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.deleteAccountState!.errorMessage!),
                backgroundColor:AppColors.redColor,
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
        locale.deleteYourAccount,
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
    return BlocBuilder<ProfileViewModel, ProfileStates>(
      builder: (context, profileState) {
        final user = profileState.userProfileStateParam?.data;
        final avatarLetter = user?.firstName?.isNotEmpty == true
            ? user!.firstName![0].toUpperCase()
            : '?';
        final email = user?.email ?? '';

        return Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 45.r,
                  backgroundColor: AppColors.primary,
                  child: Text(
                    avatarLetter,
                    style: TextStyle(
                      fontSize: 32.sp,
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 14.h),
                Text(
                  email,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.accentColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  locale.deleteAccountWarning,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.accentColor,
                    height: 1.6,
                  ),
                ),
                SizedBox(height: 32.h),
                BlocBuilder<SettingsViewModel, SettingsStates>(
                  buildWhen: (prev, curr) =>
                      prev.deleteAccountState != curr.deleteAccountState,
                  builder: (context, settingsState) {
                    final isLoading =
                        settingsState.deleteAccountState?.isLoading ?? false;
                    return SizedBox(
                      width: 200.w,
                      height: 48.h,
                      child: ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () => _showDeleteConfirmation(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                        ),
                        child: isLoading
                            ? SizedBox(
                                width: 20.w,
                                height: 20.h,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                locale.deleteAccount,
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.whiteColor,
                                ),
                              ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 16.h),
                GestureDetector(
                  onTap: () => NavigateToSettingsScreenUseCase.call(context),
                  child: Text(
                    locale.notNow,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    final locale = appLocale(context);
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.backgroundColor,
        title: Text(
          locale.deleteAccount,
          style: TextStyle(
            color: AppColors.accentColor,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
        content: Text(
          locale.deleteAccountConfirmation,
          style: TextStyle(color: AppColors.accentColor, fontSize: 14.sp),
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
              settingsViewModel.deleteAccount();
            },
            child: Text(
              locale.deleteAccount,
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
