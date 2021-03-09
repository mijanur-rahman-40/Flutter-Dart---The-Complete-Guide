import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/widgets/chat/message_bubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // future is called as soon as future is done
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocuments = chatSnapshot.data.docs;
        return ListView.builder(
          reverse: true,
          itemCount: chatSnapshot.data.docs.length,
          itemBuilder: (context, index) => MessageBubble(
            chatDocuments[index]['text'],
            chatDocuments[index]['username'],
            chatDocuments[index]['userImage'],
            chatDocuments[index]['userId'] ==
                FirebaseAuth.instance.currentUser.uid,
            key: ValueKey(chatDocuments[index].id),
          ),
        );
      },
    );
  }
}
