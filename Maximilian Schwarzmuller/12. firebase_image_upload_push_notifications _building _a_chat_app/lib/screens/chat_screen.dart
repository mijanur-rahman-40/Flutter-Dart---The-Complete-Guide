import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // StreamBuilder is a firebase builder that works like realtime data handling
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats/UMrLSClddfvaw9wV0hs6/messages')
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.none) {
            Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = streamSnapshot.data.docs;
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) => Container(
              padding: EdgeInsets.all(8),
              child: Text(
                documents[index]['text'],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // FirebaseFirestore.instance
          //     .collection('chats/UMrLSClddfvaw9wV0hs6/messages')
          //     // snapshots basically return a stream(a object)
          //     .snapshots()
          //     .listen((data) {
          //   data.docs.forEach((element) {
          //     print(element.get('text'));
          //   });
          // });
          FirebaseFirestore.instance
              .collection('chats/UMrLSClddfvaw9wV0hs6/messages')
              .add({
                'text':'This was added by clicking the button'
              });
        },
      ),
    );
  }
}
