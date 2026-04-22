// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_account_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteAccountResponse _$DeleteAccountResponseFromJson(
  Map<String, dynamic> json,
) => DeleteAccountResponse(
  message: json['Message'] as String?,
  deleted: json['Deleted'] as bool?,
);

Map<String, dynamic> _$DeleteAccountResponseToJson(
  DeleteAccountResponse instance,
) => <String, dynamic>{
  'Message': instance.message,
  'Deleted': instance.deleted,
};
