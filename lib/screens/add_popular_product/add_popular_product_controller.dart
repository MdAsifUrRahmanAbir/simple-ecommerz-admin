

import 'dart:io';

import 'package:ecommerzadmin/common_widget/toast_message.dart';
import 'package:ecommerzadmin/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../backend/services/firebase_service.dart';

class AddPopularProductController extends GetxController{

  final nameController = TextEditingController();
  final currencyController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final discountPriceController = TextEditingController();
  final haveDiscountController = TextEditingController();
  final RxString imageForEdit = "".obs;
  final RxString customUid = "".obs;

  File? imageFile;



  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  void addPopularProductAction() async{
    _isLoading.value = true;
    update();
    try{
      if(imageFile != null){
        if(nameController.text.isNotEmpty){
          customUid.value = const Uuid().v4();
          debugPrint(customUid.value);
          debugPrint(imageFile!.path);
          String url = await FirebaseServices.storeFileToFirebase(imageFile!, customUid.value);

          Map<String, dynamic> map = {
            "id": customUid.value,
            "name": nameController.text,
            "image": url,
            "currency": currencyController.text,
            "description": descriptionController.text,
            "discountPrice": discountPriceController.text,
            "haveDiscount" : haveDiscountController.text,
            "price": priceController.text
          };
          await FirebaseServices.addPopularProduct(map, customUid.value);
        }
        else{
          ToastMessage.error("All field are required");
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
        if(nameController.text.isNotEmpty){
          debugPrint(customUid.value);
          debugPrint(imageFile!.path);
          String url = await FirebaseServices.storeFileToFirebase(imageFile!, customUid.value);
          Map<String, dynamic> map = {
            "id": customUid.value,
            "title": nameController.text,
            "image": url,
            "currency": currencyController.text,
            "description": descriptionController.text,
            "discountPrice": discountPriceController.text,
            "haveDiscount" : haveDiscountController.text,
            "price": priceController.text
          };
          await FirebaseServices.updateBanner(map, customUid.value);
        }
        else{
          ToastMessage.error("Write Banner Title");
        }
      }
      else{
        if(nameController.text.isNotEmpty){
          Map<String, dynamic> map = {
            "id": customUid.value,
            "title": nameController.text,
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