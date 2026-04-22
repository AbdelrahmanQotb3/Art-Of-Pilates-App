class LogoutModel {
  String? message;
  String? status;

  LogoutModel({this.message, this.status});

  LogoutModel copyWith({String? message, String? status}) {
    return LogoutModel(message: message ?? this.message, status: status ?? this.status);
  } 
}