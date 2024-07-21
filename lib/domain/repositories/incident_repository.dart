import 'package:security_police_app/domain/entities/incident.dart';

abstract class IncidentRepository {
  Future<List<Incident>> getIncidents(int userId, String role);
  Future<void> addIncident(Incident incident);
  Future<void> deleteIncident(int id, int userId, String role);
  Future<void> deleteAllIncidents();
}
