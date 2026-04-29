import 'package:json_annotation/json_annotation.dart';

part 'cancel_booking_response.g.dart';

@JsonSerializable()
class CancelBookingResponse {
  final String? message;
  
  @JsonKey(name: 'Cancelled')
  final bool? cancelled;

  CancelBookingResponse({
    this.message, 
    this.cancelled,
  });

  factory CancelBookingResponse.fromJson(Map<String, dynamic> json) => 
      _$CancelBookingResponseFromJson(json);
      
  Map<String, dynamic> toJson() => _$CancelBookingResponseToJson(this);
}