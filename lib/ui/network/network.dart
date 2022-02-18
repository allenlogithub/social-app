import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:social_app/widgets/network/myNetwork.dart';
import 'package:social_app/network/connection/searchUser.dart';

class Network extends StatefulWidget {
  const Network({Key? key}) : super(key: key);

  @override
  _NetworkState createState() => _NetworkState();
}

class _NetworkState extends State<Network> {
  final TextEditingController _searchController = TextEditingController();
  late Future<SearchUserResponse> futureSearchUserResponse;

  void _searchUser(String s) {
    if (s.length > 1) {
      futureSearchUserResponse = searchUserRequest(s);
    }
    _searchController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white70,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0))),
                    height: 40,
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          //same action as TextField.onSubmitted
                          icon: const Icon(Icons.search),
                          iconSize: 30,
                          onPressed: () {
                            _searchUser(_searchController.text);
                          },
                        ),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            decoration: const InputDecoration.collapsed(
                              hintText: " Search connections?",
                            ),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 20,
                            ),
                            onSubmitted: (value) {
                              // same action as IconButton
                              _searchUser(value);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      print("Tapped on My Network");
                      Get.to(() => MyNetwork());
                    },
                    child: Row(
                      children: const <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "My Network",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 30.0,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      print("Tapped Invitations");
                    },
                    child: Row(
                      children: const <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Invitations",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 30.0,
                        ),
                        SizedBox(
                          height: 10,
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
          )),
    );
  }
}
