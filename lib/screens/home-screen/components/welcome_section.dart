import 'package:etutor/screens/home-screen/components/account_menu.dart';
import 'package:etutor/services/student_service.dart';
import 'package:flutter/material.dart';

class WelcomeSection extends StatefulWidget {
  WelcomeSection({Key key}) : super(key: key);

  _WelcomeSectionState createState() => _WelcomeSectionState();
}

class _WelcomeSectionState extends State<WelcomeSection> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 240,
      child: Stack(
        children: <Widget>[
          Container(
            height: 145,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0, 0.4, 0.9],
                colors: [
                  Colors.indigo[500].withAlpha(253),
                  Colors.indigo[600],
                  Colors.indigo[700],
                ],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 35),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Hi, ',
                          style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w300),
                        ),
                        TextSpan(
                          text: StudentService.currentStudent?.fullname?.value,
                          style: TextStyle(color: Colors.white, fontSize: 17, height: 2, fontWeight: FontWeight.w500),
                        ),
                        TextSpan(
                          text: '!',
                          style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 98,
            left: 0,
            right: 0,
            child: AccountMenu(),
          ),
        ],
      ),
    );
  }
}