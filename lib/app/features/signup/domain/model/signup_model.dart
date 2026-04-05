class SignupModel {
  String? message;
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? role;

  SignupModel({
    this.message,
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.role,
  });

  SignupModel copyWith({
    String? message,
    int? id,
    String? email,
    String? firstName,
    String? lastName,
    String? role,
  }) {
    return SignupModel(
      message: message ?? this.message,
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      role: role ?? this.role,
    );
  }
}
