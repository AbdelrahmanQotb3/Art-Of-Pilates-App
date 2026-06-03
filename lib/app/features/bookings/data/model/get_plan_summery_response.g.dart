// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_plan_summery_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPlanSummeryResponse _$GetPlanSummeryResponseFromJson(
  Map<String, dynamic> json,
) => GetPlanSummeryResponse(
  hasPlan: json['hasPlan'] as bool?,
  planName: json['planName'] as String?,
  sessionsTotal: (json['sessionsTotal'] as num?)?.toInt(),
  sessionsUsed: (json['sessionsUsed'] as num?)?.toInt(),
  sessionsLeft: (json['sessionsLeft'] as num?)?.toInt(),
  expiryDate: json['expiryDate'] as String?,
  startDate: json['startDate'] as String?,
);

Map<String, dynamic> _$GetPlanSummeryResponseToJson(
  GetPlanSummeryResponse instance,
) => <String, dynamic>{
  'hasPlan': instance.hasPlan,
  'planName': instance.planName,
  'sessionsTotal': instance.sessionsTotal,
  'sessionsUsed': instance.sessionsUsed,
  'sessionsLeft': instance.sessionsLeft,
  'expiryDate': instance.expiryDate,
  'startDate': instance.startDate,
};
