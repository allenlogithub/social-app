import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:social_app/network/article/get_self_article_post.dart';

class SelfArticlePost extends StatefulWidget {
  const SelfArticlePost({Key? key}) : super(key: key);

  @override
  _SelfArticlePostState createState() => _SelfArticlePostState();
}

class _SelfArticlePostState extends State<SelfArticlePost> {
  late Future<GetSelfArticleResponse> futureGetSelfArticleResponse;

  @override
  void initState() {
    super.initState();
    futureGetSelfArticleResponse = getSelfArticleRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<GetSelfArticleResponse>(
        future: futureGetSelfArticleResponse,
        builder: (context, snapshot) {
          List<dynamic> arts = snapshot.data?.message ?? [];
          if (arts.isEmpty) {
            return Container(
                // add sth
                );
          }
          return ListView.builder(
              itemCount: arts.length,
              itemBuilder: (context, index) {
                final art = arts[index];
                if (art['items'] == null) {
                  return Card(
                    child: Column(
                      children: <Widget>[Text(art['content'])],
                    ),
                  );
                }
                return Card(
                  child: Column(
                    children: <Widget>[
                      Text(art['content']),
                      ListView.builder(
                          itemCount: art['items'].length,
                          // physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, cmtIndex) {
                            final cmt = art['items'][cmtIndex];
                            return Card(
                                child: Column(
                              children: <Widget>[
                                Text(cmt['userName'].toString()),
                                Text(cmt['comment'].toString()),
                              ],
                            ));
                          }),
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}
