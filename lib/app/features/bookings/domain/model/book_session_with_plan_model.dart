class BookSessionWithPlanModel {
  String? message;
  String? invoiceId;
  int? sessionsLeft;

  BookSessionWithPlanModel({
    this.message,
    this.invoiceId,
    this.sessionsLeft,
  });

  BookSessionWithPlanModel copyWith({
    String? message,
    String? invoiceId,
    int? sessionsLeft,
  }) =>
      BookSessionWithPlanModel(
        message: message ?? this.message,
        invoiceId: invoiceId ?? this.invoiceId,
        sessionsLeft: sessionsLeft ?? this.sessionsLeft,
      );
}