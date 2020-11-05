import 'package:etutor/data/majors_model.dart';
import 'package:etutor/services/http_service.dart';
import 'package:flutter/material.dart';

abstract class MajorsService {
  static List<MajorsGroup> currentListMajorsGroup;
  static String local = 'http://10.0.0.2:8080/ETutor/api';
  static Future<List<MajorsGroup>> getMajors(BuildContext context) async {
    return HttpService.getWithAuth(
      context,
      '$local/majors/getListMajors',
    ).then((response) {
      currentListMajorsGroup =
          response.map<MajorsGroup>((e) => MajorsGroup.fromJson(e)).toList();
      return currentListMajorsGroup;
    });
  }
}
