import 'package:e_learning/screens/course_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:e_learning/models/course_model.dart';

class CourseCard extends StatefulWidget {
  final Course course;

  const CourseCard({super.key, required this.course});

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
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
          if (widget.course.thumbnail != null) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                widget.course.thumbnail!,
                fit: BoxFit.cover,
                height: 150,
                width: double.infinity,
              ),
            ),
            SizedBox(height: 8),
          ],
          Text(
            widget.course.title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            widget.course.language,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 8),
          AnimatedCrossFade(
            firstChild: SizedBox.shrink(),
            secondChild: Text(
              widget.course.description,
              maxLines: _isExpanded ? null : 2,
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
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CourseDetailScreen(courseId: widget.course.id),
                    ),
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
