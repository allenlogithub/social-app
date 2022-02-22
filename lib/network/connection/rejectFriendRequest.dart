import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import 'package:social_app/config/config.dart';
import 'package:social_app/network/auth/login.dart';

class RejectFriendRequestResponse {
  String err;
  dynamic message;

  RejectFriendRequestResponse({
    required this.err,
    required this.message,
  });

  factory RejectFriendRequestResponse.fromJson(Map<String, dynamic> json) =>
      new RejectFriendRequestResponse(
        err: json["err"] ?? "",
        message: json["message"]["items"],
      );
}

Future<RejectFriendRequestResponse> rejectFriendRequest(
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
    response = await dio.delete('/v1/user/rejectfriendrequest', data: {
      "RequestorUserId": requestorUserId,
    });
    final jsonData = response.data;
    RejectFriendRequestResponse rejectFriendRequestResponse =
        RejectFriendRequestResponse.fromJson(
            Map<String, dynamic>.from(jsonData));
    return rejectFriendRequestResponse;
  } catch (e) {
    if (e is DioError) {
      return RejectFriendRequestResponse(
          err: "RejectFriendRequestError", message: e.toString());
    }
    return RejectFriendRequestResponse(
        err: "UnknownRejectFriendRequestError", message: e.toString());
  }
}
