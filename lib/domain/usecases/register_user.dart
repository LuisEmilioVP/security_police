import 'package:security_police_app/domain/entities/user.dart';
import 'package:security_police_app/domain/repositories/user_repository.dart';

class RegisterUser {
  final UserRepository repository;

  RegisterUser(this.repository);

  Future<bool> call(User user) async {
    try {
      await repository.register(user);
      return true;
    } catch (e) {
      return false;
    }
  }
}
