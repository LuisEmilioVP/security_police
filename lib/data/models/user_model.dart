import 'package:security_police_app/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    int? id,
    required String username,
    required String password,
    required String role,
    String? photoPath,
    String? lastName,
    String? registrationNumber,
  }) : super(
          id: id,
          username: username,
          password: password,
          role: role,
          photoPath: photoPath,
          lastName: lastName,
          registrationNumber: registrationNumber,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      password: json['password'],
      role: json['role'],
      photoPath: json['photo_path'],
      lastName: json['last_name'],
      registrationNumber: json['registration_number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'role': role,
      'photo_path': photoPath,
      'last_name': lastName,
      'registration_number': registrationNumber,
    };
  }
}
