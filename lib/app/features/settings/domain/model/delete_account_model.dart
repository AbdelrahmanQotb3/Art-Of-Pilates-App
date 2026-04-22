class DeleteAccountModel {
  String? message;
  bool? deleted;

  DeleteAccountModel({this.message, this.deleted});

  DeleteAccountModel copyWith({String? message, bool? deleted}) {
    return DeleteAccountModel(message: message ?? this.message, deleted: deleted ?? this.deleted);
  }
}