import 'package:etutor/data/notification_model.dart';
import 'package:etutor/data/student_model.dart';
import 'package:etutor/services/account_service.dart';
import 'package:etutor/services/authentication_service.dart';
import 'package:etutor/services/notification_service.dart';
import 'package:etutor/services/student_service.dart';
import 'package:etutor/shared/logo-etutor.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toast/toast.dart';

class SenderScreen extends StatefulWidget {

  SenderScreen({Key key}) : super(key: key);

  _SenderScreenState createState() => _SenderScreenState();
}

class _SenderScreenState extends State<SenderScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isProcessing;
  String _amount;
  Student _receiverStudent;

  @override
  void initState() {
    _isProcessing = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final StudentQR studentQR = StudentService.studentReceiverQR;
    if (studentQR != null && _receiverStudent == null) {
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          _receiverStudent = Student(
            id: studentQR.id?.value,
            fullname: studentQR.fullname?.value,
            email: studentQR.email?.value,
            phoneNumber: studentQR.phoneNumber?.value,
          );
        });
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: LogoEtutor(logoFontSize: 32),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Center(
                    child: Text(
                      'Sending Confirmation',
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: Text(
                    '1. Please confirm the Receiver information!',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: _receiverStudent == null ?
                        SizedBox(
                          height: 59,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300],
                                  highlightColor: Colors.grey[200],
                                  child: Container(
                                    height: 8,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 7, left: 15, right: 15),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300],
                                  highlightColor: Colors.white10,
                                  child: Container(
                                    height: 29,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ) :
                        TextFormField(
                          enabled: false,
                          initialValue: _receiverStudent.fullname?.value,
                          decoration: InputDecoration(
                            labelText: 'Receiver Name',
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
                        child: _receiverStudent == null ?
                        SizedBox(
                          height: 59,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300],
                                  highlightColor: Colors.grey[200],
                                  child: Container(
                                    height: 8,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 7, left: 15, right: 15),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300],
                                  highlightColor: Colors.white10,
                                  child: Container(
                                    height: 29,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ) :
                        TextFormField(
                          enabled: false,
                          initialValue: _receiverStudent.email?.value,
                          decoration: InputDecoration(
                            labelText: 'Receiver Email',
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
                        child: _receiverStudent == null ?
                        SizedBox(
                          height: 59,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300],
                                  highlightColor: Colors.grey[200],
                                  child: Container(
                                    height: 8,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 7, left: 15, right: 15),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300],
                                  highlightColor: Colors.white10,
                                  child: Container(
                                    height: 29,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ) :
                        TextFormField(
                          enabled: false,
                          initialValue: _receiverStudent.phoneNumber?.value,
                          decoration: InputDecoration(
                            labelText: 'Receiver Phone',
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 10),
                      child: Text(
                        '2. Select an amount of sending',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: _receiverStudent == null ?
                          SizedBox(
                            height: 59,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey[300],
                                    highlightColor: Colors.grey[200],
                                    child: Container(
                                      height: 8,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 7, left: 15, right: 15),
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey[300],
                                    highlightColor: Colors.white10,
                                    child: Container(
                                      height: 29,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ) :
                          TextFormField(
                            autovalidate: true,
                            validator: (input) {
                              if (input.isEmpty) {
                                return 'Please enter an amount';
                              }
                              final inputVal = num.tryParse(input);
                              if (inputVal == null) {
                                return 'Invalid number';
                              } else if (inputVal <= 0) {
                                return 'Please enter a proper amount';
                              } else if (inputVal % 10000 != 0) {
                                return '$input is not a multiple of 10000';
                              }
                              return null;
                            },
                            onSaved: (input) => _amount = input,
                            decoration: InputDecoration(
                              labelText: 'Sending Amount',
                              hintText: 'Enter a multiple of 10000',
                              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    _receiverStudent == null ?
                    Container() :
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                              padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: _isProcessing ? 14.5 : 16),
                              color: Color(0xFF283593),
                              onPressed: sendMoney,
                              child: _isProcessing ?
                              SizedBox(
                                height: 25,
                                width: 25,
                                child: CircularProgressIndicator(
                                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.white54),
                                  backgroundColor: Colors.transparent,
                                  strokeWidth: 2,
                                ),
                              ) :
                              Text(
                                'Send now',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'CutiveMono',
                                  fontSize: 20,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
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
      ),
    );
  }

  Future sendMoney() async {
    if (_receiverStudent != null) {
      FocusScope.of(context).requestFocus(FocusNode());
      final formState = _formKey.currentState;
      if (formState.validate()) {
        formState.save();
        setState(() {
          _isProcessing = true;
        });
        StudentSendMoney studentSendMoney = StudentSendMoney(
          amount: num.tryParse(_amount),
          email: _receiverStudent.email?.value,
        );
        StudentService.sendStudentMoney(context, studentSendMoney).then((bool success) {
          if (success) {
            AuthenticationService.setBalanceUpdated(true);
            setState(() {
              _isProcessing = false;
            });
            final StudentQR studentQR = StudentService.studentReceiverQR;
            String _amountStr = AccountService.getStringCurrencyFormatted('$_amount');
            NotificationItemCM notiCM = NotificationItemCM(
              title: 'eTutor Wallet',
              body: 'You have just received ${_amountStr}VND from ${StudentService.currentStudent.fullname.value}',
              topic: '${studentQR.id.value}_balance',
            );
            NotificationService.notifyToTopic(context, notiCM);
            Future<void>(() => Toast.show(
              'Send SUCCESS',
              context,
              duration: Toast.LENGTH_LONG,
              gravity:  Toast.BOTTOM,
              backgroundColor: Colors.indigo.withOpacity(0.7),
              textColor: Colors.white,
            )).then((val) => Navigator.pop(context));
          }
        });
      }
    }
  }
}