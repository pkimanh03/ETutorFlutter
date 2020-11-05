import 'package:etutor/data/course_model.dart';
import 'package:etutor/screens/course-screen/components/slot_picker.dart';
import 'package:etutor/screens/matching-tutor-screen/matching_tutor_screen.dart';
import 'package:etutor/services/slot_service.dart';
import 'package:etutor/shared/logo-etutor.dart';
import 'package:flutter/material.dart';

class CourseDetailScreen extends StatefulWidget {
  final Course course;

  CourseDetailScreen({
    Key key,
    @required this.course,
  }) : super(key: key);

  _CourseDetailScreenState createState() => _CourseDetailScreenState(course);
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  Course _course;

  _CourseDetailScreenState(this._course);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: LogoEtutor(logoFontSize: 32),
              centerTitle: true,
              background: _course.getImage() != null ?
              Image.network(
                _course.getImage(),
                fit: BoxFit.cover,
              ) :
              Image.asset(
                'assets/appbarbg.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Text(
                        _course.name.value ?? 'Default Course',
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Icon(
                              Icons.check_circle_outline,
                              color: Colors.indigo,
                              size: 14
                            ),
                          ),
                          Text(
                            'Recommended',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey.withOpacity(0.15), width: 1),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        _course.description.value ?? 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec luctus placerat ligula, a porttitor ligula ultricies at. Nullam sagittis eu tortor semper cursus. Suspendisse commodo vel dolor at sagittis.',
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1)),
                ),
              ),
              SlotPicker(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 16),
                        color: Color(0xFF283593),
                        onPressed: matchingTutor,
                        child: Text(
                          'Find My Tutor',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'CutiveMono',
                            fontSize: 20,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Future matchingTutor() async {
    if (SlotService.selectedClasshour != null && SlotService.selectedClasshour.isNotEmpty) {
      Navigator.push(context, MaterialPageRoute(
        builder: (_) => MatchingTutorScreen(courseName: _course.name.value),
      ));
    }
  }
}