import 'package:art_of_pilates/app/core/util/app_colors.dart';
import 'package:art_of_pilates/app/core/util/app_locale.dart';
import 'package:art_of_pilates/app/features/profile/domain/use_cases/navigate_to_settings_screen_use_case.dart';
import 'package:flutter/material.dart';

class DisplayScreen extends StatelessWidget {
  const DisplayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: _buildAppBar(context),
      // body: _buildBody(context),
    );
  }
  
  PreferredSizeWidget? _buildAppBar(BuildContext context) {
    final locale = appLocale(context);
    return AppBar(
      backgroundColor: AppColors.primary,
      centerTitle: true,
      title: Text(
        locale.appDisplay,
        style: TextStyle(
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
}
