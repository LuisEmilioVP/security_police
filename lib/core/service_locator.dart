import 'package:get_it/get_it.dart';
import 'package:security_police_app/data/db_helper.dart';
import 'package:security_police_app/data/repositories/user_repository_impl.dart';
import 'package:security_police_app/data/repositories/incident_repository_impl.dart';
import 'package:security_police_app/domain/repositories/user_repository.dart';
import 'package:security_police_app/domain/repositories/incident_repository.dart';
import 'package:security_police_app/domain/usecases/get_user.dart';
import 'package:security_police_app/domain/usecases/login_user.dart';
import 'package:security_police_app/domain/usecases/register_user.dart';
import 'package:security_police_app/domain/usecases/get_incidents.dart';
import 'package:security_police_app/domain/usecases/add_incident.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  // Database
  getIt.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // Repositories
  getIt.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(getIt<DatabaseHelper>()));
  getIt.registerLazySingleton<IncidentRepository>(
      () => IncidentRepositoryImpl(getIt<DatabaseHelper>()));

  // Use cases
  getIt.registerLazySingleton(() => GetUser(getIt<UserRepository>()));
  getIt.registerLazySingleton(() => LoginUser(getIt<UserRepository>()));
  getIt.registerLazySingleton(() => RegisterUser(getIt<UserRepository>()));
  getIt.registerLazySingleton(() => GetIncidents(getIt<IncidentRepository>()));
  getIt.registerLazySingleton(() => AddIncident(getIt<IncidentRepository>()));
}
