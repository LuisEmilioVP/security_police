import 'dart:io';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:security_police_app/domain/entities/user.dart';
import 'package:security_police_app/core/utils/validators.dart';
import 'package:security_police_app/domain/usecases/register_user.dart';
import 'package:security_police_app/presentation/components/primary_button.dart';
import 'package:security_police_app/presentation/components/custom_text_field.dart';
import 'package:security_police_app/presentation/components/icon_with_text.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _registrationNumberController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final RegisterUser _registerUser = GetIt.instance<RegisterUser>();

  File? _photoFile;

  Future<void> _selectPhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final path =
          '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.png';
      final photoFile = File(pickedFile.path);
      await photoFile.copy(path);
      setState(() {
        _photoFile = File(path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de usuario'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                hintText: 'Nombre de usuario',
                controller: _usernameController,
                validator: Validators.validateUsername,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                hintText: 'Apellido',
                controller: _lastNameController,
                validator: Validators.validateLastName,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                hintText: 'Matrícula',
                controller: _registrationNumberController,
                validator: Validators.validateRegistrationNumber,
              ),
              const SizedBox(height: 10),
              if (_photoFile != null) Image.file(_photoFile!),
              IconTextButton(
                icon: Icons.image,
                text: 'Seleccionar imagen',
                onPressed: _selectPhoto,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                hintText: 'Contraseña',
                controller: _passwordController,
                obscureText: true,
                validator: Validators.validatePassword,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                hintText: 'Rol',
                controller: _roleController,
                validator: Validators.validateRole,
              ),
              const SizedBox(height: 20),
              PrimaryButton(
                text: 'Registrar',
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    final user = User(
                      username: _usernameController.text,
                      lastName: _lastNameController.text,
                      registrationNumber: _registrationNumberController.text,
                      password: _passwordController.text,
                      photoPath: _photoFile?.path,
                      role: _roleController.text,
                    );
                    final success = await _registerUser.call(user);
                    if (success) {
                      Navigator.of(context).pop();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Error al registrar')),
                      );
                    }
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
