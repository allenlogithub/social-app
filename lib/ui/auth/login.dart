import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import 'package:social_app/widgets/navigation/back.dart';
import 'package:social_app/network/auth/login.dart';
import 'package:social_app/ui/self_post/self_post.dart';

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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const <Widget>[
            SizedBox(
              height: 40,
              width: 40,
              child: NavigationBack(),
            ),
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text("Login",
                        style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
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
                          decoration:
                              const InputDecoration(hintText: 'PASSWORD'),
                        )),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          Future<LoginResponse> result = LoginRequest(
                              widget.account, _passwordController.text);
                          result.then((value) {
                            if (value.err == "") {
                              Get.to(() => SelfArticlePost());
                            } else {
                              print("value.err: " + value.err.toString());
                              print(
                                  "value.message: " + value.message.toString());
                            }
                          });
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.amber),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                    side: const BorderSide(
                                        color: Colors.amber)))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.account_box_rounded,
                                color: Colors.white),
                            Text('   Login',
                                style: GoogleFonts.lato(
                                    fontSize: 20, color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 1000,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
