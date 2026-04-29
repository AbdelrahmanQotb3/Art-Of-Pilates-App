// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookResponse _$BookResponseFromJson(Map<String, dynamic> json) => BookResponse(
  message: json['message'] as String?,
  invoice: json['invoice'] == null
      ? null
      : Invoice.fromJson(json['invoice'] as Map<String, dynamic>),
);

Map<String, dynamic> _$BookResponseToJson(BookResponse instance) =>
    <String, dynamic>{'message': instance.message, 'invoice': instance.invoice};

Invoice _$InvoiceFromJson(Map<String, dynamic> json) => Invoice(
  id: json['id'] as String?,
  userId: (json['userId'] as num?)?.toInt(),
  sessionId: json['sessionId'] as String?,
  userPlanId: json['userPlanId'],
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
);

Map<String, dynamic> _$InvoiceToJson(Invoice instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'sessionId': instance.sessionId,
  'userPlanId': instance.userPlanId,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
};
