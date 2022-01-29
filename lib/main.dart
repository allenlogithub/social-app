// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:social_app/ui/auth/signup.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Hello Flutter',
      theme: ThemeData(
        brightness: Brightness.dark,
        // primaryColor: Colors.lightBlue[800],
      ),
      home: const SignUp(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}
