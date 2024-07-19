import 'dart:convert';
import 'dart:developer';

import 'package:dirise/addNewProduct/deliverySizeScreen.dart';
import 'package:dirise/iAmHereToSell/personalizeyourstoreScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/profile_controller.dart';
import '../language/app_strings.dart';
import '../model/common_modal.dart';
import '../repository/repository.dart';
import '../screens/auth_screens/otp_screen.dart';
import '../utils/api_constant.dart';
import '../widgets/common_textfield.dart';
import 'customeraccountcreatedsuccessfullyScreen.dart';
import 'locationScreen.dart';

class PickUpAddressScreen extends StatefulWidget {
  final String? street;
  final String? city;
  final String? state;
  final String? country;
  final String? zipcode;
  final String? town;




  PickUpAddressScreen({
    Key? key,
    this.street,
    this.city,
    this.state,
    this.country,
    this.zipcode,
    this.town,

  }) : super(key: key);

  @override
  State<PickUpAddressScreen> createState() => _PickUpAddressScreenState();
}

class _PickUpAddressScreenState extends State<PickUpAddressScreen> {
  final TextEditingController streetController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController zipcodeController = TextEditingController();
  final TextEditingController townController = TextEditingController();
  final TextEditingController specialInstructionController = TextEditingController();
  RxBool hide = true.obs;
  RxBool hide1 = true.obs;
  bool showValidation = false;
  final Repositories repositories = Repositories();
  final formKey1 = GlobalKey<FormState>();
  String code = "+91";
  editAddressApi() {
    Map<String, dynamic> map = {};
    if (widget.street != null &&
        widget.city != null &&
        widget.state != null &&
        widget.country != null &&
        widget.zipcode != null &&
        widget.town != null) {
      map['address_type'] = 'Both';
      map['city'] = widget.city;
      map['country'] = widget.country;
      map['state'] = widget.state;
      map['zip_code'] = widget.zipcode;
      map['town'] = widget.town;
      map['street'] = widget.street;
      map['special_instruction'] = specialInstructionController.text.trim();
    }else{
      map['address_type'] = 'Both';
      map['city'] = cityController.text.trim();
      map['country'] = countryController.text.trim();
      map['state'] = stateController.text.trim();
      map['zip_code'] = zipcodeController.text.trim();
      map['town'] = townController.text.trim();
      map['street'] = streetController.text.trim();
      map['special_instruction'] = specialInstructionController.text.trim();
    }

    FocusManager.instance.primaryFocus!.unfocus();
    repositories.postApi(url: ApiUrls.editAddressUrl, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      if (response.status == true) {
        Get.toNamed(CustomerAccountCreatedSuccessfullyScreen.route);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.street != null) {
      streetController.text = widget.street!;
      cityController.text = widget.city ?? '';
      stateController.text = widget.state ?? '';
      countryController.text = widget.country ?? '';
      zipcodeController.text = widget.zipcode ?? '';
      townController.text = widget.town ?? '';
    }
  }
  final profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
              'Pick up address'.tr,
              style: GoogleFonts.poppins(color: Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ],
        ),
      ),
      body: Form(
        key: formKey1,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * .02,
                ),
                Text(
                  "Where do you want to receive your orders".tr,
                  style: GoogleFonts.poppins(color: Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 16),
                ),
                SizedBox(
                  height: size.height * .02,
                ),
                InkWell(
                  onTap: (){
                    Get.to(ChooseAddress());
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Select your location on the map".tr,
                      style: GoogleFonts.poppins(color: Color(0xff044484), fontWeight: FontWeight.w400, fontSize: 14),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Text(
                  "Street*".tr,
                  style: GoogleFonts.poppins(color: const Color(0xff044484), fontWeight: FontWeight.w600, fontSize: 14),
                ),
                const SizedBox(height: 5,),
                CommonTextField(
                  controller: streetController,
                  obSecure: false,
                  hintText: 'Street'.tr,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Street is required'.tr;
                    }
                    return null; // Return null if validation passes
                  },

                ),
                const SizedBox(height: 10,),
                Text(
                  "City*".tr,
                  style: GoogleFonts.poppins(color: const Color(0xff044484), fontWeight: FontWeight.w600, fontSize: 14),
                ),
                const SizedBox(height: 5,),
                CommonTextField(
                  controller: cityController,
                  obSecure: false,
                  hintText: 'city'.tr,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'city is required'.tr;
                    }
                    return null; // Return null if validation passes
                  },
                ),
                const SizedBox(height: 10,),
                Text(
                  "State*".tr,
                  style: GoogleFonts.poppins(color: const Color(0xff044484), fontWeight: FontWeight.w600, fontSize: 14),
                ),
                const SizedBox(height: 5,),
                CommonTextField(
                  controller: stateController,
                  obSecure: false,
                  hintText: 'State'.tr,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'State is required'.tr;
                    }
                    return null; // Return null if validation passes
                  },

                ),
                const SizedBox(height: 10,),
                Text(
                  "Country*".tr,
                  style: GoogleFonts.poppins(color: const Color(0xff044484), fontWeight: FontWeight.w600, fontSize: 14),
                ),
                const SizedBox(height: 5,),
                CommonTextField(
                  controller: countryController,
                  obSecure: false,
                  hintText: 'Country'.tr,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Country is required'.tr;
                    }
                    return null; // Return null if validation passes
                  },

                ),
                const SizedBox(height: 10,),
                Text(
                  "Zip Code".tr,
                  style: GoogleFonts.poppins(color: const Color(0xff044484), fontWeight: FontWeight.w600, fontSize: 14),
                ),
                const SizedBox(height: 5,),
                CommonTextField(
                  controller: zipcodeController,
                  obSecure: false,
                  hintText: 'Zip Code'.tr,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'If you dont have any zipcode then write 99999 and make sure write a right zipcode otherwise we cant help in shipping'
                          .tr;
                    }
                    return null; // Return null if validation passes
                  },
                ),
                const SizedBox(height: 10,),
                Text(
                  "Town*".tr,
                  style: GoogleFonts.poppins(color: const Color(0xff044484), fontWeight: FontWeight.w600, fontSize: 14),
                ),
                const SizedBox(height: 5,),
                CommonTextField(
                  controller: townController,
                  obSecure: false,
                  hintText: 'Town'.tr,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Town is required'.tr;
                    }
                    return null; // Return null if validation passes
                  },
                ),
                const SizedBox(height: 10,),

                Text(
                  "Special instruction".tr,
                  style: GoogleFonts.poppins(color: const Color(0xff044484), fontWeight: FontWeight.w600, fontSize: 14),
                ),
                const SizedBox(height: 5,),
                CommonTextField(
                  controller: specialInstructionController,
                  obSecure: false,
                  hintText: 'Special instruction'.tr,

                ),
                const SizedBox(height: 10,),
                SizedBox(
                  height: size.height * .02,
                ),
                GestureDetector(
                  onTap: (){

                    if (formKey1.currentState!.validate()) {
                      editAddressApi();
                    }
                    setState(() {});
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    width: Get.width,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black, // Border color
                        width: 1.0, // Border width
                      ),
                      borderRadius: BorderRadius.circular(10), // Border radius
                    ),
                    padding: const EdgeInsets.all(10), // Padding inside the container
                    child:  Center(
                      child: Text(
                        'Confirm Your Location'.tr,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Text color
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * .02,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<Widget> commonField({
  required TextEditingController textController,
  required String title,
  required String hintText,
  required FormFieldValidator<String>? validator,
  required TextInputType keyboardType,
}) {
  return [
    const SizedBox(
      height: 5,
    ),
    Text(
      title.tr,
      style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16, color: const Color(0xff0D5877)),
    ),
    const SizedBox(
      height: 8,
    ),
    CommonTextField(
      controller: textController,
      obSecure: false,
      hintText: hintText.tr,
      validator: validator,
      keyboardType: keyboardType,
    ),
  ];
}
