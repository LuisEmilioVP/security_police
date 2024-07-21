import 'package:security_police_app/domain/entities/incident.dart';

class IncidentModel extends Incident {
  IncidentModel({
    int? id,
    required String title,
    required String description,
    required DateTime date,
    String? photoPath,
    String? audioPath,
    required int userId,
  }) : super(
          id: id,
          title: title,
          description: description,
          date: date,
          photoPath: photoPath,
          audioPath: audioPath,
          userId: userId,
        );

  factory IncidentModel.fromJson(Map<String, dynamic> json) {
    return IncidentModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: DateTime.parse(json['date']),
      photoPath: json['photo_path'],
      audioPath: json['audio_path'],
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'photo_path': photoPath,
      'audio_path': audioPath,
      'user_id': userId,
    };
  }
}
