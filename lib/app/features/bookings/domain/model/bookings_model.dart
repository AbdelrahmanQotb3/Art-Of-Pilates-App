import 'package:art_of_pilates/app/features/schedule-sessions/domain/model/sessions_model.dart';

class BookingsModel {
  final String message;
  final List<BookingEntity> bookings;
  BookingsModel({
    required this.message,
    required this.bookings,
  });
}
class BookingEntity {
  final String id;
  final int userId;
  final String sessionId;
  final String userPlanId;
  final DateTime createdAt;
  final SessionEntity? session;
  final UserPlanEntity? userPlan;

  BookingEntity({
    required this.id,
    required this.userId,
    required this.sessionId,
    required this.userPlanId,
    required this.createdAt,
    this.session,
    this.userPlan,
  });
}

class UserPlanEntity {
  final String id;
  final int sessionsTotal;
  final int sessionsUsed;
  final int sessionsLeft;
  final String status;
  final DateTime? expiryDate;
  final String planName;

  UserPlanEntity({
    required this.id,
    required this.sessionsTotal,
    required this.sessionsUsed,
    required this.sessionsLeft,
    required this.status,
    this.expiryDate,
    required this.planName,
  });
}