import 'package:art_of_pilates/app/features/packages/data/model/pricing_plan_response.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/data/model/sessions_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bookings_response.g.dart';

@JsonSerializable()
class BookingsResponse {
  final String? message;
  final List<Bookings>? bookings;

  BookingsResponse({this.message, this.bookings});

  factory BookingsResponse.fromJson(Map<String, dynamic> json) =>
      _$BookingsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BookingsResponseToJson(this);
}

@JsonSerializable()
class Bookings {
  final String? id;
  final int? userId;
  final String? sessionId;
  final String? userPlanId;
  final String? createdAt;
  final String? updatedAt;
  final Sessions? session;
  final UserPlan? userPlan;

  Bookings({
    this.id,
    this.userId,
    this.sessionId,
    this.userPlanId,
    this.createdAt,
    this.updatedAt,
    this.session,
    this.userPlan,
  });

  factory Bookings.fromJson(Map<String, dynamic> json) =>
      _$BookingsFromJson(json);
  Map<String, dynamic> toJson() => _$BookingsToJson(this);
}

@JsonSerializable()
class UserPlan {
  final String? id;
  final String? createdAt;
  final String? updatedAt;
  final int? userId;
  final int? pricingPlanId;
  final int? sessionsTotal;
  final int? sessionsUsed;
  final int? sessionsLeft;
  final String? status;
  final String? startDate;
  final String? expiryDate;
  final Plan? pricingPlan;

  UserPlan({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.pricingPlanId,
    this.sessionsTotal,
    this.sessionsUsed,
    this.sessionsLeft,
    this.status,
    this.startDate,
    this.expiryDate,
    this.pricingPlan,
  });

  factory UserPlan.fromJson(Map<String, dynamic> json) =>
      _$UserPlanFromJson(json);
  Map<String, dynamic> toJson() => _$UserPlanToJson(this);
}
