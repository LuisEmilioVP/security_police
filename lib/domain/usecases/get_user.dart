import 'package:security_police_app/domain/entities/user.dart';
import 'package:security_police_app/domain/repositories/user_repository.dart';

class GetUser {
  final UserRepository repository;

  GetUser(this.repository);

  Future<User?> call(int id) async {
    return await repository.getUserById(id);
  }
}
