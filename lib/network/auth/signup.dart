import 'package:dio/dio.dart';

import 'package:social_app/config/config.dart';

class RegisterResponse {
  String err;
  dynamic message;

  RegisterResponse({
    required this.err,
    required this.message,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      new RegisterResponse(
        err: json["err"] == null ? "" : json["err"],
        message: json["message"] == null ? null : json["message"],
      );

  // Map<String, dynamic> toJson() => {
  //       "err": err == null ? null : err,
  //       "message": message == null ? null : message,
  //     };
}

Future<RegisterResponse> RegisterRequest(String name, String account,
    String password, String confirmPassword) async {
  Response response;
  var options = BaseOptions(
    baseUrl: server_domain['user'],
    connectTimeout: 500,
    receiveTimeout: 300,
  );
  var dio = Dio(options);
  try {
    response = await dio.post('/v1/user/register', data: {
      "name": name,
      "account": account,
      "password": password,
      "confirm_password": confirmPassword,
    });
    final jsonData = response.data;
    RegisterResponse registerResponse =
        RegisterResponse.fromJson(Map<String, dynamic>.from(jsonData));
    return registerResponse;
  } catch (e) {
    if (e is DioError) {
      return RegisterResponse(err: "RegisterError", message: e.toString());
    }
    return RegisterResponse(err: "UnknownRegisterError", message: e.toString());
  }
}
