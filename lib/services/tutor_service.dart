import 'package:etutor/data/tutor_model.dart';
import 'package:etutor/services/http_service.dart';
import 'package:flutter/material.dart';

abstract class TutorService {
  static List<TutorMatching> currentListTutorMatching;
  static String local = 'http://10.0.0.2:8080/ETutor/api';
  static Future<List<TutorMatching>> matchingTutorCourse(
      BuildContext context, TutorRequirement tutorRequirement) async {
    return HttpService.postWithAuth(
      context,
      '$local/tutor/matching',
      model: tutorRequirement,
    ).then((response) {
      currentListTutorMatching = response
          .map<TutorMatching>((e) => TutorMatching.fromJson(e))
          .toList();
      return currentListTutorMatching;
    });
  }
}
