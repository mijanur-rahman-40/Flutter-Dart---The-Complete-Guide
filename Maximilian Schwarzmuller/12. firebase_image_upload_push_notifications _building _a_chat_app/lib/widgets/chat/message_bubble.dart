import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String username;
  final bool isMe;
  // to efficiently updated data into list
  final Key key;

  MessageBubble(this.message, this.username, this.isMe, {this.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isMe ? Colors.blue[200] : Theme.of(context).accentColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
                bottomRight: isMe ? Radius.circular(0) : Radius.circular(12)),
          ),
          width: 150,
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                username,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isMe
                        ? Colors.white
                        : Theme.of(context).secondaryHeaderColor),
              ),
              Text(
                message,
                style: TextStyle(
                  color: isMe
                      ? Colors.white
                      : Theme.of(context).secondaryHeaderColor,
                ),
                textAlign: isMe ? TextAlign.end : TextAlign.start,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
