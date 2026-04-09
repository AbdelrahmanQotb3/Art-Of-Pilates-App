import 'package:art_of_pilates/app/features/services/data/model/services_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'one_service_response.g.dart';

@JsonSerializable()
class OneServiceResponse {
  @JsonKey(name: 'Message')
  final String? message;
  
  @JsonKey(name: 'Service')
  final Service? service;

  OneServiceResponse({this.message, this.service});

  factory OneServiceResponse.fromJson(Map<String, dynamic> json) => 
      _$OneServiceResponseFromJson(json);
      
  Map<String, dynamic> toJson() => _$OneServiceResponseToJson(this);
}
