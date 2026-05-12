import 'package:json_annotation/json_annotation.dart';
part 'create_charge_response.g.dart';

@JsonSerializable()
class CreateChargeResponse {
  @JsonKey(name: 'chargeId')
  final String? chargeId;

  @JsonKey(name: 'paymentUrl')
  final String? paymentUrl;

  @JsonKey(name: 'status')
  final String? status;

  CreateChargeResponse({this.chargeId, this.paymentUrl, this.status});

  factory CreateChargeResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateChargeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateChargeResponseToJson(this);
}
