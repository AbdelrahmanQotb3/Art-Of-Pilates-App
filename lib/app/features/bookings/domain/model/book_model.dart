class BookModel {
  final String? id;
  final int? userId;
  final String? sessionId;
  final String? userPlanId;
  final DateTime? createdAt;

  BookModel({
    this.id,
    this.userId,
    this.sessionId,
    this.userPlanId,
    this.createdAt,
  });
}