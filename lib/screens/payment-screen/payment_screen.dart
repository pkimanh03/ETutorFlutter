import 'package:etutor/screens/payment-screen/components/payment_header.dart';
import 'package:etutor/screens/payment-screen/components/user_transaction_history.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  PaymentScreen({Key key}) : super(key: key);

  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Key _accountKey, _transactionKey;

  Future<void> refreshHome() async {
    await Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _accountKey = Key('__${DateTime.now().millisecondsSinceEpoch}_ACCOUNT__');
        _transactionKey = Key('__${DateTime.now().millisecondsSinceEpoch}_TRANSACTION__');
      });
    });
  }

  @override
  void initState() {
    _accountKey = Key('__${DateTime.now().millisecondsSinceEpoch}_ACCOUNT__');
    _transactionKey = Key('__${DateTime.now().millisecondsSinceEpoch}_TRANSACTION__');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0, 0.4, 0.41, 1],
          colors: [
            Colors.indigo[500].withAlpha(253),
            Colors.indigo[500].withAlpha(253),
            Colors.white,
            Colors.white,
          ],
        ),
      ),
      child: RefreshIndicator(
        onRefresh: refreshHome,
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([
                Column(
                  children: <Widget>[
                    PaymentHeader(key: _accountKey),
                    UserTransactionHistory(key: _transactionKey),
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
              ]),
            ),
          ],
        ),
      ),
    );
  }
}