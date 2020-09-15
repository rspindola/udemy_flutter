import 'dart:math';

import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  ChatMessage(this.data, this.mine);
  final Map<String, dynamic> data;
  final bool mine;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: <Widget>[
          !mine
              ? Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(data['sendPhotoUrl']),
                  ),
                )
              : Container(),
          Expanded(
              child: Column(
            crossAxisAlignment:
                !mine ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: <Widget>[
              data['imgUrl'] != null
                  ? Image.network(
                      data['imgUrl'],
                      width: 250,
                    )
                  : Text(
                      data['text'],
                      textAlign: mine ? TextAlign.end : TextAlign.start,
                      style: TextStyle(fontSize: 16),
                    ),
              Text(
                data['sendName'],
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              ),
            ],
          )),
          mine
              ? Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(data['sendPhotoUrl']),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
