// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pricing_plan_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PricingPlanResponse _$PricingPlanResponseFromJson(Map<String, dynamic> json) =>
    PricingPlanResponse(
      message: json['Message'] as String?,
      plan: json['Plan'] == null
          ? null
          : Plan.fromJson(json['Plan'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PricingPlanResponseToJson(
  PricingPlanResponse instance,
) => <String, dynamic>{'Message': instance.message, 'Plan': instance.plan};

Plan _$PlanFromJson(Map<String, dynamic> json) => Plan(
  id: (json['id'] as num?)?.toInt(),
  planName: json['planName'] as String?,
  status: json['status'] as String?,
  imageUrl: json['imageUrl'] as String?,
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
  pricingType: json['pricingType'] as String?,
  price: (json['price'] as num?)?.toDouble(),
  currency: json['currency'] as String?,
  duration: json['duration'] as String?,
  chargeSetupFee: json['chargeSetupFee'] as bool?,
  setupFeeAmount: json['setupFeeAmount'],
  offerAsPackage: json['offerAsPackage'] as bool?,
  benefitType: json['benefitType'] as String?,
  totalSessions: (json['totalSessions'] as num?)?.toInt(),
  limitOnePerUser: json['limitOnePerUser'] as bool?,
  allowCancellation: json['allowCancellation'] as bool?,
  allowCustomStart: json['allowCustomStart'] as bool?,
  customPolicy: json['customPolicy'] as String?,
  planDetails: json['planDetails'] as String?,
  services: (json['services'] as List<dynamic>?)
      ?.map((e) => Service.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PlanToJson(Plan instance) => <String, dynamic>{
  'id': instance.id,
  'planName': instance.planName,
  'status': instance.status,
  'imageUrl': instance.imageUrl,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
  'pricingType': instance.pricingType,
  'price': instance.price,
  'currency': instance.currency,
  'duration': instance.duration,
  'chargeSetupFee': instance.chargeSetupFee,
  'setupFeeAmount': instance.setupFeeAmount,
  'offerAsPackage': instance.offerAsPackage,
  'benefitType': instance.benefitType,
  'totalSessions': instance.totalSessions,
  'limitOnePerUser': instance.limitOnePerUser,
  'allowCancellation': instance.allowCancellation,
  'allowCustomStart': instance.allowCustomStart,
  'customPolicy': instance.customPolicy,
  'planDetails': instance.planDetails,
  'services': instance.services,
};
