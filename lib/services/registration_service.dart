import 'package:etutor/data/registration_model.dart';
import 'package:etutor/services/authentication_service.dart';
import 'package:etutor/services/http_service.dart';
import 'package:etutor/services/slot_service.dart';
import 'package:flutter/material.dart';

abstract class RegistrationService {
  static List<RegistrationHistory> currentListRegistrationHistory;
  static String local = 'http://10.0.0.2:8080/ETutor/api';
  static Future<List<RegistrationHistory>> getActivityHistory(
      BuildContext context) async {
    return HttpService.getWithAuth(
      context,
      '$local/registration/history',
    ).then((response) {
      AuthenticationService.setActivityUpdated(false);
      currentListRegistrationHistory = response
          .map<RegistrationHistory>((e) => RegistrationHistory.fromJson(e))
          .toList();
      return currentListRegistrationHistory;
    });
  }

  static Future<String> registerCourse(
      BuildContext context, String courseId) async {
    // courseId = courseId.toUpperCase();
    print('courseId: $courseId');
    return HttpService.postWithAuth(
      context,
      '$local/registration/regis-course',
      model: '"$courseId"',
    ).then((response) {
      print('registerCourse SUCCESS: $response');
      return response['id'];
    });
  }

  static Future payRegistration(BuildContext context, String regisId) async {
    return HttpService.postWithAuth(
      context,
      '$local/user-transaction/pay-registration/$regisId',
    ).then((response) {
      print('payRegistration SUCCESS: $response');
      return true;
    });
  }

  static Future createTimetable(BuildContext context, String regisId) async {
    Map<String, Map<String, String>> slotMap = SlotService.selectedClasshour;
    List<String> slotId = slotMap.keys.toList();
    List<ClassHourDTO> list = List();
    slotId.forEach((_slotId) {
      slotMap[_slotId].keys.toList().forEach((_dateString) {
        list.add(ClassHourDTO(
          classhourDate: _dateString,
          registrationId: regisId,
          slotId: _slotId,
        ));
      });
    });
    StudentRegistration studentRegistration = StudentRegistration(
        classHourInsertDTOList: list, registrationId: regisId);
    return HttpService.postWithAuth(
      context,
      '$local/classhour/timetable',
      model: studentRegistration,
    ).then((response) {
      print('payRegistration SUCCESS: $response');
      return true;
    });
  }
}
