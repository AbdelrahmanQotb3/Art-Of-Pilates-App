// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'one_session_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OneSessionResponse _$OneSessionResponseFromJson(Map<String, dynamic> json) =>
    OneSessionResponse(
      message: json['Message'] as String?,
      session: json['Session'] == null
          ? null
          : Sessions.fromJson(json['Session'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OneSessionResponseToJson(OneSessionResponse instance) =>
    <String, dynamic>{'Message': instance.message, 'Session': instance.session};
