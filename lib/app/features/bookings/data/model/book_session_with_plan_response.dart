import 'package:json_annotation/json_annotation.dart';

part 'book_session_with_plan_response.g.dart';

@JsonSerializable()
class BookSessionWithPlanResponse {
  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'invoiceId')
  final String? invoiceId;

  @JsonKey(name: 'sessionsLeft')
  final int? sessionsLeft;

  BookSessionWithPlanResponse({
    this.message,
    this.invoiceId,
    this.sessionsLeft,
  });

  factory BookSessionWithPlanResponse.fromJson(Map<String, dynamic> json) =>
      _$BookSessionWithPlanResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BookSessionWithPlanResponseToJson(this);
}