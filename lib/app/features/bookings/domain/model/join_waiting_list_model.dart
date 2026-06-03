class JoinWaitingListModel {
  String? message;
  String? waitingListId;

  JoinWaitingListModel({this.message, this.waitingListId});

  JoinWaitingListModel copyWith({String? message, String? waitingListId}) =>
      JoinWaitingListModel(message: message ?? this.message, waitingListId: waitingListId ?? this.waitingListId);
}
