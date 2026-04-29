import 'package:art_of_pilates/app/config/di/di.dart';
import 'package:art_of_pilates/app/core/util/app_colors.dart';
import 'package:art_of_pilates/app/core/util/app_locale.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/bookings_model.dart';
import 'package:art_of_pilates/app/features/bookings/presentation/view_model/bookings_states.dart';
import 'package:art_of_pilates/app/features/bookings/presentation/view_model/bookings_view_model.dart';
import 'package:art_of_pilates/app/features/bookings/presentation/views/booking_card.dart';
import 'package:art_of_pilates/app/features/profile/domain/use_cases/navigate_to_home_screen_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllBookingsScreen extends StatelessWidget {
  const AllBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<BookingsViewModel>()..getAllBookings(),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: _buildAppBar(context),
          body: _buildBody(context),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        TabBar(
          indicatorColor: AppColors.primary,
          labelColor: AppColors.primary,
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(text: appLocale(context).upcoming),
            Tab(text: appLocale(context).history),
          ],
        ),
        Expanded(
          child: BlocBuilder<BookingsViewModel, BookingsStates>(
            builder: (context, state) {
              final bookingState = state.getAllBookingsState;

              if (bookingState?.isLoading == true) {
                return const Center(child: CircularProgressIndicator());
              }

              if (bookingState?.errorMessage != null) {
                return Center(child: Text(bookingState!.errorMessage!));
              }

              final bookings = bookingState?.data?.bookings ?? [];

              if (bookings.isEmpty) {
                return const Center(child: Text("No Bookings Found"));
              }

              return TabBarView(
                children: [
                  _buildBookingList(bookings),
                  _buildBookingList(bookings),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBookingList(List<BookingEntity> bookings) {
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: bookings.length,
      itemBuilder: (context, index) => BookingCard(booking: bookings[index]),
    );
  }

  PreferredSizeWidget? _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, size: 26, color: Colors.white),
        onPressed: () => NavigateToHomeScreenUseCase.call(context),
      ),
      title: Text(
        appLocale(context).bookings,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.whiteColor,
        ),
      ),
      centerTitle: true,
    );
  }
}
