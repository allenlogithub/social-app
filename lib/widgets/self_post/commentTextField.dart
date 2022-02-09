import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommentTextInput extends StatefulWidget {
  const CommentTextInput({Key? key}) : super(key: key);

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
    return Padding(
      padding: const EdgeInsets.only(),
      child: IntrinsicHeight(
        child: Column(
          children: <Widget>[
            Text(
              'Comment',
              style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextField(
                    maxLines: 8,
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
                )
              ],
            ),
            SizedBox(
              width: 100,
              height: 35,
              child: ElevatedButton(
                  onPressed: _isPostButtonEnabled
                      ? () {
                          if (_isPostButtonEnabled) {
                            print(cmtContent);
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
            ),
            const SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
