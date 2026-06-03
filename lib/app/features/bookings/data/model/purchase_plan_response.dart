import 'package:art_of_pilates/app/features/bookings/data/model/bookings_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'purchase_plan_response.g.dart'; // Ensure this matches your file name

@JsonSerializable(explicitToJson: true)
class PurchasePlanResponse {
  final String? message;
  final UserPlan? userPlan;
  final int? bookedSessionsCount;
  final List<BookedSessions>? bookedSessions;

  PurchasePlanResponse({
    this.message,
    this.userPlan,
    this.bookedSessionsCount,
    this.bookedSessions,
  });

  factory PurchasePlanResponse.fromJson(Map<String, dynamic> json) =>
      _$PurchasePlanResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PurchasePlanResponseToJson(this);
}
@JsonSerializable()
class BookedSessions {
  final String? id;
  final String? name;
  final String? startTime;
  final String? endTime;

  BookedSessions({
    this.id,
    this.name,
    this.startTime,
    this.endTime,
  });

  factory BookedSessions.fromJson(Map<String, dynamic> json) => 
      _$BookedSessionsFromJson(json);

  Map<String, dynamic> toJson() => _$BookedSessionsToJson(this);
}