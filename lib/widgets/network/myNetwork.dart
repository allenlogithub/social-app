import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:social_app/network/connection/getConnectionList.dart';
import 'package:social_app/widgets/navigation/back.dart';

class MyNetwork extends StatefulWidget {
  const MyNetwork({Key? key}) : super(key: key);

  @override
  _MyNetworkState createState() => _MyNetworkState();
}

class _MyNetworkState extends State<MyNetwork> {
  late Future<GetFriendListResponse> futureGetFriendListResponse;

  @override
  void initState() {
    super.initState();
    futureGetFriendListResponse = getFriendListRequest();
  }

  Future<void> _pullRefresh() async {
    setState(() {
      futureGetFriendListResponse = getFriendListRequest();
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
        child: FutureBuilder<GetFriendListResponse>(
            future: futureGetFriendListResponse,
            builder: (context, snapshot) {
              List<dynamic> friends = snapshot.data?.message ?? [];
              if (friends.isEmpty) {
                return const Text("Empty Friend List");
              }
              return RefreshIndicator(
                onRefresh: _pullRefresh,
                child: ListView.builder(
                    itemCount: friends.length,
                    itemBuilder: (context, index) {
                      final friend = friends[index];
                      return Row(
                        children: <Widget>[
                          const Icon(
                            Icons.person,
                            size: 120.0,
                          ),
                          Text(
                            friend['friendUserName'],
                            style: GoogleFonts.lato(
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      );
                    }),
              );
            }),
      ),
    );
  }
}
