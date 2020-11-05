import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:etutor/data/auth_model.dart';
import 'package:etutor/data/student_model.dart';
import 'package:etutor/services/account_service.dart';
import 'package:etutor/services/http_service.dart';
import 'package:etutor/services/notification_service.dart';
import 'package:etutor/services/registration_service.dart';
import 'package:etutor/services/student_service.dart';
import 'package:etutor/services/tutor_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

abstract class AuthenticationService {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = new GoogleSignIn();
  static final String ACCESS_TOKEN =
      'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJzdHVkZW50MUBldHV0b3IudG9wIiwiaWF0IjoxNjA0MTkzMjc0LCJleHAiOjE2MDQ0OTkyNTR9.CCHFesIt6LGRu94eeTl_OTLSoKGXs_HfsgjLdYWsSzqPKX08wplbpvoRGs_PtjbMiFP4EIT0Xfmyj0CZk3hmKQ';

  static String local = 'http://10.0.0.2:8080/ETutor/api';
  //
  // Auth APIs
  //

  static Future<bool> checkToken(BuildContext context) async {
    StudentService.currentStudent = await getStudent();
    if (StudentService.currentStudent != null) {
      subscribeForStudent(StudentService.currentStudent);
    }
    final Map<String, String> authHeaders =
        await HttpService.createAuthoziedHttpHeaders();
    return HttpService.getWithAuth(
      context,
      '$local/auth/expiration',
      headers: authHeaders,
      disableWarning: true,
    ).then((value) {
      return true;
    }).catchError((error) => false);
  }

  static Future<Auth> emailPasswordSignIn(BuildContext context,
      {String email, String password}) async {
    print('sigin auth');
    try {
      // AuthResult authResult = await _firebaseAuth.signInWithEmailAndPassword(
      //     email: email, password: password);
      // FirebaseUser firebaseUser = authResult.user;
      // updateUserData(firebaseUser);
      // return signInEtutorWithGmail(context, firebaseUser: firebaseUser);
      // return HttpService.postWithAuth(context, url);
      return signinEtutorWithEmailPassword(context, email, password);
    } catch (exception) {
      if (exception is PlatformException) {
        print('${exception.message}: ${exception.details}');
      } else {
        throw exception;
      }
    }
    return null;
  }

  static Future<Auth> googleSignIn(BuildContext context) async {
    final GoogleSignInAccount googleAccount = await _googleSignIn.signIn();
    if (googleAccount != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      AuthResult authResult =
          await _firebaseAuth.signInWithCredential(credential);
      FirebaseUser firebaseUser = authResult.user;
      // updateUserData(firebaseUser);
      Auth auth =
          await signInEtutorWithGmail(context, firebaseUser: firebaseUser);
      return auth;
    }
    return null;
  }

  static Future<Auth> signInEtutorWithGmail(BuildContext context,
      {FirebaseUser firebaseUser}) async {
    if (firebaseUser != null) {
      final Credential credential = new Credential(
        uid: firebaseUser.uid,
        email: firebaseUser.email,
        fullname: firebaseUser.displayName,
      );
      return HttpService.postWithAuth(
        context,
        '$local/student/signin-gmail',
        model: credential,
      ).then((response) {
        return Auth.fromJson(response);
      });
    }
    return null;
    // return HttpService.postWithAuth(
    //     context,
    //     '$local/student/signin-gmail',
    //     model: credential,
    //   ).then((response) {
    //     return Auth.fromJson(response);
    //   });
  }

  static Future<Auth> signinEtutorWithEmailPassword(
      BuildContext context, String email, String password) async {
    print('email' + email);
    print('password' + password);

    // http.Response response = await http.post(
    //   // '$local/auth/signin',
    //   'http://dummy.restapiexample.com/api/v1/create',
    //   headers: <String, String>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //   },
    //   // body: jsonEncode(<String, String>{
    //   //   'email': email,
    //   //   'password': password,
    //   // }),
    //   body: jsonEncode(<String, String>{
    //     'name': email,
    //     'salary': '123',
    //     'age': '21',
    //   }),
    // );
    // print('responseAPB');
    // print(response);
    // if (response.statusCode >= 200 && response.statusCode < 300) {
    //   print('okila');
    //   return Auth.fromJson(json.decode(response.body));
    // } else {
    //   // If the server did not return a 201 CREATED response,
    //   // then throw an exception.
    //   throw Exception('Failed to load action');
    // }

    return new Auth(tokenType: 'Bearer', accessToken: ACCESS_TOKEN);
    // .then((response) {
    //   print(response.body);
    //   return Auth.fromJson(json.decode(response.body));
    // }).catchError(onError);
  }

  static Future<void> signOut(BuildContext context) async {
    clearToken(context);
    _googleSignIn.signOut();
    _firebaseAuth.signOut();
  }

  //
  // Firebase Notification
  //

