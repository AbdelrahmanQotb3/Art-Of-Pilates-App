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

class BookPlanEvent extends BookingsEvent {
  final String userPlanId;

  BookPlanEvent(this.userPlanId);
}

class PurchasePlanEvent extends BookingsEvent {
  final int pricingPlanId;
  final String? startDate;

  PurchasePlanEvent(this.pricingPlanId, this.startDate);
}

class JoinWaitingListEvent extends BookingsEvent {
  final String sessionId;

  JoinWaitingListEvent(this.sessionId);
}

class CheckPlanForSessionEvent extends BookingsEvent {
  final String sessionId;

  CheckPlanForSessionEvent(this.sessionId);
}

class BookSessionWithPlanEvent extends BookingsEvent {
  final String sessionId;
  final String userPlanId;

  BookSessionWithPlanEvent(this.sessionId, this.userPlanId);
}

class GetPlanSummeryEvent extends BookingsEvent {}