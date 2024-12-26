import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://backend.biomedicalhorizonnetwork.com/api";

  Future<List<dynamic>> fetchCourses() async {
    final response = await http.get(Uri.parse('$baseUrl/courses'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load courses');
    }
  }

  Future<List<dynamic>> fetchSections(String courseId) async {
    final response = await http.get(Uri.parse('$baseUrl/sections/$courseId'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load sections');
    }
  }

  Future<List<dynamic>> fetchLessons(String sectionId) async {
    final response = await http.get(Uri.parse('$baseUrl/lessons/$sectionId'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load lessons');
    }
  }
}
