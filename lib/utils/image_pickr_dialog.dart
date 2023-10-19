import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerDialog{
  static void pickImage(BuildContext context, { required Function onPicked}){
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.15,
        margin: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: IconButton(
                  onPressed: () async{
                    onPicked(await _pickImage(ImageSource.gallery));
                  },
                  icon: Icon(
                    Icons.image,
                    color: Theme.of(context).primaryColor,
                    size: 50,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: IconButton(
                  onPressed: ()async{
                    onPicked(await _pickImage(ImageSource.camera));
                  },
                  icon: Icon(
                    Icons.camera,
                    color: Theme.of(context).primaryColor,
                    size: 50,
                  )),
            ),
          ],
        ),
      ),
    );
  }



  static File? file;

  static Future<File?> _pickImage(imageSource) async {
    try {
      final image =
      await ImagePicker().pickImage(source: imageSource, imageQuality: 100);
      if (image == null) return null;

      file = File(image.path);
      Get.close(1);
      return file;
    } on PlatformException catch (e) {
      debugPrint('Error: $e');
    }
    return null;
  }
}