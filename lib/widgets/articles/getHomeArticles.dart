import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import 'package:social_app/network/article/get_self_article_post.dart';
import 'package:social_app/network/article/delete_self_article.dart';
import 'package:social_app/ui/post/article.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<GetSelfArticleResponse> futureGetSelfArticleResponse;
  late Future<DelSelfArticleResponse> futureDelSelfArticleResponse;

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

  // Future<void> _removeArticle(int articleId, int index) async {
  void _removeArticle(int articleId, int index) async {
    futureDelSelfArticleResponse = delSelfArticleRequest(articleId);
    futureDelSelfArticleResponse.then((value) {
      if (value.err == '') {
        setState(() {
          futureGetSelfArticleResponse.then((value) {
            value.message.removeAt(index);
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
                        Container(
                          padding: const EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.orangeAccent.shade100,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 20,
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      'from: Self',
                                      style: GoogleFonts.lato(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                        onPressed: () => _removeArticle(
                                            art['articleId'], index),
                                        icon: const Icon(Icons.remove))
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Divider(
                                color: Colors.grey,
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
                              const SizedBox(
                                height: 10,
                              ),
                              const Divider(
                                color: Colors.grey,
                              ),
                              SizedBox(
                                height: 25,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    IconButton(
                                      onPressed: () {
                                        print("no func yet.");
                                      }, //_toArticle(art, index),
                                      icon: const Icon(Icons.crop_square_sharp),
                                      iconSize: 20,
                                      color: Colors.grey,
                                      padding: const EdgeInsets.all(3.0),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Get.to(() => Article(
                                              notifyCommentsUpdated:
                                                  updateComments,
                                              article: art,
                                              index: index,
                                            ));
                                      },
                                      icon: const Icon(Icons.comment_outlined),
                                      iconSize: 20,
                                      color: Colors.grey,
                                      padding: const EdgeInsets.all(3.0),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        print("no func yet.");
                                      }, //_toArticle(art, index),
                                      icon: const Icon(Icons.crop_square_sharp),
                                      iconSize: 20,
                                      color: Colors.grey,
                                      padding: const EdgeInsets.all(3.0),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
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
