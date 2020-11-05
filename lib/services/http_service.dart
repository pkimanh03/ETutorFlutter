import 'dart:convert';
import 'dart:io';

import 'package:etutor/data/auth_model.dart';
import 'package:etutor/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpService {

  /// HttpGet with Authorization
  static Future<dynamic> getWithAuth(BuildContext context, String url, {Map<String, String> headers, bool disableWarning = false}) async {
    final Map<String, String> authHeaders = await HttpService.createAuthoziedHttpHeaders(headers: headers);
    return http.get(
      url,
      headers: authHeaders
    ).then(
      (http.Response response) {
        if (response.statusCode == 200) {
          dynamic responseResult;
          try {
            responseResult = json.decode(response.body ?? 'null') ?? null;
          } catch(e) {
            responseResult = response.body;
          }
          return responseResult;
        } else {
          throw new http.ClientException("GET ${response.statusCode}", response.request.url);
        }
      }
    ).catchError((error) {
      if (error != null && error is http.ClientException && error.message.contains('401') && !disableWarning) {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => AlertDialog(
            title: Text('Session Timeout'),
            content: Text('Your session has expired!'),
            actions: <Widget>[
              RaisedButton(
                color: Colors.white,
                onPressed: () => AuthenticationService.clearToken(context),
                child: Text('OK', style: TextStyle(color: Colors.indigo)),
              ),
            ],
          ),
        );
      }
      throw error;
    });
  }

  /// HttpPost with Authorization
  static Future<dynamic> postWithAuth(BuildContext context, String url, {Map<String, String> headers, dynamic model}) async {
    final Map<String, String> authHeaders = await HttpService.createAuthoziedHttpHeaders(headers: headers);
    String jsonEncoded = json.encode(model ?? 'null');
    return http.post(
      url,
      headers: authHeaders,
      body: jsonEncoded != null ? jsonEncoded.substring(1, jsonEncoded.length - 1).split('\\').join('') : null
    ).then(
      (http.Response response) {
        if (response.statusCode == 200) {
          dynamic responseResult;
          try {
            responseResult = json.decode(response.body ?? 'null') ?? null;
          } catch(e) {
            responseResult = response.body;
          }
          return responseResult;
        } else {
          throw new http.ClientException("POST ${response.statusCode}", response.request.url);
        }
      }
    ).catchError((error) {
      if (error != null && error is http.ClientException && error.message.contains('401')) {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => AlertDialog(
            title: Text('Session Timeout'),
            content: Text('Your session has expired!'),
            actions: <Widget>[
              RaisedButton(
                color: Colors.white,
                onPressed: () => AuthenticationService.clearToken(context),
                child: Text('OK', style: TextStyle(color: Colors.indigo)),
              ),
            ],
          ),
        );
      }
      throw error;
    });
  }

  /// HttpPut with Authorization
  static Future<dynamic> putWithAuth(BuildContext context, String url, {Map<String, String> headers, dynamic model}) async {
    final Map<String, String> authHeaders = await HttpService.createAuthoziedHttpHeaders(headers: headers);
    String jsonEncoded = json.encode(model ?? 'null');
    return http.put(
      url,
      headers: authHeaders,
      body: jsonEncoded != null ? jsonEncoded.substring(1, jsonEncoded.length - 1).split('\\').join('') : null
    ).then(
      (http.Response response) {
        if (response.statusCode == 200) {
          dynamic responseResult;
          try {
            responseResult = json.decode(response.body ?? 'null') ?? null;
          } catch(e) {
            responseResult = response.body;
          }
          return responseResult;
        } else {
          throw new http.ClientException("PUT ${response.statusCode}", response.request.url);
        }
      }
    ).catchError((error) {
      if (error != null && error is http.ClientException && error.message.contains('401')) {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => AlertDialog(
            title: Text('Session Timeout'),
            content: Text('Your session has expired!'),
            actions: <Widget>[
              RaisedButton(
                color: Colors.white,
                onPressed: () => AuthenticationService.clearToken(context),
                child: Text('OK', style: TextStyle(color: Colors.indigo)),
              ),
            ],
          ),
        );
      }
      throw error;
    });
  }

  /// HttpDelete with Authorization
  static Future<dynamic> deleteWithAuth(BuildContext context, String url, {Map<String, String> headers}) async {
    final Map<String, String> authHeaders = await HttpService.createAuthoziedHttpHeaders(headers: headers);
    return http.delete(
      url,
      headers: authHeaders
    ).then(
      (http.Response response) {
        if (response.statusCode == 200) {
          dynamic responseResult;
          try {
            responseResult = json.decode(response.body ?? 'null') ?? null;
          } catch(e) {
            responseResult = response.body;
          }
          return responseResult;
        } else {
          throw new http.ClientException("DELETE ${response.statusCode}", response.request.url);
        }
      }
    ).catchError((error) {
      if (error != null && error is http.ClientException && error.message.contains('401')) {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => AlertDialog(
            title: Text('Session Timeout'),
            content: Text('Your session has expired!'),
            actions: <Widget>[
              RaisedButton(
                color: Colors.white,
                onPressed: () => AuthenticationService.clearToken(context),
                child: Text('OK', style: TextStyle(color: Colors.indigo)),
              ),
            ],
          ),
        );
      }
      throw error;
    });
  }

  /// Creating HttpHeaders with Authorization header for tokens
  static Future<Map<String, String>> createAuthoziedHttpHeaders({Map<String, String> headers, bool withDelayed = false}) async {
    Map<String, String> resultHeaders = {
      HttpHeaders.contentTypeHeader: "application/json",
    };
    if (headers != null) {
      if (headers.containsKey(HttpHeaders.contentTypeHeader)) {
        resultHeaders.clear();
      }
      resultHeaders.addAll(headers);
    }
    Auth auth = await AuthenticationService.getToken(withDelayed: withDelayed);
    if (auth != null) {
      resultHeaders.addAll({HttpHeaders.authorizationHeader: "${auth.tokenType.value} ${auth.accessToken.value}"});
    }
    return resultHeaders;
  }
}