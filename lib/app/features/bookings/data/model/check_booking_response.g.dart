// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_booking_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckBookingResponse _$CheckBookingResponseFromJson(
  Map<String, dynamic> json,
) => CheckBookingResponse(
  isBooked: json['isBooked'] as bool?,
  invoiceId: json['invoiceId'] as String?,
);

Map<String, dynamic> _$CheckBookingResponseToJson(
  CheckBookingResponse instance,
) => <String, dynamic>{
  'isBooked': instance.isBooked,
  'invoiceId': instance.invoiceId,
};
