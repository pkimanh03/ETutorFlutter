import 'package:etutor/screens/activity-screen/components/activity_history.dart';
import 'package:flutter/material.dart';

class ActivityScreen extends StatefulWidget {
  ActivityScreen({Key key}) : super(key: key);

  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  Key _activityKey;

  @override
  void initState() {
    _activityKey = Key('__${DateTime.now().millisecondsSinceEpoch}_ACTIVITY__');

    super.initState();
  }

  Future<void> refreshActivity() async {
    await Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _activityKey = Key('__${DateTime.now().millisecondsSinceEpoch}_ACTIVITY__');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0, 0.4, 0.4, 1],
          colors: [
            Colors.indigo[500].withAlpha(253),
            Colors.indigo[500].withAlpha(253),
            Colors.white,
            Colors.white,
          ],
        ),
      ),
      child: RefreshIndicator(
        onRefresh: refreshActivity,
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([
                Column(
                  children: <Widget>[
                    Container(
                      color: Colors.indigo[200],
                      height: 187,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            height: 180,
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
                            child: Center(
                              child: Container(
                                child: Center(
                                  child: Text(
                                    'My Activities',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 28,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ActivityHistory(key: _activityKey),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
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
              ]),
            ),
          ],
        ),
      ),
    );
  }
}