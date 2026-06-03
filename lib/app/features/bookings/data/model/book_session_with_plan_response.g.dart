// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_session_with_plan_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookSessionWithPlanResponse _$BookSessionWithPlanResponseFromJson(
  Map<String, dynamic> json,
) => BookSessionWithPlanResponse(
  message: json['message'] as String?,
  invoiceId: json['invoiceId'] as String?,
  sessionsLeft: (json['sessionsLeft'] as num?)?.toInt(),
);

Map<String, dynamic> _$BookSessionWithPlanResponseToJson(
  BookSessionWithPlanResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'invoiceId': instance.invoiceId,
  'sessionsLeft': instance.sessionsLeft,
};
