import 'package:json_annotation/json_annotation.dart';

part 'check_plan_response.g.dart';

@JsonSerializable()
class CheckPlanResponse {
  @JsonKey(name: 'hasPlan')
  final bool? hasPlan;

  @JsonKey(name: 'userPlanId')
  final String? userPlanId;

  @JsonKey(name: 'planName')
  final String? planName;

  @JsonKey(name: 'sessionsLeft')
  final int? sessionsLeft;

  CheckPlanResponse({
    this.hasPlan,
    this.userPlanId,
    this.planName,
    this.sessionsLeft,
  });

  factory CheckPlanResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckPlanResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckPlanResponseToJson(this);
}