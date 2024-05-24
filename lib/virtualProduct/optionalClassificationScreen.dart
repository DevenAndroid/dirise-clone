import 'dart:convert';

import 'package:dirise/addNewProduct/reviewPublishScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/service_controller.dart';
import '../controller/vendor_controllers/add_product_controller.dart';
import '../model/common_modal.dart';
import '../repository/repository.dart';
import '../screens/Consultation Sessions/consultationReviewPublish.dart';
import '../utils/api_constant.dart';
import '../widgets/common_button.dart';
import '../widgets/common_colour.dart';
import '../widgets/common_textfield.dart';
import 'ReviewandPublishScreen.dart';

class VirtualOptionalClassificationScreen extends StatefulWidget {
  const VirtualOptionalClassificationScreen({super.key});

  @override
  State<VirtualOptionalClassificationScreen> createState() => _VirtualOptionalClassificationScreenState();
}

class _VirtualOptionalClassificationScreenState extends State<VirtualOptionalClassificationScreen> {
  final controller = Get.put(ServiceController());
  RxBool hide = true.obs;
  RxBool hide1 = true.obs;
  bool showValidation = false;
  final Repositories repositories = Repositories();
  final formKey1 = GlobalKey<FormState>();
  String code = "+91";
  final addProductController = Get.put(AddProductController());
  optionalApi() {
    Map<String, dynamic> map = {};

    map['serial_number'] = controller.serialNumberController.text.trim();
    map['product_number'] = controller.productNumberController.text.trim();
    map['product_code'] = controller.productCodeController.text.trim();
    map['promotion_code'] = controller.promotionCodeController.text.trim();
    map['package_detail'] = controller.packageDetailsController.text.trim();
    map['item_type'] = 'service';
    map['id'] = addProductController.idProduct.value.toString();
    FocusManager.instance.primaryFocus!.unfocus();
    repositories.postApi(url: ApiUrls.giveawayProductAddress, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      print('API Response Status Code: ${response.status}');
      showToast(response.message.toString());
      if (response.status == true) {
        Get.to(VirtualReviewandPublishScreen());

      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xff0D5877),
            size: 16,
          ),
        ),
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Optional Classification'.tr,
              style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey1,
          child: Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: [
                CommonTextField(
                  controller: controller.serialNumberController,
                  obSecure: false,
                  hintText: 'Serial Number'.tr,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Meta Title is required".tr;
                    }
                    return null;
                  },
                ),
                CommonTextField(
                  controller: controller.productNumberController,
                  obSecure: false,
                  hintText: 'Product number'.tr,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Serial Number is required".tr;
                    }
                    return null;
                  },
                ),
                CommonTextField(
                  controller: controller.productCodeController,
                  obSecure: false,
                  hintText: 'Product Code'.tr,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Product number is required".tr;
                    }
                    return null;
                  },
                ),
                CommonTextField(
                  controller: controller.promotionCodeController,
                  obSecure: false,
                  hintText: 'Promotion Code'.tr,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Product number is required".tr;
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: controller.packageDetailsController,
                  maxLines: 5,
                  minLines: 5,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Package details is required".tr;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    counterStyle: GoogleFonts.poppins(
                      color: AppTheme.primaryColor,
                      fontSize: 25,
                    ),
                    counter: const Offstage(),
                    errorMaxLines: 2,
                    contentPadding: const EdgeInsets.all(15),
                    fillColor: Colors.grey.shade100,
                    hintText: 'Package details',
                    hintStyle: GoogleFonts.poppins(
                      color: AppTheme.primaryColor,
                      fontSize: 15,
                    ),
                    border: InputBorder.none,
                    focusedErrorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: AppTheme.secondaryColor)),
                    errorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: AppTheme.secondaryColor)),
                    focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: AppTheme.secondaryColor)),
                    disabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: AppTheme.secondaryColor),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: AppTheme.secondaryColor),
                    ),
                  ),
                ),
                const SizedBox(height: 100),
                CustomOutlineButton(
                  title: 'Next',
                  borderRadius: 11,
                  onPressed: () {
                    if (formKey1.currentState!.validate()) {
                      optionalApi();
                    }

                  },
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Get.to(const VirtualReviewandPublishScreen());
                  },
                  child: Container(
                    width: Get.width,
                    height: 55,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black, // Border color
                        width: 1.0, // Border width
                      ),
                      borderRadius: BorderRadius.circular(10), // Border radius
                    ),
                    padding: const EdgeInsets.all(10), // Padding inside the container
                    child: const Center(
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Text color
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
