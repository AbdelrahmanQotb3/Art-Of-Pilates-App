class VerifyChargeModel {
  bool? success;
  String? status;

  VerifyChargeModel({
    this.success,
    this.status,
  });

  VerifyChargeModel copyWith({
    bool? success,
    String? status,
  }) {
    return VerifyChargeModel(
      success: success ?? this.success,
      status: status ?? this.status,
    );
  }
}