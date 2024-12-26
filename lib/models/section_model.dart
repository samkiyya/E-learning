import 'package:hive/hive.dart';

part 'section_model.g.dart';

@HiveType(typeId: 3)
class Section extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final int courseId;

  Section({required this.id, required this.title, required this.courseId});

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      id: json['id'],
      title: json['title'],
      courseId: json['course']
          ['id'], // Parsing courseId from the 'course' object
    );
  }
}
