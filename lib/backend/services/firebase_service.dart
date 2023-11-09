import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerzadmin/common_widget/toast_message.dart';
import 'package:ecommerzadmin/utils/logger.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/banners_model.dart';
import '../models/product_model.dart';


class FirebaseServices {
  static final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  static final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;


  static const String customerUserInfo = "customerUserInfo";
  static const String sellerInfo = "sellerInfo";
  static const String banners = "banners";
  static const String popularProducts = "popularProducts";




  static Future<List<BannerModel>?> fetchBanner()async{
    try{
      final QuerySnapshot<Map<String, dynamic>> snapshot = await _fireStore.collection(banners).get();

      List<BannerModel> bannerList = snapshot.docs.map((doc) {
        final data = doc.data();
        return BannerModel.fromJson(data);
      }).toList();

      return bannerList;
    }catch(e){
      "Error From fetch banner in firebase services".bgRedConsole;
      e.toString().redConsole;
      return null;
    }
  }

  static Future<List<ProductModel>?> fetchPopularProduct()async{
    try{
      final QuerySnapshot<Map<String, dynamic>> snapshot = await _fireStore.collection(popularProducts).get();

      List<ProductModel> popularProductList = snapshot.docs.map((doc) {
        final data = doc.data();
        return ProductModel.fromJson(data);
      }).toList();


      return popularProductList;
    }catch(e){
      "Error From fetch Popular Product in firebase services".bgRedConsole;
      e.toString().redConsole;
      return null;
    }
  }

  static Future<void> deleteBanner(String id, String imagePath)async{
    try{
      final DocumentReference docRef = _fireStore.collection(banners).doc(id);

      /// due : delete also image file todo

      docRef.delete().then((value) {
        final Reference imageRef = _firebaseStorage.ref().child(imagePath);
        imageRef.delete().then((_) {
          ToastMessage.success("Banner Deleted Successfully.");
        });
        ToastMessage.success("Banner Deleted Successfully.");
      });


    }catch(e){
      "Error From delete banner in firebase services".bgRedConsole;
      e.toString().redConsole;
    }
  }

  static Future<void> deletePopularProduct(String id, String imagePath)async{
    try{
      final DocumentReference docRef = _fireStore.collection(popularProducts).doc(id);

      /// due : delete also image file todo

      docRef.delete().then((value) {
        final Reference imageRef = _firebaseStorage.ref().child(imagePath);
        imageRef.delete().then((_) {
          ToastMessage.success("Popular Product Deleted Successfully.");
        });
        ToastMessage.success("Popular Product Deleted Successfully.");
      });


    }catch(e){
      "Error From delete Popular Product in firebase services".bgRedConsole;
      e.toString().redConsole;
    }
  }



  static Future<void> addBanner(Map<String, dynamic> map, String uid) async{
    try{
      await _fireStore
          .collection(banners)
          .doc(uid)
          .set(map).then((value) => ToastMessage.success("Banner Added Successfully."));
    }catch(e){
      "Error From add banner in firebase services".bgRedConsole;
      e.toString().redConsole;
    }
  }
  static Future<void> addPopularProduct(Map<String, dynamic> map, String uid) async{
    try{
      await _fireStore
          .collection(popularProducts)
          .doc(uid)
          .set(map).then((value) => ToastMessage.success("Popular Product Added Successfully."));
    }catch(e){
      "Error From add Popular Product in firebase services".bgRedConsole;
      e.toString().redConsole;
    }
  }


  static Future<void> updateBanner(Map<String, dynamic> map, String uid) async{
    try{
      await _fireStore
          .collection(banners)
          .doc(uid)
          .update(map).then((value) => ToastMessage.success("Banner Update Successfully."));
    }catch(e){
      "Error From Update banner in firebase services".bgRedConsole;
      e.toString().redConsole;
    }
  }

  static Future<void> updatePopular(Map<String, dynamic> map, String uid) async{
    try{
      await _fireStore
          .collection(popularProducts)
          .doc(uid)
          .update(map).then((value) => ToastMessage.success("Popular Products Update Successfully."));
    }catch(e){
      "Error From Update Popular Products in firebase services".bgRedConsole;
      e.toString().redConsole;
    }
  }


  /// Store File To Firebase
  static Future<String> storeFileToFirebase(File file, String uid) async {
    "1. Upload Start".greenConsole;
    UploadTask uploadTask =
    _firebaseStorage.ref().child(uid).putFile(file);
    "2. Put File to Firebase".greenConsole;
    TaskSnapshot snap = await uploadTask;
    "3. Take Snapshot".greenConsole;
    String downloadUrl = await snap.ref.getDownloadURL();
    "4. Get Url => $downloadUrl".greenConsole;
    return downloadUrl;
  }
}