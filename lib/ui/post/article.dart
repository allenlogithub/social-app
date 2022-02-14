import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:social_app/widgets/self_post/commentShowing.dart';
import 'package:social_app/widgets/self_post/commentTextField.dart';
import 'package:social_app/widgets/navigation/back.dart';

class Article extends StatefulWidget {
  final Function(int index, dynamic comments) notifyCommentsUpdated;
  final dynamic article;
  final int index;
  const Article({
    Key? key,
    required this.notifyCommentsUpdated,
    required this.article,
    required this.index,
  }) : super(key: key);

  @override
  _ArticleState createState() => _ArticleState();
}

class _ArticleState extends State<Article> {
  dynamic art;

  @override
  void initState() {
    super.initState();
    art = widget.article;
  }

  void refreshScreen(bool refresh) {
    if (refresh) {
      setState(() {
        art = widget.article;
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              art['content'],
              style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            if (art['items'] != null) ...[
              CommentShowing(article: art),
              CommentTextInput(
                articleId: art['articleId'],
                index: widget.index,
                notifyCommentsUpdated: widget.notifyCommentsUpdated,
                refresh: refreshScreen,
              ),
            ] else ...[
              CommentTextInput(
                articleId: art['articleId'],
                index: widget.index,
                notifyCommentsUpdated: widget.notifyCommentsUpdated,
                refresh: refreshScreen,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
