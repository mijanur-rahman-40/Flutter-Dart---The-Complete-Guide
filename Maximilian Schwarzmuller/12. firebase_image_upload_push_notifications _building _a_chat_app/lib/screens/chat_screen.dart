// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/widgets/chat/messages.dart';
import 'package:flutter_chat_app/widgets/chat/new_message.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  // void initState() async{
  //   // need permission only for ios and web
  //   // FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  //   // NotificationSettings settings = await firebaseMessaging.requestPermission(
  //   //   alert: true,
  //   //   announcement: false,
  //   //   badge: true,
  //   //   carPlay: false,
  //   //   criticalAlert: false,
  //   //   provisional: false,
  //   //   sound: true,
  //   // );

  //   //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //   //     print('User granted permission');
  //   //   } else if (settings.authorizationStatus ==
  //   //       AuthorizationStatus.provisional) {
  //   //     print('User granted provisional permission');
  //   //   } else {
  //   //     print('User declined or has not accepted permission');
  //   //   }
  //     // Get any messages which caused the application to open from
  //     // a terminated state.
  //     RemoteMessage initialMessage =
  //         await FirebaseMessaging.instance.getInitialMessage();
  //     // If the message also contains a data property with a "type" of "chat",
  //     // navigate to a chat screen
  //     if (initialMessage?.data['type'] == 'chat') {
  //       // Navigator.pushNamed(context, '/chat',
  //       //     arguments: ChatArguments(initialMessage));
  //     }

  //   // Also handle any interaction when the app is in the background via a
  //   // Stream listener
  //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //     if (message.data['type'] == 'chat') {
  //       // Navigator.pushNamed(context, '/chat',
  //       //     arguments: ChatArguments(message));
  //     }
  //     print(message.data);
  //   });

  //   //   // when app into foreground
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     print('Got a message whilst in the foreground!');
  //     print('Message data: ${message.data}');

  //     if (message.notification != null) {
  //       print('Message also contained a notification: ${message.notification}');
  //     }
  //   });

  @override
  void initState() {
    super.initState();

    // working on when app is terminated
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      if (message != null) {
        //  Navigator
        print('Hello world1');
      }
    });

    //  works when app is runing on background
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;

      print('Hello world2');
      // if (notification != null && android != null) {
      //   flutterLocalNotificationsPlugin.show(
      //       notification.hashCode,
      //       notification.title,
      //       notification.body,
      //       NotificationDetails(
      //         android: AndroidNotificationDetails(
      //           channel.id,
      //           channel.name,
      //           channel.description,
      //           // TODO add a proper drawable resource to android, for now using
      //           //      one that already exists in example app.
      //           icon: 'launch_background',
      //         ),
      //       ));
      // }
    });

    //
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      print(message.data);

      //  Navigator
      print('Hello world3');
    });
    // when app into background
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
  }

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
