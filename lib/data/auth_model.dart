import 'package:jsonable/jsonable.dart';

class Auth with Jsonable {
  JString tokenType;
  JString accessToken;

  Auth({String tokenType, String accessToken}) {
    this.tokenType = this.jString('tokenType', initialValue: tokenType);
    this.accessToken = this.jString('accessToken', initialValue: accessToken);
  }

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      tokenType: json['tokenType'],
      accessToken: json['accessToken'],
    );
  }
}
class Credential with Jsonable {
  JString uid;
  JString email;
  JString fullname;

  Credential({String uid, String email, String fullname}) {
    this.uid = this.jString('uid', initialValue: uid);
    this.email = this.jString('email', initialValue: email);
    this.fullname = this.jString('fullname', initialValue: fullname);
  }
}