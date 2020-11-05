import 'package:etutor/data/dashboard_model.dart';
import 'package:etutor/screens/home-screen/components/topic_slideshow.dart';
import 'package:etutor/screens/home-screen/components/welcome_section.dart';
import 'package:etutor/services/authentication_service.dart';
import 'package:etutor/services/dashboard_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Key skeletonKey = Key('__KUDO_DASHBOARD_SKELETON__');
  final Key realKey = Key('__KUDO_DASHBOARD_REAL__');
  Key _accountKey;
  Future<List<DashboardGroup>> listDashboardGroupFuture;

  Future<void> refreshHome() async {
    await Future.delayed(Duration(seconds: 1), () {
      setState(() {
        listDashboardGroupFuture = DashboardService.getDashboard(context);
        _accountKey = Key('__${DateTime.now().millisecondsSinceEpoch}_ACCOUNT__');
      });
    });
  }

  @override
  void initState() {
    _accountKey = Key('__${DateTime.now().millisecondsSinceEpoch}_ACCOUNT__');
    listDashboardGroupFuture = AuthenticationService.shouldDashboardReload().then((shouldReload) {
      return Future.delayed(Duration(seconds: 1), () => !shouldReload && DashboardService.currentListDashboardGroup != null ?
        DashboardService.currentListDashboardGroup :
        DashboardService.getDashboard(context));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0, 0.4, 0.41, 1],
          colors: [
            Colors.indigo[500].withAlpha(253),
            Colors.indigo[500].withAlpha(253),
            Colors.white,
            Colors.white,
          ],
        ),
      ),
      child: RefreshIndicator(
        onRefresh: refreshHome,
        child: ListView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.zero,
          children: <Widget>[
            WelcomeSection(key: _accountKey),
            Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 110,
                    color: Colors.white,
                    child: Center(
                      child: RaisedButton(
                        onPressed: () => Navigator.pushNamed(context, '/major-list'),
                        child: Text('Get A Course Now!'),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Container(
                      height: 8,
                      decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1)),
                    ),
                  ),
                  FutureBuilder(
                    future: listDashboardGroupFuture,
                    builder: (BuildContext context, AsyncSnapshot<List<DashboardGroup>> snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          key: realKey,
                          children: snapshot.data
                            .map<Widget>((e) => TopicSlideshow(
                              category: e.title.value,
                              listDashboardItem: e.dashboardItemObjectList.value
                            )).toList(),
                        );
                      }
                      return Column(
                        key: skeletonKey,
                        children: <Widget>[
                          TopicSlideshow(),
                          TopicSlideshow(),
                          TopicSlideshow(),
                        ],
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Developed by ',
                              style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w200),
                            ),
                            TextSpan(
                              text: 'Kudo Shinichi',
                              style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w300),
                            ),
                            TextSpan(
                              text: ' - eTutor Team',
                              style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w200),
                            ),
                          ],
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
}