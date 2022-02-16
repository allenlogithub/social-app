import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:social_app/network/article/post_self_article.dart';
import 'package:social_app/network/article/get_self_article_post.dart';

class ArticlePosting extends StatefulWidget {
  const ArticlePosting({Key? key}) : super(key: key);

  @override
  _ArticlePostingState createState() => _ArticlePostingState();
}

class _ArticlePostingState extends State<ArticlePosting> {
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
      _isPostButtonEnabled = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  ' Sharing',
                  style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
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
                      onChanged: (value) => _postButtonDisableController(),
                    ),
                  ),
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
                          items: <String>['Global', 'Self']
                              .map<DropdownMenuItem<String>>((String value) {
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
                                        postSelfArticleRequest(dropdownValue,
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
                            backgroundColor: MaterialStateProperty.all<Color>(
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
                ),
                const SizedBox(
                  height: 1000,
                ),
              ],
            ),
          )),
    );
  }
}
