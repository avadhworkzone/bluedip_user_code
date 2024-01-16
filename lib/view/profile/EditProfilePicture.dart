import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Widget/toolbar_with_title_shadow.dart';

class EditProfilePicture extends StatelessWidget {
  EditProfilePicture({Key? key, required this.picture}) : super(key: key);

  final XFile picture;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ToolbarWithTitleShadow("Profile Picture"),
        Column(mainAxisSize: MainAxisSize.min, children: [
          Image.file(
            File(picture.path),
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 24),
          Text(picture.name)
        ]),
      ],
    )));
  }
}
