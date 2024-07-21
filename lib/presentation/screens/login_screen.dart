import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:security_police_app/core/utils/validators.dart';
import 'package:security_police_app/domain/usecases/login_user.dart';
import 'package:security_police_app/presentation/components/custom_text_field.dart';
import 'package:security_police_app/presentation/components/primary_button.dart';
import 'package:security_police_app/presentation/screens/incident_list_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginUser _loginUser = GetIt.instance<LoginUser>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              CustomTextField(
                hintText: 'Nombre de usuario',
                controller: _usernameController,
                validator: Validators.validateUsername,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                hintText: 'Contraseña',
                controller: _passwordController,
                obscureText: true,
                validator: Validators.validatePassword,
              ),
              const SizedBox(height: 20),
              PrimaryButton(
                text: 'Iniciar sesión',
                onPressed: () async {
                  final username = _usernameController.text;
                  final password = _passwordController.text;
                  final user = await _loginUser.call(username, password);
                  if (user != null) {
                    // Agrega este print para depuración
                    print(
                        'Usuario obtenido: ${user.id}, ${user.username}, ${user.role}');
                    Future.delayed(Duration(milliseconds: 500), () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => IncidentListScreen(user: user),
                        ),
                      );
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Credenciales incorrectas')),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
