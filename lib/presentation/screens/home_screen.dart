import 'package:flutter/material.dart';
import 'package:security_police_app/presentation/components/primary_button.dart';
import 'package:security_police_app/presentation/components/secondary_button.dart';
import 'package:security_police_app/presentation/screens/login_screen.dart';
import 'package:security_police_app/presentation/screens/register_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Security Police App'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.local_police,
                    size: 100, color: Theme.of(context).primaryColor),
                const SizedBox(height: 20),
                PrimaryButton(
                  text: 'Iniciar Sesión',
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                ),
                const SizedBox(height: 10),
                SecondaryButton(
                  text: 'Registrar Cuenta',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterScreen()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
