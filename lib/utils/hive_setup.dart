import 'package:e_learning/models/course_model.dart';
import 'package:e_learning/models/lesson_model.dart';
import 'package:e_learning/models/section_model.dart';

import 'package:hive_flutter/hive_flutter.dart';

Future<void> setupHive() async {
  await Hive.initFlutter();

  // Registering adapters
  Hive.registerAdapter(CourseAdapter());
  Hive.registerAdapter(SectionAdapter());
  Hive.registerAdapter(LessonAdapter());

  // Opening boxes
  await Hive.openBox<Course>('coursesBox');
  await Hive.openBox<Section>('sectionsBox');
  await Hive.openBox<Lesson>('lessonsBox');
}
