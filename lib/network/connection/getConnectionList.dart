import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import 'package:social_app/config/config.dart';
import 'package:social_app/network/auth/login.dart';

class GetFriendListResponse {
  String err;
  dynamic message;

  GetFriendListResponse({
    required this.err,
    required this.message,
  });

  factory GetFriendListResponse.fromJson(Map<String, dynamic> json) =>
      new GetFriendListResponse(
        err: json["err"] ?? "",
        message: json["message"]["items"],
      );
}

Future<GetFriendListResponse> getFriendListRequest() async {
  Response response;
  var options = BaseOptions(
    baseUrl: server_domain['user'],
    connectTimeout: 500,
    receiveTimeout: 300,
  );
  var dio = Dio(options);
  dio.interceptors.add(CookieManager(cookieJar));
  try {
    response = await dio.get('/v1/user/friendlist');
    final jsonData = response.data;
    GetFriendListResponse getFriendListResponse =
        GetFriendListResponse.fromJson(Map<String, dynamic>.from(jsonData));
    return getFriendListResponse;
  } catch (e) {
    if (e is DioError) {
      return GetFriendListResponse(
          err: "GetFriendListError", message: e.toString());
    }
    return GetFriendListResponse(
        err: "UnknownGetFriendListError", message: e.toString());
  }
}
