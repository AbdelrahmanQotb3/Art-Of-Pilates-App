import 'package:art_of_pilates/app/features/services/data/model/services_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pricing_plan_response.g.dart';

@JsonSerializable()
class PricingPlanResponse {
  @JsonKey(name: 'Message')
  final String? message;

  @JsonKey(name: 'Plan')
  final Plan? plan;

  PricingPlanResponse({this.message, this.plan});

  factory PricingPlanResponse.fromJson(Map<String, dynamic> json) =>
      _$PricingPlanResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PricingPlanResponseToJson(this);
}

@JsonSerializable()
class Plan {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'planName')
  final String? planName;

  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'imageUrl')
  final String? imageUrl;

  @JsonKey(name: 'createdAt')
  final String? createdAt;

  @JsonKey(name: 'updatedAt')
  final String? updatedAt;

  @JsonKey(name: 'pricingType')
  final String? pricingType;

  @JsonKey(name: 'price')
  final double? price;

  @JsonKey(name: 'currency')
  final String? currency;

  @JsonKey(name: 'duration')
  final String? duration;

  @JsonKey(name: 'chargeSetupFee')
  final bool? chargeSetupFee;

  @JsonKey(name: 'setupFeeAmount')
  final dynamic setupFeeAmount;

  @JsonKey(name: 'offerAsPackage')
  final bool? offerAsPackage;

  @JsonKey(name: 'benefitType')
  final String? benefitType;

  @JsonKey(name: 'totalSessions')
  final int? totalSessions;

  @JsonKey(name: 'limitOnePerUser')
  final bool? limitOnePerUser;

  @JsonKey(name: 'allowCancellation')
  final bool? allowCancellation;

  @JsonKey(name: 'allowCustomStart')
  final bool? allowCustomStart;

  @JsonKey(name: 'customPolicy')
  final String? customPolicy;

  @JsonKey(name: 'planDetails')
  final String? planDetails;

  @JsonKey(name: 'services')
  final List<Service>? services;

  Plan({
    this.id,
    this.planName,
    this.status,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
    this.pricingType,
    this.price,
    this.currency,
    this.duration,
    this.chargeSetupFee,
    this.setupFeeAmount,
    this.offerAsPackage,
    this.benefitType,
    this.totalSessions,
    this.limitOnePerUser,
    this.allowCancellation,
    this.allowCustomStart,
    this.customPolicy,
    this.planDetails,
    this.services,
  });

  factory Plan.fromJson(Map<String, dynamic> json) => _$PlanFromJson(json);

  Map<String, dynamic> toJson() => _$PlanToJson(this);
}