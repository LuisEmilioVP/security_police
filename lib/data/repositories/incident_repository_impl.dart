import 'package:security_police_app/core/error/exceptions.dart';
import 'package:security_police_app/data/db_helper.dart';
import 'package:security_police_app/data/models/incident_model.dart';
import 'package:security_police_app/domain/entities/incident.dart';
import 'package:security_police_app/domain/repositories/incident_repository.dart';

class IncidentRepositoryImpl implements IncidentRepository {
  final DatabaseHelper _databaseHelper;

  IncidentRepositoryImpl(this._databaseHelper);

  @override
  Future<List<Incident>> getIncidents(int userId, String role) async {
    try {
      final result = role == 'root'
          ? await _databaseHelper.query('incidents')
          : await _databaseHelper.query(
              'incidents',
              where: 'user_id = ?',
              whereArgs: [userId],
            );
      // Agrega este print para depuración
      print('Incidentes obtenidos: ${result.length}');
      return result.map((json) => IncidentModel.fromJson(json)).toList();
    } catch (e) {
      throw DatabaseException('No se pudieron obtener incidentes: $e');
    }
  }

  @override
  Future<void> addIncident(Incident incident) async {
    try {
      final incidentModel = IncidentModel(
        title: incident.title,
        description: incident.description,
        date: incident.date,
        photoPath: incident.photoPath,
        audioPath: incident.audioPath,
        userId: incident.userId,
      );
      await _databaseHelper.insert('incidents', incidentModel.toJson());
    } catch (e) {
      throw DatabaseException('No se pudo agregar el incidente: $e');
    }
  }

  @override
  Future<void> deleteIncident(int id, int userId, String role) async {
    try {
      if (role == 'root') {
        await _databaseHelper.delete('incidents', 'id = ?', [id]);
      } else {
        await _databaseHelper
            .delete('incidents', 'id = ? AND user_id = ?', [id, userId]);
      }
    } catch (e) {
      throw DatabaseException('No se pudo eliminar el incidente: $e');
    }
  }

  @override
  Future<void> deleteAllIncidents() async {
    try {
      await _databaseHelper.delete('incidents', null, null);
    } catch (e) {
      throw DatabaseException(
          'No se pudieron eliminar todos los incidentes: $e');
    }
  }
}
