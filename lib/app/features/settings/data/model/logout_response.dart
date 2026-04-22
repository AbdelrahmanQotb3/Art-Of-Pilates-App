import 'package:json_annotation/json_annotation.dart';

part 'logout_response.g.dart';

@JsonSerializable()
class LogOutResponse {
  @JsonKey(name: 'message')
  final String? message;
  
  @JsonKey(name: 'status')
  final String? status;

  LogOutResponse({
    this.message,
    this.status,
  });

  factory LogOutResponse.fromJson(Map<String, dynamic> json) => 
      _$LogOutResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LogOutResponseToJson(this);
}