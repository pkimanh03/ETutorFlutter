import 'package:jsonable/jsonable.dart';

class StudentRegistration with Jsonable {
  JString registrationId;
  JList<ClassHourDTO> classHourInsertDTOList;

  StudentRegistration({String registrationId, List<ClassHourDTO> classHourInsertDTOList}) {
    this.registrationId = this.jString('registrationId', initialValue: registrationId);
    this.classHourInsertDTOList = this.jList(
      'classHourInsertDTOList',
      initialValue: classHourInsertDTOList,
      constructor: () => ClassHourDTO(),
    );
  }
}
class ClassHourDTO with Jsonable {
  JString classhourDate;
  JString registrationId;
  JString slotId;

  ClassHourDTO({String classhourDate, String registrationId, String slotId}) {
    this.classhourDate = this.jString('classhourDate', initialValue: classhourDate);
    this.registrationId = this.jString('registrationId', initialValue: registrationId);
    this.slotId = this.jString('slotId', initialValue: slotId);
  }
}
class RegistrationHistory with Jsonable {
  JString registrationId;
  JString tutorId;
  JString courseId;
  JString status;
  JString createAt;
  JString tutorName;
  JString courseName;
  JNum coursePrice;
  JString createTimeString;
  JList<TimetableObject> timeTableObjectList;

  RegistrationHistory({
    String registrationId,
    String tutorId,
    String courseId,
    String status,
    String createAt,
    String tutorName,
    String courseName,
    num coursePrice,
    String createTimeString,
    List<TimetableObject> timeTableObjectList,
  }) {
    this.registrationId = this.jString('registrationId', initialValue: registrationId);
    this.tutorId = this.jString('tutorId', initialValue: tutorId);
    this.courseId = this.jString('courseId', initialValue: courseId);
    this.status = this.jString('status', initialValue: status);
    this.createAt = this.jString('createAt', initialValue: createAt);
    this.tutorName = this.jString('tutorName', initialValue: tutorName);
    this.courseName = this.jString('courseName', initialValue: courseName);
    this.coursePrice = this.jNum('coursePrice', initialValue: coursePrice);
    this.createTimeString = this.jString('createTimeString', initialValue: createTimeString);
    this.timeTableObjectList = this.jList(
      'timeTableObjectList',
      initialValue: timeTableObjectList,
      constructor: () => TimetableObject(),
    );
  }

  String getStringCoursePriceFormatted() {
    if (coursePrice == null || coursePrice.value == null) {
      return '0';
    }
    String current = '${coursePrice?.value}';
    String result = '';
    while (current.length > 3) {
      result = '.${current.substring(current.length - 3)}$result';
      current = current.substring(0, current.length - 3);
    }
    result = '$current$result';
    return result;
  }

  factory RegistrationHistory.fromJson(Map<String, dynamic> json) {
    return RegistrationHistory(
      registrationId: json['registrationId'],
      tutorId: json['tutorId'],
      courseId: json['courseId'],
      status: json['status'],
      createAt: json['createAt'],
      tutorName: json['tutorName'],
      courseName: json['courseName'],
      coursePrice: json['coursePrice'],
      createTimeString: json['createTimeString'],
      timeTableObjectList: (json['timeTableObjectList'] as List<dynamic>).map<TimetableObject>((e) => TimetableObject.fromJson(e)).toList(),
    );
  }
}
class TimetableObject with Jsonable {
  JString id;
  JString date;
  JString dateString;
  JString attendanceStatus;
  JString slotName;

  TimetableObject({String id, String date, String dateString, String attendanceStatus, String slotName}) {
    this.id = this.jString('id', initialValue: id);
    this.date = this.jString('date', initialValue: date);
    this.dateString = this.jString('dateString', initialValue: dateString);
    this.attendanceStatus = this.jString('attendanceStatus', initialValue: attendanceStatus);
    this.slotName = this.jString('slotName', initialValue: slotName);
  }

  factory TimetableObject.fromJson(Map<String, dynamic> json) {
    return TimetableObject(
      id: json['id'],
      date: json['date'],
      dateString: json['dateString'],
      attendanceStatus: json['attendanceStatus'],
      slotName: json['slotName'],
    );
  }
}