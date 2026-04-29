import 'package:art_of_pilates/app/config/base_state/base_state.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/book_model.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/bookings_model.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/cancel_booking_model.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/check_booking_model.dart';

class BookingsStates {
  BaseState<BookingsModel>? getAllBookingsState;
  BaseState<CancelBookingModel>? cancelBookingState;
  BaseState<BookModel>? bookSessionState;
  BaseState<CheckBookingModel>? checkBookingState;
  final Map<String, bool> checkedSessions;

  BookingsStates({
    this.getAllBookingsState,
    this.cancelBookingState,
    this.bookSessionState,
    this.checkBookingState,
    this.checkedSessions = const {},
  });

  BookingsStates copyWith({
    BaseState<BookingsModel>? getAllBookingsState,
    BaseState<CancelBookingModel>? cancelBookingState,
    BaseState<BookModel>? bookSessionState,
    BaseState<CheckBookingModel>? checkBookingState,
    Map<String, bool>? checkedSessions,
  }) {
    return BookingsStates(
      getAllBookingsState: getAllBookingsState ?? this.getAllBookingsState,
      cancelBookingState: cancelBookingState ?? this.cancelBookingState,
      bookSessionState: bookSessionState ?? this.bookSessionState,
      checkBookingState: checkBookingState ?? this.checkBookingState,
      checkedSessions: checkedSessions ?? this.checkedSessions,
    );
  }
}