import 'package:art_of_pilates/app/features/packages/data/model/pricing_plan_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'my_plans_response.g.dart';

@JsonSerializable()
class MyPlansResponse {
  @JsonKey(name: 'message')
  final String? message;
  
  @JsonKey(name: 'plans')
  final List<Plans>? plans;

  MyPlansResponse({this.message, this.plans});

  factory MyPlansResponse.fromJson(Map<String, dynamic> json) => _$MyPlansResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MyPlansResponseToJson(this);
}

@JsonSerializable()
class Plans {
  @JsonKey(name: 'id')
  final String? id;
  
  @JsonKey(name: 'createdAt')
  final String? createdAt;
  
  @JsonKey(name: 'updatedAt')
  final String? updatedAt;
  
  @JsonKey(name: 'userId')
  final int? userId;
  
  @JsonKey(name: 'pricingPlanId')
  final int? pricingPlanId;
  
  @JsonKey(name: 'sessionsTotal')
  final int? sessionsTotal;
  
  @JsonKey(name: 'sessionsUsed')
  final int? sessionsUsed;
  
  @JsonKey(name: 'sessionsLeft')
  final int? sessionsLeft;
  
  @JsonKey(name: 'status')
  final String? status;
  
  @JsonKey(name: 'startDate')
  final String? startDate;
  
  @JsonKey(name: 'expiryDate')
  final String? expiryDate;
  
  @JsonKey(name: 'pricingPlan')
  final Plan? pricingPlan;

  Plans({
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

  factory Plans.fromJson(Map<String, dynamic> json) => _$PlansFromJson(json);
  Map<String, dynamic> toJson() => _$PlansToJson(this);
}
