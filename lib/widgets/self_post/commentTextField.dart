import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:social_app/network/comment/post_comment.dart';

class CommentTextInput extends StatefulWidget {
  final int articleId;
  const CommentTextInput({
    Key? key,
    required this.articleId,
  }) : super(key: key);

  @override
  _CommentTextInputState createState() => _CommentTextInputState();
}

class _CommentTextInputState extends State<CommentTextInput> {
  final TextEditingController cmtContent = TextEditingController();
  late bool _isPostButtonEnabled;

  @override
  void initState() {
    super.initState();
    _isPostButtonEnabled = false;
  }

  bool _postButtonController() {
    if (cmtContent.text != "") {
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Expanded(
          child: Material(
            color: Colors.transparent,
          ),
        ),
        Container(
          color: Colors.grey[700],
          padding: const EdgeInsets.all(0.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextField(
                  maxLines: 2,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: const InputDecoration.collapsed(
                      hintText: "Add a comment..."),
                  controller: cmtContent,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  onChanged: (value) => _postButtonController(),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                  onPressed: _isPostButtonEnabled
                      ? () {
                          if (_isPostButtonEnabled) {
                            postCommentRequest(
                                cmtContent.text, widget.articleId);
                          }
                        }
                      : null,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        _isPostButtonEnabled == true
                            ? Colors.amber
                            : Colors.grey),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                    children: const [
                      Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 24.0,
                      ),
                    ],
                  )),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
