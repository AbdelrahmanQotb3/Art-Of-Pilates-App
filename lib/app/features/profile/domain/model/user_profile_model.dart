class  UserProfileModel {
  String? message;
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? role;
  String? phone;
  String? profileImage;
  UserProfileModel({this.message, this.id, this.email, this.firstName, this.lastName,this.phone, this.role, this.profileImage});

  UserProfileModel copyWith({
    String? message,
    int? id,
    String? email,
    String? firstName,
    String? lastName,
    String? phone,
    String? role,
    String? profileImage,
  }) {
    return UserProfileModel(
      message: message ?? this.message,
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      role: role ?? this.role,
      phone: phone ?? this.phone,
      profileImage: profileImage ?? this.profileImage,
    );
  }
}
