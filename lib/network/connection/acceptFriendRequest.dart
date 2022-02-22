import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import 'package:social_app/config/config.dart';
import 'package:social_app/network/auth/login.dart';

class AcceptFriendRequestResponse {
  String err;
  dynamic message;

  AcceptFriendRequestResponse({
    required this.err,
    required this.message,
  });

  factory AcceptFriendRequestResponse.fromJson(Map<String, dynamic> json) =>
      new AcceptFriendRequestResponse(
        err: json["err"] ?? "",
        message: json["message"]["items"],
      );
}

Future<AcceptFriendRequestResponse> acceptFriendRequest(
    int requestorUserId) async {
  Response response;
  var options = BaseOptions(
    baseUrl: server_domain['user'],
    connectTimeout: 500,
    receiveTimeout: 300,
  );
  var dio = Dio(options);
  dio.interceptors.add(CookieManager(cookieJar));
  try {
    response = await dio.post('/v1/user/acceptfriendrequest', data: {
      "RequestorUserId": requestorUserId,
    });
    final jsonData = response.data;
    AcceptFriendRequestResponse acceptFriendRequestResponse =
        AcceptFriendRequestResponse.fromJson(
            Map<String, dynamic>.from(jsonData));
    return acceptFriendRequestResponse;
  } catch (e) {
    if (e is DioError) {
      return AcceptFriendRequestResponse(
          err: "AcceptFriendRequestError", message: e.toString());
    }
    return AcceptFriendRequestResponse(
        err: "UnknownAcceptFriendRequestError", message: e.toString());
  }
}
