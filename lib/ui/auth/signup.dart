import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:social_app/widgets/navigation/back.dart';

class SignUp extends StatefulWidget {
  final String email;
  const SignUp({Key? key, required this.email}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const NavigationBack(),
                  const SizedBox(height: 40),
                  Text('Sign Up',
                      style: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      text: 'Using  ',
                      style: GoogleFonts.lato(color: Colors.green),
                      children: <TextSpan>[
                        TextSpan(
                            text: widget.email,
                            style: const TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: "  to login.",
                            style: GoogleFonts.lato(color: Colors.green)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
