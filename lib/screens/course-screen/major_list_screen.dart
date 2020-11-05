import 'package:etutor/data/majors_model.dart';
import 'package:etutor/screens/course-screen/components/course_list.dart';
import 'package:etutor/screens/course-screen/components/course_slideshow.dart';
import 'package:etutor/services/majors_service.dart';
import 'package:etutor/shared/logo-etutor.dart';
import 'package:flutter/material.dart';

class MajorListScreen extends StatefulWidget {
  MajorListScreen({Key key}) : super(key: key);

  _MajorListScreenState createState() => _MajorListScreenState();
}

class _MajorListScreenState extends State<MajorListScreen> {
  final Key skeletonKey = Key('__KUDO_MAJORS_SKELETON__');
  final Key realKey = Key('__KUDO_MAJORS_REAL__');
  Future<List<MajorsGroup>> listMajorsGroupFuture;

  @override
  void initState() {
    listMajorsGroupFuture = MajorsService.currentListMajorsGroup != null ?
      Future.delayed(Duration(seconds: 1), () => MajorsService.currentListMajorsGroup) :
      MajorsService.getMajors(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      future: listMajorsGroupFuture,
                      builder: (BuildContext context, AsyncSnapshot<List<MajorsGroup>> snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            key: realKey,
                            children: snapshot.data
                              .map<Widget>((e) => CourseSlideshow(
                                majors: e,
                              )).toList(),
                          );
                        }
                        return Column(
                          key: skeletonKey,
                          children: <Widget>[
                            CourseSlideshow(),
                            CourseSlideshow(),
                            CourseSlideshow(),
                          ],
                        );
                      },
                    ),
                    CourseList(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 1,
                              ),
                            ),
                          ),
                          Text(
                            'Loading ...',
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w200),
                          ),
                        ],
                      ),
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