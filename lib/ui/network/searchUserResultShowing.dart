import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:social_app/network/connection/searchUser.dart';
import 'package:social_app/widgets/navigation/back.dart';

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
                    return Row(
                      children: <Widget>[
                        const Icon(
                          Icons.person,
                          size: 120.0,
                        ),
                        Text(
                          user['userName'],
                          style: GoogleFonts.lato(
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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
