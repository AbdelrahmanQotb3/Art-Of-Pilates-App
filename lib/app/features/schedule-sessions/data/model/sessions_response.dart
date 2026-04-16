import 'package:art_of_pilates/app/features/services/data/model/services_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sessions_response.g.dart';

@JsonSerializable()
class SessionsResponse {
  @JsonKey(name: 'Message')
  final String? message;
  
  @JsonKey(name: 'Sessions')
  final List<Sessions>? sessions;

  SessionsResponse({this.message, this.sessions});

  factory SessionsResponse.fromJson(Map<String, dynamic> json) => 
      _$SessionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SessionsResponseToJson(this);
}

@JsonSerializable()
class Sessions {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'startTime')
  final String? startTime;

  @JsonKey(name: 'endTime')
  final String? endTime;

  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'maxParticipants')
  final int? maxParticipants;

  @JsonKey(name: 'currentParticipants')
  final int? currentParticipants;

  @JsonKey(name: 'serviceId')
  final String? serviceId;

  @JsonKey(name: 'staffMemberId')
  final String? staffMemberId;

  @JsonKey(name: 'service')
  final Service? service;

  @JsonKey(name: 'staffMember')
  final StaffMember? staffMember;

  Sessions({
    this.id,
    this.name,
    this.startTime,
    this.endTime,
    this.status,
    this.maxParticipants,
    this.description,
    this.currentParticipants,
    this.serviceId,
    this.staffMemberId,
    this.service,
    this.staffMember,
  });

  factory Sessions.fromJson(Map<String, dynamic> json) => 
      _$SessionsFromJson(json);

  Map<String, dynamic> toJson() => _$SessionsToJson(this);
}

@JsonSerializable()
class StaffMember {
  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'profilePic')
  final String? profilePic; 

  StaffMember({this.name, this.email, this.profilePic});

  factory StaffMember.fromJson(Map<String, dynamic> json) => 
      _$StaffMemberFromJson(json);

  Map<String, dynamic> toJson() => _$StaffMemberToJson(this);
}