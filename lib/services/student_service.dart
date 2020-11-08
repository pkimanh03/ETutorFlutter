import 'package:etutor/data/student_model.dart';
import 'package:etutor/services/authentication_service.dart';
import 'package:etutor/services/http_service.dart';
import 'package:flutter/material.dart';

abstract class StudentService {
  static Student currentStudent;
  static StudentQR studentReceiverQR;
  static String local = 'https://etutorapisp.azurewebsites.net/etutor/api';
  static Future<bool> signUp(BuildContext context, StudentCM studentCM) async {
    print('signUp');
    print(local);
    // return HttpService.postWithAuth(
    //   context,
    //   '$local/student',
    //   model: studentCM,
    // ).then((response) {
    //   print('Sign Up SUCCESS: $response');
    //   return true;
    // });
    return true;
  }

  static Future<Student> getStudentProfile(BuildContext context) async {
    return HttpService.getWithAuth(
      context,
      '$local/student/profile',
    ).then((response) {
      currentStudent = Student.fromJson(response);
      AuthenticationService.setStudent(currentStudent);
      return currentStudent;
    });
  }

  static Future<Student> getStudentById(
      BuildContext context, String studentId) async {
    return HttpService.getWithAuth(
      context,
      '$local/student/$studentId',
    ).then((response) {
      return Student.fromJson(response);
    });
  }

  static Future<bool> sendStudentMoney(
      BuildContext context, StudentSendMoney studentSendMoney) async {
    return HttpService.postWithAuth(
      context,
      '$local/user-transaction/send-money',
      model: studentSendMoney,
    ).then((response) {
      return true;
    });
  }

  static Future<bool> updateStudentProfile(
      BuildContext context, StudentUM studentUM) async {
    return HttpService.putWithAuth(
      context,
      '$local/student',
      model: studentUM,
    ).then((response) => response != null);
  }
}
