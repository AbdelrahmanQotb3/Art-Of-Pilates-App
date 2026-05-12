import 'package:art_of_pilates/app/config/di/di.dart';
import 'package:art_of_pilates/app/core/routes/routes.dart';
import 'package:art_of_pilates/app/core/util/app_colors.dart';
import 'package:art_of_pilates/app/core/util/app_images.dart';
import 'package:art_of_pilates/app/core/util/app_locale.dart';
import 'package:art_of_pilates/app/core/util/app_validation.dart';
import 'package:art_of_pilates/app/features/signin/presentation/view_model/signin_events.dart';
import 'package:art_of_pilates/app/features/signin/presentation/view_model/signin_states.dart';
import 'package:art_of_pilates/app/features/signin/presentation/view_model/signin_view_model.dart';
import 'package:art_of_pilates/app/widgets/app_exception_dialog.dart';
import 'package:art_of_pilates/app/widgets/app_text_field.dart';
import 'package:art_of_pilates/app/widgets/loading_dialog.dart';
import 'package:art_of_pilates/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SigninScreen extends StatelessWidget {
  final SigninViewModel viewModel = getIt<SigninViewModel>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = appLocale(context);

    return Scaffold(
      backgroundColor: AppColors.accentColor,
      appBar: _buildAppBar(context, locale),
      body: BlocProvider(
        create: (context) => viewModel,
        child: BlocConsumer<SigninViewModel, SigninStates>(
          listener: (context, state) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (state.signinState?.isLoading == true) {
                LoadingDialog.show(context, message: 'Signing in...');
              } else if (state.signinState?.data != null) {
                if (Navigator.of(context).canPop()) Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, Routes.homeScreen);
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
    SigninStates state,
  ) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildHeaderMessage(locale),
            _buildSigninForm(locale, context, state),
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
            locale.welcomeAppName,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.secondary,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            locale.enterYourEmailAndPassword,
            style: TextStyle(fontSize: 14.sp, color: AppColors.secondary),
          ),
        ],
      ),
    );
  }

  Widget _buildSigninForm(
    AppLocalizations locale,
    BuildContext context,
    SigninStates state,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          SizedBox(height: 12.h),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: Text(
                locale.forgotPassword,
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 16.sp,
                ),
              ),
            ),
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
                onPressed: state.signinState?.isLoading == true
                    ? null
                    : () {
                        if (_formKey.currentState!.validate()) {
                          viewModel.doIntent(
                            SigninEvent(),
                            viewModel.emailController.text,
                            viewModel.passwordController.text,
                          );
                        }
                      },
                child: Text(
                  locale.signin,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.blackColor,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          _buildSocialSigninButtons(locale, state),
          SizedBox(height: 20.h),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  locale.dontHaveAnAccount,
                  style: TextStyle(fontSize: 14.sp, color: AppColors.secondary),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                      context,
                      Routes.signupScreen,
                    );
                  },
                  child: Text(
                    locale.signup,
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

  Widget _buildSocialSigninButtons(
    AppLocalizations locale,
    SigninStates state,
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
            onPressed: state.signinState?.isLoading == true
                ? null
                : () {
                    viewModel.doIntent(SigninWithGoogleEvent());
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
        ),
      ],
    );
  }
}
