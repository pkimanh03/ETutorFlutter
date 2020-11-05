import 'package:etutor/data/account_model.dart';
import 'package:etutor/services/account_service.dart';
import 'package:etutor/services/authentication_service.dart';
import 'package:flutter/material.dart';


class AccountMenu extends StatefulWidget {
  AccountMenu({Key key}) : super(key: key);

  _AccountMenuState createState() => _AccountMenuState();
}

class _AccountMenuState extends State<AccountMenu> {
  String moneyString;
  Future<Account> account;

  @override
  void initState() {
    account = AuthenticationService.isBalanceUpdated().then((isUpdated) {
      return !isUpdated && AccountService.currentAccount != null && AccountService.currentAccount.balance != null ?
        AccountService.currentAccount :
        AccountService.getAccountBalance(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 135,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.grey.withOpacity(0.5),
            width: 0.1,
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 3,
              offset: Offset(0, 0.5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: <Widget>[
              Container(
                height: 47,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.withOpacity(0.15), width: 1),
                  ),
                ),
                child: FutureBuilder(
                  future: account,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      moneyString = AccountService.currentAccount?.getStringBalanceFormatted();
                      return Stack(
                        children: <Widget>[
                          Container(
                            child: Center(
                              child: Text(
                                moneyString,
                                style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -1,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 11,
                            left: MediaQuery.of(context).size.width / 2 + moneyString.length * 2.5,
                            child: Text(
                              'VND',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
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
              Container(
                height: 85,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: () => Navigator.pushNamed(context, '/topup'),
                      child: Container(
                        width: 65,
                        height: 65,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.indigo,
                            width: 0.7,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.library_add, size: 22, color: Colors.indigo),
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text(
                                'Top Up',
                                style: TextStyle(color: Colors.indigo, fontSize: 11),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.pushNamed(context, '/withdraw'),
                      child: Container(
                        width: 65,
                        height: 65,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.indigo,
                            width: 0.7,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.credit_card, size: 22, color: Colors.indigo),
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text(
                                'Withdraw',
                                style: TextStyle(color: Colors.indigo, fontSize: 11),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.pushNamed(context, '/request'),
                      child: Container(
                        width: 65,
                        height: 65,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.indigo,
                            width: 0.7,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.developer_mode, size: 22, color: Colors.indigo),
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text(
                                'Request',
                                style: TextStyle(color: Colors.indigo, fontSize: 11),
                              ),
                            ),
                          ],
                        ),
                      ),
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
}