import 'package:dio/dio.dart';

import 'package:social_app/config/config.dart';
import 'package:social_app/network/auth/signup.dart';

class LoginResponse {
  String err;
  dynamic message;

  LoginResponse({
    required this.err,
    required this.message,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      new LoginResponse(
        err: json["err"] == null ? "" : json["err"],
        message: json["message"] == null ? null : json["message"],
      );
}

Future<LoginResponse> LoginRequest(String account, String password) async {
  Response response;
  var options = BaseOptions(
    baseUrl: server_domain['user'],
    connectTimeout: 500,
    receiveTimeout: 300,
  );
  var dio = Dio(options);
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
      return LoginResponse(err: "RegisterError", message: e.toString());
    }
    return LoginResponse(err: "UnknownRegisterError", message: e.toString());
  }
}
