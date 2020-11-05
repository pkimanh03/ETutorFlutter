import 'package:etutor/data/account_model.dart';
import 'package:etutor/screens/payment-screen/payment_detail_screen.dart';
import 'package:etutor/services/account_service.dart';
import 'package:etutor/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class UserTransactionHistory extends StatefulWidget {
  UserTransactionHistory({Key key}) : super(key: key);

  _UserTransactionHistoryState createState() => _UserTransactionHistoryState();
}

class _UserTransactionHistoryState extends State<UserTransactionHistory> {
  final Map<String, Color> colorMap = {
    'TOPUP': Colors.green,
    'RECEIVE': Colors.indigo,
    'SEND': Colors.purple,
    'PAYMENT': Colors.orange,
    'WITHDRAWAL': Colors.red,
  };
  Future<Account> account;
  List<Transaction> history;

  @override
  void initState() {
    account = AuthenticationService.isHistoryUpdated().then((isUpdated) {
      return !isUpdated && AccountService.currentAccount != null && AccountService.currentAccount.transactionHistory != null ?
        AccountService.currentAccount :
        AccountService.getAccountTransactionHistory(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 15,
            left: 15,
            child: Text(
              'Payment History',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.5),
                    width: 0.1,
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 2,
                      offset: Offset(0, 0.5),
                    ),
                  ],
                ),
                child: FutureBuilder(
                  future: account,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      history = AccountService.currentAccount.transactionHistory.value;
                      if (history == null || history.length == 0) {
                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.grey.withOpacity(0.15), width: 1),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'No history has been recorded',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ),
                        );
                      }
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: history.length,
                        itemBuilder: (_, index) => GestureDetector(
                          onTap: () => Navigator.push(context, MaterialPageRoute(
                            builder: (_) => PaymentDetailScreen(transaction: history.elementAt(index))
                          )),
                          child: Container(
                            padding: const EdgeInsets.only(top: 12, left: 12, bottom: 12, right: 10),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Colors.grey.withOpacity(0.15), width: 1),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      history.elementAt(index).transactionType.value ?? 'UNKNOWN',
                                      style: TextStyle(
                                        color: colorMap[history.elementAt(index).transactionType.value] ?? Colors.grey,
                                        fontSize: 16,
                                        fontFamily: 'CutiveMono',
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Text(
                                        history.elementAt(index).courseName.value ?? '------',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          'VND ${history.elementAt(index).transactionType.value != null ? (['RECEIVE', 'TOPUP'].contains(history.elementAt(index).transactionType.value) ? '+' : '-') : ''}${history.elementAt(index).getStringAmountFormatted()}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 13,
                                          ),
                                        ),
                                        Icon(
                                          Icons.navigate_next,
                                          size: 18
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (_, index) => GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.only(top: 12, left: 12, bottom: 12, right: 10),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.grey.withOpacity(0.15), width: 1),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Shimmer.fromColors(
                                    baseColor: Colors.grey[300],
                                    highlightColor: Colors.grey[200],
                                    child: Container(
                                      height: 9,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 7, bottom: 14),
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey[300],
                                      highlightColor: Colors.grey[200],
                                      child: Container(
                                        height: 7,
                                        width: 110,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}