import 'dart:io';

import 'package:dirise/utils/styles.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controller/vendor_controllers/add_product_controller.dart';
import '../../../utils/helper.dart';
import '../../../widgets/dimension_screen.dart';
import '../../../widgets/loading_animation.dart';
import 'add_product_description.dart';
import 'bookable_screens/bookable_ui.dart';
import 'product_gallery_images.dart';
import 'variant_product/varient_product.dart';
import 'vertual_product_and_image.dart';

class AddProductScreen extends StatefulWidget {
final String? productId;
  const AddProductScreen({Key? key, this.productId}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final controller = Get.put(AddProductController(),permanent: true);

  @override
  void initState() {
    super.initState();
    controller.productId = "";
    controller.galleryImages.clear();
    controller.productImage = File("");
    controller.pdfFile = File("");
    controller.addMultipleItems.clear();
    controller.languageController.clear();
    controller.getProductsCategoryList();
    controller.productType = "Simple Product";
    controller.getReturnPolicyData();
    controller.resetValues();
    controller.productDurationValueController.text = "";
    controller.productDurationTypeValue = "";
    controller.valuesAssigned = false;
    controller.apiLoaded = false;
    controller.getProductDetails(idd: widget.productId).then((value) {
      setState(() {});
    });
    controller.getProductAttributes();
    controller.getTaxData();
  }

  showDeleteDialog() {
    showDialog(
        context: context,
        builder: (context1) {
          return AlertDialog(
            title: Text(
              "Are you sure you want to delete this product?".tr,
              style: titleStyle,
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child:  Text("Cancel".tr)),
              ElevatedButton(
                  onPressed: () {
                    controller.deleteProduct(context);
                  },
                  child: Text("Delete".tr)),
            ],
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xffF4F4F4),
            surfaceTintColor: Colors.white,
            leading: GestureDetector(
              onTap: () {
                Get.back();
                // _scaffoldKey.currentState!.openDrawer();
              },
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Image.asset(
                  'assets/icons/backicon.png',
                  // height: 21,
                ),
              ),
            ),
            title: Text(
              controller.productId.isEmpty ? "Add Product".tr : "Edit Product".tr,
              style: GoogleFonts.raleway(fontSize: 18, fontWeight: FontWeight.w700, color: const Color(0xff303C5E)),
            ),
            actions: [
              if (controller.productId.isNotEmpty)
                PopupMenuButton(itemBuilder: (context1) {
                  return [
                    PopupMenuItem(
                        onTap: () {
                          showDeleteDialog();
                        },
                        child:  Text("Delete Product".tr)),
                  ];
                })
            ],
          ),
          body: Obx(() {
            if (controller.refreshInt.value > 0) {}
            return controller.apiLoaded
                ? RefreshIndicator(
                    onRefresh: () async {
                      await controller.getProductsCategoryList();
                      await controller.getTaxData();
                      await controller.getProductAttributes();
                    },
                    child: SingleChildScrollView(
                        child: Form(
                      key: controller.formKey,
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(children: [
                            const AddProductDescriptionScreen(),
                            16.spaceY,
                            if (controller.productType == "Booking Product") const BookableUI(),
                            if (controller.productType == "Variants Product") const ProductVarient(),
                            const AddProductImageAndVirtualFile(),
                            16.spaceY,
                            const ProductGalleryImages(),
                            16.spaceY,
                            ElevatedButton(
                                onPressed: () {
                                  controller.addProduct(context: context);
                                },
                                style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(double.maxFinite, 60),
                                    backgroundColor: AppTheme.buttonColor,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AddSize.size10)),
                                    textStyle: GoogleFonts.poppins(fontSize: AddSize.font20, fontWeight: FontWeight.w600)),
                                child: Text(
                                  controller.productId.isEmpty ? "Create".tr : "Update".tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(color: Colors.white, fontWeight: FontWeight.w500, fontSize: AddSize.font18),
                                )),
                            10.spaceY,
                          ])),
                    )),
                  )
                : const LoadingAnimation();
          })),
    );
  }
}
