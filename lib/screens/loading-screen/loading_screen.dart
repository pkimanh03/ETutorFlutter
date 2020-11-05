import 'package:etutor/screens/loading-screen/components/login_form.dart';
import 'package:etutor/services/authentication_service.dart';
import 'package:etutor/shared/logo-etutor.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

class LoadingScreen extends StatefulWidget {
  LoadingScreen({Key key}) : super(key: key);

  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  // Add variable to top of class
  Alignment childAlignment = Alignment.center;
  Future<bool> isLoggedIn;

  @override
  void initState() {
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        // Add state updating code
        setState(() {
          childAlignment = visible ? Alignment.topCenter : Alignment.center;
        });
      },
    );
    AuthenticationService.settingUpFirebaseMessaging(context);
    isLoggedIn = AuthenticationService.checkToken(context);
    isLoggedIn.then((value) {
      if (value) {
        Navigator.pushNamedAndRemoveUntil(context, '/main', (route) =>  false);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF3F51B5),
      body: AnimatedContainer(
        curve: Curves.easeOut,
        duration: Duration(
          milliseconds: 150,
        ),
        padding: EdgeInsets.only(top: 40),
        width: double.infinity,
        height: double.infinity,
        alignment: childAlignment,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Center(
              child: LogoEtutor(logoFontSize: 40),
            ),
            SizedBox(
              height: 20.0,
            ),
            FutureBuilder<bool>(
              future: isLoggedIn,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data == false) {
                    return LoginForm();
                  }
                }
                // By default, show a loading spinner.
                return CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.white54),
                  backgroundColor: Colors.transparent,
                  strokeWidth: 2,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
