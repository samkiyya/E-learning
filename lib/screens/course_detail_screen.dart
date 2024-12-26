import 'package:e_learning/providers/course_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './section_detail_screen.dart';

class CourseDetailScreen extends StatelessWidget {
  final int courseId;

  CourseDetailScreen({required this.courseId});

  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<CourseProvider>(context);
    
    // Fetch sections when the screen is built
    Future<void> _fetchSectionsIfNeeded() async {
      // Check if the sections are already available
      if (courseProvider.sections.isEmpty) {
        await courseProvider.fetchSections(courseId); // Fetch from API if not available in Hive
      }
    }

    // Fetch the sections when the widget is built
    _fetchSectionsIfNeeded();

    return Scaffold(
      appBar: AppBar(
        title: Text('Course Details'),
      ),
      body: FutureBuilder(
        future: courseProvider.fetchSections(courseId),
        builder: (context, snapshot) {
          // If it's waiting for data, show a loading spinner
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } 
          
          // If there's an error while fetching, display an error message
          else if (snapshot.hasError) {
            return Center(child: Text('Error loading sections: ${snapshot.error}'));
          } 
          
          // If no data is found
          else {
            if (courseProvider.sections.isEmpty) {
              return Center(child: Text('No sections available.'));
            }
            
            // If data is available, display the sections in a ListView
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
                        builder: (context) => SectionDetailScreen(sectionId: section.id),
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
