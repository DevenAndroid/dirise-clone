import 'dart:developer';
import 'dart:io';

import 'package:dirise/utils/styles.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controller/profile_controller.dart';
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
  final controller = Get.put(AddProductController(), permanent: true);

  @override
  void initState() {
    super.initState();
    controller.productId = controller.idProduct.value.toString();
    log('dshgsdhjgk${controller.productId}');
    controller.galleryImages.clear();
    controller.productImage = File("");
    controller.pdfFile = File("");
    controller.addMultipleItems.clear();
    controller.languageController.clear();
    controller.getProductsCategoryList();
    controller.productType = "variants";
    controller.getReturnPolicyData();
    controller.resetValues();
    controller.productDurationValueController.text = "";
    controller.productDurationTypeValue = "";
    controller.valuesAssigned = false;
    controller.apiLoaded = false;
    controller.getProductDetails(idd: controller.idProduct.value.toString()).then((value) {
      setState(() {});
    });
    controller.getProductAttributes();
    controller.getTaxData();
  }


final profileController = Get.put(ProfileController());
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
                child: profileController.selectedLAnguage.value != 'English' ?
                Image.asset(
                  'assets/images/forward_icon.png',
                  height: 19,
                  width: 19,
                ) :
                Image.asset(
                  'assets/images/back_icon_new.png',
                  height: 19,
                  width: 19,
                ),
              ),
            ),
            title: Text(
              "Variable Product".tr,
              style: GoogleFonts.raleway(fontSize: 18, fontWeight: FontWeight.w700, color: const Color(0xff303C5E)),
            ),

          ),
          body: Obx(() {
            if (controller.refreshInt.value > 0) {}
            return controller.apiLoaded
                ? SingleChildScrollView(
                    child: Form(
                  key: controller.formKey,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(children: [
                        // const AddProductDescriptionScreen(),
                        // 16.spaceY,
                        const ProductVarient(),
                        16.spaceY,
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
                                textStyle:
                                    GoogleFonts.poppins(fontSize: AddSize.font20, fontWeight: FontWeight.w600)),
                            child: Text(
                              controller.productId.isEmpty ? "Create".tr : "Update".tr,
                              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: Colors.white, fontWeight: FontWeight.w500, fontSize: AddSize.font18),
                            )),
                        10.spaceY,
                      ])),
                ))
                : const LoadingAnimation();
          })),
    );
  }
}
