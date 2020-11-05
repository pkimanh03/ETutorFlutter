import 'package:etutor/data/account_model.dart';
import 'package:etutor/screens/payment-screen/components/payment_menu.dart';
import 'package:etutor/services/account_service.dart';
import 'package:etutor/services/authentication_service.dart';
import 'package:flutter/material.dart';

class PaymentHeader extends StatefulWidget {
  PaymentHeader({Key key}) : super(key: key);

  _PaymentHeaderState createState() => _PaymentHeaderState();
}

class _PaymentHeaderState extends State<PaymentHeader> {
  String moneyString;
  Future<Account> account;

  @override
  void initState() {
    moneyString = AccountService.currentAccount?.getStringBalanceFormatted() ?? '000';
    account = AuthenticationService.isBalanceUpdated().then((isUpdated) {
      return isUpdated ?
        AccountService.getAccountBalance(context) :
        (
          AccountService.currentAccount == null ?
          AccountService.getAccountBalance(context) :
          AccountService.currentAccount
        );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 255,
      child: Stack(
        children: <Widget>[
          Container(
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0, 0.4, 0.9],
                colors: [
                  Colors.indigo[500].withAlpha(253),
                  Colors.indigo[600],
                  Colors.indigo[700],
                ],
              ),
            ),
            child: Center(
              child: FutureBuilder(
                future: account,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    moneyString = AccountService.currentAccount?.getStringBalanceFormatted();
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            child: Center(
                              child: Text(
                                moneyString,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -1,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 70,
                            right: MediaQuery.of(context).size.width / 2 + moneyString.length * 8,
                            child: Text(
                              'VND',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return Stack(
                    children: <Widget>[
                      Container(
                        child: Center(
                          child: SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(Colors.white54),
                              backgroundColor: Colors.transparent,
                              strokeWidth: 1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          Positioned(
            top: 150,
            left: 0,
            right: 0,
            child: PaymentMenu(),
          ),
        ],
      ),
    );
  }
}