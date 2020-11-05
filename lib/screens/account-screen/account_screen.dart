import 'package:etutor/data/notification_model.dart';
import 'package:etutor/data/student_model.dart';
import 'package:etutor/services/authentication_service.dart';
import 'package:etutor/services/notification_service.dart';
import 'package:etutor/services/student_service.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class AccountScreen extends StatefulWidget {
  AccountScreen({Key key}) : super(key: key);

  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String _fullname, _phoneNumber, _address, _favorite;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isUpdating, _saving, _isFetchingNewData;

  @override
  void initState() {
    _isUpdating = false;
    _saving = false;
    _isFetchingNewData = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            color: Colors.white,
            height: 300,
            child: Stack(
              children: <Widget>[
                Container(
                  height: 220,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/appbarbg.jpg'),
                    ),
                  ),
                  child: Container(),
                ),
                Positioned(
                  top: 145,
                  left: MediaQuery.of(context).size.width / 2 - 75,
                  child: Container(
                    width: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.indigo,
                        width: 0.7,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                      child: Image.asset('assets/etutorlogo.png'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: _isFetchingNewData ? 10 : 15),
            child: Container(
              child: Center(
                child: _isFetchingNewData ? 
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      backgroundColor: Colors.white,
                    ),
                  ),
                ) :
                Text(
                  StudentService.currentStudent?.fullname?.value,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
                ),
              ),
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: _isUpdating ? 10 : 0),
                  child: _isUpdating ?
                  RaisedButton(
                    onPressed: updateProfile,
                    color: Colors.indigo,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: _saving ?
                    SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: new AlwaysStoppedAnimation<Color>(Colors.white54),
                        backgroundColor: Colors.transparent,
                      ),
                    ) :
                    Icon(Icons.check, color: Colors.white),
                  ) :
                  Container(),
                ),
                RaisedButton(
                  onPressed: () {
                    setState(() {
                      _isUpdating = !_isUpdating;
                      _saving = false;
                    });
                  },
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: _isUpdating ? Icon(Icons.close) : Icon(Icons.edit),
                ),
              ],
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        enabled: _isUpdating,
                        initialValue: StudentService.currentStudent?.fullname?.value,
                        validator: (input) {
                          if (input.isEmpty) {
                            return 'Please tell us your Full Name';
                          }
                          return null;
                        },
                        onSaved: (input) => _fullname = input,
                        decoration: InputDecoration(
                          labelText: 'Full Name',
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        enabled: false,
                        initialValue: StudentService.currentStudent?.email?.value,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        enabled: _isUpdating,
                        initialValue: StudentService.currentStudent?.phoneNumber?.value,
                        onSaved: (input) => _phoneNumber = input,
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        enabled: _isUpdating,
                        initialValue: StudentService.currentStudent?.favoriteMajors?.value,
                        maxLines: 4,
                        onSaved: (input) => _favorite = input,
                        decoration: InputDecoration(
                          labelText: 'Favorite Majors',
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        ),
                        keyboardType: TextInputType.multiline,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        enabled: _isUpdating,
                        initialValue: StudentService.currentStudent?.address?.value,
                        maxLines: 4,
                        onSaved: (input) => _address = input,
                        decoration: InputDecoration(
                          labelText: 'Address',
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        ),
                        keyboardType: TextInputType.multiline,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: GestureDetector(
                onTap: () => AuthenticationService.signOut(context),
                child: Text(
                  'Log Out',
                  style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.w200),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Developed by ',
                      style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w200),
                    ),
                    TextSpan(
                      text: 'Kudo Shinichi',
                      style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w300),
                    ),
                    TextSpan(
                      text: ' - eTutor Team',
                      style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w200),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> updateProfile() async {
    FocusScope.of(context).requestFocus(FocusNode());
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      setState(() {
        _saving = true;
      });
      if (StudentService.currentStudent != null) {
        final String id = StudentService.currentStudent.id.value;
        final num age = StudentService.currentStudent.age.value;
        StudentUM studentUM = StudentUM(
          id: id,
          age: age,
          fullname: _fullname,
          phoneNumber: _phoneNumber,
          favoriteMajors: _favorite,
          address: _address,
        );
        StudentService.updateStudentProfile(context, studentUM).then((bool success) {
          if (success) {
            setState(() {
              _isFetchingNewData = true;
            });
            StudentService.getStudentProfile(context).then((Student student) {
              if (student != null) {
                setState(() {
                  _isFetchingNewData = false;
                });
              }
            });
            NotificationItemCM notiCM = NotificationItemCM(
              title: 'Profile Updated',
              body: 'Your profile has been updated successfully',
              topic: '${StudentService.currentStudent.id.value}_profile',
            );
            NotificationService.notifyToTopic(context, notiCM);
            Toast.show(
              'Update SUCCESS',
              context,
              duration: Toast.LENGTH_LONG,
              gravity:  Toast.CENTER,
              backgroundColor: Colors.indigo.withOpacity(0.7),
              textColor: Colors.white,
            );
          }
        }).whenComplete(() {
          setState(() {
            _isUpdating = false;
            _saving = false;
          });
        });
      }
    }
  }
}