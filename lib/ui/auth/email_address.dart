import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import 'package:social_app/widgets/navigation/back.dart';
import 'package:social_app/ui/auth/signup.dart';

class EmailAddress extends StatefulWidget {
  const EmailAddress({Key? key}) : super(key: key);

  @override
  _EmailAddressState createState() => _EmailAddressState();
}

class _EmailAddressState extends State<EmailAddress> {
  final TextEditingController _emailController = TextEditingController();
  bool obscureText = false;

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
                  Text("What's your\nemail\naddress?",
                      style: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  Container(
                      width: 280,
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        controller: _emailController,
                        autocorrect: true,
                        decoration:
                            const InputDecoration(hintText: 'Enter Email Here'),
                      )),
                  SizedBox(
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => SignUp(email: _emailController.text));
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.amber),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                      side: const BorderSide(
                                          color: Colors.amber)))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.email, color: Colors.white),
                          Text('   Continue with Email',
                              style: GoogleFonts.lato(
                                  fontSize: 20, color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        // ),
      ),
    );
  }
}
