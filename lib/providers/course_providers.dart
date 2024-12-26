import 'package:e_learning/models/course_model.dart';
import 'package:e_learning/models/lesson_model.dart';
import 'package:e_learning/models/section_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';

class CourseProvider with ChangeNotifier {
  List<Course> _courses = [];
  List<Section> _sections = [];
  List<Lesson> _lessons = [];

  List<Course> get courses => _courses;
  List<Section> get sections => _sections;
  List<Lesson> get lessons => _lessons;

  // Set up Hive and register adapters
  Future<void> setupHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(CourseAdapter());
    Hive.registerAdapter(SectionAdapter());
    Hive.registerAdapter(LessonAdapter());
  }

  // Fetch courses from API or Hive
  Future<void> fetchCourses() async {
    // Check if courses are already stored in Hive
    var courseBox = await Hive.openBox<Course>('coursesBox');
    if (courseBox.isNotEmpty) {
      _courses = courseBox.values.toList();
      notifyListeners();
    } else {
      // Fetch courses from API and store in Hive
      final response = await http.get(
          Uri.parse('https://backend.biomedicalhorizonnetwork.com/api/course'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _courses = (data as List).map((item) => Course.fromJson(item)).toList();

        // Save to Hive for offline usage
        for (var course in _courses) {
          await courseBox.put(course.id, course);
        }

        notifyListeners();
      } else {
        throw Exception('Failed to load courses');
      }
    }
  }

  // Fetch sections from API
  Future<void> fetchSections(int courseId) async {
    final response = await http.get(Uri.parse(
        'https://backend.biomedicalhorizonnetwork.com/api/section/$courseId'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _sections = (data as List).map((item) => Section.fromJson(item)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load sections');
    }
  }

  // Fetch lessons from API
  Future<void> fetchLessons(int sectionId) async {
    final response = await http.get(Uri.parse(
        'https://backend.biomedicalhorizonnetwork.com/api/lesson/$sectionId'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _lessons = (data as List).map((item) => Lesson.fromJson(item)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load lessons');
    }
  }
}
