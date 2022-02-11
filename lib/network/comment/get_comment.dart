import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import 'package:social_app/config/config.dart';
import 'package:social_app/network/auth/login.dart';

class GetCommentResponse {
  String err;
  dynamic message;

  GetCommentResponse({
    required this.err,
    required this.message,
  });

  factory GetCommentResponse.fromJson(Map<String, dynamic> json) =>
      new GetCommentResponse(
        err: json["err"] == null ? "" : json["err"],
        message: json["message"] == null ? null : json["message"],
      );
}

Future<GetCommentResponse> getCommentRequest(int articleId) async {
  Response response;
  var options = BaseOptions(
    baseUrl: server_domain['post'],
    connectTimeout: 500,
    receiveTimeout: 300,
  );
  var dio = Dio(options);
  dio.interceptors.add(CookieManager(cookieJar));
  try {
    response = await dio
        .get('/v1/post/articlecomment?articleid=' + articleId.toString());
    final jsonData = response.data;
    GetCommentResponse getCommentResponse =
        GetCommentResponse.fromJson(Map<String, dynamic>.from(jsonData));
    return getCommentResponse;
  } catch (e) {
    if (e is DioError) {
      return GetCommentResponse(err: "GetCommentError", message: e.toString());
    }
    return GetCommentResponse(
        err: "UnknownGetCommentError", message: e.toString());
  }
}