  static void settingUpFirebaseMessaging(BuildContext context) {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        notificationHandler(context, message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        notificationHandler(context, message);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
  }

  static Future<dynamic> notificationHandler(
      BuildContext context, Map<String, dynamic> message) async {
    final String title = message['notification']['title'];
    final String body = message['notification']['body'];
    if (title.toUpperCase().contains('profile')) {
      StudentService.getStudentProfile(context);
    } else if (title.toUpperCase().contains('wallet')) {
      setBalanceUpdated(true);
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(body),
          actions: <Widget>[
            RaisedButton(
              color: Colors.white,
              onPressed: () => Navigator.pop(context),
              child: Text('OK', style: TextStyle(color: Colors.indigo)),
            ),
          ],
        ),
      );
    } else if (title.toUpperCase().contains('registration')) {
      setActivityUpdated(true);
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(body),
          actions: <Widget>[
            RaisedButton(
              color: Colors.white,
              onPressed: () => Navigator.pop(context),
              child: Text('OK', style: TextStyle(color: Colors.indigo)),
            ),
          ],
        ),
      );
    }
    setNotificationUpdated(true);
  }

  static void subscribeForStudent(Student student) {
    if (student != null) {
      subscribeToTopicFirebaseMessaging('${student.id.value}');
      subscribeToTopicFirebaseMessaging('${student.id.value}_profile');
      subscribeToTopicFirebaseMessaging('${student.id.value}_balance');
      subscribeToTopicFirebaseMessaging('${student.id.value}_activity');
    }
  }

  static void subscribeToTopicFirebaseMessaging(String topic) {
    _firebaseMessaging.unsubscribeFromTopic(topic).then((val) {
      _firebaseMessaging.subscribeToTopic(topic);
    });
  }

  //
  // Auth-Guard
  //

  static Future<bool> shouldDashboardReload() async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();
    final int millisecondsSinceEpoch =
        prefs.getInt('ETUTOR_DASHBOARD_LATEST') ?? null;
    return millisecondsSinceEpoch != null &&
        DateTime.now().isAfter(
            DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch)
                .add(Duration(minutes: 5)));
  }

  static Future<void> setDashboardLatestLoad() async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(
        'ETUTOR_DASHBOARD_LATEST', DateTime.now().millisecondsSinceEpoch);
  }

  static Future<Auth> getToken({bool withDelayed = false}) async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();
    final String tokenString = prefs.getString('ETUTOR_TOKEN') ?? null;
    Auth token;
    if (tokenString != null) {
      token = Auth.fromJson(json.decode(tokenString)) ?? null;
    } else {
      token = null;
    }
    return withDelayed
        ? Future.delayed(Duration(seconds: 1), () => token)
        : token;
  }

  static Future<bool> setToken(Auth auth) async {
    final String encodedToken = json.encode(auth);
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(
        'ETUTOR_TOKEN',
        encodedToken
            .substring(1, encodedToken.length - 1)
            .split('\\')
            .join(''));
  }

  static Future<Student> getStudent() async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();
    final String studentString = prefs.getString('ETUTOR_STUDENT') ?? null;
    Student account;
    if (studentString != null) {
      account = Student.fromJson(json.decode(studentString)) ?? null;
    } else {
      account = null;
    }
    return account;
  }

  static Future<void> setStudent(Student account) async {
    final String encodedToken = json.encode(account);
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(
        'ETUTOR_STUDENT',
        encodedToken
            .substring(1, encodedToken.length - 1)
            .split('\\')
            .join(''));
  }

  static Future<bool> isBalanceUpdated() async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();
    final String isUpdatedString =
        prefs.getString('ETUTOR_BALANCE_UPDATED') ?? null;
    return isUpdatedString != null && isUpdatedString == 'true';
  }

  static Future<void> setBalanceUpdated(bool isUpdated) async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('ETUTOR_BALANCE_UPDATED', isUpdated ? 'true' : 'false');
    if (isUpdated) {
      prefs.setString('ETUTOR_HISTORY_UPDATED', 'true');
    }
  }

  static Future<bool> isNotificationUpdated() async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();
    final String isUpdatedString =
        prefs.getString('ETUTOR_NOTIFICATION_UPDATED') ?? null;
    return isUpdatedString != null && isUpdatedString == 'true';
  }

  static Future<void> setNotificationUpdated(bool isUpdated) async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(
        'ETUTOR_NOTIFICATION_UPDATED', isUpdated ? 'true' : 'false');
  }

  static Future<bool> isActivityUpdated() async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();
    final String isUpdatedString =
        prefs.getString('ETUTOR_ACTIVITY_UPDATED') ?? null;
    return isUpdatedString != null && isUpdatedString == 'true';
  }

  static Future<void> setActivityUpdated(bool isUpdated) async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('ETUTOR_ACTIVITY_UPDATED', isUpdated ? 'true' : 'false');
  }

  static Future<bool> isHistoryUpdated() async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();
    final String isUpdatedString =
        prefs.getString('ETUTOR_HISTORY_UPDATED') ?? null;
    return isUpdatedString != null && isUpdatedString == 'true';
  }

  static Future<void> setHistoryUpdatedFalse() async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('ETUTOR_HISTORY_UPDATED', 'false');
  }

  static Future<void> clearToken(BuildContext context) async {
    StudentService.currentStudent = await getStudent();
    if (StudentService.currentStudent != null) {
      _firebaseMessaging
          .unsubscribeFromTopic(StudentService.currentStudent.id.value);
    }
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();
    prefs.clear().then((value) {
      if (value) {
        StudentService.currentStudent = null;
        AccountService.currentAccount = null;
        NotificationService.currentListNotificationItems = null;
        RegistrationService.currentListRegistrationHistory = null;
        TutorService.currentListTutorMatching = null;
        Navigator.pushNamedAndRemoveUntil(context, '/etutor', (route) => false);
      }
    });
  }
}
