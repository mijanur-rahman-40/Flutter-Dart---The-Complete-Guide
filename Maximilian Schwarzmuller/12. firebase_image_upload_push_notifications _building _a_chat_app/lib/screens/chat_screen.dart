// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/widgets/chat/messages.dart';
import 'package:flutter_chat_app/widgets/chat/new_message.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FlutterChat'),
        actions: [
          DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.exit_to_app,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      SizedBox(width: 8),
                      Text('Logout'),
                    ],
                  ),
                ),
                // value as a identifier
                value: 'logout',
              ),
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          ),
        ],
      ),
      // StreamBuilder is a firebase builder that works like realtime data handling
      body:
          //  StreamBuilder(
          //   stream: FirebaseFirestore.instance
          //       .collection('chats/UMrLSClddfvaw9wV0hs6/messages')
          //       .snapshots(),
          //   builder: (BuildContext context,
          //       AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          //     if (streamSnapshot.connectionState == ConnectionState.waiting) {
          //       Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     }
          //     final documents = streamSnapshot.data.docs;
          //     return ListView.builder(
          //       itemCount: documents.length,
          //       itemBuilder: (context, index) => Container(
          //         padding: EdgeInsets.all(8),
          //         child: Text(
          //           documents[index]['text'],
          //         ),
          //       ),
          //     );
          //   },
          // ),
          Container(
        child: Column(
          children: [
            // as list view will be rendered, So Expanded takes space as much as possible.
            Expanded(child: Messages()),
            NewMessage(),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () {
      //     // FirebaseFirestore.instance
      //     //     .collection('chats/UMrLSClddfvaw9wV0hs6/messages')
      //     //     // snapshots basically return a stream(a object)
      //     //     .snapshots()
      //     //     .listen((data) {
      //     //   data.docs.forEach((element) {
      //     //     print(element.get('text'));
      //     //   });
      //     // });
      //     FirebaseFirestore.instance
      //         .collection('chats/UMrLSClddfvaw9wV0hs6/messages')
      //         .add({'text': 'This was added by clicking the button'});
      //   },
      // ),
    );
  }
}
