import 'dart:convert';
import 'dart:developer';

import 'package:dirise/addNewProduct/deliverySizeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bottomavbar.dart';
import '../controller/vendor_controllers/add_product_controller.dart';
import '../language/app_strings.dart';
import '../model/common_modal.dart';
import '../repository/repository.dart';
import '../screens/auth_screens/otp_screen.dart';
import '../utils/api_constant.dart';
import '../widgets/common_button.dart';
import '../widgets/common_textfield.dart';
import 'giveawaylocation.dart';
import 'locationScreen.dart';

class AddProductPickUpAddressScreen extends StatefulWidget {
  final String? street;
  final String? city;
  final String? state;
  final String? country;
  final String? zipcode;
  final String? town;

  AddProductPickUpAddressScreen({
    Key? key,
    this.street,
    this.city,
    this.state,
    this.country,
    this.zipcode,
    this.town,
  }) : super(key: key);

  @override
  State<AddProductPickUpAddressScreen> createState() => _AddProductPickUpAddressScreenState();
}

class _AddProductPickUpAddressScreenState extends State<AddProductPickUpAddressScreen> {
  final TextEditingController streetController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController zipcodeController = TextEditingController();
  final TextEditingController townController = TextEditingController();
  final TextEditingController specialInstructionController = TextEditingController();
  final addProductController = Get.put(AddProductController());
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
        widget.zipcode != null &&
        widget.town != null) {
      map['city'] = cityController.text.trim();
      map['item_type'] = 'giveaway';
      map['state'] =  stateController.text.trim();
      map['zip_code'] = zipcodeController.text.trim();
      map['town'] = townController.text.trim();
      map['id'] = addProductController.idProduct.value.toString();
      map['street'] =  streetController.text.trim();
      map['special_instruction'] = specialInstructionController.text.trim();
    } else {
      map['city'] = cityController.text.trim();
      map['item_type'] = 'giveaway';
      map['state'] = stateController.text.trim();
      map['zip_code'] = zipcodeController.text.trim();
      map['town'] = townController.text.trim();
      map['street'] = streetController.text.trim();
      map['id'] = addProductController.idProduct.value.toString();
      map['special_instruction'] = specialInstructionController.text.trim();
    }

    FocusManager.instance.primaryFocus!.unfocus();
    repositories.postApi(url: ApiUrls.giveawayProductAddress, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      print('API Response Status Code: ${response.status}');
      showToast(response.message.toString());
      if (response.status == true) {
        Get.to(DeliverySizeScreen());
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
      zipcodeController.text = widget.zipcode ?? '';
      townController.text = widget.town ?? '';
    }
  }

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
             "Vendor address",
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
                  onTap: () {
                    // Get.toNamed("/chooseAddressScreen");
              Get.to(ChooseAddressForGiveaway());
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Select your location on the map".tr,
                      style: GoogleFonts.poppins(color: Color(0xff044484), fontWeight: FontWeight.w400, fontSize: 14),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Text(
                  "Street*".tr,
                  style: GoogleFonts.poppins(color: Color(0xff044484), fontWeight: FontWeight.w600, fontSize: 14),
                ),
                SizedBox(height: 5,),
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
                SizedBox(height: 10,),
                Text(
                  "City*".tr,
                  style: GoogleFonts.poppins(color: Color(0xff044484), fontWeight: FontWeight.w600, fontSize: 14),
                ),
                SizedBox(height: 5,),
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
                SizedBox(height: 10,),
                Text(
                  "State*".tr,
                  style: GoogleFonts.poppins(color: Color(0xff044484), fontWeight: FontWeight.w600, fontSize: 14),
                ),
                SizedBox(height: 5,),
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
                SizedBox(height: 10,),
                Text(
                  "Zip Code*".tr,
                  style: GoogleFonts.poppins(color: Color(0xff044484), fontWeight: FontWeight.w600, fontSize: 14),
                ),
                SizedBox(height: 5,),
                CommonTextField(
                   controller: zipcodeController,
                    obSecure: false,
                    hintText: 'Zip Code'.tr,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Zip Code is required'.tr;
                      }
                      return null; // Return null if validation passes
                    },
                   ),
                SizedBox(height: 10,),
                Text(
                  "Town*".tr,
                  style: GoogleFonts.poppins(color: Color(0xff044484), fontWeight: FontWeight.w600, fontSize: 14),
                ),
                SizedBox(height: 5,),
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
                SizedBox(height: 10,),

                Text(
                  "Special instruction".tr,
                  style: GoogleFonts.poppins(color: Color(0xff044484), fontWeight: FontWeight.w600, fontSize: 14),
                ),
                SizedBox(height: 5,),
                CommonTextField(
                   controller: specialInstructionController,
                    obSecure: false,
                    hintText: 'Special instruction'.tr,

                    ),
                SizedBox(height: 10,),
                SizedBox(
                  height: size.height * .02,
                ),
                CustomOutlineButton(
                  title: 'Confirm Your Location',
                  borderRadius: 11,
                  onPressed: () {
                    if (formKey1.currentState!.validate()) {
                      editAddressApi();
                    }
                    setState(() {});
                  },
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


