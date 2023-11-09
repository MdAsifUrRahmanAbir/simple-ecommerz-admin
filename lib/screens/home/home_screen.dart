

import 'package:ecommerzadmin/screens/add_popular_product/add_popular_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common_widget/loading_widget.dart';
import '../../common_widget/text_labels/title_heading3_widget.dart';
import '../../common_widget/text_labels/title_heading4_widget.dart';
import '../../routes/routes.dart';
import '../../utils/assets_path.dart';
import '../add_banner/add_banner_controller.dart';
import 'home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final controller = Get.put(HomeController());
  final addBannerController = Get.put(AddBannerController(), permanent: true);
  final addPopularController = Get.put(AddPopularProductController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              controller.fetchBanners();
              controller.fetchAllProducts();
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: Obx(() => controller.isLoading
          ? const Center(
              child: CustomLoadingWidget(),
            )
          : RefreshIndicator(
              onRefresh: () async {
                controller.fetchBanners();
                 controller.fetchAllProducts();
              },
              child: ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Banners"),
                            IconButton(
                                onPressed: () {
                                  addBannerController.titleController.clear();
                                  addBannerController.customUid.value = "";
                                  addBannerController.imageForEdit.value = "";
                                  Get.toNamed(Routes.addBannerScreen);
                                },
                                icon:
                                    const Icon(Icons.add, color: Colors.black)),
                          ],
                        ),
                        _banners(),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Products"),
                            IconButton(
                                onPressed: () {
                                  addPopularController.currencyController.clear();
                                  addPopularController.discountPriceController.clear();
                                  addPopularController.descriptionController.clear();
                                  addPopularController.haveDiscountController.clear();
                                  addPopularController.priceController.clear();
                                  addPopularController.nameController.clear();
                                  addPopularController.customUid.value = "";
                                  addPopularController.imageForEdit.value = "";
                                  Get.toNamed(Routes.addPopularProductScreen);
                                },
                                icon: const Icon(Icons.add, color: Colors.black)),
                          ],
                        ),
                        _product(),

                        /// show all products here
                      ],
                    ),
                  ),
                ],
              ),
            )),
    );
  }

  _banners() {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: controller.bannerData.length,
          itemBuilder: (context, index) {
            var data = controller.bannerData[index];
            return Container(
              width: 300,
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(data.image), fit: BoxFit.fill)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 50,
                    color: Colors.black87,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          data.title,
                          style: const TextStyle(color: Colors.white),
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              controller.deleteBannersFromFirebase(
                                  data.id, data.image);
                            },
                            icon: const Icon(Icons.delete, color: Colors.red)),
                        IconButton(
                            onPressed: () {
                              addBannerController.titleController.text = data.title;
                              addBannerController.customUid.value = data.id;
                              addBannerController.imageForEdit.value = data.image;
                              Get.toNamed(Routes.addBannerScreen);
                            },
                            icon: const Icon(Icons.edit, color: Colors.green)),
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }


  _product() {
    return SizedBox(
      height: 200,
      child: ListView.separated(
        shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            var data = controller.popularProductData[index];
            return InkWell(
              onTap: () {
                //controller.goToDetailsScreen(data, context);
              },
              child: Container(
                height: 200,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  children: [
                    SizedBox(
                      height: 200,
                      width: 250,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: FadeInImage(
                          placeholder: AssetImage(Assets.productPlaceHolder),
                          image: NetworkImage(data.image),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                                height: 50,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(.7)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    TitleHeading4Widget(
                                      text: data.name,
                                      color: Colors.white,
                                    ),
                                    Column(
                                      children: [
                                        TitleHeading3Widget(
                                          text: data.haveDiscount
                                              ? "${data.discountPrice.toStringAsFixed(2)} ${data.currency}"
                                              : "${data.price.toStringAsFixed(2)} ${data.currency}",
                                          color: Colors.black87,
                                        ),
                                        Visibility(
                                            visible: data.haveDiscount,
                                            child: Text(
                                              "${data.price.toStringAsFixed(2)} ${data.currency}",
                                              style: const TextStyle(
                                                  decoration:
                                                  TextDecoration.lineThrough,
                                                  fontSize: 12.0,
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold),
                                            ))
                                      ],
                                    ),
                                  ],
                                ))
                          ],
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: 40,
                              color: Colors.black87,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [

                                  const Spacer(),
                                  IconButton(
                                      onPressed: () {
                                        controller.deletePopularProductFromFirebase(
                                            data.id, data.image);
                                      },
                                      icon: const Icon(Icons.delete, color: Colors.red)),
                                  IconButton(
                                      onPressed: () {
                                        addPopularController.nameController.text = data.name;
                                        addPopularController.customUid.value = data.id;
                                        addPopularController.imageForEdit.value = data.image;
                                        //double.parse(priceController.text)= data.price  ;
                                        addPopularController.haveDiscountController.text = data.haveDiscount ;
                                        addPopularController.discountPriceController.text = data.discountPrice ;
                                        addPopularController.descriptionController.text = data.description;
                                        addPopularController.currencyController.text = data.currency;

                                        Get.toNamed(Routes.addPopularProductScreen);
                                      },
                                      icon: const Icon(Icons.edit, color: Colors.green)),
                                ],
                              ),
                            )
                          ],
                        ),

                      ],
                    ),

                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, i) => const SizedBox(width: 15),
          itemCount: controller.popularProductData.length >= 10
              ? 10
              : controller.popularProductData.length
        // itemCount: 5
      ),
    );
  }


}
