import 'dart:convert';

import 'package:etutor/data/notification_model.dart';
import 'package:etutor/data/tutor_model.dart';
import 'package:etutor/services/notification_service.dart';
import 'package:etutor/services/registration_service.dart';
import 'package:etutor/services/student_service.dart';
import 'package:etutor/shared/logo-etutor.dart';
import 'package:flutter/material.dart';

class TutorDetailScreen extends StatefulWidget {
  final TutorMatching tutorMatching;
  final String courseName;

  TutorDetailScreen({
    Key key,
    @required this.tutorMatching,
    @required this.courseName,
  }) : super(key: key);

  _TutorDetailScreenState createState() => _TutorDetailScreenState(tutorMatching, courseName);
}

class _TutorDetailScreenState extends State<TutorDetailScreen> {
  final TutorMatching _tutorMatching;
  final String _courseName;

  _TutorDetailScreenState(this._tutorMatching, this._courseName);

  TutorCourse _tutorCourse;
  bool _isProcessing;

  @override
  void initState() {
    _isProcessing = false;
    _tutorCourse = _tutorMatching.getTutorCourseSelected(_courseName);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: LogoEtutor(logoFontSize: 32),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              color: Colors.white,
              height: 300,
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 220,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/appbarbg.jpg'),
                      ),
                    ),
                    child: Container(),
                  ),
                  Positioned(
                    top: 145,
                    left: MediaQuery.of(context).size.width / 2 - 75,
                    child: Container(
                      width: 150,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.indigo,
                          width: 0.7,
                        ),
                      ),
                      child: _tutorMatching.getAvatar() != null ?
                        Image.network(_tutorMatching.getAvatar()) :
                        Image.network('http://photos.etutor.top:8021/PhotosManager/api/images/3051012f-e42d-4e84-afc2-ebac73b4fd52'),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Container(
                child: Center(
                  child: Text(
                    _tutorMatching.fullname.value,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 15, left: 15),
                          child: Text(
                            'Age:',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, left: 15),
                          child: Text(
                            '30',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 15, left: 15),
                          child: Text(
                            'Phone Number:',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, left: 10),
                          child: Text(
                            '0946912678',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 15, left: 15),
                          child: Text(
                            'Address:',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 7, left: 15, right: 15),
                            child: Text(
                              '\t\t\t Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec luctus placerat ligula, a porttitor ligula ultricies at. Nullam sagittis eu tortor semper cursus. Suspendisse commodo vel dolor at sagittis.',
                              overflow: TextOverflow.clip,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 15, left: 15),
                          child: Text(
                            'Available Courses:',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 7, left: 15, right: 15),
                            child: Text(
                              '\t\t\t Lorem ipsum dolor sit amet, Consectetur adipiscing elit, Donec luctus placerat ligula, Nullam sagittis cursus',
                              overflow: TextOverflow.clip,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 15, left: 15),
                          child: Text(
                            'Certificates:',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 7, left: 15, right: 15),
                            child: Text(
                              'Nothing to show',
                              overflow: TextOverflow.clip,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 18, left: 15),
                          child: Text(
                            'Selected Course:',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, left: 10),
                          child: Text(
                            _courseName,
                            overflow: TextOverflow.clip,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 15, left: 15),
                          child: Text(
                            'Total:',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      _tutorCourse.getStringPriceFormatted(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: _isProcessing ? 14.5 : 16),
                      color: Color(0xFF283593),
                      onPressed: registerCourse,
                      child: _isProcessing ?
                      SizedBox(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(Colors.white54),
                          backgroundColor: Colors.transparent,
                          strokeWidth: 2,
                        ),
                      ) :
                      Text(
                        'Get This Tutor',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'CutiveMono',
                          fontSize: 20,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future registerCourse() async {
    setState(() {
      _isProcessing = true;
    });
    final String courseId = _tutorCourse.id.value;
    RegistrationService.registerCourse(context, courseId).then((regisId) {
      NotificationItemCM notiCM_1 = NotificationItemCM(
        title: 'New Registration',
        body: 'You have new registration with course name "${_tutorCourse.name.value}"',
        topic: '${StudentService.currentStudent.id.value}_activity',
      );
      NotificationService.notifyToTopic(context, notiCM_1);
      final String _regisId = regisId;
      RegistrationService.payRegistration(context, _regisId).then((success) {
        if (success) {
          final String _regisBase64Id = base64.encode(utf8.encode(_regisId)).substring(0, 15);
          NotificationItemCM notiCM_2 = NotificationItemCM(
            title: 'eTutor Wallet',
            body: 'Your wallet has been charge ${_tutorCourse.getStringPriceFormatted()}VND for registration $_regisBase64Id',
            topic: '${StudentService.currentStudent.id.value}_activity',
          );
          NotificationService.notifyToTopic(context, notiCM_2);
          RegistrationService.createTimetable(context, _regisId).then((success) {
            if (success) {
              showDialog(
                context: context,
                barrierDismissible: true,
                builder: (context) => AlertDialog(
                  title: Text('Registration SUCCESS'),
                  content: Text('Enjoy your Course!'),
                  actions: <Widget>[
                    RaisedButton(
                      color: Colors.white,
                      onPressed: () => Navigator.pop(context),
                      child: Text('OK', style: TextStyle(color: Colors.indigo)),
                    ),
                  ],
                ),
              ).then((val) => Navigator.pop(context)).then((val) => Navigator.pop(context)).then((val) => Navigator.pop(context));
            }
          });
        }
      });
    });
  }
}