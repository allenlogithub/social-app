import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  final String account;
  const Login({Key? key, required this.account}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
                  const SizedBox(height: 80),
                  Text("Login",
                      style: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 40),
                  RichText(
                    text: TextSpan(
                      text: 'Using  ',
                      style: GoogleFonts.lato(color: Colors.green),
                      children: <TextSpan>[
                        TextSpan(
                          text: widget.account,
                          style: GoogleFonts.lato(
                            color: Colors.white70,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        TextSpan(
                            text: "  to login.",
                            style: GoogleFonts.lato(color: Colors.green)),
                      ],
                    ),
                  ),
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
