// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_charge_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateChargeResponse _$CreateChargeResponseFromJson(
  Map<String, dynamic> json,
) => CreateChargeResponse(
  chargeId: json['chargeId'] as String?,
  paymentUrl: json['paymentUrl'] as String?,
  status: json['status'] as String?,
);

Map<String, dynamic> _$CreateChargeResponseToJson(
  CreateChargeResponse instance,
) => <String, dynamic>{
  'chargeId': instance.chargeId,
  'paymentUrl': instance.paymentUrl,
  'status': instance.status,
};
