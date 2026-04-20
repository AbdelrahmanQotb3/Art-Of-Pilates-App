import 'package:art_of_pilates/app/core/util/app_colors.dart';
import 'package:art_of_pilates/app/core/util/app_locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CouponBottomSheet {
  static void show(
    BuildContext context, {
    required Function(String) onApplied,
  }) {
    final locale = appLocale(context);
    final TextEditingController couponController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            top: 24.h,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  locale.enterCouponcode,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.accentColor,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                locale.couponCode,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: AppColors.accentColor,
                ),
              ),
              SizedBox(height: 8.h),
              TextField(
                controller: couponController,
                autofocus: true,
                style: TextStyle(color: AppColors.accentColor),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary, width: 2),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Text(
                      locale.cancel,
                      style: TextStyle(fontSize: 14.sp, color: AppColors.accentColor),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (couponController.text.trim().isNotEmpty) {
                        onApplied(couponController.text.trim());
                      }
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                    ),
                    child: Text(
                      locale.apply,
                      style: TextStyle(color: AppColors.whiteColor, fontSize: 14.sp),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}