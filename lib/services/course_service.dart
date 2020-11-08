import 'package:etutor/data/course_model.dart';
import 'package:etutor/services/http_service.dart';
import 'package:flutter/material.dart';

abstract class CourseService {
  static List<Course> top20Courses;
  static String local = 'https://etutorapisp.azurewebsites.net/etutor/api';
  static Future<List<Course>> getTop20Course(BuildContext context) async {
    return HttpService.getWithAuth(
      context,
      '$local/course/getTop20',
    ).then((response) {
      top20Courses = response.map<Course>((e) => Course.fromJson(e)).toList();
      return top20Courses;
    });
  }
}
