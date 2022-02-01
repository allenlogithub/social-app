import 'package:flutter/material.dart';

import 'package:social_app/network/auth/signup.dart';

class Login extends StatefulWidget {
  final String name;
  final String account;
  final String password;
  final String passwordAgain;
  const Login({
    Key? key,
    required this.name,
    required this.account,
    required this.password,
    required this.passwordAgain,
  }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    print(widget.name);
    print(widget.account);
    print(widget.password);
    print(widget.passwordAgain);
    RegisterRequest(
        widget.name, widget.account, widget.password, widget.passwordAgain);
    return Container();
  }
}
