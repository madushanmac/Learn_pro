import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/course.dart';
import 'auth_provider.dart';

class CourseProvider with ChangeNotifier {
  List<CourseModel> _courses = [];
  final String _baseUrl = 'https://festive-clarke.93-51-37-244.plesk.page/api/v1';
  final AuthProvider authProvider;

  CourseProvider({required this.authProvider});

  List<CourseModel> get courses => _courses;

  Future<void> fetchCourses() async {
    final token = authProvider.token;
    if (token == null) return;

    final response = await http.get(
      Uri.parse('$_baseUrl/courses'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body) as List;
      _courses = responseData.map((course) => CourseModel.fromJson(course)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load courses');
    }
  }

  Future<void> enrollInCourse(int courseId) async {
    final token = authProvider.token;
    if (token == null) return;

    final response = await http.post(
      Uri.parse('$_baseUrl/courses/$courseId/enroll'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      // Handle successful enrollment
      notifyListeners();
    } else {
      throw Exception('Failed to enroll in course');
    }
  }

  Future<void> deleteCourse(int courseId) async {
    final token = authProvider.token;
    if (token == null) return;

    final response = await http.delete(
      Uri.parse('$_baseUrl/courses/$courseId'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      _courses.removeWhere((course) => course.id == courseId);
      notifyListeners();
    } else {
      throw Exception('Failed to delete course');
    }
  }
}
