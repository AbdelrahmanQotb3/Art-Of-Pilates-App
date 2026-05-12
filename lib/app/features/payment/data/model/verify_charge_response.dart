import 'package:json_annotation/json_annotation.dart';

part 'verify_charge_response.g.dart'; 

@JsonSerializable()
class VerifyChargeResponse {
  @JsonKey(name: 'success')
  final bool? success;

  @JsonKey(name: 'status')
  final String? status;

  VerifyChargeResponse({
    this.success, 
    this.status,
  });

  factory VerifyChargeResponse.fromJson(Map<String, dynamic> json) => 
      _$VerifyChargeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyChargeResponseToJson(this);
}