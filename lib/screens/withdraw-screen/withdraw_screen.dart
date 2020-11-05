import 'package:etutor/data/notification_model.dart';
import 'package:etutor/services/account_service.dart';
import 'package:etutor/services/authentication_service.dart';
import 'package:etutor/services/notification_service.dart';
import 'package:etutor/services/student_service.dart';
import 'package:etutor/shared/logo-etutor.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class WithdrawScreen extends StatefulWidget {
  WithdrawScreen({Key key}) : super(key: key);

  _WithdrawScreenState createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isProcessing;
  String _amount;

  @override
  void initState() {
    _isProcessing = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                      'Withdraw Activity',
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 30),
                  child: Text(
                    'Select an amount of withdrawing',
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
                      child: TextFormField(
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
                          } else if (inputVal % 1000 != 0) {
                            return '$input is not a multiple of 1000';
                          }
                          return null;
                        },
                        onSaved: (input) => _amount = input,
                        decoration: InputDecoration(
                          labelText: 'Amount',
                          hintText: 'Enter a multiple of 1000',
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: _isProcessing ? 14.5 : 16),
                          color: Color(0xFF283593),
                          onPressed: withdrawMoney,
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
                            'Confirm',
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
            SizedBox(
              height: 20.0,
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

  Future withdrawMoney() async {
    FocusScope.of(context).requestFocus(FocusNode());
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      setState(() {
        _isProcessing = true;
      });
      AccountService.withdrawMoney(context, _amount).then((bool success) {
        if (success) {
          AuthenticationService.setBalanceUpdated(true);
          setState(() {
            _isProcessing = false;
          });
          String _amountStr = AccountService.getStringCurrencyFormatted('$_amount');
          NotificationItemCM notiCM = NotificationItemCM(
            title: 'eTutor Wallet',
            body: 'Withdraw successfully with amount of ${_amountStr}VND',
            topic: '${StudentService.currentStudent.id.value}_balance',
          );
          NotificationService.notifyToTopic(context, notiCM);
          Future<void>(() => Toast.show(
            'Withdraw SUCCESS',
            context,
            duration: Toast.LENGTH_LONG,
            gravity:  Toast.CENTER,
            backgroundColor: Colors.indigo.withOpacity(0.7),
            textColor: Colors.white,
          )).then((val) => Navigator.pop(context));
        }
      });
    }
  }
}