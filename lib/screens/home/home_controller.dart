
import 'package:ecommerzadmin/utils/logger.dart';
import 'package:get/get.dart';

import '../../backend/models/banners_model.dart';
import '../../backend/models/product_model.dart';
import '../../backend/services/firebase_service.dart';

class HomeController extends GetxController{
  @override
  void onInit() {
    // TODO: implement onInit
    fetchBanners();
    super.onInit();
  }


  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  /// fetching banners
  late List<BannerModel> bannerData;
  void fetchBanners() async {
    _isLoading.value = true;
    update();
    "START FETCHING BANNER ".bgGreenConsole;

    try {
      bannerData = (await FirebaseServices.fetchBanner())!;

      bannerData.toString().yellowConsole;
      _fetchAllProducts();
    } catch (e) {
      e.toString().redConsole;
    } finally {
      // _isLoading.value = false;
      // update();
    }
  }

  /// fetching popular products
  late List<ProductModel> popularProductData;
  void _fetchAllProducts() async {
    "START FETCHING Popular Product ".bgGreenConsole;

    try {
      popularProductData = (await FirebaseServices.fetchPopularProduct())!;
    } catch (e) {
      e.toString().redConsole;
    } finally {
      _isLoading.value = false;
      update();
    }
  }

  void deleteBannersFromFirebase(String id, String imagePath) async{
    _isLoading.value = true;
    update();
    try{
      await FirebaseServices.deleteBanner(id, imagePath).then((value) => fetchBanners());
    }catch(e){
      e.toString().redConsole;
    }finally{
      // _isLoading.value = false;
      // update();
    }
  }
}