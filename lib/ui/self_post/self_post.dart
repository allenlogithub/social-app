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
  final TextEditingController _newSelfArticleContent = TextEditingController();
  var dropdownValue;

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
          // if no article found
          if (arts.isEmpty) {
            return Scaffold(
              body: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            'Start Your Frist Post.',
                            style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                          Column(
                            children: <Widget>[
                              Card(
                                color: Colors.grey,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    maxLines: 8,
                                    decoration: const InputDecoration.collapsed(
                                        hintText: "Enter your post here."),
                                    controller: _newSelfArticleContent,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                  child: Center(
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: dropdownValue,
                                    icon: const Icon(
                                        Icons.arrow_drop_down_circle),
                                    elevation: 5,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownValue = newValue!;
                                      });
                                    },
                                    hint: const Text("Scope"),
                                    items: <String>['Global', 'Self']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              )),
                              Expanded(
                                  child: Center(
                                child: ElevatedButton(
                                    onPressed: () {
                                      // Future<SelfArticlePostResponse> post = SelfArticlePostRequest(

                                      // ),
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.amber),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          side: const BorderSide(
                                            color: Colors.amber,
                                          ),
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Post',
                                          style: GoogleFonts.lato(
                                            fontSize: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    )),
                              )),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          // if article found
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
                                Text(cmt['userName']),
                                Text(cmt['comment']),
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
