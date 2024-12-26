import 'package:hive/hive.dart';

part 'lesson_model.g.dart';

@HiveType(typeId: 2)
class Lesson extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final int sectionId;

  @HiveField(3)
  final String videoUrl;

  @HiveField(4)
  final String attachment;

  @HiveField(5)
  final String banner;

  @HiveField(6)
  final String summary;

  @HiveField(7)
  final int order;

  Lesson({
    required this.id,
    required this.title,
    required this.sectionId,
    required this.videoUrl,
    required this.attachment,
    required this.banner,
    required this.summary,
    required this.order,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'],
      title: json['title'],
      sectionId: json['section']['id'], // Parsing sectionId from the 'section' object
      videoUrl: json['video_url'] ?? '', // Default empty string if null
      attachment: json['attachment'] ?? '', // Default empty string if null
      banner: json['banner'] ?? '', // Default empty string if null
      summary: json['summary'] ?? '', // Default empty string if null
      order: json['order'] ?? 0, // Default 0 if null
    );
  }
}
