import 'package:json_annotation/json_annotation.dart';

part 'check_booking_response.g.dart';

@JsonSerializable()
class CheckBookingResponse {
  @JsonKey(name: 'isBooked')
  final bool? isBooked;

  @JsonKey(name: 'invoiceId')
  final String? invoiceId;

  CheckBookingResponse({
    this.isBooked,
    this.invoiceId,
  });

  factory CheckBookingResponse.fromJson(Map<String, dynamic> json) => 
      _$CheckBookingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckBookingResponseToJson(this);
}