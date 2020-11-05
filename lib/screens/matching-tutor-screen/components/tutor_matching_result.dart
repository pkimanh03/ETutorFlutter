import 'package:etutor/data/tutor_model.dart';
import 'package:etutor/screens/matching-tutor-screen/tutor_detail.dart';
import 'package:flutter/material.dart';

class TutorMatchingResult extends StatefulWidget {
  final TutorMatching tutorMatching;
  final String courseName;

  TutorMatchingResult({Key key, @required this.tutorMatching, @required this.courseName}) : super(key: key);

  _TutorMatchingResultState createState() => _TutorMatchingResultState(tutorMatching, courseName);
}

class _TutorMatchingResultState extends State<TutorMatchingResult> {
  final TutorMatching _tutorMatching;
  final String _courseName;

  _TutorMatchingResultState(this._tutorMatching, this._courseName);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(
        builder: (_) => TutorDetailScreen(tutorMatching: _tutorMatching, courseName: _courseName),
      )),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.withOpacity(0.15), width: 1),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(
                    color: Colors.indigo,
                    width: 0.2,
                  ),
                  image: DecorationImage(
                    image: _tutorMatching.getAvatar() != null ?
                      NetworkImage(_tutorMatching.getAvatar()) :
                      NetworkImage('http://photos.etutor.top:8021/PhotosManager/api/images/3051012f-e42d-4e84-afc2-ebac73b4fd52'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10, right: 18),
                          child: Text(
                            _tutorMatching.fullname.value,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 3,
                          right: 0,
                          child: Icon(
                            Icons.check_circle_outline,
                            color: Colors.indigo,
                            size: 14
                          ),
                        ),
                      ],
                    ),
                    Text(
                      _courseName,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  _tutorMatching.getTutorCourseSelected(_courseName).getStringPriceFormatted(),
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}