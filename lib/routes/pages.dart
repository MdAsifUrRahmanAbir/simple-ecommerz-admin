import 'package:get/get.dart';

import '../screens/add_banner/add_banner_screen.dart';
import '../screens/add_popular_product/add_popular_product_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/splash/splash_screen.dart';
import 'routes.dart';

class Pages {
  static var list = [
    GetPage(
      name: Routes.splashScreen,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: Routes.homeScreen,
      page: () => HomeScreen(),
    ),

    GetPage(
      name: Routes.addBannerScreen,
      page: () => AddBannerScreen(),
    ),
    GetPage(
      name: Routes.addPopularProductScreen,
      page: () => AddPopularProductScreen(),
    ),
  ];
}
