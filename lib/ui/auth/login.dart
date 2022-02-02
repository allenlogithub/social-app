import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// import 'package:social_app/network/auth/signup.dart';

class Login extends StatefulWidget {
  const Login({
    Key? key,
  }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Your Account",
                      style: GoogleFonts.lato(
                          color: Colors.white70,
                          fontSize: 10,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                      width: 280,
                      child: TextField(
                        controller: _accountController,
                        autocorrect: true,
                        decoration: const InputDecoration(hintText: 'ACCOUNT'),
                      )),
                  const SizedBox(height: 20),
                  Text("Your Password",
                      style: GoogleFonts.lato(
                          color: Colors.white70,
                          fontSize: 10,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                      width: 280,
                      child: TextField(
                        controller: _passwordController,
                        autocorrect: true,
                        decoration: const InputDecoration(hintText: 'PASSWORD'),
                      )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
