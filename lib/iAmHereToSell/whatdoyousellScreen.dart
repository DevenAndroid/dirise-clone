import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';

import '../model/vendor_models/vendor_category_model.dart';
import '../widgets/common_colour.dart';
import '../widgets/common_textfield.dart';

class WhatdoyousellScreen extends StatefulWidget {
  const WhatdoyousellScreen({super.key});

  @override
  State<WhatdoyousellScreen> createState() => _WhatdoyousellScreenState();
}

class _WhatdoyousellScreenState extends State<WhatdoyousellScreen> {
  ModelVendorCategory modelVendorCategory = ModelVendorCategory(usphone: []);
  Rx<RxStatus> vendorCategoryStatus = RxStatus.empty().obs;
  final GlobalKey categoryKey = GlobalKey();
  Map<String, VendorCategoriesData> allSelectedCategory = {};
  TextEditingController _otpController = TextEditingController();
  bool showValidation = false;
  bool? _isValue = false;

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: GoogleFonts.poppins(
      fontSize: 22,
      color: const Color.fromRGBO(30, 60, 87, 1),
    ),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.withOpacity(0.5)), // Border for each box
      borderRadius: BorderRadius.circular(8), // Border radius for each box
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: const Icon(
          Icons.arrow_back_ios_new,
          color: Color(0xff0D5877),
          size: 16,
        ),
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'What do you sell?'.tr,
              style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 20,right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'This is where your product will be shown. Category can’t be changed later.',
                style: GoogleFonts.poppins(color: const Color(0xff111727), fontSize: 13),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(() {
                if (kDebugMode) {
                  print(modelVendorCategory.usphone!
                      .map((e) => DropdownMenuItem(value: e, child: Text(e.name.toString().capitalize!)))
                      .toList());
                }
                return DropdownButtonFormField<VendorCategoriesData>(
                  key: categoryKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  icon: vendorCategoryStatus.value.isLoading
                      ? const CupertinoActivityIndicator()
                      : vendorCategoryStatus.value.isError
                          ? IconButton(
                              onPressed: () {},
                              padding: EdgeInsets.zero,
                              visualDensity: VisualDensity.compact,
                              icon: const Icon(
                                Icons.refresh,
                                color: Colors.black,
                              ))
                          : const Icon(Icons.keyboard_arrow_down_rounded),
                  iconSize: 30,
                  iconDisabledColor: const Color(0xff97949A),
                  iconEnabledColor: const Color(0xff97949A),
                  value: null,
                  style: GoogleFonts.poppins(color: Colors.black, fontSize: 16),
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
                  items: modelVendorCategory.usphone!
                      .map((e) => DropdownMenuItem(value: e, child: Text(e.name.toString().capitalize!)))
                      .toList(),
                  hint: Text('Search category to choose'.tr),
                  onChanged: (value) {
                    // selectedCategory = value;
                    if (value == null) return;
                    if (allSelectedCategory.isNotEmpty) return;
                    allSelectedCategory[value.id.toString()] = value;
                    setState(() {});
                  },
                  validator: (value) {
                    if (allSelectedCategory.isEmpty) {
                      return "Please select Category".tr;
                    }
                    return null;
                  },
                );
              }),
              const SizedBox(
                height: 10,
              ),
              const CommonTextField(hintText: 'Store Name*',),
              const SizedBox(
                height: 10,
              ),
              const CommonTextField(hintText: 'Store Email*',),
              const SizedBox(
                height: 10,
              ),
              const CommonTextField(hintText: 'Store Number*',),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Verification'.tr,
                style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 20),
              ),
              Text(
                'Enter Verification'.tr,
                style: GoogleFonts.poppins(color: const Color(0xff1D2C3D), fontWeight: FontWeight.w400, fontSize: 14),
              ),

              PinCodeFields(
                length: 5,
                controller: _otpController,
                fieldBorderStyle: FieldBorderStyle.square,
                responsive: true,
                fieldHeight: 50.0,
                fieldWidth: 60.0,
                borderWidth: 1.0,
                activeBorderColor: Colors.black,
                activeBackgroundColor:
                Colors.black.withOpacity(.10),
                borderRadius: BorderRadius.circular(5.0),
                keyboardType: TextInputType.number,
                autoHideKeyboard: true,
                fieldBackgroundColor:
                Colors.white.withOpacity(.10),
                borderColor: Colors.black,
                textStyle: GoogleFonts.poppins(
                  fontSize: 25.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                onComplete: (output) {

                },
              ),
              const SizedBox(
                height: 10,
              ),
              RichText(
                text: const TextSpan(
                  text: 'if you dont receive a code',
                  style: TextStyle(
                    fontFamily: 'Your App Font Family',
                    color: Colors.black
                  ),
                  children: [
                    TextSpan(
                      text: 'Resend',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(0xff014E70)
                      ),
                    ),

                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Transform.translate(
                    offset: const Offset(-6, 0),
                    child: Checkbox(
                        visualDensity: const VisualDensity(horizontal: -1, vertical: -3),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        value: _isValue,
                        side: BorderSide(
                          color: showValidation == false ? const Color(0xff0D5877) : Colors.red,
                        ),
                        onChanged: (bool? value) {
                          setState(() {
                            _isValue = value;
                          });
                        }),
                  ),
                  Expanded(
                    child: Text(
                      'By clicking next, you agree to the DIRISE Terms of Service and Privacy Policy'.tr,
                      style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w500, fontSize: 13),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: Get.width,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xff0D5877), // Border color
                    width: 1.0, // Border width
                  ),
                  borderRadius: BorderRadius.circular(2), // Border radius
                ),
                padding: const EdgeInsets.all(10), // Padding inside the container
                child: const Center(
                  child: Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Text color
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
