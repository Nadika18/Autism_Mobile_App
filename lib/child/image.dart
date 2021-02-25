import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Image for description



class MyImage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyImageState();
}

class _MyImageState extends State<MyImage> {

  String filePath = '';

  getImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool check = prefs.containsKey('image');
    if (check) {
      setState(() {
        filePath = prefs.getString('image');
      });
      return;
    }
    ImagePicker imagePicker = new ImagePicker();
    PickedFile image = await imagePicker.getImage(source: ImageSource.gallery);
    String imagePath = image.path;
    await prefs.setString('image', imagePath);
    setState(() {
      filePath = prefs.getString('image');
    });
  }

  @override
  void initState() {
    super.initState();
    getImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: filePath == '' ? FlatButton(
          onPressed: getImage,
          child: Text('Add image'),
        ) : Image.file(File(filePath)),
      )
    );
  }
}