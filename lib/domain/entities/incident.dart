class Incident {
  final int? id;
  final String title;
  final String description;
  final DateTime date;
  final String? photoPath;
  final String? audioPath;
  final int userId;

  Incident({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    this.photoPath,
    this.audioPath,
    required this.userId,
  });
}
