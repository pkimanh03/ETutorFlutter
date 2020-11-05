import 'dart:convert';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:etutor/data/student_model.dart';
import 'package:etutor/services/student_service.dart';
import 'package:etutor/shared/logo-etutor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class RequestScreen extends StatefulWidget {
  RequestScreen({Key key}) : super(key: key);

  _RequestScreenState createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  final GlobalKey qrKey = GlobalKey();
  
  String _dataString;
  bool _isProcessing;

  @override
  void initState() {
    StudentQR studentQR = StudentQR(
      id: StudentService.currentStudent?.id?.value,
      fullname: StudentService.currentStudent?.fullname?.value,
      email: StudentService.currentStudent?.email?.value,
      phoneNumber: StudentService.currentStudent?.phoneNumber?.value,
    );
    String jsonEncoded = json.encode(studentQR);
    _isProcessing = false;
    _dataString = jsonEncoded.substring(1, jsonEncoded.length - 1).split('\\').join('');

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
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Center(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Center(
                        child: Text(
                          'Ask sender to scan QR Code',
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    RepaintBoundary(
                      key: qrKey,
                      child: QrImage(
                        data: _dataString,
                        size: 250,
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Center(
                      child: Text('or', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w200)),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                              padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: _isProcessing ? 14.5 : 16),
                              color: Color(0xFF283593),
                              onPressed: scanQR,
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
                                'Make a Scan!',
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
      ),
    );
  }

  Future scanQR() async {
    try {
      setState(() {
        _isProcessing = true;
      });
      String qrCode = await BarcodeScanner.scan();
      StudentQR studentQR = StudentQR.fromJson(json.decode(qrCode));
      StudentService.studentReceiverQR = studentQR;
      Navigator.pushNamed(context, '/sender').then((val) {
        setState(() {
          _isProcessing = false;
        });
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => AlertDialog(
            title: Text('Barcode Scanner ERROR'),
            content: Text('The user did not grant the camera permission!'),
            actions: <Widget>[
              RaisedButton(
                color: Colors.white,
                onPressed: () => Navigator.pop(context),
                child: Text('OK', style: TextStyle(color: Colors.indigo)),
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => AlertDialog(
            title: Text('Barcode Scanner ERROR'),
            content: Text('Unknown error: $e'),
            actions: <Widget>[
              RaisedButton(
                color: Colors.white,
                onPressed: () => Navigator.pop(context),
                child: Text('OK', style: TextStyle(color: Colors.indigo)),
              ),
            ],
          ),
        );
      }
    } on FormatException {
      // Do nothing
      setState(() {
        _isProcessing = false;
      });
    } catch (e) {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
          title: Text('Barcode Scanner ERROR'),
          content: Text('Unknown error: $e'),
          actions: <Widget>[
            RaisedButton(
              color: Colors.white,
              onPressed: () => Navigator.pop(context),
              child: Text('OK', style: TextStyle(color: Colors.indigo)),
            ),
          ],
        ),
      );
    }
  }
}