import 'package:e_learning/widgets/course_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/course_providers.dart';

class CourseListScreen extends StatefulWidget {
  const CourseListScreen({super.key});

  @override
  State<CourseListScreen> createState() => _CourseListScreenState();
}

class _CourseListScreenState extends State<CourseListScreen> {
  late Future<void> _fetchCoursesFuture;

  @override
  void initState() {
    super.initState();
    _fetchCoursesFuture = _fetchCourses();
  }

  Future<void> _fetchCourses() async {
    try {
      await Provider.of<CourseProvider>(context, listen: false).fetchCourses();
    } catch (error) {
      print('Error fetching courses: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<CourseProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Courses'),
      ),
      body: FutureBuilder(
        future: _fetchCoursesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Error loading courses: ${snapshot.error}'));
          } else {
            if (courseProvider.courses.isEmpty) {
              return Center(child: Text('No courses available.'));
            }

            return ListView.builder(
              itemCount: courseProvider.courses.length,
              itemBuilder: (context, index) {
                final course = courseProvider.courses[index];
                return CourseCard(course: course);
              },
            );
          }
        },
      ),
    );
  }
}
