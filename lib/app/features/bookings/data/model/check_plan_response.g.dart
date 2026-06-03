// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_plan_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckPlanResponse _$CheckPlanResponseFromJson(Map<String, dynamic> json) =>
    CheckPlanResponse(
      hasPlan: json['hasPlan'] as bool?,
      userPlanId: json['userPlanId'] as String?,
      planName: json['planName'] as String?,
      sessionsLeft: (json['sessionsLeft'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CheckPlanResponseToJson(CheckPlanResponse instance) =>
    <String, dynamic>{
      'hasPlan': instance.hasPlan,
      'userPlanId': instance.userPlanId,
      'planName': instance.planName,
      'sessionsLeft': instance.sessionsLeft,
    };
