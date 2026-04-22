import 'package:art_of_pilates/app/config/di/di.dart';
import 'package:art_of_pilates/app/core/util/app_colors.dart';
import 'package:art_of_pilates/app/core/util/app_images.dart';
import 'package:art_of_pilates/app/core/util/app_locale.dart';
import 'package:art_of_pilates/app/features/services/presentation/view_model/services_events.dart';
import 'package:art_of_pilates/app/features/services/presentation/view_model/services_states.dart';
import 'package:art_of_pilates/app/features/services/presentation/view_model/services_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceDetailsScreen extends StatelessWidget {
  final String serviceId;
  final ServicesViewModel viewModel = getIt<ServicesViewModel>();
  ServiceDetailsScreen({super.key, required this.serviceId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          viewModel..doIntent(OneServiceEvent(serviceId: serviceId)),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: _buildAppBar(context),
        body: _buildBody(context),
        bottomNavigationBar: _buildBottomNavigationBar(context),
      ),
    );
  }

  PreferredSizeWidget? _buildAppBar(BuildContext context) {
    final locale = appLocale(context);
    return AppBar(
      backgroundColor: AppColors.primary,
      title: Text(
        locale.serviceDetails,
        style: TextStyle(
          color: AppColors.whiteColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(
          Icons.arrow_back_ios_new_outlined,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }

  Widget? _buildBody(BuildContext context) {
    final locale = appLocale(context);
    return BlocBuilder<ServicesViewModel, ServicesStates>(
      builder: (context, state) {
        if (state.oneServiceState?.isLoading ?? false) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.oneServiceState?.errorMessage != null) {
          return Center(
            child: Text(
              'Error: ${state.oneServiceState!.errorMessage}',
              style: const TextStyle(color: AppColors.redColor),
            ),
          );
        } else if (state.oneServiceState?.data != null) {
          final service = state.oneServiceState!.data!;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildServiceImageSection(),
                SizedBox(height: 16.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service.name ?? 'Unknown Service',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        locale.location,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        service.location ?? 'Unknown Location',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6.w),
                        child: Text(
                          "Art of Pilates Studio, Muhammed Al Tawedi, Jeddah, Saudi Arabia",
                          style: TextStyle(fontSize: 14.sp),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        locale.price,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        service.price.toString(),
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        locale.partOfPricingPlan,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        service.bookingPolicy.toString(),
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: Text('Service not found'));
        }
      },
    );
  }

  Image _buildServiceImageSection() => Image.asset(
    AppImages.homeLogo,
    width: double.infinity,
    height: 250.h,
    fit: BoxFit.cover,
  );

  Widget _buildBottomNavigationBar(BuildContext context) {
    final locale = appLocale(context);
    return BottomAppBar(
      color: AppColors.backgroundColor,
      elevation: 0,
      child: Center(
        child: SizedBox(
          width: 160.w,
          height: 50.h,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            onPressed: () {
              // Handle service selection logic
            },
            child: Text(
              locale.selectService,
              style: TextStyle(
                color: AppColors.whiteColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
