class SigninModel {
  String? message;
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? role;
  String? profileImage;
  SigninModel({this.message, this.id, this.email, this.firstName, this.lastName, this.role, this.profileImage});

  SigninModel copyWith({
    String? message,
    int? id,
    String? email,
    String? firstName,
    String? lastName,
    String? role,
    String? profileImage,
  }) {
    return SigninModel(
      message: message ?? this.message,
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      role: role ?? this.role,
      profileImage: profileImage ?? this.profileImage,
    );
  }
}