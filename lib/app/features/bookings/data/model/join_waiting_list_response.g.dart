// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'join_waiting_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JoinWaitingListResponse _$JoinWaitingListResponseFromJson(
  Map<String, dynamic> json,
) => JoinWaitingListResponse(
  message: json['message'] as String?,
  waitingListId: json['waitingListId'] as String?,
);

Map<String, dynamic> _$JoinWaitingListResponseToJson(
  JoinWaitingListResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'waitingListId': instance.waitingListId,
};
