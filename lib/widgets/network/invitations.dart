import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:social_app/network/connection/getFriendRequestList.dart';
import 'package:social_app/widgets/navigation/back.dart';

class Invitations extends StatefulWidget {
  const Invitations({Key? key}) : super(key: key);

  @override
  _InvitationsState createState() => _InvitationsState();
}

class _InvitationsState extends State<Invitations> {
  late Future<GetFriendRequestListResponse> futureGetFriendRequestListResponse;
  List<Color> _acceptInvitationIconButtonColor = [];
  List<Color> _rejectInvitationIconButtonColor = [];

  @override
  void initState() {
    super.initState();
    futureGetFriendRequestListResponse = getFriendRequestListRequest();
    futureGetFriendRequestListResponse.then((value) {
      List<dynamic> data = value.message ?? [];
      _acceptInvitationIconButtonColor =
          List<Color>.filled(data.length, Colors.green.shade300);
      _rejectInvitationIconButtonColor =
          List<Color>.filled(data.length, Colors.red.shade300);
    });
  }

  Future<void> _pullRefresh() async {
    setState(() {
      futureGetFriendRequestListResponse = getFriendRequestListRequest();
    });
  }

  void _viewUser(int userId) {
    print("viewed");
    print(userId);
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
        child: FutureBuilder<GetFriendRequestListResponse>(
          future: futureGetFriendRequestListResponse,
          builder: (context, snapshot) {
            List<dynamic> requests = snapshot.data?.message ?? [];
            if (requests.isEmpty) {
              return Center(
                child: Text(
                  "Empty Request List",
                  style: GoogleFonts.lato(
                    fontSize: 30,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: _pullRefresh,
              child: ListView.builder(
                  itemCount: requests.length,
                  itemBuilder: (context, index) {
                    final request = requests[index];
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
                              child: Row(
                            children: <Widget>[
                              Text(
                                request['userName'],
                                style: GoogleFonts.lato(
                                  fontSize: 40,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    _rejectInvitationIconButtonColor[index] =
                                        Colors.grey;
                                    _acceptInvitationIconButtonColor[index] =
                                        Colors.grey;
                                  });
                                },
                                iconSize: 40,
                                color: _rejectInvitationIconButtonColor[index],
                                icon: const Icon(Icons.cancel_outlined),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    _rejectInvitationIconButtonColor[index] =
                                        Colors.grey;
                                    _acceptInvitationIconButtonColor[index] =
                                        Colors.grey;
                                  });
                                },
                                iconSize: 40,
                                color: _acceptInvitationIconButtonColor[index],
                                icon: const Icon(Icons.check_circle_outline),
                              ),
                            ],
                          ))
                        ],
                      ),
                    );
                  }),
            );
          },
        ),
      ),
    );
  }
}
