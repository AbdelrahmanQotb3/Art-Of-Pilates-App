import 'package:art_of_pilates/app/config/di/di.dart';
import 'package:art_of_pilates/app/core/util/app_colors.dart';
import 'package:art_of_pilates/app/core/util/app_locale.dart';
import 'package:art_of_pilates/app/features/profile/presentation/view_model/profile_states.dart';
import 'package:art_of_pilates/app/features/profile/presentation/view_model/profile_view_model.dart';
import 'package:art_of_pilates/app/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final ProfileViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = getIt<ProfileViewModel>();
    viewModel.getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: _buildAppBar(context),
        body: BlocListener<ProfileViewModel, ProfileStates>(
          listenWhen: (previous, current) =>
              previous.editUserProfileStateParam?.isLoading == true &&
              current.editUserProfileStateParam?.isLoading == false,
          listener: (context, state) {
            if (state.editUserProfileStateParam?.data != null) {
              _showSnackbar(context, appLocale(context).updateSuccess,  Colors.green);
            } else if (state.editUserProfileStateParam?.errorMessage != null) {
              _showSnackbar(context, state.editUserProfileStateParam!.errorMessage!, Colors.red);
            }
          },
          child: _buildBody(context),
        ),
      ),
    );
  }

  void _showSnackbar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        margin: EdgeInsets.all(16.w),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final locale = appLocale(context);
    return AppBar(
      backgroundColor: AppColors.primary,
      centerTitle: true,
      title: Text(
        locale.editInfo,
        style: const TextStyle(
          color: AppColors.whiteColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(
          Icons.arrow_back_ios_new_outlined,
          color: AppColors.whiteColor,
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: BlocBuilder<ProfileViewModel, ProfileStates>(
            builder: (context, state) {
              final bool canSave = state.hasChanges;
              final bool isLoading = state.editUserProfileStateParam?.isLoading ?? false;

              return Center(
                child: InkWell(
                  onTap: (canSave && !isLoading)
                      ? () {
                          viewModel.editUserInfo();
                        }
                      : null,
                  child: isLoading
                      ? SizedBox(
                          width: 20.w,
                          height: 20.h,
                          child: const CircularProgressIndicator(
                            color: AppColors.whiteColor,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          locale.save,
                          style: TextStyle(
                            color: canSave
                                ? AppColors.whiteColor
                                : AppColors.whiteColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    final locale = appLocale(context);
    return BlocBuilder<ProfileViewModel, ProfileStates>(
      builder: (context, state) {
        if (state.userProfileStateParam?.isLoading ?? false) {
          return const Center(child: CircularProgressIndicator());
        }

        final user = state.userProfileStateParam?.data;
        final String avatarLetter = user?.firstName?.isNotEmpty == true
            ? user!.firstName![0].toUpperCase()
            : '?';

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPhotoIcon(avatarLetter),
                SizedBox(height: 20.h),
                
                _buildLabel(locale.userName),
                AppTextField(
                  controller: viewModel.usernameController,
                  hint: "${user?.firstName} ${user?.lastName}",
                  backGroundColor: AppColors.backgroundColor,
                ),
                
                SizedBox(height: 16.h),
                Divider(
                  height: 32.h,
                  color: AppColors.accentColor,
                  thickness: 1,
                ),
                
                Text(locale.editInfo, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
                SizedBox(height: 4.h),
                Text(
                  locale.updateYourPersonalInformation,
                  style: TextStyle(fontSize: 13.sp, color: Colors.grey),
                ),
                SizedBox(height: 20.h),

                _buildLabel(locale.firstName),
                AppTextField(
                  controller: viewModel.firstNameController,
                  hint: user?.firstName ?? "",
                  backGroundColor: AppColors.backgroundColor,
                ),
                
                SizedBox(height: 16.h),
                _buildLabel(locale.lastName),
                AppTextField(
                  controller: viewModel.lastNameController,
                  hint: user?.lastName ?? "",
                  backGroundColor: AppColors.backgroundColor,
                ),
                
                SizedBox(height: 16.h),
                _buildLabel(locale.email),
                AppTextField(
                  controller: viewModel.emailController,
                  hint: user?.email ?? "",
                  backGroundColor: AppColors.backgroundColor,
                ),
                
                SizedBox(height: 16.h),
                _buildLabel(locale.phone),
                AppTextField(
                  controller: viewModel.phoneController,
                  hint: user?.phone ?? locale.phone,
                  backGroundColor: AppColors.backgroundColor,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        text,
        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
      ),
    );
  }

  Center _buildPhotoIcon(String avatarLetter) {
    return Center(
      child: Stack(
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
            bottom: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(6.r),
              decoration: BoxDecoration(
                color: AppColors.secondary,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.backgroundColor, width: 2),
              ),
              child: Icon(Icons.camera_alt_outlined, size: 18.sp, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}