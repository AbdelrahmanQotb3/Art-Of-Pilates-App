// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_plan_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PurchasePlanResponse _$PurchasePlanResponseFromJson(
  Map<String, dynamic> json,
) => PurchasePlanResponse(
  message: json['message'] as String?,
  userPlan: json['userPlan'] == null
      ? null
      : UserPlan.fromJson(json['userPlan'] as Map<String, dynamic>),
  bookedSessionsCount: (json['bookedSessionsCount'] as num?)?.toInt(),
  bookedSessions: (json['bookedSessions'] as List<dynamic>?)
      ?.map((e) => BookedSessions.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PurchasePlanResponseToJson(
  PurchasePlanResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'userPlan': instance.userPlan?.toJson(),
  'bookedSessionsCount': instance.bookedSessionsCount,
  'bookedSessions': instance.bookedSessions?.map((e) => e.toJson()).toList(),
};

BookedSessions _$BookedSessionsFromJson(Map<String, dynamic> json) =>
    BookedSessions(
      id: json['id'] as String?,
      name: json['name'] as String?,
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
    );

Map<String, dynamic> _$BookedSessionsToJson(BookedSessions instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
    };
