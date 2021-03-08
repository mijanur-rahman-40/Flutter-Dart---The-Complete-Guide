import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserIamgePicker extends StatefulWidget {
  final void Function(File pickedImage) imagePickFunction;
  UserIamgePicker(this.imagePickFunction);

  @override
  _UserIamgePickerState createState() => _UserIamgePickerState();
}

class _UserIamgePickerState extends State<UserIamgePicker> {
  File _image;
  final picker = new ImagePicker();

  // take image
  Future<void> getImage() async {
    final pickedImage = await picker.getImage(
      // imageQuality value range 0 to 100
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
      maxHeight: 150
    );
    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      } else {
        print('No image selected.');
      }
      widget.imagePickFunction(_image);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage: _image != null ? FileImage(_image) : null,
        ),
        TextButton.icon(
          onPressed: getImage,
          icon: Icon(Icons.image),
          label: Text('Add Image'),
        ),
      ],
    );
  }
}
