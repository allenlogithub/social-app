import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';

import 'package:social_app/config/config.dart';

class LoginResponse {
  String err;
  dynamic message;

  LoginResponse({
    required this.err,
    required this.message,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        err: json["err"] ?? "",
        message: json["message"],
      );
}

var cookieJar;

Future<LoginResponse> LoginRequest(String account, String password) async {
  Response response;
  var options = BaseOptions(
    baseUrl: server_domain['user'],
    connectTimeout: 500,
    receiveTimeout: 300,
  );
  var dio = Dio(options);
  Directory appDocDir = await getApplicationDocumentsDirectory();
  String appDocPath = appDocDir.path;
  cookieJar = PersistCookieJar(
      ignoreExpires: true, storage: FileStorage(appDocPath + "/.cookies/"));
  dio.interceptors.add(CookieManager(cookieJar));
  try {
    response = await dio.post('/v1/user/login', data: {
      "account": account,
      "password": password,
    });
    final jsonData = response.data;
    LoginResponse loginResponse =
        LoginResponse.fromJson(Map<String, dynamic>.from(jsonData));
    return loginResponse;
  } catch (e) {
    if (e is DioError) {
      return LoginResponse(err: "LoginError", message: e.toString());
    }
    return LoginResponse(err: "UnknownLoginError", message: e.toString());
  }
}
