import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/core/util/app_locale.dart';
import 'package:art_of_pilates/app/core/util/exceptions/abstract/app_exception.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/bookings_model.dart';
import 'package:art_of_pilates/app/features/bookings/presentation/view_model/bookings_view_model.dart';
import 'package:art_of_pilates/app/widgets/app_exception_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingCard extends StatelessWidget {
  final BookingEntity booking;

  const BookingCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Text(
                "${booking.createdAt.day}",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              Text(
                _getMonthName(booking.createdAt.month),
                style: TextStyle(fontSize: 12.sp, color: Colors.grey),
              ),
            ],
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  booking.session?.name ?? "Reformer",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Today 6:30 PM (50mins)",
                  style: TextStyle(color: Colors.grey, fontSize: 13.sp),
                ),
                SizedBox(height: 8.h),
                Text(
                  "With ${booking.session?.staffMember?.name} · Art of Pilates Studio",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12.sp,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 12.h),
                _buildStatusBadge(),
              ],
            ),
          ),
          PopupMenuButton<String>(
            icon: Icon(
              Icons.more_horiz,
              color: Theme.of(context).colorScheme.tertiary,
              size: 20.sp,
            ),
            color: Theme.of(context).colorScheme.surface,
            onSelected: (value) async {
  if (value == 'cancel') {
    final result = await context
        .read<BookingsViewModel>()
        .cancelBooking(booking.id);
    
    switch (result) {
      case ErrorResponse(:final error):
        if (error is AppException) {
          await AppExceptionDialog.show(context, error);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.toString())),
          );
        }
      case SuccessResponse():
        break;
    }

    await context.read<BookingsViewModel>().getAllBookings();
  }
},itemBuilder: (_) => [
              PopupMenuItem(
                value: 'cancel',
                child: Text(
                  appLocale(context).cancelBooking,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: const Text(
        "Booked",
        style: TextStyle(color: Color(0xFF2E7D32), fontWeight: FontWeight.bold),
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      "JAN",
      "FEB",
      "MAR",
      "APR",
      "MAY",
      "JUN",
      "JUL",
      "AUG",
      "SEP",
      "OCT",
      "NOV",
      "DEC",
    ];
    return months[month - 1];
  }
}
