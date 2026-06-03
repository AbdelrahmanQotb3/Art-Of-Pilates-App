import 'package:json_annotation/json_annotation.dart';

part 'get_plan_summery_response.g.dart';

@JsonSerializable()
class GetPlanSummeryResponse {
  @JsonKey(name: 'hasPlan')
  final bool? hasPlan;

  @JsonKey(name: 'planName')
  final String? planName;

  @JsonKey(name: 'sessionsTotal')
  final int? sessionsTotal;

  @JsonKey(name: 'sessionsUsed')
  final int? sessionsUsed;

  @JsonKey(name: 'sessionsLeft')
  final int? sessionsLeft;

  @JsonKey(name: 'expiryDate')
  final String? expiryDate;

  @JsonKey(name: 'startDate')
  final String? startDate;

  GetPlanSummeryResponse({
    this.hasPlan,
    this.planName,
    this.sessionsTotal,
    this.sessionsUsed,
    this.sessionsLeft,
    this.expiryDate,
    this.startDate,
  });

  factory GetPlanSummeryResponse.fromJson(Map<String, dynamic> json) =>
      _$GetPlanSummeryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetPlanSummeryResponseToJson(this);
}