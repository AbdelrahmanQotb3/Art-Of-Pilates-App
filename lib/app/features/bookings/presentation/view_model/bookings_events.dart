sealed class BookingsEvent {}

class GetAllBookingsEvent extends BookingsEvent {}
class CancelBookingEvent extends BookingsEvent {
  final String id;

  CancelBookingEvent(this.id);
}

class BookSessionEvent extends BookingsEvent {
  final String sessionId;

  BookSessionEvent(this.sessionId);
}

class CheckBookingEvent extends BookingsEvent {
  final String sessionId;

  CheckBookingEvent(this.sessionId);
}