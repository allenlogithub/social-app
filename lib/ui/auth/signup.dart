import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import 'package:social_app/widgets/navigation/back.dart';
import 'package:social_app/ui/auth/login.dart';
import 'package:social_app/network/auth/signup.dart';

class SignUp extends StatefulWidget {
  final String email;
  const SignUp({Key? key, required this.email}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordAgainController =
      TextEditingController();
  // late Future<RegisterResponse> Register;

  // @override
  // void initState() {
  //   super.initState();
  //   Register = RegisterRequest(_nameController.text, widget.email,
  //       _passwordController.text, _passwordAgainController.text);
  // }

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
                  const NavigationBack(),
                  const SizedBox(height: 20),
                  Text('Sign Up',
                      style: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      text: 'Using  ',
                      style: GoogleFonts.lato(color: Colors.green),
                      children: <TextSpan>[
                        TextSpan(
                          text: widget.email,
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
                  Text("Your Name",
                      style: GoogleFonts.lato(
                          color: Colors.white70,
                          fontSize: 10,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                      width: 280,
                      child: TextField(
                        controller: _nameController,
                        autocorrect: true,
                        decoration: const InputDecoration(hintText: 'NAME'),
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
                  const SizedBox(height: 20),
                  Text("Your Password Again to Confirm",
                      style: GoogleFonts.lato(
                          color: Colors.white70,
                          fontSize: 10,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                      width: 280,
                      child: TextField(
                        controller: _passwordAgainController,
                        autocorrect: true,
                        decoration:
                            const InputDecoration(hintText: 'PASSWORD AGAIN'),
                      )),
                  const SizedBox(height: 20),
                  // FutureBuilder<RegisterResponse>(
                  //     future: Register,
                  //     builder: (context, snapshot) {
                  //       if (snapshot.hasData) {
                  //         return Text(snapshot.data!.message);
                  //       } else if (snapshot.hasError) {
                  //         return Text('${snapshot.error}');
                  //       }

                  //       // By default, show a loading spinner.
                  //       return const CircularProgressIndicator();
                  //     }),
                  SizedBox(
                    height: 60,
                    child: ElevatedButton(
                      // onPressed: () {
                      //   Get.to(() => Login(
                      //         name: _nameController.text,
                      //         account: widget.email,
                      //         password: _passwordController.text,
                      //         passwordAgain: _passwordAgainController.text,
                      //       ));
                      // },
                      // onPressed: () {
                      //   FutureBuilder<RegisterResponse>(
                      //       future: Register,
                      //       builder: (context, snapshot) {
                      //         if (snapshot.hasData) {
                      //           return Text(snapshot.data!.message);
                      //         } else if (snapshot.hasError) {
                      //           return Text('${snapshot.error}');
                      //         }

                      //         // By default, show a loading spinner.
                      //         return const CircularProgressIndicator();
                      //       });
                      // },
                      onPressed: () {
                        Future<RegisterResponse> result = RegisterRequest(
                            _nameController.text,
                            widget.email,
                            _passwordController.text,
                            _passwordAgainController.text);
                        result.then((value) {
                          if (value.err == "") {
                            print("registerSuccess");
                            print(value.message["success"]);
                          } else {
                            print("value.err: " + value.err.toString());
                            print("value.message: " + value.message.toString());
                          }
                        });
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
                          Text('Sign Up',
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
      ),
    );
  }
}
