import 'package:art_of_pilates/app/config/di/di.dart';
import 'package:art_of_pilates/app/core/util/app_colors.dart';
import 'package:art_of_pilates/app/core/util/app_locale.dart';
import 'package:art_of_pilates/app/features/bookings/presentation/view_model/bookings_states.dart';
import 'package:art_of_pilates/app/features/bookings/presentation/view_model/bookings_view_model.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/domain/model/sessions_model.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/domain/use_cases/navigate_to_payment_screen.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/presentation/view_model/sessions_view_model.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/presentation/views/show_more_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SessionCheckoutScreen extends StatefulWidget {
  final SessionEntity session;
  const SessionCheckoutScreen({super.key, required this.session});

  @override
  State<SessionCheckoutScreen> createState() => _SessionCheckoutScreenState();
}

class _SessionCheckoutScreenState extends State<SessionCheckoutScreen> {
  late final SessionsViewModel sessionsViewModel;
  late final BookingsViewModel bookingsViewModel;
  bool _agreedToTerms = false;
  bool _marketingConsent = false;
  bool _showTermsError = false;
  String? _appliedCoupon;

  @override
  void initState() {
    super.initState();
    sessionsViewModel = getIt<SessionsViewModel>();
    bookingsViewModel = getIt<BookingsViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: sessionsViewModel),
        BlocProvider.value(value: bookingsViewModel),
      ],
      child: BlocListener<BookingsViewModel, BookingsStates>(
        listenWhen: (prev, curr) =>
            prev.bookSessionState != curr.bookSessionState,
        listener: (context, state) {
          if (state.bookSessionState?.data != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(appLocale(context).sessionBookedSuccessfully),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context);
          }
          if (state.bookSessionState?.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.bookSessionState!.errorMessage!),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: _buildAppBar(context),
          body: _buildBody(context),
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
        locale.checkout,
        style: const TextStyle(
          color: AppColors.whiteColor,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.close, color: AppColors.whiteColor),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final locale = appLocale(context);
    final session = widget.session;
    final price = session.service?.price ?? 0.0;
    final currency = session.service?.currency ?? 'SAR';

    final formattedTime = sessionsViewModel.formatTime(session.startTime);
    final duration = sessionsViewModel.formatDuration(
      session.startTime,
      session.endTime,
    );

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionPadding(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        locale.orderSummary,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.accentColor,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 52.w,
                            height: 52.h,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Icon(
                              Icons.fitness_center,
                              color: AppColors.primary,
                              size: 24.sp,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '1 x ${session.name ?? ''}',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.accentColor,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  '$formattedTime · $duration',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: AppColors.accentColor
                                  ),
                                ),
                                ShowMoreDetails(
                                  session: session,
                                  sessionsViewModel: sessionsViewModel,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '$currency ${price.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.accentColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                _buildDivider(),

                ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 4.h,
                  ),
                  leading: Icon(
                    Icons.discount_outlined,
                    color: AppColors.accentColor,
                    size: 22.sp,
                  ),
                  title: Text(
                    _appliedCoupon ?? locale.promoCode,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: _appliedCoupon != null
                          ? AppColors.accentColor
                          : AppColors.accentColor,
                    ),
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: AppColors.accentColor,
                  ),
                  onTap: () {
                    // TODO: open coupon sheet
                  },
                ),
                _buildDivider(),
                _buildSectionPadding(
                  child: Column(
                    children: [
                      _buildPriceRow(
                        locale.subtotal,
                        '$currency ${price.toStringAsFixed(2)}',
                      ),
                      SizedBox(height: 10.h),
                      _buildPriceRow(locale.tax, '$currency 0.00'),
                      _buildDivider(),
                      SizedBox(height: 10.h),
                      _buildPriceRow(
                        locale.total,
                        '$currency ${price.toStringAsFixed(2)}',
                        bold: true,
                      ),
                    ],
                  ),
                ),

                _buildDivider(),
                _buildSectionPadding(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        locale.reviewAndPlaceOrder,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.accentColor,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: AppColors.accentColor,
                                  height: 1.5,
                                ),
                                children: [
                                  TextSpan(text: '${locale.iAgreeToThe} '),
                                  TextSpan(
                                    text: locale.termsAndConditions,
                                    style: TextStyle(color: AppColors.primary),
                                  ),
                                  const TextSpan(text: ', '),
                                  TextSpan(
                                    text: locale.privacyPolicy,
                                    style: TextStyle(color: AppColors.primary),
                                  ),
                                  TextSpan(text: ' ${locale.and} '),
                                  TextSpan(
                                    text: locale.returnPolicy,
                                    style: TextStyle(color: AppColors.primary),
                                  ),
                                  const TextSpan(text: '.'),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          GestureDetector(
                            onTap: () => setState(() {
                              _agreedToTerms = !_agreedToTerms;
                              if (_agreedToTerms) _showTermsError = false;
                            }),
                            child: Container(
                              width: 24.w,
                              height: 24.h,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: _showTermsError
                                      ? AppColors.redColor
                                      : AppColors.accentColor,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(4.r),
                                color: _agreedToTerms
                                    ? AppColors.primary
                                    : Colors.transparent,
                              ),
                              child: _agreedToTerms
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
                      if (_showTermsError) ...[
                        SizedBox(height: 8.h),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 10.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.redColor,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: AppColors.whiteColor,
                                size: 14.sp,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                locale.mustAcceptTerms,
                                style: TextStyle(
                                  color: AppColors.whiteColor,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                      SizedBox(height: 16.h),
                      _buildDivider(),
                      SizedBox(height: 16.h),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              locale.sendMeMarketingCommunications,
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: AppColors.accentColor,
                                height: 1.5,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          GestureDetector(
                            onTap: () => setState(
                              () => _marketingConsent = !_marketingConsent,
                            ),
                            child: Container(
                              width: 24.w,
                              height: 24.h,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.accentColor,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(4.r),
                                color: _marketingConsent
                                    ? AppColors.primary
                                    : Colors.transparent,
                              ),
                              child: _marketingConsent
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
                    ],
                  ),
                ),

                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),

        Container(
          color: AppColors.backgroundColor,
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    locale.estimatedTotal,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.accentColor,
                    ),
                  ),
                  Text(
                    '${session.service?.currency ?? 'SAR'} ${price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.accentColor,
                    ),
                  ),
                ],
              ),

              BlocBuilder<BookingsViewModel, BookingsStates>(
                buildWhen: (prev, curr) =>
                    prev.bookSessionState != curr.bookSessionState,
                builder: (context, state) {
                  final isLoading = state.bookSessionState?.isLoading ?? false;
                  return ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            if (!_agreedToTerms) {
                              setState(() => _showTermsError = true);
                              return;
                            }
                            NavigateToPaymentScreen.call(
                              context,
                              widget.session,
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _agreedToTerms
                          ? AppColors.primary
                          : AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 14.h,
                      ),
                    ),
                    child: isLoading
                        ? SizedBox(
                            width: 20.w,
                            height: 20.h,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            locale.continueToPayment,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.whiteColor,
                            ),
                          ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionPadding({required Widget child}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: child,
    );
  }

  Widget _buildDivider() =>
      Divider(color: AppColors.accentColor, height: 1);

  Widget _buildPriceRow(String label, String value, {bool bold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            color: bold
                ? AppColors.accentColor
                : AppColors.accentColor,
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.accentColor,
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
