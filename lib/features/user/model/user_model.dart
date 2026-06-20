class UserModel {

  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String? profileImage;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.profileImage,
  });

  // =========================
  // FROM JSON
  // =========================

  factory UserModel.fromJson(
      Map<String, dynamic> json,
      ) {

    return UserModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      profileImage: json['profile_image'],
    );
  }

  // =========================
  // TO JSON
  // =========================

  Map<String, dynamic> toJson() {

    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'profile_image': profileImage,
    };
  }

  // =========================
  // FULL NAME
  // =========================

  String get fullName {

    return '$firstName $lastName';
  }
}