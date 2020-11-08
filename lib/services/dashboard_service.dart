import 'package:etutor/data/dashboard_model.dart';
import 'package:etutor/services/authentication_service.dart';
import 'package:etutor/services/http_service.dart';
import 'package:flutter/material.dart';

abstract class DashboardService {
  static List<DashboardGroup> currentListDashboardGroup;

  static String local = 'https://etutorapisp.azurewebsites.net/etutor/api';
  static Future<List<DashboardGroup>> getDashboard(BuildContext context) async {
    return HttpService.getWithAuth(
      context,
      '$local/dashboard',
    ).then((response) {
      AuthenticationService.setDashboardLatestLoad();
      currentListDashboardGroup = response
          .map<DashboardGroup>((e) => DashboardGroup.fromJson(e))
          .toList();
      return currentListDashboardGroup;
    });
  }
}
