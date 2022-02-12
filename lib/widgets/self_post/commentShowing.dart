import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommentShowing extends StatefulWidget {
  final dynamic article;
  const CommentShowing({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  _CommentShowingState createState() => _CommentShowingState();
}

class _CommentShowingState extends State<CommentShowing> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListView.builder(
            itemCount: widget.article['items'].length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, cmtIndex) {
              final cmt = widget.article['items'][cmtIndex];
              return Card(
                child: Row(
                  children: <Widget>[
                    const Icon(
                      Icons.account_box_rounded,
                      color: Colors.white,
                      size: 50.0,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          cmt['userName'],
                          style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(cmt['comment'],
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    )
                  ],
                ),
              );
            }),
      ],
    );
  }
}
