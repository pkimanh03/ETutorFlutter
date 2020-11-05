import 'dart:convert';

import 'package:etutor/data/auth_model.dart';
import 'package:etutor/data/student_model.dart';
import 'package:etutor/services/authentication_service.dart';
import 'package:etutor/services/student_service.dart';
import 'package:flutter/material.dart';

class LoginWithGoogleButton extends StatefulWidget {
  const LoginWithGoogleButton({Key key}) : super(key: key);

  @override
  _LoginWithGoogleButtonState createState() => _LoginWithGoogleButtonState();
}

class _LoginWithGoogleButtonState extends State<LoginWithGoogleButton> {
  bool _saving;

  @override
  void initState() {
    _saving = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.white,
      onPressed: signInWithGoogle,
      child: _saving ?
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 13.5),
          child: SizedBox(
            height: 25,
            width: 25,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
              backgroundColor: Colors.transparent,
            ),
          ),
        ) :
        Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 11),
            child: Image(image: AssetImage('assets/google_logo.png'), height: 30.0),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              'Sign in with Google',
              style: TextStyle(
                color: Color(0xFFD2504D),
                fontSize: 16,
                letterSpacing: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> signInWithGoogle() async {
    if (!_saving) {
      setState(() {
        _saving = true;
      });
      FocusScope.of(context).requestFocus(FocusNode());
      AuthenticationService.googleSignIn(context)
        .then(
          (Auth auth) {
            if (auth != null) {
              AuthenticationService.setToken(auth);
              StudentService.getStudentProfile(context).then((Student student) {
                AuthenticationService.subscribeForStudent(student);
                if (student != null) {
                  String jsonEncoded = json.encode(auth);
                  print("authJsonEncoded: ${jsonEncoded.substring(1, jsonEncoded.length - 1).split('\\').join('')}");
                  Navigator.pushNamedAndRemoveUntil(context, '/main', (route) =>  false);
                } else {
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) => AlertDialog(
                      title: Text('Sign In FAILED on fetching Student data'),
                      content: Text('An UNKNOWN ERROR has occurred!'),
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
              }).whenComplete(() {
                setState(() {
                  _saving = false;
                });
              });
            }
          },
          onError: (error) {
            print("authError: $error");
          }
        ).whenComplete(() {
          setState(() {
            _saving = false;
          });
        });
    }
  }
}