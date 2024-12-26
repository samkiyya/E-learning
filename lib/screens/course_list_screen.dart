import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/course_providers.dart';
import './course_detail_screen.dart';

class CourseListScreen extends StatefulWidget {
  @override
  _CourseListScreenState createState() => _CourseListScreenState();
}

class _CourseListScreenState extends State<CourseListScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize Hive in the initState to set it up before fetching data
    Future.microtask(() => Provider.of<CourseProvider>(context, listen: false).setupHive());
  }

  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<CourseProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Courses'),
      ),
      body: FutureBuilder(
        future: courseProvider.fetchCourses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading courses: ${snapshot.error}'));
          } else {
            if (courseProvider.courses.isEmpty) {
              return Center(child: Text('No courses available.'));
            }

            return ListView.builder(
              itemCount: courseProvider.courses.length,
              itemBuilder: (context, index) {
                final course = courseProvider.courses[index];
                return ListTile(
                  title: Text(course.title),
                  subtitle: Text(course.language),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CourseDetailScreen(courseId: course.id),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
