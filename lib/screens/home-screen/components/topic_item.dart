import 'package:etutor/data/dashboard_model.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TopicItem extends StatefulWidget {
  final DashboardItem dashboardItem;

  TopicItem({
    Key key,
    this.dashboardItem
  }) : super(key: key);

  _TopicItemState createState() => _TopicItemState(dashboardItem: dashboardItem);
}

class _TopicItemState extends State<TopicItem> {
  DashboardItem dashboardItem;
  bool _isInWishlist;
  bool _isBookMarked;

  _TopicItemState({this.dashboardItem});

  @override
  void initState() {
    _isInWishlist = false;
    _isBookMarked = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
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
            dashboardItem != null ?
            Container(
              height: 125,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                image: DecorationImage(
                  image: dashboardItem?.getImage() != null ? NetworkImage(dashboardItem.getImage()) : AssetImage('assets/etutorlswDark.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ) :
            Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[200],
              child: Container(
                height: 125,
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
                    height: 108,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.withOpacity(0.15), width: 1),
                      ),
                    ),
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
                                  child: dashboardItem != null ?
                                  Text(
                                    dashboardItem?.name?.value ?? 'Default Course',
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
                                        height: 13,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                dashboardItem != null ?
                                Text(
                                  dashboardItem?.description?.value ?? 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec luctus placerat ligula, a porttitor ligula ultricies at. Nullam sagittis eu tortor semper cursus. Suspendisse commodo vel dolor at sagittis.',
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ) :
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(top: 16),
                                        child: Shimmer.fromColors(
                                          baseColor: Colors.grey[300],
                                          highlightColor: Colors.grey[200],
                                          child: Container(
                                            height: 7,
                                            width: 220,
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
                                            width: 140,
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
                                            width: 260,
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
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 8),
                    child: dashboardItem != null ?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isInWishlist = !_isInWishlist;
                            });
                          },
                          child: Icon(
                            _isInWishlist ? Icons.favorite : Icons.favorite_border,
                            size: 20,
                            color: _isInWishlist ? Colors.red : Colors.grey,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isBookMarked = !_isBookMarked;
                            });
                          },
                          child: Icon(
                            _isBookMarked ? Icons.bookmark : Icons.bookmark_border,
                            size: 22,
                            color: _isBookMarked ? Colors.indigo : Colors.grey,
                          ),
                        ),
                      ],
                    ) :
                    Container(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}