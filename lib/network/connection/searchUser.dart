import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import 'package:social_app/config/config.dart';
import 'package:social_app/network/auth/login.dart';

class SearchUserResponse {
  String err;
  dynamic message;

  SearchUserResponse({
    required this.err,
    required this.message,
  });

  factory SearchUserResponse.fromJson(Map<String, dynamic> json) =>
      new SearchUserResponse(
        err: json["err"] ?? "",
        message: json["message"]["items"],
      );
}

Future<SearchUserResponse> searchUserRequest(String userString) async {
  Response response;
  var options = BaseOptions(
    baseUrl: server_domain['user'],
    connectTimeout: 500,
    receiveTimeout: 300,
  );
  var dio = Dio(options);
  dio.interceptors.add(CookieManager(cookieJar));
  try {
    response = await dio.get('/v1/user/searchuser?SearchString=' + userString);
    final jsonData = response.data;
    SearchUserResponse searchUserResponse =
        SearchUserResponse.fromJson(Map<String, dynamic>.from(jsonData));
    return searchUserResponse;
  } catch (e) {
    if (e is DioError) {
      return SearchUserResponse(err: "SearchUserError", message: e.toString());
    }
    return SearchUserResponse(
        err: "UnknownSearchUserError", message: e.toString());
  }
}
