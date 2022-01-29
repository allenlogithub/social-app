import 'package:flutter/material.dart';

import 'package:social_app/widgets/navigation/back_button.dart';

class NavigationBack extends StatelessWidget {
  const NavigationBack({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AppBackButton();
  }
}
