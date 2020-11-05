import 'package:jsonable/jsonable.dart';

class MajorsGroup with Jsonable {
  JString id;
  JString name;
  JString description;
  JList<MajorsItem> courseCollection;

  MajorsGroup({String id, String name, String description, List<MajorsItem> courseCollection}) {
    this.id = this.jString('id', initialValue: id);
    this.name = this.jString('name', initialValue: name);
    this.description = this.jString('description', initialValue: description);
    this.courseCollection = this.jList(
      'courseCollection',
      initialValue: courseCollection,
      constructor: () => MajorsItem(),
    );
  }

  factory MajorsGroup.fromJson(Map<String, dynamic> json) {
    return MajorsGroup(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      courseCollection: (json['courseCollection'] as List<dynamic>).map<MajorsItem>((e) => MajorsItem.fromJson(e)).toList(),
    );
  }
}
class MajorsItem with Jsonable {
  JString id;
  JString name;
  JString image;
  JString description;

  MajorsItem({String id, String name, String image, String description}) {
    this.id = this.jString('id', initialValue: id);
    this.name = this.jString('name', initialValue: name);
    this.image = this.jString('image', initialValue: image);
    this.description = this.jString('description', initialValue: description);
  }

  String getImage() {
    final String img = image.value;
    return img != null && img != 'null' && img != 'string' && img != 'No Image' ? img : null;
  }

  factory MajorsItem.fromJson(Map<String, dynamic> json) {
    return MajorsItem(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      description: json['description'],
    );
  }
}