import 'dart:convert';

import 'package:dirise/addNewProduct/reviewPublishScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/profile_controller.dart';
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

class OptionalClassificationScreen extends StatefulWidget {
  int? id;
  dynamic Packagedetails;
  dynamic PromotionCode;
  dynamic  ProductCode;
  dynamic SerialNumber;
  dynamic Productnumber;
  OptionalClassificationScreen(
      {super.key,
      this.id,
      this.Packagedetails,
      this.Productnumber,
      this.SerialNumber,
      this.PromotionCode,
      this.ProductCode});

  @override
  State<OptionalClassificationScreen> createState() => _OptionalClassificationScreenState();
}

class _OptionalClassificationScreenState extends State<OptionalClassificationScreen> {
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


    TextEditingController serialNumberController = TextEditingController();

    map['serial_number'] = controller.serialNumberController.text.trim();
    map['product_number'] = controller.productNumberController.text.trim();
    map['product_code'] = controller.productCodeController.text.trim();
    map['promotion_code'] = controller.promotionCodeController.text.trim();
    map['package_detail'] = controller.packageDetailsController.text.trim();
    map['item_type'] = 'product';
    map['id'] = addProductController.idProduct.value.toString();
    FocusManager.instance.primaryFocus!.unfocus();
    repositories.postApi(url: ApiUrls.giveawayProductAddress, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      print('API Response Status Code: ${response.status}');
      showToast(response.message.toString());
      if (response.status == true) {
        Get.to(ProductReviewPublicScreen());
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.id != null) {
      controller.serialNumberController.text = widget.SerialNumber ?? "";
      controller.productNumberController.text = widget.Productnumber ?? "";
      controller.productCodeController.text = widget.PromotionCode.toString();
      controller.promotionCodeController.text = widget.SerialNumber ?? "";
      controller.packageDetailsController.text = widget.Packagedetails ?? "";
    }
  }

  final profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: (){
            Get.back();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              profileController.selectedLAnguage.value != 'English' ?
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
            ],
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
                const SizedBox(height: 10),
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
                const SizedBox(height: 10),
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
                const SizedBox(height: 10),
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
                const SizedBox(height: 10),
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
                    Get.to( const ProductReviewPublicScreen());
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
