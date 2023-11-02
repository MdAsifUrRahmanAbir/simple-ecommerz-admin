

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              controller.fetchBanners();
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
                // controller.fetchAllProducts();
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
                                onPressed: () {},
                                icon:
                                    const Icon(Icons.add, color: Colors.black)),
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
      height: 150,
      width: 200,
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
                height: 150,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  children: [
                    SizedBox(
                      height: 150,
                      width: 200,
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
