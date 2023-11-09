import 'dart:io';

import 'package:ecommerzadmin/screens/add_popular_product/add_popular_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common_widget/image_widget.dart';
import '../../common_widget/input_feild_widgets/primary_input_feild_widget.dart';
import '../../common_widget/loading_widget.dart';


class AddPopularProductScreen extends StatelessWidget {
  AddPopularProductScreen({super.key});

  final controller = Get.put(AddPopularProductController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.imageForEdit.value.isNotEmpty
            ? "Update Popular Product"
            : "Add Popular Product"),
      ),
      body: SingleChildScrollView(
        child: Column(
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

            Column(

              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PrimaryTextInputWidget(
                      controller: controller.nameController,
                      hintext: "Product name",
                      bordercolor: Colors.green,
                      keyboardtype: TextInputType.name),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PrimaryTextInputWidget(
                      controller: controller.descriptionController,
                      hintext: "Product Description",
                      bordercolor: Colors.green,
                      keyboardtype: TextInputType.name),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PrimaryTextInputWidget(
                      controller: controller.currencyController,
                      hintext: "Price Currency (Like USD)",
                      bordercolor: Colors.green,
                      keyboardtype: TextInputType.name),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PrimaryTextInputWidget(
                      controller: controller.priceController,
                      hintext: "Product Price",
                      bordercolor: Colors.green,
                      keyboardtype: TextInputType.name),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PrimaryTextInputWidget(
                      controller: controller.haveDiscountController,
                      hintext: "Have Discount??(true or false)",
                      bordercolor: Colors.green,
                      keyboardtype: TextInputType.name),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PrimaryTextInputWidget(
                      controller: controller.discountPriceController,
                      hintext: "Discount Price",
                      bordercolor: Colors.green,
                      keyboardtype: TextInputType.name),
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
                        ?controller.updatePopularAction
                        : controller.addPopularProductAction,
                    child: Text(controller.imageForEdit.value.isNotEmpty
                        ? "Update Popular Product"
                        : "Add Popular Product"),
                  ),
                )),

              ],

            ),




          ],
        ),
      ),
    );
  }
}