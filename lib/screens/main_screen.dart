import 'package:etutor/routes.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedPageIndex;

  @override
  void initState() {
    _selectedPageIndex = 0;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ETutor Home',
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
      home: Scaffold(
        body: MainRoutes.tabBarViewList[_selectedPageIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 15,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedPageIndex,
            type: BottomNavigationBarType.fixed,
            iconSize: 30,
            elevation: 10,
            showUnselectedLabels: true,
            selectedItemColor: Colors.indigo,
            selectedFontSize: 10,
            unselectedItemColor: Colors.grey.withOpacity(0.8),
            unselectedFontSize: 10,
            onTap: (index) {
              setState(() {
                _selectedPageIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Home')
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.assignment),
                title: Text('Activity')
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_balance_wallet),
                title: Text('Payment')
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.inbox),
                title: Text('Inbox')
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                title: Text('Account')
              ),
            ],
          ),
        ),
      ),
      routes: MainRoutes.innerRouteList,
    );
  }
}