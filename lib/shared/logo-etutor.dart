import 'package:flutter/material.dart';

class LogoEtutor extends StatefulWidget {
  final double logoFontSize;

  LogoEtutor({Key key, this.logoFontSize}) : super(key: key);

  _LogoEtutorState createState() => _LogoEtutorState(this.logoFontSize);
}

class _LogoEtutorState extends State<LogoEtutor> {
  final double logoFontSize;

  _LogoEtutorState(this.logoFontSize);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'etutor',
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'CutiveMono',
          fontSize: this.logoFontSize,
        ),
      ),
    );
  }
}
