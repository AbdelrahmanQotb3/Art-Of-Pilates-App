import 'package:json_annotation/json_annotation.dart';

part 'book_response.g.dart';

@JsonSerializable()
class BookResponse {
  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'invoice')
  final Invoice? invoice;

  BookResponse({
    this.message,
    this.invoice,
  });

  factory BookResponse.fromJson(Map<String, dynamic> json) => 
      _$BookResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BookResponseToJson(this);
}

@JsonSerializable()
class Invoice {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'userId')
  final int? userId;

  @JsonKey(name: 'sessionId')
  final String? sessionId;

  @JsonKey(name: 'userPlanId')
  final dynamic userPlanId;

  @JsonKey(name: 'createdAt')
  final String? createdAt;

  @JsonKey(name: 'updatedAt')
  final String? updatedAt;

  Invoice({
    this.id,
    this.userId,
    this.sessionId,
    this.userPlanId,
    this.createdAt,
    this.updatedAt,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) => 
      _$InvoiceFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceToJson(this);
}