import 'package:etutor/data/student_model.dart';
import 'package:etutor/services/student_service.dart';
import 'package:etutor/shared/logo-etutor.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key key}) : super(key: key);

  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _fullname, _email, _password, _phoneNumber, _address, _favorite;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _saving;

  bool _passwordInvisible, _repasswordInvisible;

  @override
  void initState() {
    _passwordInvisible = true;
    _repasswordInvisible = true;
    _saving = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF3F51B5),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.only(top: 40),
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(
                child: LogoEtutor(logoFontSize: 40),
              ),
              SizedBox(
                height: 20.0,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextFormField(
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
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextFormField(
                          validator: (input) {
                            if (input.isEmpty) {
                              return 'Please type an Email';
                            }
                            return null;
                          },
                          onSaved: (input) => _email = input,
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
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextFormField(
                          validator: (input) {
                            if (input.isEmpty) {
                              return 'Please type a Password';
                            }
                            return null;
                          },
                          onSaved: (input) => _password = input,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordInvisible ? Icons.visibility_off : Icons.visibility,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordInvisible = !_passwordInvisible;
                                });
                              },
                            ),
                          ),
                          obscureText: _passwordInvisible,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextFormField(
                          validator: (input) {
                            if (_password != null) {
                              if (input.isEmpty) {
                                return 'Please retype your Password';
                              }
                              if (_password != input) {
                                return 'Re-password not matched';
                              }
                            }
                            return null;
                          },
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            labelText: 'Re-password',
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _repasswordInvisible ? Icons.visibility_off : Icons.visibility,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              onPressed: () {
                                setState(() {
                                  _repasswordInvisible = !_repasswordInvisible;
                                });
                              },
                            ),
                          ),
                          obscureText: _repasswordInvisible,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextFormField(
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
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextFormField(
                          maxLines: 4,
                          onSaved: (input) => _phoneNumber = input,
                          decoration: InputDecoration(
                            labelText: 'Address',
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
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                              padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: _saving ? 14.5 : 16),
                              color: Color(0xFF283593),
                              onPressed: signUp,
                              child: _saving ?
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
                                'Sign up',
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
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            text: 'I will come back later',
                            style: TextStyle(color: Colors.white, fontSize: 15, height: 2, fontWeight: FontWeight.w300, decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()..onTap = () => Navigator.pop(context),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signUp() async {
    setState(() {
      _passwordInvisible = true;
      _repasswordInvisible = true;
    });
    FocusScope.of(context).requestFocus(FocusNode());
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      if (formState.validate()) {
        formState.save();
        setState(() {
          _saving = true;
        });
        StudentCM studentCM = StudentCM(
          fullname: _fullname,
          email: _email,
          password: _password,
          age: 0,
          address: _address,
          favoriteMajors: _favorite,
          phoneNumber: _phoneNumber,
        );
        StudentService.signUp(context, studentCM).then((bool success) {
          if (success) {
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (context) => AlertDialog(
                title: Text('Sign Up SUCCESS'),
                content: Text('Please Sign in to get your first Course!'),
                actions: <Widget>[
                  RaisedButton(
                    color: Colors.white,
                    onPressed: () => Navigator.pop(context),
                    child: Text('OK', style: TextStyle(color: Colors.indigo)),
                  ),
                ],
              ),
            ).then((val) => Navigator.pop(context));
          }
        }).whenComplete(() {
          setState(() {
            _saving = false;
          });
        });
      }
    }
  }
}