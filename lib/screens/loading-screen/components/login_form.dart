import 'dart:convert';

import 'package:etutor/data/auth_model.dart';
import 'package:etutor/data/student_model.dart';
import 'package:etutor/screens/loading-screen/components/login_with_google_button.dart';
import 'package:etutor/services/authentication_service.dart';
import 'package:etutor/services/student_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key key}) : super(key: key);

  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;

  bool _passwordInvisible;
  bool _saving;

  @override
  void initState() {
    _saving = false;
    _passwordInvisible = true;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextFormField(
                enabled: !_saving,
                initialValue: 'student1@etutor.top',
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Please type an Email';
                  }
                  return null;
                },
                onSaved: (input) => _email = input,
                decoration: InputDecoration(
                  labelText: 'Email',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextFormField(
                enabled: !_saving,
                initialValue: 'student1',
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Please type a Password';
                  }
                  return null;
                },
                onSaved: (input) => _password = input,
                decoration: InputDecoration(
                  labelText: 'Password',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordInvisible ? Icons.visibility_off : Icons.visibility,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordInvisible = !_passwordInvisible;
                      });
                    },
                  ),
                ),
                obscureText: _passwordInvisible,
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: _saving ? 14.5 : 16),
                    color: Color(0xFF283593),
                    onPressed: signInWithEmailAndPassword,
                    child: _saving ?
                    SizedBox(
                      height: 25,
                      width: 25,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: new AlwaysStoppedAnimation<Color>(Colors.white54),
                        backgroundColor: Colors.transparent,
                      ),
                    ) :
                    Text(
                      'Sign in with Email',
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
          SizedBox(
            height: 10.0,
          ),
          Container(
            child: Center(
              child: Text('or', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w200)),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: LoginWithGoogleButton(),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            child: Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Don\'t have an account? ',
                      style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w200),
                    ),
                    TextSpan(
                      text: 'Sign up now',
                      style: TextStyle(color: Colors.white, fontSize: 15, height: 2, fontWeight: FontWeight.w300, decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()..onTap = () => Navigator.pushNamed(context, '/register'),
                    ),
                    TextSpan(
                      text: ' for free.',
                      style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w200),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> signInWithEmailAndPassword() async {
    if (!_saving) {
      setState(() {
        _passwordInvisible = true;
      });
      FocusScope.of(context).requestFocus(FocusNode());
      final formState = _formKey.currentState;
      if (formState.validate()) {
        formState.save();
        setState(() {
          _saving = true;
        });
        bool _isSignInSuccess = false;
        AuthenticationService.emailPasswordSignIn(context, email: _email, password: _password)
          .then(
            (Auth auth) {
              if (auth != null) {
                _isSignInSuccess = true;
                AuthenticationService.setToken(auth);
                StudentService.getStudentProfile(context).then((Student student) {
                  AuthenticationService.subscribeForStudent(student);
                  if (student != null) {
                    String jsonEncoded = json.encode(auth);
                    print("authJsonEncoded: ${jsonEncoded.substring(1, jsonEncoded.length - 1).split('\\').join('')}");
                    Navigator
                    .pushNamedAndRemoveUntil(context, '/main', (route) =>  false);
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
              } else {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) => AlertDialog(
                    title: Text('Sign In FAILED'),
                    content: Text('Incorrect Username or Password!'),
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
            },
            onError: (error) {
              print("authError: $error");
            }
          ).whenComplete(() {
            if (!_isSignInSuccess) {
              setState(() {
                _saving = false;
              });
            }
          });
      }
    }
  }
}
