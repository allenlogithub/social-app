import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:social_app/network/connection/searchUser.dart';
import 'package:social_app/widgets/navigation/back.dart';
import 'package:social_app/network/connection/sendFriendRequest.dart';

class SearchUserResultShowing extends StatefulWidget {
  final String searchString;
  const SearchUserResultShowing({
    Key? key,
    required this.searchString,
  }) : super(key: key);

  @override
  _SearchUserResultShowingState createState() =>
      _SearchUserResultShowingState();
}

class _SearchUserResultShowingState extends State<SearchUserResultShowing> {
  late Future<SearchUserResponse> futureSearchUserResponse;
  late Future<SendFriendRequestResponse> futureSendFriendRequestResponse;

  @override
  void initState() {
    super.initState();
    futureSearchUserResponse = searchUserRequest(widget.searchString);
  }

  Future<void> _pullRefresh() async {
    if (widget.searchString.length > 1) {
      setState(() {
        futureSearchUserResponse = searchUserRequest(widget.searchString);
      });
    }
  }

  void _viewUser(int userId) {
    print("viewed");
    print(userId);
  }

  void _sendInvitation(int userId) {
    sendFriendRequest(userId).then((value) {
      if (value.err == '') {
        print("accepted!");
      }
      print("value.err:");
      print(value.err);
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
              child: NavigationBack(),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<SearchUserResponse>(
          future: futureSearchUserResponse,
          builder: (context, snapshot) {
            List<dynamic> users = snapshot.data?.message ?? [];
            if (users.isEmpty) {
              return Column();
            }
            return RefreshIndicator(
              child: ListView.builder(
                  itemCount: users.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return SizedBox(
                      height: 100,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Icon(
                            Icons.person,
                            size: 90.0,
                          ),
                          Flexible(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            user['userName'],
                                            style: GoogleFonts.lato(
                                              fontSize: 30,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            onPressed: () {
                                              _viewUser(
                                                user['userId'],
                                              );
                                            },
                                            iconSize: 40,
                                            icon:
                                                const Icon(Icons.manage_search),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              _sendInvitation(
                                                user['userId'],
                                              );
                                            },
                                            iconSize: 40,
                                            color: Colors.blue,
                                            icon: const Icon(
                                                Icons.person_add_alt_1),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "intro......",
                                  style: GoogleFonts.lato(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
              onRefresh: _pullRefresh,
            );
          },
        ),
      ),
    );
  }
}
