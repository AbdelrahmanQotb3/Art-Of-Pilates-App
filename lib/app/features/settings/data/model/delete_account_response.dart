import 'package:json_annotation/json_annotation.dart';

part 'delete_account_response.g.dart'; 

@JsonSerializable()
class DeleteAccountResponse {
  @JsonKey(name: 'Message')
  final String? message;
  
  @JsonKey(name: 'Deleted')
  final bool? deleted;

  DeleteAccountResponse({
    this.message,
    this.deleted,
  });

  factory DeleteAccountResponse.fromJson(Map<String, dynamic> json) => 
      _$DeleteAccountResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteAccountResponseToJson(this);
}