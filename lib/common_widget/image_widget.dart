import 'dart:io';

import 'package:flutter/material.dart';

import '../utils/image_pickr_dialog.dart';

class ImageWidget extends StatefulWidget {
  const ImageWidget({super.key, required this.onPicked});

  final Function onPicked;

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  File? file;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ImagePickerDialog.pickImage(context, onPicked: (value){
          file = value;
          widget.onPicked(file);
          setState(() {});
        });
      },
      child: file == null
          ? Container(
              height: 200,
              width: double.infinity,
              alignment: Alignment.center,
              color: Colors.grey,
              child: const Text("Select Image"))
          : Image.file(
          file!,
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
