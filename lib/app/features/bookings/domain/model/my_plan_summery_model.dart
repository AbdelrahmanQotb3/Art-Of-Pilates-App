class MyPlanSummeryModel {
  final bool? hasPlan;
  final String? planName;
  final int? sessionsTotal;
  final int? sessionsUsed;
  final int? sessionsLeft;
  final String? expiryDate;
  final String? startDate;

  const MyPlanSummeryModel({
    this.hasPlan,
    this.planName,
    this.sessionsTotal,
    this.sessionsUsed,
    this.sessionsLeft,
    this.expiryDate,
    this.startDate,
  });

  MyPlanSummeryModel copyWith({
    bool? hasPlan,
    String? planName,
    int? sessionsTotal,
    int? sessionsUsed,
    int? sessionsLeft,
    String? expiryDate,
    String? startDate,
  }) {
    return MyPlanSummeryModel(
      hasPlan: hasPlan ?? this.hasPlan,
      planName: planName ?? this.planName,
      sessionsTotal: sessionsTotal ?? this.sessionsTotal,
      sessionsUsed: sessionsUsed ?? this.sessionsUsed,
      sessionsLeft: sessionsLeft ?? this.sessionsLeft,
      expiryDate: expiryDate ?? this.expiryDate,
      startDate: startDate ?? this.startDate,
    );
  }
}