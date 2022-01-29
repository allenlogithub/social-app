// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:social_app/ui/auth/signup.dart';
import 'package:social_app/ui/splash_screen/splash_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 3)),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: SplashPage(),
            debugShowCheckedModeBanner: false,
          );
        } else {
          return GetMaterialApp(
            title: 'Hello Flutter',
            theme: ThemeData(
              brightness: Brightness.dark,
            ),
            home: const SignUp(title: 'Flutter Demo Home Page'),
            debugShowCheckedModeBanner: false,
          );
        }
      },
    );
  }
}
