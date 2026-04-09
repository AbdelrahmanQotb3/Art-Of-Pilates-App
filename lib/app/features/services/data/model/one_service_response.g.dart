// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'one_service_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OneServiceResponse _$OneServiceResponseFromJson(Map<String, dynamic> json) =>
    OneServiceResponse(
      message: json['Message'] as String?,
      service: json['Service'] == null
          ? null
          : Service.fromJson(json['Service'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OneServiceResponseToJson(OneServiceResponse instance) =>
    <String, dynamic>{'Message': instance.message, 'Service': instance.service};
