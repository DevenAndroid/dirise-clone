import 'dart:convert';

import 'package:dirise/Services/review_publish_service.dart';
import 'package:dirise/Services/services_classification.dart';
import 'package:dirise/addNewProduct/reviewPublishScreen.dart';
import 'package:dirise/controller/service_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/vendor_controllers/add_product_controller.dart';
import '../model/common_modal.dart';
import '../repository/repository.dart';
import '../utils/api_constant.dart';
import '../widgets/common_button.dart';
import '../widgets/common_colour.dart';
import '../widgets/common_textfield.dart';
import 'optional_collection.dart';

class ServiceOptionalScreen extends StatefulWidget {
  int? id;
  String? metaTags;
  String? MetaTitle;
  String? MetaDescription;
  String? longDescription;
  String? noTax;

  ServiceOptionalScreen({super.key, this.id, this.metaTags, this.MetaDescription, this.MetaTitle,this.longDescription,this.noTax});

  @override
  State<ServiceOptionalScreen> createState() => _ServiceOptionalScreenState();
}

class _ServiceOptionalScreenState extends State<ServiceOptionalScreen> {
  final serviceController = Get.put(ServiceController());
  RxBool hide = true.obs;
  RxBool hide1 = true.obs;
  bool showValidation = false;
  final Repositories repositories = Repositories();
  final formKey1 = GlobalKey<FormState>();
  String code = "+91";

  TextEditingController metaTitleController = TextEditingController();
  TextEditingController metaDescriptionController = TextEditingController();
  TextEditingController longDescriptionController = TextEditingController();
  TextEditingController metaTagsController = TextEditingController();
  TextEditingController taxController = TextEditingController();

  final addProductController = Get.put(AddProductController());
  optionalApi() {
    Map<String, dynamic> map = {};

    map['meta_title'] = metaTitleController.text.trim();
    map['item_type'] = 'service';
    map['meta_description'] = metaDescriptionController.text.trim();
    map['long_description'] = longDescriptionController.text.trim();
    map['meta_tags'] = metaTagsController.text.trim();
    map['tax_type'] = taxController.text.trim();
    map['id'] = addProductController.idProduct.value.toString();

    FocusManager.instance.primaryFocus!.unfocus();
    repositories.postApi(url: ApiUrls.giveawayProductAddress, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      print('API Response Status Code: ${response.status}');
      // showToast(response.message.toString());
      if (response.status == true) {
        if(formKey1.currentState!.validate()){
        Get.to(() => const ServiceClassificationScreen());
        }
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.id != null) {
      metaTitleController.text = widget.MetaTitle.toString();
      metaDescriptionController.text = widget.MetaDescription.toString();
      metaTagsController.text = widget.metaTags.toString();
      longDescriptionController.text = widget.longDescription.toString();
      taxController.text = widget.noTax.toString();
    }
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
              'Optional Description'.tr,
              style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey1,
          child: Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: [
                TextFormField(
                  controller: longDescriptionController,
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
                    hintText: 'Long Description(optional)',
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
                CommonTextField(
                    controller: metaTitleController,
                    obSecure: false,
                    hintText: 'Meta Title'.tr,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Meta Title is required".tr;
                      }
                      return null;
                    },

                ),
                TextFormField(
                  maxLines: 2,
                  controller: metaDescriptionController,
                  minLines: 2,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Meta Description is required".tr;
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
                    hintText: 'Meta Description',
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
                CommonTextField(
                    controller: metaTagsController,
                    obSecure: false,
                    hintText: 'Meta Tags'.tr,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Meta Tags is required".tr;
                      }
                      return null;
                    },
                    ),
                CommonTextField(
                    controller: taxController,
                    obSecure: false,
                    hintText: 'No Tax '.tr,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Tax is required".tr;
                      }
                      return null;
                    },

                ),
                const SizedBox(height: 20),
                CustomOutlineButton(
                  title: 'Next',
                  borderRadius: 11,
                  onPressed: () {
                    // if(formKey1.currentState!.validate()){
                    optionalApi();
                    // }
                  },
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const ServiceClassificationScreen());
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
