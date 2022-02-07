import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import 'package:social_app/config/config.dart';
import 'package:social_app/network/auth/login.dart';

class GetSelfArticleResponse {
  String err;
  dynamic message;

  GetSelfArticleResponse({
    required this.err,
    required this.message,
  });

  factory GetSelfArticleResponse.fromJson(Map<String, dynamic> json) =>
      GetSelfArticleResponse(
        err: json["err"] ?? "",
        message: json["message"]["items"],
      );
}

Future<GetSelfArticleResponse> getSelfArticleRequest() async {
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
    response = await dio.get('/v1/post/personalarticle');
    final jsonData = response.data;
    GetSelfArticleResponse getSelfArticleResponse =
        GetSelfArticleResponse.fromJson(Map<String, dynamic>.from(jsonData));
    return getSelfArticleResponse;
  } catch (e) {
    if (e is DioError) {
      return GetSelfArticleResponse(
          err: "GetSelfArticleResponseError", message: e.toString());
    }
    return GetSelfArticleResponse(
        err: "UnknownGetSelfArticleResponseError", message: e.toString());
  }
}
