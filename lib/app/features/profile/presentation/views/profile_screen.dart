import 'package:art_of_pilates/app/config/di/di.dart';
import 'package:art_of_pilates/app/core/util/app_colors.dart';
import 'package:art_of_pilates/app/core/util/app_locale.dart';
import 'package:art_of_pilates/app/features/profile/domain/use_cases/navigate_to_edit_info_screen_use_case.dart';
import 'package:art_of_pilates/app/features/profile/domain/use_cases/navigate_to_home_screen_use_case.dart';
import 'package:art_of_pilates/app/features/profile/domain/use_cases/navigate_to_settings_screen_use_case.dart';
import 'package:art_of_pilates/app/features/profile/presentation/view_model/profile_states.dart';
import 'package:art_of_pilates/app/features/profile/presentation/view_model/profile_view_model.dart';
import 'package:art_of_pilates/app/features/profile/presentation/views/account_tab.dart';
import 'package:art_of_pilates/app/features/profile/presentation/views/my_activities_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final ProfileViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = getIt<ProfileViewModel>();
    viewModel.getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: viewModel,
      child: DefaultTabController(
        length: 2,
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
      title: Column(
        children: [
          Text(
            locale.profile,
            style: const TextStyle(
              color: AppColors.whiteColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            locale.artOfPilates,
            style: TextStyle(
              color: AppColors.whiteColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
      leading: IconButton(
        onPressed: () => NavigateToHomeScreenUseCase.call(context),
        icon: const Icon(
          Icons.arrow_back_ios_new_outlined,
          color: AppColors.whiteColor,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            NavigateToSettingsScreenUseCase.call(context);
          },
          icon: const Icon(
            Icons.settings_outlined,
            color: AppColors.whiteColor,
          ),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    final locale = appLocale(context);
    return BlocBuilder<ProfileViewModel, ProfileStates>(
      builder: (context, state) {
        final user = state.userProfileStateParam?.data;

        final String fullName = user != null
            ? '${user.firstName ?? ''} ${user.lastName ?? ''}'.trim()
            : '';

        final String avatarLetter = user?.firstName?.isNotEmpty == true
            ? user!.firstName![0].toUpperCase()
            : '?';

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fullName.isEmpty ? '...' : fullName,
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.accentColor,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      ElevatedButton(
                        onPressed: () {
                          NavigateToEditInfoScreenUseCase.call(context);
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            AppColors.primary,
                          ),
                          minimumSize: WidgetStatePropertyAll(
                            Size(180.w, 28.h),
                          ),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                          ),
                        ),
                        child: Text(
                          locale.editInfo,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 40.r,
                        backgroundColor: AppColors.primary,
                        child: Text(
                          avatarLetter,
                          style: TextStyle(
                            fontSize: 28.sp,
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 2,
                        right: 2,
                        child: Container(
                          width: 14.w,
                          height: 14.h,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.backgroundColor,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            TabBar(
              indicatorColor: AppColors.accentColor,
              indicatorWeight: 2,
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: AppColors.accentColor,
              labelColor: AppColors.accentColor,
              unselectedLabelColor: AppColors.accentColor,
              labelStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.normal,
              ),
              tabs: [
                Tab(text: locale.myActivities),
                Tab(text: locale.account),
              ],
            ),
            Expanded(
              child: TabBarView(children: [MyActivitiesTab(), AccountTab()]),
            ),
          ],
        );
      },
    );
  }
}
