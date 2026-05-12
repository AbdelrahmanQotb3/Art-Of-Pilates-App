import 'package:art_of_pilates/app/config/di/di.dart';
import 'package:art_of_pilates/app/core/util/app_colors.dart';
import 'package:art_of_pilates/app/core/util/app_locale.dart';
import 'package:art_of_pilates/app/features/home/domain/use_cases/navigate_to_profile_screen_use_case.dart';
import 'package:art_of_pilates/app/features/packages/presentation/view_model/packages_states.dart';
import 'package:art_of_pilates/app/features/packages/presentation/view_model/packages_view_model.dart';
import 'package:art_of_pilates/app/features/packages/presentation/views/pricing_plan_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PackagesTab extends StatefulWidget {
  const PackagesTab({super.key});

  @override
  State<PackagesTab> createState() => _PackagesTabState();
}

class _PackagesTabState extends State<PackagesTab> {
  late final PackagesViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = getIt<PackagesViewModel>();
    viewModel.getAllPackages();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: viewModel,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: _buildAppBar(context),
        body: _buildBody(context),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.person, size: 26, color: Colors.white),
        onPressed: () => NavigateToProfileScreenUseCase.call(context),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications, size: 26, color: Colors.white),
          onPressed: () {},
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    final locale = appLocale(context);
    return BlocBuilder<PackagesViewModel, PackagesStates>(
      builder: (context, state) {
        if (state.packagesState?.isLoading ?? false) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.packagesState?.errorMessage != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  state.packagesState!.errorMessage!,
                  style: TextStyle(color: AppColors.redColor, fontSize: 14.sp),
                ),
                SizedBox(height: 12.h),
                ElevatedButton(
                  onPressed: () => viewModel.getAllPackages(),
                  child: Text(locale.retry),
                ),
              ],
            ),
          );
        }

        final plans = state.packagesState?.data?.plans ?? [];

        if (plans.isEmpty) {
          return Center(
            child: Text(
              appLocale(context).noPackagesFound,
              style: TextStyle(fontSize: 14.sp, color: AppColors.accentColor),
            ),
          );
        }

        return ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          itemCount: plans.length,
          separatorBuilder: (_, _) => SizedBox(height: 16.h),
          itemBuilder: (context, index) => PricingPlanCard(plan: plans[index]),
        );
      },
    );
  }
}
