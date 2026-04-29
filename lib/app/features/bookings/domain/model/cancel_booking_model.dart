class CancelBookingModel {
  String? message;
  bool? cancelled;

  CancelBookingModel({
    this.message,
    this.cancelled,
  });

  CancelBookingModel copyWith({
    String? message,
    bool? cancelled,
  }) =>
      CancelBookingModel(
        message: message ?? this.message,
        cancelled: cancelled ?? this.cancelled,
      );
}
