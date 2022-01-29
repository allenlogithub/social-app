import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import 'package:social_app/ui/auth/email_address.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned(
            bottom: 150,
            left: 40,
            child: SizedBox(
              width: 300,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Let's share\n        your memory.",
                        style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 80),
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                          onPressed: () {
                            Get.to(() => const EmailAddress());
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.amber),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                      side: const BorderSide(
                                          color: Colors.amber)))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Continue with Email',
                                style: GoogleFonts.lato(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ],
                          )),
                    )
                  ]),
            )),
      ]),
    );
  }
}
