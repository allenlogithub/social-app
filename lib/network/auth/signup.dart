import 'package:dio/dio.dart';

import 'package:social_app/config/config.dart';

void RegisterRequest(String name, String account, String password,
    String confirm_password) async {
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
      "confirm_password": confirm_password,
    });
    print(response.data.toString());
  } catch (e) {
    if (e is DioError) {
      print(e.response);
    }
  }
}
