import 'package:etutor/data/notification_model.dart';
import 'package:etutor/services/authentication_service.dart';
import 'package:etutor/services/http_service.dart';
import 'package:flutter/material.dart';

abstract class NotificationService {
  static List<NotificationItem> currentListNotificationItems;

  static String local = 'https://etutorapisp.azurewebsites.net/etutor/api';
  static Future<List<NotificationItem>> getListNotificationItems(
      BuildContext context, String topic) async {
    return HttpService.getWithAuth(
      context,
      '$local/notification/$topic',
    ).then((response) {
      AuthenticationService.setNotificationUpdated(false);
      currentListNotificationItems = response
          .map<NotificationItem>((e) => NotificationItem.fromJson(e))
          .toList();
      return currentListNotificationItems;
    });
  }

  static Future<bool> notifyToTopic(
      BuildContext context, NotificationItemCM notiCM) async {
    return HttpService.postWithAuth(
      context,
      '$local/notification/data',
      model: notiCM,
    ).then((response) {
      return response != null;
    });
  }
}
