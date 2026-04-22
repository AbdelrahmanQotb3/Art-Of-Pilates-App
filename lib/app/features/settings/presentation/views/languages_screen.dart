import 'package:art_of_pilates/app/core/util/app_colors.dart';
import 'package:art_of_pilates/app/core/util/app_locale.dart';
import 'package:art_of_pilates/app/features/profile/domain/use_cases/navigate_to_settings_screen_use_case.dart';
import 'package:art_of_pilates/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguagesScreen extends StatefulWidget {
  const LanguagesScreen({super.key});

  @override
  State<LanguagesScreen> createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {
  String _selectedLocale = 'en';

  @override
  void initState() {
    super.initState();
    _loadSavedLocale();
  }

  Future<void> _loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedLocale = prefs.getString('locale') ?? 'en';
    });
  }

  Future<void> _saveAndRestart() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('locale', _selectedLocale);

  if (!mounted) return;
  MyApp.of(context)?.setLocale(Locale(_selectedLocale));
  NavigateToSettingsScreenUseCase.call(context);
}

  @override
  Widget build(BuildContext context) {
    final locale = appLocale(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: _buildAppBar(context, locale),
      body: _buildBody(context, locale),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, dynamic locale) {
    return AppBar(
      backgroundColor: AppColors.primary,
      centerTitle: true,
      title: Text(
        locale.appLanguage,
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
      actions: [
        TextButton(
          onPressed: _saveAndRestart,
          child: Text(
            locale.save,
            style: TextStyle(
              color: AppColors.whiteColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context, dynamic locale) {
    final languages = [
      {'code': 'ar', 'label': 'Arabic - (العربية)'},
      {'code': 'en', 'label': 'English - (English)'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          color: AppColors.backgroundColor,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Text(
            locale.appWillRestartOnLanguageChange,
            style: TextStyle(
              fontSize: 13.sp,
              color: AppColors.accentColor,
            ),
          ),
        ),

        Divider(color: AppColors.accentColor, height: 1),
        Expanded(
          child: ListView.separated(
            itemCount: languages.length,
            separatorBuilder: (_, _) => Divider(
              color: AppColors.accentColor,
              height: 1,
            ),
            itemBuilder: (context, index) {
              final lang = languages[index];
              final isSelected = _selectedLocale == lang['code'];
              return ListTile(
                tileColor: AppColors.backgroundColor,
                title: Text(
                  lang['label']!,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.accentColor,
                  ),
                ),
                trailing: isSelected
                    ? Icon(
                        Icons.check,
                        color: AppColors.accentColor,
                        size: 20.sp,
                      )
                    : null,
                onTap: () {
                  setState(() => _selectedLocale = lang['code']!);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}