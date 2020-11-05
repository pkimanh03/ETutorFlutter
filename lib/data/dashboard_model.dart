import 'package:jsonable/jsonable.dart';

class DashboardGroup with Jsonable {
  JString title;
  JList<DashboardItem> dashboardItemObjectList;

  DashboardGroup({String title, List<DashboardItem> dashboardItemObjectList}) {
    this.title = this.jString('title', initialValue: title);
    this.dashboardItemObjectList = this.jList(
      'dashboardItemObjectList',
      initialValue: dashboardItemObjectList,
      constructor: () => DashboardItem(),
    );
  }

  factory DashboardGroup.fromJson(Map<String, dynamic> json) {
    return DashboardGroup(
      title: json['title'],
      dashboardItemObjectList: (json['dashboardItemObjectList'] as List<dynamic>).map<DashboardItem>((e) => DashboardItem.fromJson(e)).toList(),
    );
  }
}
class DashboardItem with Jsonable {
  JString name;
  JString image;
  JString description;

  DashboardItem({String name, String image, String description}) {
    this.name = this.jString('name', initialValue: name);
    this.image = this.jString('image', initialValue: image);
    this.description = this.jString('description', initialValue: description);
  }

  String getImage() {
    final String img = image.value;
    return img != null && img != 'null' && img != 'string' && img != 'No Image' ? img : null;
  }

  factory DashboardItem.fromJson(Map<String, dynamic> json) {
    return DashboardItem(
      name: json['name'],
      image: json['image'],
      description: json['description'],
    );
  }
}