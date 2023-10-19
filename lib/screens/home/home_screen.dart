import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common_widget/loading_widget.dart';
import '../../routes/routes.dart';
import 'home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: (){
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
                            onPressed: () {},
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
}
