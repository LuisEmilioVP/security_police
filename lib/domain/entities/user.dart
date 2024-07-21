class User {
  final int? id;
  final String username;
  final String? lastName;
  final String? registrationNumber;
  final String? photoPath;
  final String password;
  final String role;

  User({
    this.id,
    required this.username,
    this.lastName,
    this.registrationNumber,
    this.photoPath,
    required this.password,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'last_name': lastName,
      'registration_number': registrationNumber,
      'photo_path': photoPath,
      'password': password,
      'role': role,
    };
  }
}
