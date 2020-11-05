import 'package:etutor/screens/inbox-screen/components/inbox_history.dart';
import 'package:etutor/shared/logo-etutor.dart';
import 'package:flutter/material.dart';

class InboxScreen extends StatefulWidget {
  InboxScreen({Key key}) : super(key: key);

  _InboxScreenState createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  Key _inboxKey;

  @override
  void initState() {
    _inboxKey = Key('__${DateTime.now().millisecondsSinceEpoch}_INBOX__');

    super.initState();
  }

  Future<void> refreshInbox() async {
    await Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _inboxKey = Key('__${DateTime.now().millisecondsSinceEpoch}_INBOX__');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: LogoEtutor(logoFontSize: 32),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: RefreshIndicator(
          onRefresh: refreshInbox,
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              InboxHistory(key: _inboxKey),
              SizedBox(
                height: 20.0,
              ),
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
        ),
      ),
    );
  }
}