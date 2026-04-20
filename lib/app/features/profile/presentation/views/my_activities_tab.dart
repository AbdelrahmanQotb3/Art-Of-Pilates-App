import 'package:art_of_pilates/app/core/util/app_colors.dart';
import 'package:art_of_pilates/app/core/util/app_locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyActivitiesTab extends StatelessWidget {
  const MyActivitiesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = appLocale(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Text(
            locale.seeYourInfoAndActivities,
            style: TextStyle(
              fontSize: 13.sp,
              color: AppColors.accentColor,
            ),
          ),
        ),
        _buildMenuItem(Icons.calendar_today_outlined, locale.bookings),
        _buildMenuItem(Icons.shopping_bag_outlined, locale.orders),
        _buildMenuItem(Icons.stars_outlined, locale.rewards),
        _buildMenuItem(Icons.check_box_outlined, locale.myPrograms),
      ],
    );
  }

  Widget _buildMenuItem(IconData icon, String label) {
    return ListTile(
      leading: Icon(icon, color: AppColors.accentColor, size: 22),
      title: Text(
        label,
        style: const TextStyle(
          color: AppColors.accentColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: AppColors.accentColor),
      onTap: () {},
    );
  }
}
