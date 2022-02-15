import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import 'package:social_app/network/article/get_self_article_post.dart';
import 'package:social_app/network/article/post_self_article.dart';
import 'package:social_app/ui/post/article.dart';
import 'package:social_app/widgets/self_post/commentTextField.dart';

class SelfArticlePost extends StatefulWidget {
  const SelfArticlePost({
    Key? key,
  }) : super(key: key);

  @override
  _SelfArticlePostState createState() => _SelfArticlePostState();
}

class _SelfArticlePostState extends State<SelfArticlePost> {
  late Future<GetSelfArticleResponse> futureGetSelfArticleResponse;
  final TextEditingController _newSelfArticleContent = TextEditingController();
  var dropdownValue;
  late bool _isPostButtonEnabled;

  @override
  void initState() {
    super.initState();
    _isPostButtonEnabled = false;
    futureGetSelfArticleResponse = getSelfArticleRequest();
  }

  void updateComments(int index, dynamic comments) {
    setState(() {
      futureGetSelfArticleResponse.then((value) {
        value.message[index]['items'] = comments;
      });
    });
  }

  bool _postButtonDisableController() {
    if (dropdownValue != null && _newSelfArticleContent.text != "") {
      setState(() {
        _isPostButtonEnabled = true;
      });
    } else {
      setState(() {
        _isPostButtonEnabled = false;
      });
    }

    return _isPostButtonEnabled;
  }

  void _resetTextField() {
    setState(() {
      _newSelfArticleContent.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      'Sharing',
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
                                  hintText: "What Are You Thinking?"),
                              controller: _newSelfArticleContent,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              onChanged: (value) =>
                                  _postButtonDisableController(),
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
                              icon: const Icon(Icons.arrow_drop_down_circle),
                              elevation: 5,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                  _postButtonDisableController();
                                });
                              },
                              hint: const Text("Scope"),
                              items: <String>[
                                'Global',
                                'Self'
                              ].map<DropdownMenuItem<String>>((String value) {
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
                              onPressed: _isPostButtonEnabled
                                  ? () {
                                      if (_isPostButtonEnabled) {
                                        Future<PostSelfArticleResponse> result =
                                            postSelfArticleRequest(
                                                dropdownValue,
                                                _newSelfArticleContent.text);
                                        result.then((then) {
                                          setState(() {
                                            futureGetSelfArticleResponse =
                                                getSelfArticleRequest();
                                          });
                                        });
                                        _resetTextField();
                                      }
                                    }
                                  : null,
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        _isPostButtonEnabled == true
                                            ? Colors.amber
                                            : Colors.grey),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                    side: const BorderSide(
                                      color: Colors.amber,
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: FutureBuilder<GetSelfArticleResponse>(
                  future: futureGetSelfArticleResponse,
                  builder: (context, snapshot) {
                    List<dynamic> arts = snapshot.data?.message ?? [];
                    if (arts.isEmpty) {
                      return Column();
                    }
                    return ListView.builder(
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
                                              notifyCommentsUpdated:
                                                  updateComments,
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
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                            side: const BorderSide(
                                              color: Color(0xFF827717),
                                              width: 2.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                        });
                  }),
            )),
            CommentTextInput(
              notifyCommentsUpdated: updateComments,
              articleId: -1,
              index: -1,
              refresh: (bool refresh) {},
            ),
          ],
        ),
      ),
    );
  }
}
