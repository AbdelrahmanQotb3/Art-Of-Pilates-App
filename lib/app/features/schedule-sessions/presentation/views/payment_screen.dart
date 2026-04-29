import 'package:art_of_pilates/app/config/di/di.dart';
import 'package:art_of_pilates/app/core/util/app_colors.dart';
import 'package:art_of_pilates/app/core/util/app_locale.dart';
import 'package:art_of_pilates/app/features/bookings/presentation/view_model/bookings_states.dart';
import 'package:art_of_pilates/app/features/bookings/presentation/view_model/bookings_view_model.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/domain/model/sessions_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentScreen extends StatefulWidget {
  final SessionEntity session;
  const PaymentScreen({super.key, required this.session});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late final BookingsViewModel bookingsViewModel;
  String _selectedPaymentMethod = 'online'; // 'online' or 'offline'

  @override
  void initState() {
    super.initState();
    bookingsViewModel = getIt<BookingsViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    final locale = appLocale(context);

    return MultiBlocProvider(
      providers: [BlocProvider.value(value: bookingsViewModel)],
      child: BlocListener<BookingsViewModel, BookingsStates>(
        listenWhen: (prev, curr) =>
            prev.bookSessionState != curr.bookSessionState,
        listener: (context, state) {
          if (state.bookSessionState?.data != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(locale.sessionBookedSuccessfully),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context); // Go back to previous screen
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
          appBar: AppBar(
            backgroundColor: AppColors.primary,
            centerTitle: true,
            title: Text(
              locale.payment,
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
          ),
          body: _buildBody(context),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final locale = appLocale(context);
    final session = widget.session;
    final price = session.service?.price ?? 0.0;
    final currency = session.service?.currency ?? 'SAR';

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Payment Methods Section
                _buildSectionPadding(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        locale.selectPaymentMethod,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.accentColor,
                        ),
                      ),
                      SizedBox(height: 16.h),

                      // Online Payment Option
                      _buildPaymentMethodCard(
                        title: locale.onlinePayment,
                        subtitle: locale.onlinePaymentDescription,
                        icon: Icons.credit_card,
                        isSelected: _selectedPaymentMethod == 'online',
                        onTap: () =>
                            setState(() => _selectedPaymentMethod = 'online'),
                      ),

                      SizedBox(height: 12.h),

                      // Offline Payment Option
                      _buildPaymentMethodCard(
                        title: locale.offlinePayment,
                        subtitle: locale.offlinePaymentDescription,
                        icon: Icons.store,
                        isSelected: _selectedPaymentMethod == 'offline',
                        onTap: () =>
                            setState(() => _selectedPaymentMethod = 'offline'),
                      ),
                    ],
                  ),
                ),

                _buildDivider(),

                // Order Summary Section
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

                      // Order item row
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
                                // Text(
                                //   '${session.startTime} · ${session.endTime.difference(session.startTime).inMinutes} minutes',
                                //   style: TextStyle(
                                //     fontSize: 12.sp,
                                //     color: AppColors.accentColor.withOpacity(
                                //       0.6,
                                //     ),
                                //   ),
                                // ),
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

                      SizedBox(height: 16.h),

                      // Price breakdown
                      _buildPriceRow(
                        locale.subtotal,
                        '$currency ${price.toStringAsFixed(2)}',
                      ),
                      SizedBox(height: 8.h),
                      _buildPriceRow(locale.tax, '$currency 0.00'),
                      _buildDivider(),
                      SizedBox(height: 8.h),
                      _buildPriceRow(
                        locale.total,
                        '$currency ${price.toStringAsFixed(2)}',
                        bold: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Bottom Button with BlocBuilder for loading state
        BlocBuilder<BookingsViewModel, BookingsStates>(
          buildWhen: (prev, curr) =>
              prev.bookSessionState != curr.bookSessionState,
          builder: (context, state) {
            final isLoading = state.bookSessionState?.isLoading ?? false;
            return Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.blackColor,
                    blurRadius: 4,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _handlePayment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: isLoading
                      ? SizedBox(
                          width: 20.w,
                          height: 20.h,
                          child: CircularProgressIndicator(
                            color: AppColors.whiteColor,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          locale.confirmAndPay,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.whiteColor,
                          ),
                        ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildPaymentMethodCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : AppColors.accentColor,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Container(
              width: 48.w,
              height: 48.h,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary
                    : AppColors.accentColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                icon,
                color: isSelected ? AppColors.primary : AppColors.accentColor,
                size: 24.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.accentColor,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.accentColor,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: AppColors.primary, size: 24.sp),
          ],
        ),
      ),
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
                : AppColors.accentColor.withOpacity(0.7),
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

  void _handlePayment() {
    if (_selectedPaymentMethod == 'online') {
      // TODO: Navigate to online payment flow
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Redirecting to online payment...')),
      );
    } else {
      // Book session for offline payment
      bookingsViewModel.bookSession(widget.session.id.toString());
    }
  }
}
