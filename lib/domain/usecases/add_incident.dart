import 'package:security_police_app/domain/entities/incident.dart';
import 'package:security_police_app/domain/repositories/incident_repository.dart';

class AddIncident {
  final IncidentRepository repository;

  AddIncident(this.repository);

  Future<bool> call(Incident incident) async {
    try {
      await repository.addIncident(incident);
      return true;
    } catch (e) {
      return false;
    }
  }
}
