import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:social_app/widgets/self_post/commentShowing.dart';
import 'package:social_app/widgets/self_post/commentTextField.dart';
import 'package:social_app/widgets/navigation/back.dart';

class Article extends StatefulWidget {
  final dynamic article;
  const Article({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  _ArticleState createState() => _ArticleState();
}

class _ArticleState extends State<Article> {
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.article['content'],
              style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            if (widget.article['items'] != null) ...[
              CommentShowing(article: widget.article),
              CommentTextInput(articleId: widget.article['articleId']),
            ] else ...[
              CommentTextInput(articleId: widget.article['articleId']),
            ]
          ],
        ),
      ),
    );
  }
}
