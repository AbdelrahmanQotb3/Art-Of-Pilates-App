import 'package:art_of_pilates/app/config/di/di.dart';
import 'package:art_of_pilates/app/core/routes/routes.dart';
import 'package:art_of_pilates/app/core/util/app_colors.dart';
import 'package:art_of_pilates/app/core/util/app_images.dart';
import 'package:art_of_pilates/app/core/util/app_locale.dart';
import 'package:art_of_pilates/app/core/util/app_validation.dart';
import 'package:art_of_pilates/app/features/signup/presentation/view_model/signup_events.dart';
import 'package:art_of_pilates/app/features/signup/presentation/view_model/signup_states.dart';
import 'package:art_of_pilates/app/features/signup/presentation/view_model/signup_view_model.dart';
import 'package:art_of_pilates/app/widgets/app_exception_dialog.dart';
import 'package:art_of_pilates/app/widgets/app_text_field.dart';
import 'package:art_of_pilates/app/widgets/loading_dialog.dart';
import 'package:art_of_pilates/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignupScreen extends StatelessWidget {
  final SignupViewModel viewModel = getIt<SignupViewModel>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = appLocale(context);

    return Scaffold(
      backgroundColor: AppColors.accentColor,
      appBar: _buildAppBar(context, locale),
      body: BlocProvider(
        create: (context) => viewModel,
        child: BlocConsumer<SignupViewModel, SignupStates>(
          listener: (context, state) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (state.signupState?.isLoading == true) {
                LoadingDialog.show(context, message: 'Creating account...');
              } else if (state.signupState?.data != null) {
                if (Navigator.of(context).canPop()) Navigator.of(context).pop();
                final nextRoute = viewModel.isSocialSignup
                    ? Routes.homeScreen
                    : Routes.signinScreen;
                Navigator.pushReplacementNamed(context, nextRoute);
              } else if (state.appException != null) {
                if (Navigator.of(context).canPop()) Navigator.of(context).pop();
                AppExceptionDialog.show(context, state.appException!);
              }
            });
          },
          builder: (context, state) {
            return _buildBody(locale, context, state);
          },
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, AppLocalizations locale) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: AppColors.whiteColor),
        onPressed: () {
          Navigator.pushReplacementNamed(context, Routes.getStartedScreen);
        },
      ),
    );
  }

  Widget _buildBody(
    AppLocalizations locale,
    BuildContext context,
    SignupStates state,
  ) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildHeaderMessage(locale),
            _buildSignupForm(locale, context, state),
          ],
        ),
      ),
    );
  }

  Center _buildHeaderMessage(AppLocalizations locale) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            locale.createYourAccount,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.secondary,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            locale.enterYourDetailsToSignup,
            style: TextStyle(fontSize: 14.sp, color: AppColors.secondary),
          ),
        ],
      ),
    );
  }

  Widget _buildSignupForm(
    AppLocalizations locale,
    BuildContext context,
    SignupStates state,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextField(
            controller: viewModel.firstNameController,
            label: locale.firstName,
            hint: locale.enterYourFirstName,
            backGroundColor: AppColors.accentColor,
            validator: (v) {
              if (v == null || v.trim().isEmpty) {
                return locale.firstNameRequired;
              }
              return null;
            },
          ),
          SizedBox(height: 20.h),
          AppTextField(
            controller: viewModel.lastNameController,
            label: locale.lastName,
            hint: locale.enterYourLastName,
            backGroundColor: AppColors.accentColor,
            validator: (v) {
              if (v == null || v.trim().isEmpty) {
                return locale.lastNameRequired;
              }
              return null;
            },
          ),
          SizedBox(height: 20.h),
          AppTextField(
            controller: viewModel.emailController,
            label: locale.email,
            hint: locale.enterYourEmail,
            backGroundColor: AppColors.accentColor,
            validator: (v) => AppValidators.validateEmail(v, context),
          ),
          SizedBox(height: 20.h),
          AppTextField(
            controller: viewModel.passwordController,
            label: locale.password,
            hint: locale.enterYourPassword,
            backGroundColor: AppColors.accentColor,
            isPassword: true,
            validator: (v) => AppValidators.validatePassword(v, context),
          ),
          SizedBox(height: 20.h),
          AppTextField(
            controller: viewModel.confirmPasswordController,
            label: locale.confirmPassword,
            hint: locale.enterYourConfirmPassword,
            backGroundColor: AppColors.accentColor,
            isPassword: true,
            validator: (v) {
              if (v == null || v.isEmpty) {
                return locale.confirmPasswordRequired;
              } else if (v != viewModel.passwordController.text) {
                return locale.passwordNotMatched;
              }
              return null;
            },
          ),
          SizedBox(height: 20.h),
          Center(
            child: SizedBox(
              width: double.infinity,
              height: 55.h,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(AppColors.secondary),
                ),
                onPressed: state.signupState?.isLoading == true
                    ? null
                    : () async {
                        try {
                          viewModel.doIntent(SignupEvent());
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Failed to sign up: $e')),
                          );
                        }
                      },
                child: Text(
                  locale.signup,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.blackColor,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          _buildSocialSignupButtons(locale, state),
          SizedBox(height: 20.h),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  locale.alreadyHaveAnAccount,
                  style: TextStyle(fontSize: 14.sp, color: AppColors.secondary),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                      context,
                      Routes.signinScreen,
                    );
                  },
                  child: Text(
                    locale.signin,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialSignupButtons(
    AppLocalizations locale,
    SignupStates state,
  ) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 50.h,
          child: OutlinedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(AppColors.whiteColor),
              side: WidgetStateProperty.all(
                const BorderSide(color: AppColors.secondary),
              ),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
            onPressed: state.signupState?.isLoading == true
                ? null
                : () async {
                    try {
                      viewModel.doIntent(SignupWithGoogleEvent());
                    } catch (e) {
                      print('Google Sign-In error: $e');
                    }
                  },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppImages.googleLogo,
                  width: 24.w,
                  height: 24.h,
                ),
                SizedBox(width: 10.w),
                Text(
                  locale.continueWithGoogle,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.blackColor,
                  ),
                ),
              ],
            ),
          ),
        ),],
    );
  }
}
