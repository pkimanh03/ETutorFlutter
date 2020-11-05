import 'package:jsonable/jsonable.dart';

class TutorMatching with Jsonable {
  JString tutorId;
  JString fullname;
  JString avatar;
  JList<TutorCourse> courseList;

  TutorMatching({String tutorId, String fullname, String avatar, List<TutorCourse> courseList}) {
    this.tutorId = this.jString('tutorId', initialValue: tutorId);
    this.fullname = this.jString('fullname', initialValue: fullname);
    this.avatar = this.jString('avatar', initialValue: avatar);
    this.courseList = this.jList(
      'courseList',
      initialValue: courseList,
      constructor: () => TutorCourse(),
    );
  }

  String getAvatar() {
    final String img = avatar.value;
    return img != null && img != 'null' && img != 'string' && img != 'No Image' ? img : null;
  }

  TutorCourse getTutorCourseSelected(String courseName) {
    return courseList.value.firstWhere((tc) => tc.name.value == courseName);
  }

  factory TutorMatching.fromJson(Map<String, dynamic> json) {
    return TutorMatching(
      tutorId: json['tutorId'],
      fullname: json['fullname'],
      avatar: json['avatar'],
      courseList: (json['courseList'] as List<dynamic>).map<TutorCourse>((e) => TutorCourse.fromJson(e)).toList(),
    );
  }
}
class TutorCourse with Jsonable {
  JString id;
  JString name;
  JString description;
  JString image;
  JNum price;

  TutorCourse({String id, String name, String image, String description, num price}) {
    this.id = this.jString('id', initialValue: id);
    this.name = this.jString('name', initialValue: name);
    this.image = this.jString('image', initialValue: image);
    this.description = this.jString('description', initialValue: description);
    this.price = this.jNum('price', initialValue: price);
  }

  String getImage() {
    final String img = image.value;
    return img != null && img != 'null' && img != 'string' && img != 'No Image' ? img : null;
  }

  String getStringPriceFormatted() {
    if (price == null || price.value == null) {
      return '0';
    }
    String current = '${price?.value}';
    String result = '';
    while (current.length > 3) {
      result = '.${current.substring(current.length - 3)}$result';
      current = current.substring(0, current.length - 3);
    }
    result = '$current$result';
    return result;
  }

  factory TutorCourse.fromJson(Map<String, dynamic> json) {
    return TutorCourse(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      description: json['description'],
      price: json['price'],
    );
  }
}
class TutorRequirement with Jsonable {
  JString courseName;
  JList<String> slotList;

  TutorRequirement({String courseName, List<String> slotList}) {
    this.courseName = this.jString('courseName', initialValue: courseName);
    this.slotList = this.jList('slotList', initialValue: slotList);
  }
}