import 'dart:convert';
import 'dart:developer';

import 'package:dirise/addNewProduct/reviewPublishScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/common_button.dart';
import '../../widgets/common_colour.dart';
import '../../widgets/common_textfield.dart';

class ExtendProgramOptionalScreen extends StatefulWidget {
  const ExtendProgramOptionalScreen({super.key});

  @override
  State<ExtendProgramOptionalScreen> createState() => _ExtendProgramOptionalScreenState();
}

class _ExtendProgramOptionalScreenState extends State<ExtendProgramOptionalScreen> {
  final TextEditingController metaTitleController = TextEditingController();
  final TextEditingController metaDescriptionController = TextEditingController();
  final TextEditingController longDescriptionController = TextEditingController();
  final TextEditingController serialNumberController = TextEditingController();
  final TextEditingController productNumberController = TextEditingController();

  final formKey1 = GlobalKey<FormState>();

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
              'Optional'.tr,
              style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          child: Form(
            key: formKey1,
            child: Column(
              children: [
                CommonTextField(
                  controller: metaTitleController,
                  obSecure: false,
                  hintText: 'Location'.tr,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Location is required'.tr;
                    }
                    return null; // Return null if validation passes
                  },
                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    Radio(value: 1, groupValue: 1, onChanged: (value) {}),
                    Expanded(
                      child: Text(
                          'I will set it the location later.I agree to that a full refund will be mandatory in case in the customer request a refund because of the missing information.'
                      ,style: TextStyle(fontSize: 14,color: Color(0xffEB4335)),),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                CommonTextField(
                  controller: serialNumberController,
                  obSecure: false,
                  hintText: 'Host name'.tr,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Host name is required'.tr;
                    }
                    return null; // Return null if validation passes
                  },
                ),
                CommonTextField(
                  controller: longDescriptionController,
                  obSecure: false,
                  hintText: 'Program name'.tr,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Program name is required'.tr;
                    }
                    return null; // Return null if validation passes
                  },
                ),
                CommonTextField(
                  controller: productNumberController,
                  obSecure: false,
                  hintText: 'Program goal'.tr,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Program goal is required'.tr;
                    }
                    return null; // Return null if validation passes
                  },
                ),
                TextFormField(
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
                const SizedBox(height: 20),
                CustomOutlineButton(
                  title: 'Done',
                  borderRadius: 11,
                  onPressed: () {},
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Get.to(ReviewPublishScreen());
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
