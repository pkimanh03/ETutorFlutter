import 'package:jsonable/jsonable.dart';

class Student with Jsonable {
  JString id;
  JString fullname;
  JNum age;
  JString address;
  JString phoneNumber;
  JString favoriteMajors;
  JString email;

  Student({String id, String fullname, int age, String address, String phoneNumber, String favoriteMajors, String email}) {
    this.id = this.jString('id', initialValue: id);
    this.fullname = this.jString('fullname', initialValue: fullname);
    this.age = this.jNum('age', initialValue: age);
    this.address = this.jString('address', initialValue: address);
    this.phoneNumber = this.jString('phoneNumber', initialValue: phoneNumber);
    this.favoriteMajors = this.jString('favoriteMajors', initialValue: favoriteMajors);
    this.email = this.jString('email', initialValue: email);
  }

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      fullname: json['fullname'],
      age: json['age'],
      address: json['address'],
      phoneNumber: json['phoneNumber'],
      favoriteMajors: json['favoriteMajors'],
      email: json['email'],
    );
  }
}
class StudentCM with Jsonable {
  JString fullname;
  JNum age;
  JString address;
  JString phoneNumber;
  JString favoriteMajors;
  JString email;
  JString password;

  StudentCM({String fullname, int age, String address, String phoneNumber, String favoriteMajors, String email, String password}) {
    this.fullname = this.jString('fullname', initialValue: fullname);
    this.age = this.jNum('age', initialValue: age);
    this.address = this.jString('address', initialValue: address);
    this.phoneNumber = this.jString('phoneNumber', initialValue: phoneNumber);
    this.favoriteMajors = this.jString('favoriteMajors', initialValue: favoriteMajors);
    this.email = this.jString('email', initialValue: email);
    this.password = this.jString('password', initialValue: password);
  }
}
class StudentUM with Jsonable {
  JString id;
  JString fullname;
  JNum age;
  JString address;
  JString phoneNumber;
  JString favoriteMajors;

  StudentUM({String id, String fullname, int age, String address, String phoneNumber, String favoriteMajors}) {
    this.id = this.jString('id', initialValue: id);
    this.fullname = this.jString('fullname', initialValue: fullname);
    this.age = this.jNum('age', initialValue: age);
    this.address = this.jString('address', initialValue: address);
    this.phoneNumber = this.jString('phoneNumber', initialValue: phoneNumber);
    this.favoriteMajors = this.jString('favoriteMajors', initialValue: favoriteMajors);
  }
}
class StudentQR with Jsonable {
  JString id;
  JString fullname;
  JString email;
  JString phoneNumber;

  StudentQR({String id, String fullname, String phoneNumber, String email}) {
    this.id = this.jString('id', initialValue: id);
    this.fullname = this.jString('fullname', initialValue: fullname);
    this.phoneNumber = this.jString('phoneNumber', initialValue: phoneNumber);
    this.email = this.jString('email', initialValue: email);
  }

  factory StudentQR.fromJson(Map<String, dynamic> json) {
    return StudentQR(
      id: json['id'],
      fullname: json['fullname'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
    );
  }
}
class StudentSendMoney with Jsonable {
  JNum amount;
  JString email;

  StudentSendMoney({int amount, String email}) {
    this.amount = this.jNum('amount', initialValue: amount);
    this.email = this.jString('email', initialValue: email);
  }
}