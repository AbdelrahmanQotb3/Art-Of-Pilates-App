import 'package:art_of_pilates/app/config/di/di.dart';
import 'package:art_of_pilates/app/core/util/app_colors.dart';
import 'package:art_of_pilates/app/core/util/app_locale.dart';
import 'package:art_of_pilates/app/features/packages/domain/model/packages_model.dart';
import 'package:art_of_pilates/app/features/packages/domain/use_cases/navigate_to_checkout_screen_use_case.dart';
import 'package:art_of_pilates/app/features/packages/presentation/view_model/packages_states.dart';
import 'package:art_of_pilates/app/features/packages/presentation/view_model/packages_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PackageDetailsScreen extends StatefulWidget {
  final int packageId;
  const PackageDetailsScreen({super.key, required this.packageId});

  @override
  State<PackageDetailsScreen> createState() => _PackageDetailsScreenState();
}

class _PackageDetailsScreenState extends State<PackageDetailsScreen> {
  late final PackagesViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = getIt<PackagesViewModel>();
    viewModel.getOnePackage(widget.packageId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: viewModel,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: _buildAppBar(context),
        body: BlocBuilder<PackagesViewModel, PackagesStates>(
          buildWhen: (prev, curr) =>
              prev.onePackageState != curr.onePackageState,
          builder: (context, state) {
            if (state.onePackageState?.isLoading ?? false) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.onePackageState?.errorMessage != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.onePackageState!.errorMessage!,
                      style: TextStyle(color: Colors.red, fontSize: 14.sp),
                    ),
                    SizedBox(height: 12.h),
                    ElevatedButton(
                      onPressed: () =>
                          viewModel.getOnePackage(widget.packageId),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            final plan = state.onePackageState?.data;
            if (plan == null) return const SizedBox.shrink();
            return _buildBody(context, plan);
          },
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
        locale.planSummary,
        style: TextStyle(
          color: AppColors.whiteColor,
          fontSize: 18.sp,
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
    );
  }

  Widget _buildBody(BuildContext context, PricingPlanEntity plan) {
    final locale = appLocale(context);
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  plan.planName ?? '',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.accentColor,
                  ),
                ),
                SizedBox(height: 10.h),
                if (plan.planDetails != null)
                  Text(
                    plan.planDetails ?? '',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: AppColors.accentColor,
                      height: 1.5,
                    ),
                  ),
                SizedBox(height: 24.h),
                _buildSummaryRow(
                  locale.price,
                  '${plan.currency ?? 'SAR'} ${plan.price?.toStringAsFixed(2) ?? ''}',
                  bold: true,
                ),
                _buildDivider(),
                _buildSummaryRow(
                  locale.startDate,
                  locale.selectDuringCheckout,
                  bold: true,
                ),
                _buildDivider(),
                _buildSummaryRow(
                  locale.duration,
                  plan.duration ?? '',
                  bold: true,
                ),
                _buildDivider(),
              ],
            ),
          ),
        ),

        Container(
          color: AppColors.backgroundColor,
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        '${locale.totalToday}  ',
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: AppColors.accentColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${plan.currency ?? 'SAR'} ${plan.price?.toStringAsFixed(2) ?? ''}',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.accentColor,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      NavigateToCheckoutScreenUseCase.call(context, plan);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 28.w,
                        vertical: 12.h,
                      ),
                    ),
                    child: Text(
                      locale.checkout,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Text(
                locale.taxDisclaimer,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: AppColors.accentColor,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool bold = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 14.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.accentColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              color: AppColors.accentColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() =>
      Divider(color: AppColors.accentColor, height: 1);
}
