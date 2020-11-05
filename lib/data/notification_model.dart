import 'package:jsonable/jsonable.dart';

class NotificationItem with Jsonable {
  JString title;
  JString body;
  JString createAt;
  JString create;

  NotificationItem({String title, String body, String createAt, String create}) {
    this.title = this.jString('title', initialValue: title);
    this.body = this.jString('body', initialValue: body);
    this.createAt = this.jString('createAt', initialValue: createAt);
    this.create = this.jString('create', initialValue: create);
  }

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      title: json['title'],
      body: json['body'],
      createAt: json['createAt'],
      create: json['create'],
    );
  }
}
class NotificationItemCM with Jsonable {
  JString title;
  JString body;
  JString topic;

  NotificationItemCM({String title, String body, String topic}) {
    this.title = this.jString('title', initialValue: title);
    this.body = this.jString('body', initialValue: body);
    this.topic = this.jString('topic', initialValue: topic);
  }
}