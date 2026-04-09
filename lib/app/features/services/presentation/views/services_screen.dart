import 'package:art_of_pilates/app/config/di/di.dart';
import 'package:art_of_pilates/app/core/util/app_colors.dart';
import 'package:art_of_pilates/app/core/util/app_images.dart';
import 'package:art_of_pilates/app/core/util/app_locale.dart';
import 'package:art_of_pilates/app/features/services/domain/model/services_model.dart';
import 'package:art_of_pilates/app/features/services/domain/use_cases/navigate_to_service_details_screen_use_case.dart';
import 'package:art_of_pilates/app/features/services/presentation/view_model/services_events.dart';
import 'package:art_of_pilates/app/features/services/presentation/view_model/services_view_model.dart';
import 'package:art_of_pilates/app/features/services/presentation/view_model/services_states.dart';
import 'package:art_of_pilates/app/widgets/app_text_field.dart';
import 'package:art_of_pilates/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ServicesViewModel>()..doIntent(ServicesEvent()),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: _buildAppBar(context),
        body: _buildBody(context),
      ),
    );
  }

  PreferredSizeWidget? _buildAppBar(BuildContext context) {
    final locale = appLocale(context);
    return AppBar(
      backgroundColor: AppColors.primary,
      title: Column(
        children: [
          Text(
            locale.services,
            style: const TextStyle(
              color: AppColors.whiteColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            locale.artOfPilates,
            style: const TextStyle(
              color: AppColors.whiteColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
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
        if (state.servicesState?.isLoading ?? false) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.servicesState?.errorMessage != null) {
          return Center(
            child: Text(
              'Error: ${state.servicesState!.errorMessage}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else if (state.servicesState?.data?.services != null) {
          final services = state.servicesState!.data!.services!;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSearchBar(locale),
                  const SizedBox(height: 10),
                  ...services.map(
                    (service) => InkWell(
                      onTap: () => NavigateToServiceDetailsScreenUseCase.call(context, service.id!),
                      child: _buildServiceItem(context, service)
                      ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: Text('No services available'));
        }
      },
    );
  }

  AppTextField _buildSearchBar(AppLocalizations locale) {
    return AppTextField(
      controller: TextEditingController(),
      hint: locale.searchForServices,
      label: locale.searchForServices,
      prefixIcon: const Icon(
        Icons.search_outlined,
        color: AppColors.accentColor,
      ),
    );
  }

  Widget _buildServiceItem(BuildContext context, ServiceEntity service) {
    final locale = appLocale(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: Image.asset(AppImages.splashLogo, width: 60, height: 60),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.name ?? 'Unknown Service',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.accentColor,
                  ),
                ),
                Text(
                  service.location ?? 'Unknown Location',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.accentColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${service.currency ?? ''} ${service.price ?? 0} . ${locale.payableWithPlan}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.accentColor,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 12),
            child: ElevatedButton(
              onPressed: () {
                // Handle booking action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                locale.book,
                style: const TextStyle(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
