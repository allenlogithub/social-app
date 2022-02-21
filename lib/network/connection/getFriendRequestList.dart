import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import 'package:social_app/config/config.dart';
import 'package:social_app/network/auth/login.dart';

class GetFriendRequestListResponse {
  String err;
  dynamic message;

  GetFriendRequestListResponse({
    required this.err,
    required this.message,
  });

  factory GetFriendRequestListResponse.fromJson(Map<String, dynamic> json) =>
      new GetFriendRequestListResponse(
        err: json["err"] ?? "",
        message: json["message"]["items"],
      );
}

Future<GetFriendRequestListResponse> getFriendRequestListRequest() async {
  Response response;
  var options = BaseOptions(
    baseUrl: server_domain['user'],
    connectTimeout: 500,
    receiveTimeout: 300,
  );
  var dio = Dio(options);
  dio.interceptors.add(CookieManager(cookieJar));
  try {
    response = await dio.get('/v1/user/friendrequestlist');
    final jsonData = response.data;
    GetFriendRequestListResponse getFriendRequestListResponse =
        GetFriendRequestListResponse.fromJson(
            Map<String, dynamic>.from(jsonData));
    return getFriendRequestListResponse;
  } catch (e) {
    if (e is DioError) {
      return GetFriendRequestListResponse(
          err: "GetFriendRequestListRequestError", message: e.toString());
    }
    return GetFriendRequestListResponse(
        err: "UnknownGetFriendRequestListRequestError", message: e.toString());
  }
}
