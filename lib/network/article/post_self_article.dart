import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import 'package:social_app/config/config.dart';
import 'package:social_app/network/auth/login.dart';

class PostSelfArticleResponse {
  String err;
  dynamic message;

  PostSelfArticleResponse({
    required this.err,
    required this.message,
  });

  factory PostSelfArticleResponse.fromJson(Map<String, dynamic> json) =>
      PostSelfArticleResponse(
        err: json["err"] ?? "",
        message: json["message"],
      );
}

Future<PostSelfArticleResponse> postSelfArticleRequest(
    String visibility, String content) async {
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
    response = await dio.post('/v1/post/article', data: {
      "Content": content,
      "Visibility": visibility,
    });
    final jsonData = response.data;
    PostSelfArticleResponse postSelfArticleResponse =
        PostSelfArticleResponse.fromJson(Map<String, dynamic>.from(jsonData));
    return postSelfArticleResponse;
  } catch (e) {
    if (e is DioError) {
      return PostSelfArticleResponse(
          err: "PostSelfArticleResponseError", message: e.toString());
    }
    return PostSelfArticleResponse(
        err: "UnknownPostSelfArticleResponseError", message: e.toString());
  }
}
