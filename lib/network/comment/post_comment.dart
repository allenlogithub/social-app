import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import 'package:social_app/config/config.dart';
import 'package:social_app/network/auth/login.dart';

class PostCommentResponse {
  String err;
  dynamic message;

  PostCommentResponse({
    required this.err,
    required this.message,
  });

  factory PostCommentResponse.fromJson(Map<String, dynamic> json) =>
      new PostCommentResponse(
        err: json["err"] == null ? "" : json["err"],
        message: json["message"] == null ? null : json["message"],
      );
}

Future<PostCommentResponse> postCommentRequest(
    String content, int articleId) async {
  Response response;
  var options = BaseOptions(
    baseUrl: server_domain['post'],
    connectTimeout: 500,
    receiveTimeout: 300,
  );
  var dio = Dio(options);
  dio.interceptors.add(CookieManager(cookieJar));
  try {
    response = await dio.post('/v1/post/articlecomment', data: {
      "Content": content,
      "ArticleId": articleId,
    });
    final jsonData = response.data;
    PostCommentResponse postCommentResponse =
        PostCommentResponse.fromJson(Map<String, dynamic>.from(jsonData));
    return postCommentResponse;
  } catch (e) {
    if (e is DioError) {
      return PostCommentResponse(
          err: "PostCommentError", message: e.toString());
    }
    return PostCommentResponse(
        err: "UnknownPostCommentError", message: e.toString());
  }
}
