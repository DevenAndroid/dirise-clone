import 'dart:convert';
import 'package:dirise/Services/services_classification.dart';
import 'package:dirise/screens/academic%20programs/sponsors_academic_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../model/common_modal.dart';
import '../../repository/repository.dart';
import '../../utils/api_constant.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_colour.dart';
import '../../widgets/common_textfield.dart';


class OptionalDetailsAcademicScreen extends StatefulWidget {
  const OptionalDetailsAcademicScreen({super.key});

  @override
  State<OptionalDetailsAcademicScreen> createState() => _OptionalDetailsAcademicScreenState();
}

class _OptionalDetailsAcademicScreenState extends State<OptionalDetailsAcademicScreen> {
  final TextEditingController locationController = TextEditingController();
  final TextEditingController hostNameController = TextEditingController();
  final TextEditingController programNameController = TextEditingController();
  final TextEditingController programGoalController = TextEditingController();
  final TextEditingController programDesController = TextEditingController();
  final TextEditingController sponsorController = TextEditingController();
  RxBool hide = true.obs;
  RxBool hide1 = true.obs;
  bool showValidation = false;
  final Repositories repositories = Repositories();
  final formKey1 = GlobalKey<FormState>();
  String code = "+91";
  optionalApi() {
    Map<String, dynamic> map = {};

    // map['meta_title'] = locationController.text.trim();
    // map['item_type'] = 'giveaway';
    // map['meta_description'] = serviceController.metaDescriptionController.text.trim();
    // map['long_description'] = serviceController.longDescriptionController.text.trim();
    // map['serial_number'] = serviceController.serialNumberController.text.trim();
    // map['product_number'] = serviceController.productNumberController.text.trim();

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
                  controller:locationController,
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
                    hintText: 'Location',
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
                  controller: hostNameController,
                  obSecure: false,
                  hintText: 'Host name'.tr,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Host name is required".tr;
                    }
                    return null;
                  },

                ),
                CommonTextField(
                  controller: programNameController,
                  obSecure: false,
                  hintText: 'Program name'.tr,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Program name is required".tr;
                    }
                    return null;
                  },

                ),
                CommonTextField(
                  controller: programGoalController,
                  obSecure: false,
                  hintText: 'Program goal'.tr,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Program goal is required".tr;
                    }
                    return null;
                  },
                ),
                TextFormField(
                  maxLines: 2,
                  controller: programDesController,
                  minLines: 2,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Program Description is required".tr;
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
                    hintText: 'Program Description',
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
                  controller: sponsorController,
                  obSecure: false,
                  hintText: 'Sponsor'.tr,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Sponsor goal is required".tr;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomOutlineButton(
                  title: 'Done',
                  borderRadius: 11,
                  onPressed: () {
                    // if(formKey1.currentState!.validate()){
                    // optionalApi();
                    // }
                     Get.to(()=> const SponsorsScreenAcademic());
                  },
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Get.to(()=> const SponsorsScreenAcademic());
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
