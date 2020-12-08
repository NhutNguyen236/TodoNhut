import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:ui' as ui;

class AppInfoScreen extends StatelessWidget {
  static String id = 'AppInfoScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(30.0),
            child: Column(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        FontAwesomeIcons.arrowLeft,
                        size: 22.0,
                        color: Colors.amber,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ListTile(
                      title: Text(
                          'Final project for Android Application Development which is a simple, minimal todo app.'),
                    ),
                    Divider(
                      thickness: 2.0,
                      color: Colors.redAccent,
                    ),
                    ListTile(
                      leading: Icon(Icons.device_hub),
                      title: Text('Author: T-Bone and Draw'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
