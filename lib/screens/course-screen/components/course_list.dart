import 'package:etutor/data/course_model.dart';
import 'package:etutor/screens/course-screen/course_detail_screen.dart';
import 'package:etutor/services/course_service.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CourseList extends StatefulWidget {
  final String title;

  CourseList({Key key, this.title = 'Courses With Promotion'}) : super(key: key);

  _CourseListState createState() => _CourseListState(title: title);
}

class _CourseListState extends State<CourseList> {
  final String title;
  final Key skeletonKey = Key('__KUDO_TOP20COURSE_SKELETON__');
  final Key realKey = Key('__KUDO_TOP20COURSE_REAL__');
  Future<List<Course>> listCourse;

  _CourseListState({this.title});

  @override
  void initState() {
    listCourse = Future.delayed(Duration(milliseconds: 100), () => CourseService.top20Courses != null ?
      CourseService.top20Courses :
      CourseService.getTop20Course(context)
    );

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
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          FutureBuilder(
            future: listCourse,
            builder: (BuildContext context, AsyncSnapshot<List<Course>> snapshot) {
              if (snapshot.hasData) {
                final List<Course> _listCourse = snapshot.data;
                return Container(
                  key: realKey,
                  padding: const EdgeInsets.only(top: 30),
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _listCourse.length,
                    itemBuilder: (_, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(
                          builder: (_) => CourseDetailScreen(course: _listCourse[index]),
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
                                      image: _listCourse[index]?.getImage() != null ? NetworkImage(_listCourse[index].getImage()) : AssetImage('assets/etutorlogo.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Stack(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10, right: 18),
                                          child: Text(
                                            _listCourse[index]?.name?.value ?? 'Default Course',
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
                                      _listCourse[index]?.description?.value ?? 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec luctus placerat ligula, a porttitor ligula ultricies at. Nullam sagittis eu tortor semper cursus. Suspendisse commodo vel dolor at sagittis.',
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }

              return Container(
                key: skeletonKey,
                padding: const EdgeInsets.only(top: 30),
                child: 
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (_, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
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
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[300],
                              highlightColor: Colors.grey[200],
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  border: Border.all(
                                    color: Colors.indigo,
                                    width: 0.2,
                                  ),
                                  color: Colors.grey[300],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey[300],
                                    highlightColor: Colors.grey[200],
                                    child: Container(
                                      height: 13,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 28),
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey[300],
                                    highlightColor: Colors.grey[200],
                                    child: Container(
                                      height: 7,
                                      width: 190,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey[300],
                                    highlightColor: Colors.grey[200],
                                    child: Container(
                                      height: 7,
                                      width: 130,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey[300],
                                    highlightColor: Colors.grey[200],
                                    child: Container(
                                      height: 7,
                                      width: 240,
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
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}