class CheckPlanModel {
  final bool? hasPlan;
  final String? userPlanId;
  final String? planName;
  final int? sessionsLeft;

  CheckPlanModel({
    this.hasPlan,
    this.userPlanId,
    this.planName,
    this.sessionsLeft,
  });

  CheckPlanModel copyWith({
    bool? hasPlan,
    String? userPlanId,
    String? planName,
    int? sessionsLeft,
  }) {
    return CheckPlanModel(
      hasPlan: hasPlan ?? this.hasPlan,
      userPlanId: userPlanId ?? this.userPlanId,
      planName: planName ?? this.planName,
      sessionsLeft: sessionsLeft ?? this.sessionsLeft,
    );
  }
}