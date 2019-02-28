import 'dart:io';
import 'package:flutter/material.dart';
import 'image_picker_handler.dart';
import 'image_picker_dialog.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin, ImagePickerListener {
  File _image;
  AnimationController _controller;
  ImagePickerHandler imagePicker;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
    );
    imagePicker = ImagePickerHandler(this, _controller);
    imagePicker.init();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => imagePicker.showDialog(context),
        child: Center(
          child: _image == null
              ? Stack(
                  children: <Widget>[
                    Center(
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: const Color(0xff778899),
                      ),
                    ),
                    Center(
                      child: Icon(Icons.camera),
                    )
                  ],
                )
              : Container(
                  height: 160,
                  width: 160,
                  decoration: BoxDecoration(
                    color: const Color(0xff7c94b6),
                    image: DecorationImage(
                      image: ExactAssetImage(_image.path),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(color: Colors.red, width: 5),
                    borderRadius: BorderRadius.all(
                      const Radius.circular(80),
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  @override
  userImage(File _image) {
    setState(() {
      this._image = _image;
    });
  }
}
