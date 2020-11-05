import 'package:etutor/main.dart';
import 'package:etutor/screens/account-screen/account_screen.dart';
import 'package:etutor/screens/activity-screen/activity_screen.dart';
import 'package:etutor/screens/course-screen/major_list_screen.dart';
import 'package:etutor/screens/home-screen/home_screen.dart';
import 'package:etutor/screens/inbox-screen/inbox_screen.dart';
import 'package:etutor/screens/loading-screen/loading_screen.dart';
import 'package:etutor/screens/main_screen.dart';
import 'package:etutor/screens/payment-screen/payment_screen.dart';
import 'package:etutor/screens/register-screen/register_screen.dart';
import 'package:etutor/screens/request-screen/request_screen.dart';
import 'package:etutor/screens/request-screen/sender_screen.dart';
import 'package:etutor/screens/topup-screen/topup_screen.dart';
import 'package:etutor/screens/withdraw-screen/withdraw_screen.dart';
import 'package:flutter/widgets.dart';

class MainRoutes {
  static final Map<String, Widget Function(BuildContext)> outerRouteList = {
    '/': (BuildContext context) => LoadingScreen(),
    '/main': (BuildContext context) => MainScreen(),
    '/register': (BuildContext context) => RegisterScreen(),
  };

  static final Map<String, Widget Function(BuildContext)> innerRouteList = {
    '/etutor': (BuildContext context) => ETutorApp(),
    '/main': (BuildContext context) => MainScreen(),
    '/major-list': (BuildContext context) => MajorListScreen(),
    '/request': (BuildContext context) => RequestScreen(),
    '/sender': (BuildContext context) => SenderScreen(),
    '/topup': (BuildContext context) => TopupScreen(),
    '/withdraw': (BuildContext context) => WithdrawScreen(),
  };

  static final List<Widget> tabBarViewList = <Widget>[
    HomeScreen(),
    ActivityScreen(),
    PaymentScreen(),
    InboxScreen(),
    AccountScreen(),
  ];
}
