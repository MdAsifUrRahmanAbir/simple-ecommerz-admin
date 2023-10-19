

import 'dart:io';

import 'package:ecommerzadmin/common_widget/toast_message.dart';
import 'package:ecommerzadmin/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../backend/services/firebase_service.dart';

class AddBannerController extends GetxController{

  final titleController = TextEditingController();

  File? imageFile;



  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  void addBannerAction() async{
    _isLoading.value = true;
    update();
    try{
      if(imageFile != null){
        if(titleController.text.isNotEmpty){
          String customUid = const Uuid().v4();
          debugPrint(customUid);
          String filePath = await FirebaseServices.storeFileToFirebase(imageFile!, customUid);

          Map<String, dynamic> map = {
            "id": customUid,
            "title": titleController.text,
            "image": filePath
          };
          await FirebaseServices.addBanner(map, customUid);
        }
        else{
          ToastMessage.error("Write Banner Title");
        }
      }
      else{
        ToastMessage.error("Select Image First");
      }
    }catch(e){
      e.toString().redConsole;
    }finally{
      _isLoading.value = false;
      update();
    }

  }
}