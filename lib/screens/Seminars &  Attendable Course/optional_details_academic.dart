import 'dart:convert';
import 'package:dirise/Services/services_classification.dart';
import 'package:dirise/controller/service_controller.dart';
import 'package:dirise/screens/Consultation%20Sessions/sponsors_screen.dart';
import 'package:dirise/screens/Seminars%20&%20%20Attendable%20Course/sponsors_academic_screen.dart';
import 'package:dirise/screens/extendedPrograms/sponsors_academic_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/vendor_controllers/add_product_controller.dart';
import '../../model/common_modal.dart';
import '../../repository/repository.dart';
import '../../utils/api_constant.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_colour.dart';
import '../../widgets/common_textfield.dart';
import 'eligible_customer_academic.dart';

class OptionalDetailsSeminarAndAttendable extends StatefulWidget {
  const OptionalDetailsSeminarAndAttendable({super.key});

  @override
  State<OptionalDetailsSeminarAndAttendable> createState() => _OptionalDetailsSeminarAndAttendableState();
}

class _OptionalDetailsSeminarAndAttendableState extends State<OptionalDetailsSeminarAndAttendable> {
  final serviceController = Get.put(ServiceController());
  RxBool hide = true.obs;
  RxBool hide1 = true.obs;
  bool showValidation = false;
  final Repositories repositories = Repositories();
  final addProductController = Get.put(AddProductController());
  final formKey1 = GlobalKey<FormState>();
  String code = "+91";
  final TextEditingController locationController = TextEditingController();
  final TextEditingController hostNameController = TextEditingController();
  final TextEditingController programNameController = TextEditingController();
  final TextEditingController programGoalController = TextEditingController();
  final TextEditingController programDescription = TextEditingController();
  final TextEditingController virtualLocationDescription = TextEditingController();
  final TextEditingController linktoenterDescription = TextEditingController();
  final TextEditingController linkwillbesentviaDescription = TextEditingController();
  optionalApi() {
    Map<String, dynamic> map = {};
    map["id"] = addProductController.idProduct.value.toString();
    map['bookable_product_location'] = locationController.text.trim();
    map['item_type'] = 'product';
    map['host_name'] = hostNameController.text.trim();
    map['program_name'] = programNameController.text.trim();
    map['program_goal'] = programGoalController.text.trim();
    map['program_desc'] = programDescription.text.trim();
    map['bookable_product_location'] = virtualLocationDescription.text.trim();
    map['optional_link'] = linktoenterDescription.text.trim();
    map['link_share_via'] = linkwillbesentviaDescription.text.trim();

    FocusManager.instance.primaryFocus!.unfocus();
    repositories.postApi(url: ApiUrls.giveawayProductAddress, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      print('API Response Status Code: ${response.status}');
      if (response.status == true) {
        showToast(response.message.toString());

        if (formKey1.currentState!.validate()) {
          Get.to(() => const SponsorsScreenSeminarAndAttendable());
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
                CommonTextField(
                  controller: virtualLocationDescription,
                  obSecure: false,
                  hintText: 'Virtual Location'.tr,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Virtual Location is required".tr;
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: locationController,
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
                  controller: programDescription,
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
                  controller: linktoenterDescription,
                  obSecure: false,
                  hintText: 'Link to enter'.tr,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Link to enter is required".tr;
                    }
                    return null;
                  },
                ),
                CommonTextField(
                  controller: linkwillbesentviaDescription,
                  obSecure: false,
                  hintText: 'Link will be sent via'.tr,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Link will be sent via is required".tr;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomOutlineButton(
                  title: 'Done',
                  borderRadius: 11,
                  onPressed: () {
                    optionalApi();
                  },
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Get.to(() =>  SponsorsScreenExtendedPrograms());
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
