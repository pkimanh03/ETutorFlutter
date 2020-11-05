import 'package:etutor/data/registration_model.dart';
import 'package:etutor/screens/activity-screen/activity_detail.dart';
import 'package:etutor/services/authentication_service.dart';
import 'package:etutor/services/registration_service.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ActivityHistory extends StatefulWidget {
  ActivityHistory({Key key}) : super(key: key);

  _ActivityHistoryState createState() => _ActivityHistoryState();
}

class _ActivityHistoryState extends State<ActivityHistory> {
  final Map<String, Color> colorMap = {
    'CREATED': Colors.red,
    'ONGOING': Colors.orange,
    'COMPLETED': Colors.green,
    'CANCELED': Colors.grey,
  };
  Future<List<RegistrationHistory>> listRegistrationHistoryFuture;
  List<RegistrationHistory> history;

  @override
  void initState() {
    listRegistrationHistoryFuture = AuthenticationService.isActivityUpdated().then((isUpdated) {
      return !isUpdated && RegistrationService.currentListRegistrationHistory != null ?
        Future.delayed(Duration(seconds: 1), () => RegistrationService.currentListRegistrationHistory) :
        RegistrationService.getActivityHistory(context);
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
              'Activity History',
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
                    history = RegistrationService.currentListRegistrationHistory;
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
                            'No activity has been recorded',
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
                          Navigator.push(context, MaterialPageRoute(
                            builder: (_) => ActivityDetailScreen(registrationHistory: history[index]),
                          ));
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
                                        width: 40,
                                        decoration: BoxDecoration(
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
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context).size.width - 110,
                                          child: Text(
                                            history.elementAt(index).courseName.value ?? 'Default Course',
                                            overflow: TextOverflow.clip,
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 13),
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Status: ',
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: history.elementAt(index).status.value ?? '------',
                                                  style: TextStyle(
                                                    color: colorMap[history.elementAt(index).status.value] ?? Colors.grey,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                right: 10,
                                bottom: 10,
                                child: Text(
                                  history.elementAt(index).createTimeString.value ?? '------',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
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
                                  width: 40,
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
                              padding: const EdgeInsets.only(top: 10),
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