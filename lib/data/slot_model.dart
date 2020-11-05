import 'package:jsonable/jsonable.dart';

class DayItem with Jsonable {
  JString dayInWeek;
  JList<SlotItem> slotDTOList;

  DayItem({String dayInWeek, List<SlotItem> slotDTOList}) {
    this.dayInWeek = this.jString('dayInWeek', initialValue: dayInWeek);
    this.slotDTOList = this.jList(
      'slotDTOList',
      initialValue: slotDTOList,
      constructor: () => SlotItem(),
    );
  }

  factory DayItem.fromJson(Map<String, dynamic> json) {
    return DayItem(
      dayInWeek: json['dayInWeek'],
      slotDTOList: (json['slotDTOList'] as List<dynamic>).map<SlotItem>((e) => SlotItem.fromJson(e)).toList(),
    );
  }
}
class SlotItem with Jsonable {
  JString id;
  JString name;
  JString description;
  JNum endTime;
  JNum startTime;
  JString timeInSlot;
  JString dayInWeek;

  SlotItem({String id, String name, String description, num endTime, num startTime, String timeInSlot, String dayInWeek}) {
    this.id = this.jString('id', initialValue: id);
    this.name = this.jString('name', initialValue: name);
    this.description = this.jString('description', initialValue: description);
    this.endTime = this.jNum('endTime', initialValue: endTime);
    this.startTime = this.jNum('startTime', initialValue: startTime);
    this.timeInSlot = this.jString('timeInSlot', initialValue: timeInSlot);
    this.dayInWeek = this.jString('dayInWeek', initialValue: dayInWeek);
  }

  factory SlotItem.fromJson(Map<String, dynamic> json) {
    return SlotItem(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      endTime: json['endTime'],
      startTime: json['startTime'],
      timeInSlot: json['timeInSlot'],
      dayInWeek: json['dayInWeek'],
    );
  }
}