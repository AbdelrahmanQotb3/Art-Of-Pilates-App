// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sessions_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionsResponse _$SessionsResponseFromJson(Map<String, dynamic> json) =>
    SessionsResponse(
      message: json['Message'] as String?,
      sessions: (json['Sessions'] as List<dynamic>?)
          ?.map((e) => Sessions.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SessionsResponseToJson(SessionsResponse instance) =>
    <String, dynamic>{
      'Message': instance.message,
      'Sessions': instance.sessions,
    };

Sessions _$SessionsFromJson(Map<String, dynamic> json) => Sessions(
  id: json['id'] as String?,
  name: json['name'] as String?,
  startTime: json['startTime'] as String?,
  endTime: json['endTime'] as String?,
  status: json['status'] as String?,
  maxParticipants: (json['maxParticipants'] as num?)?.toInt(),
  description: json['description'] as String?,
  currentParticipants: (json['currentParticipants'] as num?)?.toInt(),
  serviceId: json['serviceId'] as String?,
  staffMemberId: json['staffMemberId'] as String?,
  service: json['service'] == null
      ? null
      : Service.fromJson(json['service'] as Map<String, dynamic>),
  staffMember: json['staffMember'] == null
      ? null
      : StaffMember.fromJson(json['staffMember'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SessionsToJson(Sessions instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'startTime': instance.startTime,
  'endTime': instance.endTime,
  'status': instance.status,
  'description': instance.description,
  'maxParticipants': instance.maxParticipants,
  'currentParticipants': instance.currentParticipants,
  'serviceId': instance.serviceId,
  'staffMemberId': instance.staffMemberId,
  'service': instance.service,
  'staffMember': instance.staffMember,
};

StaffMember _$StaffMemberFromJson(Map<String, dynamic> json) => StaffMember(
  name: json['name'] as String?,
  email: json['email'] as String?,
  profilePic: json['profilePic'] as String?,
);

Map<String, dynamic> _$StaffMemberToJson(StaffMember instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'profilePic': instance.profilePic,
    };
