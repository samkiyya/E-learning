import 'package:e_learning/providers/course_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './section_detail_screen.dart';

class CourseDetailScreen extends StatelessWidget {
  final int courseId;

  const CourseDetailScreen({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<CourseProvider>(context);

    // Fetch sections when the screen is built, if not already fetched
    Future<void> fetchSectionsIfNeeded() async {
      // Check if the sections are already available in the provider
      if (courseProvider.sections.isEmpty) {
        await courseProvider
            .fetchSections(courseId); // Fetch from API if not available
      }
    }

    // Trigger the section fetch only once when the screen is built
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await fetchSectionsIfNeeded();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Course Details'),
      ),
      body: Consumer<CourseProvider>(
        builder: (context, courseProvider, _) {
          // If sections are still empty after attempting to fetch, show loading indicator
          if (courseProvider.sections.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }

          // If no sections are available, display a message
          if (courseProvider.sections.isEmpty) {
            return Center(child: Text('No sections available.'));
          }

          // Display the sections in a ListView
          return ListView.builder(
            itemCount: courseProvider.sections.length,
            itemBuilder: (context, index) {
              final section = courseProvider.sections[index];
              return ListTile(
                title: Text(section.title),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SectionDetailScreen(sectionId: section.id),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
