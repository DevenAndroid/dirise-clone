import 'dart:convert';

import 'package:dirise/Services/review_publish_service.dart';
import 'package:dirise/addNewProduct/reviewPublishScreen.dart';
import 'package:dirise/controller/service_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/common_modal.dart';
import '../repository/repository.dart';
import '../utils/api_constant.dart';
import '../widgets/common_button.dart';
import '../widgets/common_colour.dart';
import '../widgets/common_textfield.dart';
import 'optional_collection.dart';

class ServiceClassificationScreen extends StatefulWidget {
  const ServiceClassificationScreen({super.key});

  @override
  State<ServiceClassificationScreen> createState() => _ServiceClassificationScreenState();
}

class _ServiceClassificationScreenState extends State<ServiceClassificationScreen> {

  final serviceController = Get.put(ServiceController());
  RxBool hide = true.obs;
  RxBool hide1 = true.obs;
  bool showValidation = false;
  final Repositories repositories = Repositories();
  final formKey1 = GlobalKey<FormState>();
  String code = "+91";
  optionalApi() {
    Map<String, dynamic> map = {};

    map['serial_number'] = serviceController.serialNumber1Controller.text.trim();
    map['item_type'] = 'giveaway';
    map['product_number'] = serviceController.productNumber1Controller.text.trim();
    map['product_code'] = serviceController.productCode1Controller.text.trim();
    map['promotion_code'] = serviceController.promotionCode1Controller.text.trim();
    map['package_detail'] = serviceController.packageDetails1Controller.text.trim();

    FocusManager.instance.primaryFocus!.unfocus();
    repositories.postApi(url: ApiUrls.giveawayProductAddress, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      print('API Response Status Code: ${response.status}');
      showToast(response.message.toString());
      if (response.status == true) {
        if(formKey1.currentState!.validate()){
          Get.to(()=> const ReviewPublishServiceScreen());
        }

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
        child: Container(
          margin: EdgeInsets.only(left: 15,right: 15),
          child: Form(
            key: formKey1,
            child: Column(
              children: [

                CommonTextField(
                    controller: serviceController.serialNumber1Controller,
                    obSecure: false,
                    hintText: 'Serial Number'.tr,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Serial Number is required'),
                    ])),
                CommonTextField(
                    controller: serviceController.productNumber1Controller,
                    obSecure: false,
                    hintText: 'Product number'.tr,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Product number is required'),
                    ])),
                CommonTextField(
                    controller: serviceController.productCode1Controller,
                    obSecure: false,
                    hintText: 'Product Code'.tr,
                    keyboardType: TextInputType.number,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Product Code is required'),
                    ])),
                CommonTextField(
                    controller: serviceController.promotionCode1Controller,
                    obSecure: false,
                    hintText: 'Promotion Code'.tr,
                    keyboardType: TextInputType.number,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Promotion Code is required'),
                    ])),
                TextFormField(
                  controller: serviceController.packageDetails1Controller,
                  maxLines: 2,
                  minLines: 2,
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
                const SizedBox(height: 20),
                CustomOutlineButton(
                  title: 'Next',
                  borderRadius: 11,
                  onPressed: () {
                    if(formKey1.currentState!.validate()){
                      optionalApi();
                    }
                  },
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: (){
                    Get.to(()=> const ReviewPublishServiceScreen());
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
