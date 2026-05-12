class CreateChargeModel {
  String? chargeId;
  String? paymentUrl;
  String? status;
  String? userPlanId;

  CreateChargeModel({
    this.chargeId,
    this.paymentUrl,
    this.status,
    this.userPlanId,
  });

  CreateChargeModel copyWith({
    String? chargeId,
    String? paymentUrl,
    String? status,
    String? userPlanId,
  }) {
    return CreateChargeModel(
      chargeId: chargeId ?? this.chargeId,
      paymentUrl: paymentUrl ?? this.paymentUrl,
      status: status ?? this.status,
      userPlanId: userPlanId ?? this.userPlanId,
    );
  }
}
