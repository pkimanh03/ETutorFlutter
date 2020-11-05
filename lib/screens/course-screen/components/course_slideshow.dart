import 'package:etutor/data/majors_model.dart';
import 'package:etutor/screens/course-screen/components/course_item.dart';
import 'package:flutter/material.dart';

class CourseSlideshow extends StatefulWidget {
  final MajorsGroup majors;

  CourseSlideshow({Key key, this.majors}) : super(key: key);

  _CourseSlideshowState createState() => _CourseSlideshowState(majors: majors);
}

class _CourseSlideshowState extends State<CourseSlideshow> {
  final MajorsGroup majors;

  _CourseSlideshowState({this.majors});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 15,
            left: 15,
            child: majors != null ?
            Text(
              majors.name.value ?? 'Default Majors',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ) :
            Container(),
          ),
          Container(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 250,
                    child: majors != null ?
                    ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemCount: majors.courseCollection.value.length,
                      itemBuilder: (_, index) => CourseItem(courseItem: majors.courseCollection.value[index]),
                    ) :
                    ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (_, index) => CourseItem(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}