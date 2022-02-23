import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:social_app/widgets/articles/getHomeArticles.dart';
import 'package:social_app/widgets/self_post/articlePosting.dart';
import 'package:social_app/ui/network/network.dart';
import 'package:social_app/widgets/auth/logout.dart';

class MainTabbar extends StatefulWidget {
  const MainTabbar({
    Key? key,
  }) : super(key: key);

  @override
  _MainTabbarState createState() => _MainTabbarState();
}

class _MainTabbarState extends State<MainTabbar> {
  int _bottomNavigationBarIndex = 0;

  void _bottomNavigationBarTapped(int index) {
    setState(() {
      _bottomNavigationBarIndex = index;
    });
  }

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
              child: Icon(Icons.list_rounded),
            ),
            Spacer(),
            LogoutButton(),
          ],
        ),
      ),
      body: IndexedStack(
        index: _bottomNavigationBarIndex,
        children: <Widget>[
          Home(),
          ArticlePosting(),
          Network(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Post'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Network'),
        ],
        currentIndex: _bottomNavigationBarIndex,
        onTap: _bottomNavigationBarTapped,
        fixedColor: Colors.amber,
      ),
    );
  }
}
