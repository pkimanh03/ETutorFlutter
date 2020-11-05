import 'package:etutor/data/dashboard_model.dart';
import 'package:etutor/screens/home-screen/components/topic_item.dart';
import 'package:flutter/material.dart';

class TopicSlideshow extends StatefulWidget {
  final String category;
  final List<DashboardItem> listDashboardItem;

  TopicSlideshow({Key key, this.category, this.listDashboardItem}) : super(key: key);

  _TopicSlideshowState createState() => _TopicSlideshowState(category: category, listDashboardItem: listDashboardItem);
}

class _TopicSlideshowState extends State<TopicSlideshow> {
  String category;
  List<DashboardItem> listDashboardItem;

  _TopicSlideshowState({this.category, this.listDashboardItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 15,
            left: 15,
            child: category != null ?
            Text(
              category,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ) :
            Container(),
          ),
          Container(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 300,
                    child: PageView(
                      physics: BouncingScrollPhysics(),
                      controller: PageController(),
                      children: listDashboardItem != null ?
                      listDashboardItem.map((e) => TopicItem(dashboardItem: e)).toList() :
                      <Widget>[
                        TopicItem(),
                      ],
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