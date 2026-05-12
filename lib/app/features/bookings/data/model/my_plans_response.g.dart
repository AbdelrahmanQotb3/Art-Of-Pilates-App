// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_plans_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyPlansResponse _$MyPlansResponseFromJson(Map<String, dynamic> json) =>
    MyPlansResponse(
      message: json['message'] as String?,
      plans: (json['plans'] as List<dynamic>?)
          ?.map((e) => Plans.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MyPlansResponseToJson(MyPlansResponse instance) =>
    <String, dynamic>{'message': instance.message, 'plans': instance.plans};

Plans _$PlansFromJson(Map<String, dynamic> json) => Plans(
  id: json['id'] as String?,
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
  userId: (json['userId'] as num?)?.toInt(),
  pricingPlanId: (json['pricingPlanId'] as num?)?.toInt(),
  sessionsTotal: (json['sessionsTotal'] as num?)?.toInt(),
  sessionsUsed: (json['sessionsUsed'] as num?)?.toInt(),
  sessionsLeft: (json['sessionsLeft'] as num?)?.toInt(),
  status: json['status'] as String?,
  startDate: json['startDate'] as String?,
  expiryDate: json['expiryDate'] as String?,
  pricingPlan: json['pricingPlan'] == null
      ? null
      : Plan.fromJson(json['pricingPlan'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PlansToJson(Plans instance) => <String, dynamic>{
  'id': instance.id,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
  'userId': instance.userId,
  'pricingPlanId': instance.pricingPlanId,
  'sessionsTotal': instance.sessionsTotal,
  'sessionsUsed': instance.sessionsUsed,
  'sessionsLeft': instance.sessionsLeft,
  'status': instance.status,
  'startDate': instance.startDate,
  'expiryDate': instance.expiryDate,
  'pricingPlan': instance.pricingPlan,
};
