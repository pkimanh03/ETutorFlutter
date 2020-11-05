import 'dart:convert';

import 'package:etutor/data/tutor_model.dart';
import 'package:etutor/screens/matching-tutor-screen/components/tutor_matching_result.dart';
import 'package:etutor/services/slot_service.dart';
import 'package:etutor/services/tutor_service.dart';
import 'package:etutor/shared/logo-etutor.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MatchingTutorScreen extends StatefulWidget {
  final String courseName;

  MatchingTutorScreen({
    Key key,
    @required this.courseName,
  }) : super(key: key);

  _MatchingTutorScreenState createState() => _MatchingTutorScreenState(courseName);
}

class _MatchingTutorScreenState extends State<MatchingTutorScreen> {
  final String _courseName;
  Future<List<TutorMatching>> listTutorMatchingFuture;

  _MatchingTutorScreenState(this._courseName);

  @override
  void initState() {
    List<String> _slotList = SlotService.selectedClasshour.keys.toList();
    TutorRequirement _tutorRequirement = TutorRequirement(courseName: _courseName, slotList: _slotList);
    listTutorMatchingFuture = TutorService.matchingTutorCourse(context, _tutorRequirement);
    String jsonEncoded = json.encode(_tutorRequirement);
    print('${jsonEncoded.substring(1, jsonEncoded.length - 1).split('\\').join('')}');

    super.initState();
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
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([
                Column(
                  children: <Widget>[
                    FutureBuilder(
                      future: listTutorMatchingFuture,
                      builder: (BuildContext context, AsyncSnapshot<List<TutorMatching>> snapshot) {
                        if (snapshot.hasError) {
                          if (snapshot.error is http.ClientException && (snapshot.error as http.ClientException).message.contains('POST 404')) {
                            return Container(
                              height: MediaQuery.of(context).size.height - 155,
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 20),
                                      child: Text(
                                        'No Tutor available!',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                        }
                        if (snapshot.hasData) {
                          List<TutorMatching> _list = snapshot.data;
                          return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _list.length,
                            itemBuilder: (_, index) => Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: TutorMatchingResult(
                                tutorMatching: _list[index],
                                courseName: _courseName,
                              ),
                            ),
                          );
                        }
                        return Container(
                          height: MediaQuery.of(context).size.height - 155,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Text('Wait for matching'),
                                ),
                                SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 1,
                                    backgroundColor: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 20,
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
              ]),
            ),
          ],
        ),
      ),
    );
  }
}