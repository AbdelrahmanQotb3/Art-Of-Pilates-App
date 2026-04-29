// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cancel_booking_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CancelBookingResponse _$CancelBookingResponseFromJson(
  Map<String, dynamic> json,
) => CancelBookingResponse(
  message: json['message'] as String?,
  cancelled: json['Cancelled'] as bool?,
);

Map<String, dynamic> _$CancelBookingResponseToJson(
  CancelBookingResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'Cancelled': instance.cancelled,
};
