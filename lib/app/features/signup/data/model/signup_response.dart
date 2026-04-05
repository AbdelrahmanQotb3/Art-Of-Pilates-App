import 'package:art_of_pilates/app/features/signin/data/model/signin_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'signup_response.g.dart';

@JsonSerializable()
class SignupResponse {
  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'user')
  final User? user;

  SignupResponse({this.message, this.user});

  factory SignupResponse.fromJson(Map<String, dynamic> json) =>
      _$SignupResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignupResponseToJson(this);
}