// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_plan_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookPlanResponse _$BookPlanResponseFromJson(Map<String, dynamic> json) =>
    BookPlanResponse(
      message: json['message'] as String?,
      bookedCount: (json['bookedCount'] as num?)?.toInt(),
      sessionsLeft: (json['sessionsLeft'] as num?)?.toInt(),
      bookedSessions: (json['bookedSessions'] as List<dynamic>?)
          ?.map((e) => BookedSessionDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BookPlanResponseToJson(BookPlanResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'bookedCount': instance.bookedCount,
      'sessionsLeft': instance.sessionsLeft,
      'bookedSessions': instance.bookedSessions,
    };

BookedSessionDto _$BookedSessionDtoFromJson(Map<String, dynamic> json) =>
    BookedSessionDto(
      id: json['id'] as String?,
      name: json['name'] as String?,
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
      staffMember: json['staffMember'] as String?,
    );

Map<String, dynamic> _$BookedSessionDtoToJson(BookedSessionDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'staffMember': instance.staffMember,
    };
