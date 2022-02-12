import 'package:flutter/material.dart';

import 'package:social_app/network/comment/post_comment.dart';
import 'package:social_app/network/comment/get_comment.dart';

class CommentTextInput extends StatefulWidget {
  final Function(int index, dynamic comments) notifyCommentsUpdated;
  final int articleId;
  final int index;
  const CommentTextInput({
    Key? key,
    required this.notifyCommentsUpdated,
    required this.articleId,
    required this.index,
  }) : super(key: key);

  @override
  _CommentTextInputState createState() => _CommentTextInputState();
}

class _CommentTextInputState extends State<CommentTextInput> {
  final TextEditingController cmtContent = TextEditingController();
  late bool _isPostButtonEnabled;
  late Future<GetCommentResponse> futureGetCommentResponse;

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
                      ? () async {
                          if (_isPostButtonEnabled) {
                            await postCommentRequest(
                                cmtContent.text, widget.articleId);
                            futureGetCommentResponse =
                                getCommentRequest(widget.articleId);
                            futureGetCommentResponse.then((value) {
                              widget.notifyCommentsUpdated(
                                  widget.index, value.message['items']);
                            });
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
