import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import 'package:social_app/network/article/get_self_article_post.dart';
import 'package:social_app/ui/post/article.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<GetSelfArticleResponse> futureGetSelfArticleResponse;

  @override
  void initState() {
    super.initState();
    futureGetSelfArticleResponse = getSelfArticleRequest();
  }

  void updateComments(int index, dynamic comments) {
    setState(() {
      futureGetSelfArticleResponse.then((value) {
        value.message[index]['items'] = comments;
      });
    });
  }

  Future<void> _pullRefresh() async {
    setState(() {
      futureGetSelfArticleResponse = getSelfArticleRequest();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: FutureBuilder<GetSelfArticleResponse>(
          future: futureGetSelfArticleResponse,
          builder: (context, snapshot) {
            List<dynamic> arts = snapshot.data?.message ?? [];
            if (arts.isEmpty) {
              return Column();
            }
            return RefreshIndicator(
              onRefresh: _pullRefresh,
              child: ListView.builder(
                  itemCount: arts.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final art = arts[index];
                    return Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              art['content'],
                              maxLines: 8,
                              style: GoogleFonts.lato(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            ElevatedButton(
                                onPressed: () {
                                  Get.to(() => Article(
                                        notifyCommentsUpdated: updateComments,
                                        article: art,
                                        index: index,
                                      ));
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          const Color(0xFF827717)),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                      side: const BorderSide(
                                        color: Color(0xFF827717),
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'View',
                                      style: GoogleFonts.lato(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    );
                  }),
            );
          }),
    );
  }
}
