import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:social_app/network/auth/logout.dart';
import 'package:social_app/ui/auth/email_address.dart';

class LogoutButton extends StatefulWidget {
  const LogoutButton({Key? key}) : super(key: key);

  @override
  _LogoutButtonState createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> {
  late Future<LogoutResponse> futureLogoutResponse;

  void _logout() {
    futureLogoutResponse = logoutResponseRequest();
    futureLogoutResponse.then((value) {
      if (value.err.isEmpty) {
        print("logout successfully");
        Get.to(() => const EmailAddress());
      } else {
        print("logout failed");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        _logout();
      },
      icon: const Icon(Icons.logout),
      color: Colors.white,
    );
  }
}
