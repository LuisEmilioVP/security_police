import 'package:security_police_app/domain/entities/user.dart';

abstract class UserRepository {
  Future<User?> login(String username, String password);
  Future<void> register(User user);
  Future<User?> getUserById(int id);
}
