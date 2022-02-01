// import 'package:dio/dio.dart';

// import 'package:social_app/config/config.dart';

// void RegisterRequest() async {
//   Response response;
//   var options = BaseOptions(
//     baseUrl: server_domain['user'],
//     connectTimeout: 500,
//     receiveTimeout: 300,
//   );
//   var dio = Dio(options);
//   response = await dio.post('/v1/user/register', data: {
//     "name": "allen",
//     "account": "allenlo01301@gmail.com",
//     "password": "123123",
//     "confirm_password": "123123",
//   });
//   print(response.data.toString());
// }
