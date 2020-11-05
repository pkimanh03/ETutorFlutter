import 'package:jsonable/jsonable.dart';

class Account with Jsonable {
  JNum balance;
  JList<Transaction> transactionHistory;

  Account();

  void setBalance(num balance) {
    this.balance = this.jNum('balance', initialValue: balance);
  }

  void setTransactionHistory(List<Transaction> transactions) {
    this.transactionHistory = this.jList('transactionHistory', initialValue: transactions);
  }

  void setTransactionHistoryFromJson(List<dynamic> transactionsJson) {
    this.transactionHistory = this.jList('transactionHistory', initialValue: null);
    this.transactionHistory..value = transactionsJson.map((e) => Transaction.fromJson(e)).toList();
  }

  String getStringBalanceFormatted() {
    if (balance == null || balance.value == null) {
      return '0';
    }
    String current = '${balance?.value}';
    String result = '';
    while (current.length > 3) {
      result = '.${current.substring(current.length - 3)}$result';
      current = current.substring(0, current.length - 3);
    }
    result = '$current$result';
    return result;
  }

  factory Account.fromJson(Map<String, dynamic> json) {
    final Account account = Account();
    account.setBalance(json['balance']);
    account.setTransactionHistoryFromJson(json['transactionHistory']);
    return account;
  }
}
class Transaction with Jsonable {
  JString id;
  JString transactionType;
  JString createAt;
  JNum amount;
  JString courseName;
  JString createTimeString;

  Transaction({String id, String transactionType, int amount, String createAt, String courseName, String createTimeString}) {
    this.id = this.jString('id', initialValue: id);
    this.transactionType = this.jString('transactionType', initialValue: transactionType);
    this.createAt = this.jString('createAt', initialValue: createAt);
    this.amount = this.jNum('amount', initialValue: amount);
    this.courseName = this.jString('courseName', initialValue: courseName);
    this.createTimeString = this.jString('createTimeString', initialValue: createTimeString);
  }

  String getStringAmountFormatted() {
    if (amount == null || amount.value == null) {
      return '0';
    }
    String current = '${amount?.value}';
    String result = '';
    while (current.length > 3) {
      result = '.${current.substring(current.length - 3)}$result';
      current = current.substring(0, current.length - 3);
    }
    result = '$current$result';
    return result;
  }

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      transactionType: json['transactionType'],
      createAt: json['createAt'],
      amount: json['amount'],
      courseName: json['courseName'],
      createTimeString: json['createTimeString'],
    );
  }
}