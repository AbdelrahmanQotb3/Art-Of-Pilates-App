import 'package:art_of_pilates/app/core/util/app_locale.dart';
import 'package:art_of_pilates/app/features/bookings/domain/use_cases/navigate_to_all_bookings_screen_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyActivitiesTab extends StatelessWidget {
  const MyActivitiesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = appLocale(context);
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Text(
            locale.seeYourInfoAndActivities,
            style: theme.textTheme.bodyMedium,
          ),
        ),
        _buildMenuItem(
          context,
          Icons.calendar_today_outlined,
          locale.bookings,
          onTap: () => NavigateToAllBookingsScreenUseCase.call(context),
        ),
        _buildMenuItem(context, Icons.shopping_bag_outlined, locale.orders),
        _buildMenuItem(context, Icons.stars_outlined, locale.rewards),
        _buildMenuItem(context, Icons.check_box_outlined, locale.myPrograms),
      ],
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String label, {
    VoidCallback? onTap,
  }) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Icon(icon, color: theme.colorScheme.tertiary, size: 22),
      title: Text(
        label,
        style: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(Icons.chevron_right, color: theme.colorScheme.tertiary),
      onTap: onTap ?? () {},
    );
  }
}
