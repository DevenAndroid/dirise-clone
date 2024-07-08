import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dirise/singleproductScreen/singleProductReturnPolicy.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/profile_controller.dart';
import '../controller/vendor_controllers/add_product_controller.dart';
import '../model/common_modal.dart';
import '../model/virtualProductModel.dart';
import '../repository/repository.dart';
import '../utils/api_constant.dart';
import '../vendor/authentication/image_widget.dart';
import '../widgets/common_button.dart';
import '../widgets/common_colour.dart';

class VirtualProductScreen extends StatefulWidget {
  const VirtualProductScreen({super.key});

  @override
  State<VirtualProductScreen> createState() => _VirtualProductScreenState();
}

class _VirtualProductScreenState extends State<VirtualProductScreen> {
  String productItem = 'PDF'; // Default selected item
  File featuredImage = File("");
  RxBool showValidation = false.obs;
  final profileController = Get.put(ProfileController());
  bool checkValidation(bool bool1, bool2) {
    if (bool1 == true && bool2 == true) {
      return true;
    } else {
      return false;
    }
  }

  List<String> productItemList = [
    'PDF',
    'Audio',
    'Video',
    'Image',
    'Others',
  ];
  String languageItem = 'Arabic'; // Default selected item

  List<String> languageItemList = [
    'Arabic',
    'English',
  ];
  final Repositories repositories = Repositories();
  final formKey1 = GlobalKey<FormState>();
  final addProductController = Get.put(AddProductController());
  optionalApi() {
    if (featuredImage.path.isEmpty) {
      if (featuredImage.path.isEmpty) {
        showToastCenter('Please select an file');
      }
      showValidation.value = true;
      return;
    }
    Map<String, String> map = {};
    Map<String, File> images = {};
    map['virtual_product_type'] = productItem;
    map['virtual_product_file_language'] = languageItem;
    map['product_type'] = 'virtual_product';
    map['product_type'] = 'virtual_product';
    map['item_type'] = 'virtual_product';
    images['virtual_product_file'] = featuredImage;
    map["id"] =  addProductController.idProduct.value.toString();
    log(images.toString());
    FocusManager.instance.primaryFocus!.unfocus();
    repositories
        .multiPartApi(
        mapData: map,
        images: images,
        context: context,
        url: ApiUrls.giveawayProductAddress, onProgress: (int bytes, int totalBytes) {  },
       )
        .then((value) {
      VirtualProductModel response = VirtualProductModel.fromJson(jsonDecode(value));
      print('API Response Status Code: ${response.status}');
      log(response.message.toString());
      showToast(response.message.toString());
      if (response.status == true) {
        Get.to(SingleProductReturnPolicy());
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
              'Virtual Product'.tr,
              style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Virtual Product Type:'.tr,
                style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w500, fontSize: 16),
              ),
              const SizedBox(
                height: 5,
              ),
              DropdownButtonFormField<String>(
                value: productItem,
                onChanged: (String? newValue) {
                  setState(() {
                    productItem = newValue!;
                  });
                },
                items: productItemList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: const Color(0xffE2E2E2).withOpacity(.35),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10).copyWith(right: 8),
                  focusedErrorBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: AppTheme.secondaryColor)),
                  errorBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: Color(0xffE2E2E2))),
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an item';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Select file according to choosed category:'.tr,
                style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w500, fontSize: 16),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Confirm your\nuploaded file'.tr,
                      style: GoogleFonts.inter(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14),
                    ),
                  ),
                  Container(
                    height: 220,
                    width: 200,
                    child: ImageWidget(
                      // key: paymentReceiptCertificateKey,
                      title: "Click To Edit Uploaded  File".tr,
                      file: featuredImage,
                      validation: checkValidation(showValidation.value, featuredImage.path.isEmpty),
                      filePicked: (File g) {
                        featuredImage = g;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Language:'.tr,
                style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w500, fontSize: 16),
              ),
              const SizedBox(
                height: 5,
              ),
              DropdownButtonFormField<String>(
                value: languageItem,
                onChanged: (String? newValue) {
                  setState(() {
                    languageItem = newValue!;
                  });
                },
                items: languageItemList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: const Color(0xffE2E2E2).withOpacity(.35),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10).copyWith(right: 8),
                  focusedErrorBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: AppTheme.secondaryColor)),
                  errorBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: Color(0xffE2E2E2))),
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an item';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 100,
              ),
              CustomOutlineButton(
                title: 'Confirm',
                borderRadius: 11,
                onPressed: () {

                  optionalApi();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
