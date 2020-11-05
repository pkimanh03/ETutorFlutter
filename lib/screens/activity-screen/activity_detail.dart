import 'package:etutor/data/registration_model.dart';
import 'package:etutor/shared/logo-etutor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ActivityDetailScreen extends StatefulWidget {
  final RegistrationHistory registrationHistory;

  ActivityDetailScreen({Key key, @required this.registrationHistory}) : super(key: key);

  _ActivityDetailScreenState createState() => _ActivityDetailScreenState(registrationHistory);
}

class _ActivityDetailScreenState extends State<ActivityDetailScreen> {
  final Map<String, Color> colorMap = {
    'CREATED': Colors.red,
    'ONGOING': Colors.orange,
    'COMPLETED': Colors.green,
    'CANCELED': Colors.grey,
  };
  final Map<String, dynamic> attendenceMap = {
    'NOT_YET': {
      'text': 'NOT_YET',
      'color': Colors.red,
    },
    'ONLY_TUTOR': {
      'text': 'NOT_YET',
      'color': Colors.red,
    },
    'ONLY_STUDENT': {
      'text': 'PRESENT',
      'color': Colors.green,
    },
    'PRESENT': {
      'text': 'PRESENT',
      'color': Colors.green,
    },
  };
  final RegistrationHistory _registrationHistory;

  _ActivityDetailScreenState(this._registrationHistory);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: LogoEtutor(logoFontSize: 32),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Column(
            children: <Widget>[
              Center(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Center(
                        child: Text(
                          'Activity Detail',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            _registrationHistory.courseName.value ?? 'Default Course',
                            overflow: TextOverflow.clip,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Center(
                        child: Text(
                          _registrationHistory.status.value ?? 'UNKNOWN',
                          style: TextStyle(
                            color: colorMap[_registrationHistory.status.value] ?? Colors.black,
                            fontSize: 20,
                            fontFamily: 'CutiveMono',
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 15, left: 15),
                                  child: Text(
                                    'Course Price:',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15, right: 15),
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'vnđ  ',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                        TextSpan(
                                          text: _registrationHistory.getStringCoursePriceFormatted(),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 30,
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 15, left: 15),
                                  child: Text(
                                    'Date and Time:',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15, right: 15),
                                  child: Text(
                                    _registrationHistory.createTimeString.value,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 15, left: 15),
                                  child: Text(
                                    'Tutor:',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15, right: 15),
                                  child: Text(
                                    _registrationHistory.tutorName.value ?? '------',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    _registrationHistory.timeTableObjectList.value == null || _registrationHistory.timeTableObjectList.value.isEmpty ?
                    Container() :
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 15, left: 15, bottom: 10),
                                  child: Text(
                                    'Classhours:',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                ListView.builder(
                                  padding: EdgeInsets.zero,
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: _registrationHistory.timeTableObjectList.value.length,
                                  itemBuilder: (_, index) {
                                    final List<TimetableObject> _list = _registrationHistory.timeTableObjectList.value;
                                    return Stack(
                                      children: <Widget>[
                                        Container(
                                          padding: const EdgeInsets.only(top: 15, bottom: 15, left: 15),
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(color: Colors.grey.withOpacity(0.15), width: 1),
                                            ),
                                          ),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    width: MediaQuery.of(context).size.width - 110,
                                                    child: Text(
                                                      _list[index].slotName.value ?? 'UNKNOWN_0',
                                                      overflow: TextOverflow.clip,
                                                      textAlign: TextAlign.justify,
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.w300,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 5),
                                                    child: Text(
                                                      _list[index].dateString.value != null ? _list[index].dateString.value.split(' ')[0] ?? '------' : '------',
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          right: 15,
                                          bottom: 25,
                                          child: Text(
                                            _list[index].attendanceStatus.value != null ? attendenceMap[_list[index].attendanceStatus.value]['text'] ?? '------' : '------',
                                            style: TextStyle(
                                              color: _list[index].attendanceStatus.value != null ? attendenceMap[_list[index].attendanceStatus.value]['color'] ?? Colors.grey : Colors.grey,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 15, left: 15),
                                  child: Text(
                                    'Rate your Tutor:',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 10, bottom: 15, right: 15),
                                  child: RatingBar(
                                    initialRating: 0,
                                    direction: Axis.horizontal,
                                    itemCount: 5,
                                    itemSize: 30,
                                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (_, index) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
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