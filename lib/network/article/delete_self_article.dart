import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import 'package:social_app/config/config.dart';
import 'package:social_app/network/auth/login.dart';

class DelSelfArticleResponse {
  String err;
  dynamic message;

  DelSelfArticleResponse({
    required this.err,
    required this.message,
  });

  factory DelSelfArticleResponse.fromJson(Map<String, dynamic> json) =>
      DelSelfArticleResponse(
        err: json["err"] ?? "",
        message: json["message"],
      );
}

Future<DelSelfArticleResponse> delSelfArticleRequest(int articleId) async {
  Response response;
  var options = BaseOptions(
    baseUrl: server_domain['post'],
    connectTimeout: 500,
    receiveTimeout: 300,
  );
  var dio = Dio(options);
  dio.interceptors.add(CookieManager(cookieJar));
  dio.interceptors.asMap()[0];
  try {
    response = await dio.delete('/v1/post/article', data: {
      "ArticleId": articleId,
    });
    final jsonData = response.data;
    DelSelfArticleResponse delSelfArticleResponse =
        DelSelfArticleResponse.fromJson(Map<String, dynamic>.from(jsonData));
    return delSelfArticleResponse;
  } catch (e) {
    if (e is DioError) {
      return DelSelfArticleResponse(
          err: "DelSelfArticleResponseError", message: e.toString());
    }
    return DelSelfArticleResponse(
        err: "UnknownDelSelfArticleResponseError", message: e.toString());
  }
}
