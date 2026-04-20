import 'package:art_of_pilates/app/core/util/app_colors.dart';
import 'package:art_of_pilates/app/core/util/app_locale.dart';
import 'package:art_of_pilates/app/features/packages/domain/model/packages_model.dart';
import 'package:art_of_pilates/app/features/packages/presentation/views/copoun_sheet.dart';
import 'package:art_of_pilates/app/features/packages/presentation/views/date_picker_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CheckoutScreen extends StatefulWidget {
  final PricingPlanEntity plan;
  const CheckoutScreen({super.key, required this.plan});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  DateTime _selectedStartDate = DateTime.now();
  String? _appliedCoupon;
  bool _policyAccepted = false;
  bool _showPolicyError = false;

  void _showCouponSheet(BuildContext context) {
    CouponBottomSheet.show(
    context,
    onApplied: (code) => setState(() => _appliedCoupon = code),
  );}

  void _showDatePicker(BuildContext context) {
    AppDatePickerSheet.show(
    context,
    initialDate: _selectedStartDate,
    onDateSelected: (date) => setState(() => _selectedStartDate = date),
  );}

  @override
  Widget build(BuildContext context) {
    final locale = appLocale(context);
    final plan = widget.plan;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 14.h,
                    ),
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
                        SizedBox(height: 4.h),
                        Text(
                          'Starts ${DateFormat('MMM d, yyyy').format(_selectedStartDate)}',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.accentColor,
                          ),
                        ),
                        Text(
                          'Valid for ${plan.duration ?? ''}',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.accentColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  _buildDivider(),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 14.h,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 18.sp,
                          color: AppColors.accentColor,
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                locale.planStarts,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: AppColors.accentColor,
                                ),
                              ),
                              Text(
                                _isToday(_selectedStartDate)
                                    ? locale.today
                                    : DateFormat(
                                        'MMM d, yyyy',
                                      ).format(_selectedStartDate),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.accentColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _showDatePicker(context),
                          child: Text(
                            locale.change,
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: AppColors.accentColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  _buildDivider(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 14.h,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.discount_outlined,
                          size: 18.sp,
                          color: AppColors.accentColor,
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Text(
                            _appliedCoupon ??
                                locale
                                    .copounNotAdded,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: _appliedCoupon != null
                                  ? AppColors.accentColor
                                  : AppColors.accentColor
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _showCouponSheet(context),
                          child: Text(
                            locale.enter,
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: AppColors.accentColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  _buildDivider(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          locale.totalToday,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.accentColor,
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
                  ),

                  _buildDivider(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 14.h,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              text: '${locale.iHaveReadAndAcceptPlanPolicy} ',
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: AppColors.accentColor,
                              ),
                              children: [
                                TextSpan(
                                  text: locale.planPolicy,
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: AppColors.primary,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                TextSpan(text: '.'),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _policyAccepted = !_policyAccepted;
                              if (_policyAccepted) _showPolicyError = false;
                            });
                          },
                          child: Container(
                            width: 24.w,
                            height: 24.h,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.accentColor,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(4.r),
                              color: _policyAccepted
                                  ? AppColors.primary
                                  : Colors.transparent,
                            ),
                            child: _policyAccepted
                                ? Icon(
                                    Icons.check,
                                    size: 16.sp,
                                    color: AppColors.whiteColor,
                                  )
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),

                  if (_showPolicyError)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 12.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red.shade900,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: AppColors.whiteColor,
                              size: 16.sp,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              locale.mustAcceptPlanPolicy,
                              style: TextStyle(
                                color: AppColors.whiteColor,
                                fontSize: 13.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
            child: SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                onPressed: () {
                  if (!_policyAccepted) {
                    setState(() => _showPolicyError = true);
                    return;
                  }
                  // TODO: continue to payment logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                ),
                child: Text(
                  locale.continueToPaymnet,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final locale = appLocale(context);
    return AppBar(
      backgroundColor: AppColors.primary,
      centerTitle: true,
      title: Text(
        locale.checkout,
        style: TextStyle(
          color: AppColors.whiteColor,
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

  Widget _buildDivider() =>
      Divider(color: AppColors.accentColor, height: 1);

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }
}
