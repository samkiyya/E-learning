import 'package:e_learning/providers/course_providers.dart';
import 'package:e_learning/providers/lesson_provider.dart';
import 'package:e_learning/screens/course_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CourseProvider()),
        ChangeNotifierProvider(create: (_) => LessonProvider()),
      ],
      child: MaterialApp(
        title: 'LMS App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: CourseListScreen(),
      ),
    );
  }
}
