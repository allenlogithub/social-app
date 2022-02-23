import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import 'package:social_app/config/config.dart';
import 'package:social_app/network/auth/login.dart';

class LogoutResponse {
  String err;
  dynamic message;

  LogoutResponse({
    required this.err,
    required this.message,
  });

  factory LogoutResponse.fromJson(Map<String, dynamic> json) =>
      new LogoutResponse(
        err: json["err"] ?? "",
        message: json["message"],
      );
}

Future<LogoutResponse> logoutResponseRequest() async {
  Response response;
  var options = BaseOptions(
    baseUrl: server_domain['user'],
    connectTimeout: 500,
    receiveTimeout: 300,
  );
  var dio = Dio(options);
  dio.interceptors.add(CookieManager(cookieJar));
  try {
    response = await dio.post('/v1/user/logout');
    final jsonData = response.data;
    LogoutResponse logoutResponse =
        LogoutResponse.fromJson(Map<String, dynamic>.from(jsonData));
    return logoutResponse;
  } catch (e) {
    if (e is DioError) {
      return LogoutResponse(
          err: "LogoutResponseRequestError", message: e.toString());
    }
    return LogoutResponse(
        err: "UnknownLogoutResponseRequestError", message: e.toString());
  }
}
