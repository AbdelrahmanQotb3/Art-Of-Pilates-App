import 'package:art_of_pilates/app/features/schedule-sessions/data/model/sessions_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'one_session_response.g.dart';

@JsonSerializable()
class OneSessionResponse {
  @JsonKey(name: 'Message')
  final String? message;
  
  @JsonKey(name: 'Session')
  final Sessions? session;

  OneSessionResponse({this.message, this.session});

  factory OneSessionResponse.fromJson(Map<String, dynamic> json) => 
      _$OneSessionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OneSessionResponseToJson(this);
}
