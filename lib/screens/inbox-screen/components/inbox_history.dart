import 'package:etutor/data/notification_model.dart';
import 'package:etutor/services/authentication_service.dart';
import 'package:etutor/services/notification_service.dart';
import 'package:etutor/services/student_service.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class InboxHistory extends StatefulWidget {
  InboxHistory({Key key}) : super(key: key);

  _InboxHistoryState createState() => _InboxHistoryState();
}

class _InboxHistoryState extends State<InboxHistory> {
  final Map<String, Color> colorMap = {
    'CREATED': Colors.red,
    'ONGOING': Colors.orange,
    'COMPLETED': Colors.green,
    'CANCELED': Colors.grey,
  };
  Future<List<NotificationItem>> listRegistrationHistoryFuture;
  List<NotificationItem> history;

  @override
  void initState() {
    listRegistrationHistoryFuture = AuthenticationService.isNotificationUpdated().then((isUpdated) {
      return !isUpdated && NotificationService.currentListNotificationItems != null ?
        Future.delayed(Duration(seconds: 1), () => NotificationService.currentListNotificationItems) :
        NotificationService.getListNotificationItems(context, StudentService.currentStudent.id.value);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 15,
            left: 15,
            child: Text(
              'Inbox History',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: FutureBuilder(
                future: listRegistrationHistoryFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    history = NotificationService.currentListNotificationItems;
                    if (history == null || history.length == 0) {
                      return Container(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey.withOpacity(0.15), width: 1),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'No inbox has been recorded',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ),
                      );
                    }
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: history.length,
                      itemBuilder: (_, index) => GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (context) => AlertDialog(
                              title: Text(history.elementAt(index).title.value ?? 'Notification'),
                              content: Text(history.elementAt(index).body.value ?? '------'),
                              actions: <Widget>[
                                RaisedButton(
                                  color: Colors.white,
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('OK', style: TextStyle(color: Colors.indigo)),
                                ),
                              ],
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.only(top: 12, left: 12, bottom: 10, right: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: Colors.grey.withOpacity(0.6),
                                    width: 0.1,
                                  ),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 0.5,
                                      offset: Offset(0, 0.2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(right: 15),
                                      child: Container(
                                        width: 30,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 0.5,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(40),
                                          child: Image.asset('assets/etutorlogoDark.png'),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width - 100,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            history.elementAt(index).title.value ?? 'Notification',
                                            textAlign: TextAlign.justify,
                                            overflow: TextOverflow.clip,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 9, bottom: 20),
                                            child: Text(
                                              history.elementAt(index).body.value ?? '------',
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                right: 10,
                                bottom: 10,
                                child: Text(
                                  history.elementAt(index).create.value ?? '------',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 4,
                    itemBuilder: (_, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Container(
                        padding: const EdgeInsets.only(top: 12, left: 12, bottom: 10, right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.6),
                            width: 0.1,
                          ),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 0.5,
                              offset: Offset(0, 0.2),
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey[300],
                                highlightColor: Colors.grey[200],
                                child: Container(
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 0.5,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(40),
                                    child: Image.asset('assets/etutorlogo.png'),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Shimmer.fromColors(
                                    baseColor: Colors.grey[300],
                                    highlightColor: Colors.grey[200],
                                    child: Container(
                                      height: 9,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 7, bottom: 14),
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey[300],
                                      highlightColor: Colors.grey[200],
                                      child: Container(
                                        height: 7,
                                        width: 110,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
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
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}