

import 'dart:io';

import 'package:ecommerzadmin/common_widget/toast_message.dart';
import 'package:ecommerzadmin/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../backend/services/firebase_service.dart';

class AddBannerController extends GetxController{

  final titleController = TextEditingController();
  final RxString imageForEdit = "".obs;
  final RxString customUid = "".obs;

  File? imageFile;



  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  void addBannerAction() async{
    _isLoading.value = true;
    update();
    try{
      if(imageFile != null){
        if(titleController.text.isNotEmpty){
          customUid.value = const Uuid().v4();
          debugPrint(customUid.value);
          debugPrint(imageFile!.path);
          String url = await FirebaseServices.storeFileToFirebase(imageFile!, customUid.value);

          Map<String, dynamic> map = {
            "id": customUid.value,
            "title": titleController.text,
            "image": url
          };
          await FirebaseServices.addBanner(map, customUid.value);
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

  void updateBannerAction() async{
    _isLoading.value = true;
    update();
    try{
      if(imageFile != null){
        if(titleController.text.isNotEmpty){
          debugPrint(customUid.value);
          debugPrint(imageFile!.path);
          String url = await FirebaseServices.storeFileToFirebase(imageFile!, customUid.value);
          Map<String, dynamic> map = {
            "id": customUid.value,
            "title": titleController.text,
            "image": url
          };
          await FirebaseServices.updateBanner(map, customUid.value);
        }
        else{
          ToastMessage.error("Write Banner Title");
        }
      }
      else{
        if(titleController.text.isNotEmpty){
          Map<String, dynamic> map = {
            "id": customUid.value,
            "title": titleController.text,
            "image": imageForEdit.value
          };
          await FirebaseServices.updateBanner(map, customUid.value);
        }
        else{
          ToastMessage.error("Write Banner Title");
        }
      }
    }catch(e){
      e.toString().redConsole;
    }finally{
      _isLoading.value = false;
      update();
    }

  }
}