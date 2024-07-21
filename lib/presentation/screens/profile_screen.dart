import 'dart:io';
import 'package:flutter/material.dart';
import 'package:security_police_app/data/db_helper.dart';
import 'package:security_police_app/domain/entities/user.dart';
import 'package:security_police_app/presentation/themes/app_theme.dart';
import 'package:security_police_app/data/repositories/user_repository_impl.dart';

class ProfileScreen extends StatefulWidget {
  final int userId;

  const ProfileScreen({super.key, required this.userId});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<User?> _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = _fetchUser();
  }

  Future<User?> _fetchUser() async {
    final dbHelper = DatabaseHelper();
    return await UserRepositoryImpl(dbHelper).getUserById(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil del Usuario'),
      ),
      body: FutureBuilder<User?>(
        future: _userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No se encontraron datos'));
          }

          final user = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: user.photoPath != null
                        ? FileImage(File(user.photoPath!))
                        : const AssetImage('assets/images/avatar.jpg')
                            as ImageProvider,
                    backgroundColor: AppTheme.foregroundColor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Nombre de Usuario: ${user.username}',
                    style: const TextStyle(
                        color: AppTheme.textColor, fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Apellido: ${user.lastName ?? 'No disponible'}',
                    style: const TextStyle(
                        color: AppTheme.textColor, fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Matrícula: ${user.registrationNumber ?? 'No disponible'}',
                    style: const TextStyle(
                        color: AppTheme.textColor, fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Rol: ${user.role}',
                    style: const TextStyle(
                        color: AppTheme.textColor, fontSize: 18),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
