import 'package:jsonable/jsonable.dart';

class Course with Jsonable {
  JString name;
  JString description;
  JString image;

  Course({String name, String description, String image}) {
    this.name = this.jString('name', initialValue: name);
    this.description = this.jString('description', initialValue: description);
    this.image = this.jString('image', initialValue: image);
  }

  String getImage() {
    final String img = image.value;
    return img != null && img != 'string' && img != 'No Image' ? img : null;
  }

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      name: json['name'],
      description: json['description'],
      image: json['image'],
    );
  }
}