import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('chat').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocuments = chatSnapshot.data.docs;
        return ListView.builder(
          itemCount: chatSnapshot.data.docs.length,
          itemBuilder: (context, index) => Text(chatDocuments[index]['text']),
        );
      },
    );
  }
}
