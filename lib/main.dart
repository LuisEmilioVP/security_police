import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:security_police_app/data/db_helper.dart';
import 'package:security_police_app/domain/usecases/login_user.dart';
import 'package:security_police_app/domain/usecases/add_incident.dart';
import 'package:security_police_app/domain/usecases/register_user.dart';
import 'package:security_police_app/domain/usecases/get_incidents.dart';
import 'package:security_police_app/presentation/themes/app_theme.dart';
import 'package:security_police_app/presentation/screens/home_screen.dart';
import 'package:security_police_app/domain/repositories/user_repository.dart';
import 'package:security_police_app/data/repositories/user_repository_impl.dart';
import 'package:security_police_app/domain/repositories/incident_repository.dart';
import 'package:security_police_app/data/repositories/incident_repository_impl.dart';

// Set up dependency injection
void setupLocator() {
  // Registrar DatabaseHelper como singleton
  GetIt.I.registerSingleton<DatabaseHelper>(DatabaseHelper());

  // Registrar repositorios con DatabaseHelper como dependencia
  GetIt.I.registerSingleton<UserRepository>(
      UserRepositoryImpl(GetIt.I<DatabaseHelper>()));
  GetIt.I.registerSingleton<IncidentRepository>(
      IncidentRepositoryImpl(GetIt.I<DatabaseHelper>()));

  // Registrar casos de uso con sus repositorios como dependencias
  GetIt.I.registerSingleton<LoginUser>(LoginUser(GetIt.I<UserRepository>()));
  GetIt.I
      .registerSingleton<RegisterUser>(RegisterUser(GetIt.I<UserRepository>()));
  GetIt.I.registerSingleton<GetIncidents>(
      GetIncidents(GetIt.I<IncidentRepository>()));
  GetIt.I.registerSingleton<AddIncident>(
      AddIncident(GetIt.I<IncidentRepository>()));
}

void main() {
  setupLocator();
  runApp(const SecurityPoliceApp());
}

class SecurityPoliceApp extends StatelessWidget {
  const SecurityPoliceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Security Police App',
      theme: AppTheme.theme,
      home: const HomeScreen(),
    );
  }
}
