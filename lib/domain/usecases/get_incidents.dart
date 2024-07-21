import 'package:security_police_app/domain/entities/incident.dart';
import 'package:security_police_app/domain/repositories/incident_repository.dart';

class GetIncidents {
  final IncidentRepository repository;

  GetIncidents(this.repository);

  Future<List<Incident>> call(int userId, String role) async {
    return await repository.getIncidents(userId, role);
  }
}
