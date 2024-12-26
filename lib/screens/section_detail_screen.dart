import 'package:e_learning/providers/course_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './lesson_detail_screen.dart';

class SectionDetailScreen extends StatelessWidget {
  final int sectionId;

  SectionDetailScreen({required this.sectionId});

  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<CourseProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Section Details'),
      ),
      body: FutureBuilder(
        future: courseProvider.fetchLessons(sectionId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading lessons'));
          } else {
            return ListView.builder(
              itemCount: courseProvider.lessons.length,
              itemBuilder: (context, index) {
                final lesson = courseProvider.lessons[index];
                return ListTile(
                  title: Text(lesson.title),
                  trailing: IconButton(
                    icon: Icon(Icons.download),
                    onPressed: () {
                      // Download or play offline logic goes here
                    },
                  ),
                  onTap: () {
                    // Video play logic
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
