import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_app/widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  Future<void> _submitAuthForm(
    String email,
    String password,
    String username,
    File userImage,
    bool isLogin,
    BuildContext context,
  ) async {
    // user success auth information
    UserCredential userCredential;
    try {
      setState(() => _isLoading = true);
      if (isLogin) {
        userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        // creating references and folder to upload image
        final reference = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child(userCredential.user.uid + '.jpg');
        // upload the file
        await reference.putFile(userImage);

        // getting image url
        final url = await reference.getDownloadURL();

        // adding user data
        FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user.uid)
            .set({
          'username': username,
          'email': email,
          'image_url': url,
        });
      }
      // if platform interaction is failed
    } on PlatformException catch (error) {
      var message = 'An error occureed, Pleae check your credienatials';
      if (error.message != null) {
        message = error.message;
      }
      // show the message into snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      setState(() => _isLoading = false);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm, _isLoading),
    );
  }
}
