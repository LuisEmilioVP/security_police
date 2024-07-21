import 'package:security_police_app/domain/entities/user.dart';
import 'package:security_police_app/domain/repositories/user_repository.dart';

class LoginUser {
  final UserRepository repository;

  LoginUser(this.repository);

  Future<User?> call(String username, String password) async {
    return await repository.login(username, password);
  }
}
