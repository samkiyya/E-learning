import 'package:e_learning/screens/lesson_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:e_learning/models/lesson_model.dart'; // Make sure the import path is correct
import 'package:provider/provider.dart';
import 'package:e_learning/providers/lesson_provider.dart';  // Import your lesson provider

// Custom LessonCard widget
class LessonCard extends StatefulWidget {
  final Lesson lesson;

  const LessonCard({Key? key, required this.lesson}) : super(key: key);

  @override
  _LessonCardState createState() => _LessonCardState();
}

class _LessonCardState extends State<LessonCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final lessonProvider = Provider.of<LessonProvider>(context);

    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              'https://backend.biomedicalhorizonnetwork.com/${widget.lesson.banner}',
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
          ),
          SizedBox(height: 8),
          // Title and Duration
          Text(
            widget.lesson.title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            "Duration: ${widget.lesson.order} minutes",  // You can replace order with the actual duration if available
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          SizedBox(height: 8),
          // Summary with Expand functionality
          AnimatedCrossFade(
            firstChild: SizedBox.shrink(),
            secondChild: Text(
              widget.lesson.summary,
              maxLines: _isExpanded ? null : 3,
              overflow: _isExpanded ? null : TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey[700]),
            ),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: Duration(milliseconds: 200),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Text(_isExpanded ? 'Show Less' : 'Read More'),
              ),
              FutureBuilder<bool>(
                future: lessonProvider.isLessonDownloaded(widget.lesson.id.toString()),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  final isDownloaded = snapshot.data ?? false;

                  return IconButton(
                    icon: Icon(isDownloaded ? Icons.play_arrow : Icons.download),
                    onPressed: () {
                      if (isDownloaded) {
                        // Play offline
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LessonDetailScreen(
                              lessonId: widget.lesson.id,
                              videoUrl: Uri.parse(widget.lesson.videoUrl),
                            ),
                          ),
                        );
                      } else {
                        // Download lesson
                        lessonProvider.downloadLesson(widget.lesson.id.toString(), Uri.parse(widget.lesson.videoUrl));
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
