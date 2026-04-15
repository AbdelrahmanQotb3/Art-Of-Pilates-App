import 'package:json_annotation/json_annotation.dart';

part 'current_user_response.g.dart';

@JsonSerializable(includeIfNull: false)
class CurrentUserResponse {
  @JsonKey(name: 'Message')
  String? message;
  @JsonKey(name: 'User')
  User? user;

  CurrentUserResponse({this.message, this.user});

  factory CurrentUserResponse.fromJson(Map<String, dynamic> json) =>
      _$CurrentUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentUserResponseToJson(this);
}

@JsonSerializable()
class User {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? profileImage;
  String? phone;
  String? role;
  String? createdAt;
  String? updatedAt;
  String? provider;

  User({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.profileImage,
    this.role,
    this.phone,
    this.createdAt,
    this.updatedAt,
    this.provider,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
