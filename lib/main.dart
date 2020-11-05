import 'package:etutor/routes.dart';
import 'package:flutter/material.dart';

void main() => runApp(ETutorApp());

class ETutorApp extends StatefulWidget {
  ETutorApp({Key key}) : super(key: key);

  _ETutorAppState createState() => _ETutorAppState();
}

class _ETutorAppState extends State<ETutorApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ETutor App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.indigo,
      ),
      initialRoute: '/',
      routes: MainRoutes.outerRouteList,
    );
  }
}
