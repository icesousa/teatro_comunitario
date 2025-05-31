// lib/models/show.dart

class Show {
  final String id;
  final String title;
  final DateTime date;
  final String description;
  final String imageUrl;

  Show({
    required this.id,
    required this.title,
    required this.date,
    required this.description,
    required this.imageUrl,
  });
}
