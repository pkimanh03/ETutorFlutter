import 'package:etutor/data/account_model.dart';
import 'package:etutor/services/authentication_service.dart';
import 'package:etutor/services/http_service.dart';
import 'package:flutter/material.dart';

abstract class AccountService {
  static Account currentAccount;

  static String local = 'http://10.0.0.2:8080/ETutor/api';

  static Future<Account> getAccountBalance(BuildContext context) async {
    return HttpService.getWithAuth(
      context,
      '$local/account/balance',
    ).then((response) {
      if (currentAccount == null) {
        currentAccount = Account();
      }
      currentAccount.setBalance(response);
      AuthenticationService.setBalanceUpdated(false);
      return currentAccount;
    });
  }

  static Future<Account> getAccountTransactionHistory(
      BuildContext context) async {
    return HttpService.getWithAuth(
      context,
      '$local/user-transaction/history',
    ).then((response) {
      if (currentAccount == null) {
        currentAccount = Account();
      }
      currentAccount.setTransactionHistoryFromJson(response);
      AuthenticationService.setHistoryUpdatedFalse();
      return currentAccount;
    });
  }

  static Future<bool> topupMoney(
      BuildContext context, String topupAmount) async {
    print('topupAmount: $topupAmount');
    return HttpService.postWithAuth(
      context,
      '$local/user-transaction/top-up',
      model: topupAmount,
    ).then((response) {
      return true;
    });
  }

  static Future<bool> withdrawMoney(
      BuildContext context, String withdrawAmount) async {
    print('withdrawAmount: $withdrawAmount');
    return HttpService.postWithAuth(
      context,
      '$local/user-transaction/withdraw-money',
      model: withdrawAmount,
    ).then((response) {
      return true;
    });
  }

  static String getStringCurrencyFormatted(String numStr) {
    if (numStr == null || numStr.isEmpty) {
      return '0';
    }
    String current = numStr;
    String result = '';
    while (current.length > 3) {
      result = '.${current.substring(current.length - 3)}$result';
      current = current.substring(0, current.length - 3);
    }
    result = '$current$result';
    return result;
  }
}
