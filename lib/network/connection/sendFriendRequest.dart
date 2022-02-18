import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import 'package:social_app/config/config.dart';
import 'package:social_app/network/auth/login.dart';

class SendFriendRequestResponse {
  String err;
  dynamic message;

  SendFriendRequestResponse({
    required this.err,
    required this.message,
  });

  factory SendFriendRequestResponse.fromJson(Map<String, dynamic> json) =>
      new SendFriendRequestResponse(
        err: json["err"] ?? "",
        message: json["message"]["items"],
      );
}

Future<SendFriendRequestResponse> sendFriendRequest(int receiverUserId) async {
  Response response;
  var options = BaseOptions(
    baseUrl: server_domain['user'],
    connectTimeout: 500,
    receiveTimeout: 300,
  );
  var dio = Dio(options);
  dio.interceptors.add(CookieManager(cookieJar));
  try {
    response = await dio.post('/v1/user/sendfriendrequest', data: {
      "ReceiverUserId": receiverUserId,
    });
    final jsonData = response.data;
    SendFriendRequestResponse sendFriendRequestResponse =
        SendFriendRequestResponse.fromJson(Map<String, dynamic>.from(jsonData));
    return sendFriendRequestResponse;
  } catch (e) {
    if (e is DioError) {
      return SendFriendRequestResponse(
          err: "SendFriendRequestError", message: e.toString());
    }
    return SendFriendRequestResponse(
        err: "UnknownSendFriendRequestError", message: e.toString());
  }
}
