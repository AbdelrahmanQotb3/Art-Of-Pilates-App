import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/config/di/di.dart';
import 'package:art_of_pilates/app/core/util/app_colors.dart';
import 'package:art_of_pilates/app/core/util/app_locale.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/book_model.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/my_plans_model.dart';
import 'package:art_of_pilates/app/features/bookings/presentation/view_model/bookings_states.dart';
import 'package:art_of_pilates/app/features/bookings/presentation/view_model/bookings_view_model.dart';
import 'package:art_of_pilates/app/features/packages/domain/model/packages_model.dart';
import 'package:art_of_pilates/app/features/payment/domain/model/create_charge_model.dart';
import 'package:art_of_pilates/app/features/payment/presentation/view_model/payment_events.dart';
import 'package:art_of_pilates/app/features/payment/presentation/view_model/payment_states.dart';
import 'package:art_of_pilates/app/features/payment/presentation/view_model/payment_view_model.dart';
import 'package:art_of_pilates/app/features/payment/presentation/views/tap_payment_screen.dart';
import 'package:art_of_pilates/app/widgets/app_exception_dialog.dart';
import 'package:art_of_pilates/app/features/profile/domain/use_cases/navigate_to_home_screen_use_case.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/domain/model/sessions_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentScreen extends StatefulWidget {
  final SessionEntity? session;
  final PricingPlanEntity? plan;

  const PaymentScreen({super.key, this.session, this.plan})
    : assert(
        session != null || plan != null,
        'Either session or plan must be provided',
      );

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late final BookingsViewModel bookingsViewModel;
  late final PaymentViewModel paymentViewModel;
  String _selectedPaymentMethod = 'online';

  @override
  void initState() {
    super.initState();
    bookingsViewModel = getIt<BookingsViewModel>();
    paymentViewModel = getIt<PaymentViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    final locale = appLocale(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: bookingsViewModel),
        BlocProvider.value(value: paymentViewModel),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<BookingsViewModel, BookingsStates>(
            listenWhen: (prev, curr) =>
                prev.bookSessionState != curr.bookSessionState,
            listener: (context, state) {
              if (state.bookSessionState?.isLoading == false &&
                  state.bookSessionState?.data != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(locale.sessionBookedSuccessfully),
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
          ),

          BlocListener<BookingsViewModel, BookingsStates>(
            listenWhen: (prev, curr) =>
                prev.getMyPlansState != curr.getMyPlansState,
            listener: (context, state) {
              if (state.getMyPlansState?.isLoading == false &&
                  state.getMyPlansState?.data != null) {
                final plans = state.getMyPlansState!.data!.plans;
                if (plans != null && plans.isNotEmpty) {
                  // Assume the last plan is the one just purchased
                  final latestPlan = plans.last;
                  bookingsViewModel.bookPlan(latestPlan.id);
                }
              }
              if (state.getMyPlansState?.errorMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.getMyPlansState!.errorMessage!),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),

          BlocListener<BookingsViewModel, BookingsStates>(
            listenWhen: (prev, curr) =>
                prev.bookPlanState != curr.bookPlanState,
            listener: (context, state) {
              if (state.bookPlanState?.isLoading == false &&
                  state.bookPlanState?.data != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(locale.planPurchasedSuccessfully),
                    backgroundColor: Colors.green,
                  ),
                );
                NavigateToHomeScreenUseCase.call(context);
              }
              if (state.bookPlanState?.errorMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.bookPlanState!.errorMessage!),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),

          BlocListener<PaymentViewModel, PaymentStates>(
            listenWhen: (prev, curr) =>
                prev.createChargeState != curr.createChargeState ||
                prev.appException != curr.appException,
            listener: (context, state) {
              if (state.appException != null &&
                  state.createChargeState?.isLoading == false) {
                AppExceptionDialog.show(context, state.appException!);
                return;
              }

              if (state.createChargeState?.isLoading == false &&
                  state.createChargeState?.data != null) {
                final CreateChargeModel charge = state.createChargeState!.data!;

                if (charge.paymentUrl != null && charge.chargeId != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TapPaymentScreen(
                        paymentUrl: charge.paymentUrl!,
                        chargeId: charge.chargeId!,
                        paymentViewModel: paymentViewModel,
                        onPaymentResult: (success) async {
                          if (!success) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    appLocale(context).paymentFailed,
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                            return;
                          }

                          if (widget.session != null) {
                            final bookResult = await bookingsViewModel
                                .bookSession(widget.session!.id!);
                            if (context.mounted) {
                              if (bookResult is SuccessResponse<BookModel>) {
                                NavigateToHomeScreenUseCase.call(context);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Booking failed. Contact support with ID: ${charge.chargeId}',
                                    ),
                                  ),
                                );
                              }
                            }
                          } else if (widget.plan != null) {
                            if (context.mounted) {
                              final myPlansResult = await bookingsViewModel
                                  .getMyPlans();

                              if (context.mounted) {
                                if (myPlansResult
                                    is SuccessResponse<MyPlansModel>) {
                                  final plans = myPlansResult.data?.plans;

                                  if (plans != null && plans.isNotEmpty) {
                                    final latestPlan = plans.last;

                                    await bookingsViewModel.bookPlan(
                                      latestPlan.id!,
                                    );
                                  } else {
                                    _showErrorSnackBar(
                                      context,
                                      'No active plans found.',
                                    );
                                  }
                                } else {
                                  _showErrorSnackBar(
                                    context,
                                    'Failed to fetch plans. Contact support with ID: ${charge.chargeId}',
                                  );
                                }
                              }
                            }
                          }
                        },
                      ),
                    ),
                  );
                }
              }

              if (state.createChargeState?.errorMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.createChargeState!.errorMessage!),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
        ],
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
    final double price;
    final String currency;
    final String? name;

    if (widget.session != null) {
      final session = widget.session!;
      price = (session.service?.price ?? 0.0).toDouble();
      currency = session.service?.currency ?? 'SAR';
      name = session.name;
    } else {
      final plan = widget.plan!;
      price = (plan.price ?? 0.0).toDouble();
      currency = plan.currency ?? 'SAR';
      name = plan.planName;
    }

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
                        locale.selectPaymentMethod,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.accentColor,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      _buildPaymentMethodCard(
                        title: locale.onlinePayment,
                        subtitle: locale.onlinePaymentDescription,
                        icon: Icons.credit_card,
                        isSelected: _selectedPaymentMethod == 'online',
                        onTap: () =>
                            setState(() => _selectedPaymentMethod = 'online'),
                      ),
                      SizedBox(height: 12.h),
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
                              color: AppColors.primary.withOpacity(0.15),
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
                            child: Text(
                              '1 x ${name ?? ''}',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.accentColor,
                              ),
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

        BlocBuilder<BookingsViewModel, BookingsStates>(
          buildWhen: (prev, curr) =>
              prev.bookSessionState != curr.bookSessionState,
          builder: (context, bookingState) {
            return BlocBuilder<PaymentViewModel, PaymentStates>(
              buildWhen: (prev, curr) =>
                  prev.createChargeState != curr.createChargeState,
              builder: (context, paymentState) {
                final isLoading =
                    (bookingState.bookSessionState?.isLoading ?? false) ||
                    (paymentState.createChargeState?.isLoading ?? false);

                return Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
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
                              child: const CircularProgressIndicator(
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
            );
          },
        ),
      ],
    );
  }

  void _handlePayment() async {
    final locale = appLocale(context);

    if (_selectedPaymentMethod == 'online') {
      if (widget.session != null) {
        paymentViewModel.onEvent(
          CreateChargeEvent(sessionId: widget.session!.id!),
        );
      } else if (widget.plan != null) {
        paymentViewModel.onEvent(
          CreatePlanChargeEvent(planId: widget.plan!.id!),
        );
      }
    } else {
      if (widget.session != null) {
        bookingsViewModel.bookSession(widget.session!.id!);
      } else if (widget.plan != null) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(locale.planOfflinePaymentNotAvailable),
              backgroundColor: AppColors.redColor,
            ),
          );
        }
      }
    }
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
            color: isSelected ? AppColors.primary : AppColors.accentColor,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.2),
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
                    ? AppColors.primary.withOpacity(0.15)
                    : AppColors.accentColor.withOpacity(0.1),
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
                      color: AppColors.accentColor.withOpacity(0.6),
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
      Divider(color: AppColors.accentColor.withOpacity(0.2), height: 1);

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

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }
}
