import 'package:etutor/data/course_model.dart';
import 'package:etutor/data/majors_model.dart';
import 'package:etutor/screens/course-screen/course_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CourseItem extends StatefulWidget {
  final MajorsItem courseItem;

  const CourseItem({
    Key key,
    this.courseItem
  }) : super(key: key);

  @override
  _CourseItemState createState() => _CourseItemState(courseItem: courseItem);
}

class _CourseItemState extends State<CourseItem> {
  final MajorsItem courseItem;

  _CourseItemState({this.courseItem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, top: 15, bottom: 15),
      child: GestureDetector(
        onTap: () {
          if (courseItem != null) {
            Navigator.push(context, MaterialPageRoute(
              builder: (_) => CourseDetailScreen(course: Course(
                name: courseItem.name.value,
                description: courseItem.description.value,
                image: courseItem.image.value,
              )),
            ));
          }
        },
        child: Container(
          width: 190,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey.withOpacity(0.5),
              width: 0.5,
            ),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 3,
                offset: Offset(0, 0.5),
              ),
            ],
          ),
          child: Column(
            children: <Widget>[
              courseItem != null ?
              Container(
                height: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  image: DecorationImage(
                    image: courseItem?.getImage() != null ? NetworkImage(courseItem.getImage()) : AssetImage('assets/etutorlswDark.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ) :
              Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[200],
                child: Container(
                  height: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    color: Colors.grey[300],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: courseItem != null ?
                                    Text(
                                      courseItem?.name?.value ?? 'Default Course',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ) :
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Shimmer.fromColors(
                                        baseColor: Colors.grey[300],
                                        highlightColor: Colors.grey[200],
                                        child: Container(
                                          height: 12,
                                          width: 90,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  courseItem != null ?
                                  Text(
                                    courseItem?.description?.value ?? 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec luctus placerat ligula, a porttitor ligula ultricies at. Nullam sagittis eu tortor semper cursus. Suspendisse commodo vel dolor at sagittis.',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ) :
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey[300],
                                      highlightColor: Colors.grey[200],
                                      child: Container(
                                        height: 8,
                                        width: 120,
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}