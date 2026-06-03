import 'package:art_of_pilates/app/config/di/di.dart';
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
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
          indicatorColor: Theme.of(context).colorScheme.primary,
          labelColor: Theme.of(context).colorScheme.primary,
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

              final allBookings = bookingState?.data?.bookings ?? [];

              if (allBookings.isEmpty) {
                return const Center(child: Text("No Bookings Found"));
              }

              final now = DateTime.now();
              final upcomingBookings = allBookings.where((booking) {
                final startTime = booking.session?.startTime;
                if (startTime == null) return false;
                final startDateTime = DateTime.tryParse(startTime);
                return startDateTime != null && startDateTime.isAfter(now);
              }).toList();
              final historyBookings = allBookings
                  .where((booking) => booking.createdAt.isBefore(now))
                  .toList();

              return TabBarView(
                children: [
                  _buildBookingList(upcomingBookings, "No Upcoming Bookings"),
                  _buildBookingList(historyBookings, "No History Found"),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBookingList(List<BookingEntity> bookings, String emptyMsg) {
    if (bookings.isEmpty) {
      return Center(child: Text(emptyMsg));
    }

    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: bookings.length,
      itemBuilder: (context, index) => BookingCard(booking: bookings[index]),
    );
  }

  PreferredSizeWidget? _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, size: 26, color: Colors.white),
        onPressed: () => NavigateToHomeScreenUseCase.call(context),
      ),
      title: Text(
        appLocale(context).bookings,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
    );
  }
}
