import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common_widget/image_widget.dart';
import '../../common_widget/input_feild_widgets/primary_input_feild_widget.dart';
import '../../common_widget/loading_widget.dart';
import 'add_banner_controller.dart';

class AddBannerScreen extends StatelessWidget {
  AddBannerScreen({super.key});

  final controller = Get.put(AddBannerController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.imageForEdit.value.isNotEmpty
            ? "Update Banner"
            : "Add Banner"),
      ),
      body: Column(
        children: [
          Obx(() => ImageWidget(
                networkImage: controller.imageForEdit.value,
                onPicked: (File file) {
                  controller.imageFile = file;
                },
              )),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PrimaryTextInputWidget(
                controller: controller.titleController,
                hintext: "Title",
                bordercolor: Colors.green,
                keyboardtype: TextInputType.emailAddress),
          ),
          const SizedBox(
            height: 10,
          ),
          Obx(() => controller.isLoading
              ? const Center(
                  child: CustomLoadingWidget(),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: controller.imageForEdit.value.isNotEmpty
                        ? controller.updateBannerAction
                        : controller.addBannerAction,
                    child: Text(controller.imageForEdit.value.isNotEmpty
                        ? "Update Banner"
                        : "Add Banner"),
                  ),
                )),
        ],
      ),
    );
  }
}
