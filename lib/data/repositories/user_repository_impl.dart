import 'package:security_police_app/core/error/exceptions.dart';
import 'package:security_police_app/data/db_helper.dart';
import 'package:security_police_app/data/models/user_model.dart';
import 'package:security_police_app/domain/entities/user.dart';
import 'package:security_police_app/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final DatabaseHelper _databaseHelper;

  UserRepositoryImpl(this._databaseHelper);

  @override
  Future<User?> login(String username, String password) async {
    try {
      final result = await _databaseHelper.query(
        'users',
        where: 'username = ? AND password = ?',
        whereArgs: [username, password],
      );
      if (result.isNotEmpty) {
        return UserModel.fromJson(result.first);
      } else {
        return null;
      }
    } catch (e) {
      throw AuthenticationException('Error al iniciar sesión: $e');
    }
  }

  @override
  Future<void> register(User user) async {
    try {
      final userModel = UserModel(
        id: user.id,
        username: user.username,
        password: user.password,
        role: user.role,
        photoPath: user.photoPath,
        lastName: user.lastName,
        registrationNumber: user.registrationNumber,
      );
      await _databaseHelper.insert('users', userModel.toJson());
    } catch (e) {
      throw AuthenticationException('No se pudo registrar el usuario: $e');
    }
  }

  @override
  Future<User?> getUserById(int id) async {
    try {
      final result = await _databaseHelper.query(
        'users',
        where: 'id = ?',
        whereArgs: [id],
      );
      if (result.isNotEmpty) {
        return UserModel.fromJson(result.first);
      }
      return null;
    } catch (e) {
      throw DatabaseException('No se pudo obtener el usuario: $e');
    }
  }
}
