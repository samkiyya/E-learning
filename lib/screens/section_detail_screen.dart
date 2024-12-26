import 'package:e_learning/providers/course_providers.dart';
import 'package:e_learning/widgets/lesson_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './lesson_detail_screen.dart';
import 'package:e_learning/providers/lesson_provider.dart';

class SectionDetailScreen extends StatelessWidget {
  final int sectionId;

  const SectionDetailScreen({super.key, required this.sectionId});

  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<CourseProvider>(context);
    final lessonProvider = Provider.of<LessonProvider>(context);

    // Fetch lessons if they are not already fetched
    Future<void> fetchLessonsIfNeeded() async {
      if (courseProvider.lessons.isEmpty) {
        await courseProvider.fetchLessons(sectionId);
      }
    }

    // Trigger fetching lessons when the widget is built
    fetchLessonsIfNeeded();

    return Scaffold(
      appBar: AppBar(
        title: Text('Section Details'),
      ),
      body: Consumer<CourseProvider>(
        builder: (context, provider, child) {
          // If lessons are still loading
          if (provider.lessons.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }

          // If there is an error while fetching lessons
          if (provider.lessons.isEmpty) {
            return Center(child: Text('Error loading lessons'));
          }

          // Display the lessons once fetched
          return ListView.builder(
            itemCount: provider.lessons.length,
            itemBuilder: (context, index) {
              final lesson = provider.lessons[index];
              return LessonCard(lesson: lesson);
            },
          );
        },
      ),
    );
  }
}
