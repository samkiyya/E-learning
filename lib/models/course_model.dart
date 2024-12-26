import 'dart:convert';

import 'package:hive/hive.dart';

part 'course_model.g.dart';

@HiveType(typeId: 0)
class Course extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String language;

  @HiveField(4)
  final String? thumbnail;

  @HiveField(5)
  final int categoryId;

  @HiveField(6)
  final double price;

  @HiveField(7)
  final Map<String, String> outcomes;

  @HiveField(8)
  final String section;

  @HiveField(9)
  final Map<String, String> requirements;

  @HiveField(10)
  final bool discountFlag;

  @HiveField(11)
  final double discountedPrice;

  @HiveField(12)
  final String courseType;

  @HiveField(13)
  final bool isTopCourse;

  @HiveField(14)
  final String status;

  @HiveField(15)
  final String? pdf;

  @HiveField(16)
  final String? videoUrl;

  @HiveField(17)
  final bool isFreeCourse;

  @HiveField(18)
  final DateTime createdAt;

  @HiveField(19)
  final DateTime updatedAt;

  @HiveField(20)
  final Category category;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.language,
    this.thumbnail,
    required this.categoryId,
    required this.price,
    required this.outcomes,
    required this.section,
    required this.requirements,
    required this.discountFlag,
    required this.discountedPrice,
    required this.courseType,
    required this.isTopCourse,
    required this.status,
    this.pdf,
    this.videoUrl,
    required this.isFreeCourse,
    required this.createdAt,
    required this.updatedAt,
    required this.category,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      language: json['language'],
      thumbnail: json['thumbnail'],
      categoryId: json['category_id'],
      price: json['price'].toDouble(),
      outcomes: Map<String, String>.from(jsonDecode(json['outcomes'])),
      section: json['section'],
      requirements: Map<String, String>.from(jsonDecode(json['requirements'])),
      discountFlag: json['discount_flag'],
      discountedPrice: json['discounted_price'].toDouble(),
      courseType: json['course_type'],
      isTopCourse: json['is_top_course'],
      status: json['status'],
      pdf: json['pdf'],
      videoUrl: json['video_url'],
      isFreeCourse: json['is_free_course'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      category: Category.fromJson(json['category']),
    );
  }
}

@HiveType(typeId: 1)
class Category extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  Category({
    required this.id,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
    );
  }
}
