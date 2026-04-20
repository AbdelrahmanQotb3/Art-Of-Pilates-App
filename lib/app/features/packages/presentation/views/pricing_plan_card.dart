import 'package:art_of_pilates/app/config/di/di.dart';
import 'package:art_of_pilates/app/core/util/app_colors.dart';
import 'package:art_of_pilates/app/core/util/app_locale.dart';
import 'package:art_of_pilates/app/features/packages/domain/model/packages_model.dart';
import 'package:art_of_pilates/app/features/packages/domain/use_cases/navigate_to_package_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PricingPlanCard extends StatefulWidget {
  final PricingPlanEntity plan;
  const PricingPlanCard({super.key, required this.plan});

  @override
  State<PricingPlanCard> createState() => _PricingPlanCardState();
}

class _PricingPlanCardState extends State<PricingPlanCard> {
  bool _showBenefits = false;

  @override
  Widget build(BuildContext context) {
    final locale = appLocale(context);
    final plan = widget.plan;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              plan.planName ?? '',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.accentColor,
              ),
            ),
            SizedBox(height: 8.h),

            if (plan.services != null && plan.services!.isNotEmpty)
              Text(
                plan.services!.map((s) => s.name ?? '').join(', '),
                style: TextStyle(
                  fontSize: 13.sp,
                  color: AppColors.accentColor,
                ),
              ),

            SizedBox(height: 12.h),

            Text(
              '${plan.currency ?? 'SAR'} ${plan.price?.toStringAsFixed(2) ?? ''}',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),

            SizedBox(height: 6.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${locale.validFor} ${plan.duration ?? ''}',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: AppColors.accentColor,
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    getIt<NavigateToPackageDetailsScreenUseCase>().call(
                      context,
                      plan.id!,
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.accentColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 6.h,
                    ),
                  ),
                  child: Text(
                    locale.select,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: AppColors.accentColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            if (plan.services != null && plan.services!.isNotEmpty) ...[
              Divider(
                color: AppColors.accentColor,
                height: 20.h,
              ),
              GestureDetector(
                onTap: () => setState(() => _showBenefits = !_showBenefits),
                child: Row(
                  children: [
                    Text(
                      locale.showBenefits,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppColors.accentColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      _showBenefits
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      size: 18.sp,
                      color: AppColors.accentColor,
                    ),
                  ],
                ),
              ),
              if (_showBenefits) ...[
                SizedBox(height: 8.h),
                ...plan.services!.map(
                  (service) => Padding(
                    padding: EdgeInsets.only(bottom: 6.h),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check,
                          size: 14.sp,
                          color: AppColors.primary,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            '${plan.totalSessions ?? ''} ${service.name ?? ''}',
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: AppColors.accentColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
