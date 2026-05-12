import 'package:art_of_pilates/app/core/util/app_locale.dart';
import 'package:art_of_pilates/app/features/profile/presentation/view_model/profile_states.dart';
import 'package:art_of_pilates/app/features/profile/presentation/view_model/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountTab extends StatelessWidget {
  const AccountTab({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = appLocale(context);
    final theme = Theme.of(context);
    return BlocBuilder<ProfileViewModel, ProfileStates>(
      builder: (context, state) {
        if (state.userProfileStateParam?.isLoading ?? false) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.userProfileStateParam?.errorMessage != null) {
          return Center(
            child: Text(
              'Error: ${state.userProfileStateParam!.errorMessage}',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
          );
        } else if (state.userProfileStateParam?.data != null) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 12.0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  locale.overView,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.h),
                _buildDataRow(
                  context,
                  locale.firstName,
                  state.userProfileStateParam!.data!.firstName ?? '',
                ),
                _buildDataRow(
                  context,
                  locale.lastName,
                  state.userProfileStateParam!.data!.lastName ?? '',
                ),
                _buildDataRow(
                  context,
                  locale.email,
                  state.userProfileStateParam!.data!.email ?? '',
                ),
                _buildDataRow(
                  context,
                  locale.role,
                  state.userProfileStateParam!.data!.role ?? '',
                ),
              ],
            ),
          );
        }
        return Center(
          child: Text('No user data found', style: theme.textTheme.bodyMedium),
        );
      },
    );
  }

  Widget _buildDataRow(BuildContext context, String title, String info) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textTheme.bodySmall),
          SizedBox(height: 8.h),
          Text(
            info,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
