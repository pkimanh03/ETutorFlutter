import 'package:etutor/data/account_model.dart';
import 'package:etutor/shared/logo-etutor.dart';
import 'package:flutter/material.dart';

class PaymentDetailScreen extends StatefulWidget {
  final Transaction transaction;

  PaymentDetailScreen({Key key, @required this.transaction}) : super(key: key);

  _PaymentDetailScreenState createState() => _PaymentDetailScreenState(transaction);
}

class _PaymentDetailScreenState extends State<PaymentDetailScreen> {
  final Map<String, Color> colorMap = {
    'TOPUP': Colors.green,
    'RECEIVE': Colors.indigo,
    'SEND': Colors.purple,
    'PAYMENT': Colors.orange,
    'WITHDRAWAL': Colors.red,
  };
  Transaction _transaction;

  _PaymentDetailScreenState(this._transaction);

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: LogoEtutor(logoFontSize: 32),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Column(
            children: <Widget>[
              Center(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Center(
                        child: Text(
                          'Payment Detail',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Center(
                        child: Text(
                          _transaction.transactionType.value ?? 'UNKNOWN',
                          style: TextStyle(
                            color: colorMap[_transaction.transactionType.value] ?? Colors.grey,
                            fontSize: 24,
                            fontFamily: 'CutiveMono',
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 15, left: 15),
                                  child: Text(
                                    'Total:',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15, right: 15),
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'vnđ  ',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                        TextSpan(
                                          text: _transaction.getStringAmountFormatted(),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 15, left: 15),
                                  child: Text(
                                    'Date and Time:',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15, right: 15),
                                  child: Text(
                                    _transaction.createTimeString.value,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 15, left: 15),
                                  child: Text(
                                    'Course:',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15, right: 15),
                                  child: Text(
                                    _transaction.courseName.value ?? '------',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
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
}