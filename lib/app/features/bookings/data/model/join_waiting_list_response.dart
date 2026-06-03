import 'package:json_annotation/json_annotation.dart';

part 'join_waiting_list_response.g.dart';

@JsonSerializable()
class JoinWaitingListResponse {
  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'waitingListId')
  final String? waitingListId;

  JoinWaitingListResponse({
    this.message, 
    this.waitingListId,
  });

  factory JoinWaitingListResponse.fromJson(Map<String, dynamic> json) =>
      _$JoinWaitingListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$JoinWaitingListResponseToJson(this);
}