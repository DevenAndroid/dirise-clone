import 'dart:convert';

import 'package:dirise/utils/api_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../iAmHereToSell/pickUpAddressForsellHere.dart';
import '../language/app_strings.dart';
import '../model/common_modal.dart';
import '../repository/repository.dart';
import '../widgets/common_button.dart';
import '../widgets/vendor_common_textfield.dart';

class ReturnPolicyScreens extends StatefulWidget {
  const ReturnPolicyScreens({super.key});

  @override
  State<ReturnPolicyScreens> createState() => _ReturnPolicyScreensState();
}

class _ReturnPolicyScreensState extends State<ReturnPolicyScreens> {

  TextEditingController titleController = TextEditingController();
  TextEditingController daysController = TextEditingController();
  TextEditingController descController = TextEditingController();
  final Repositories repositories = Repositories();
  final formKey1 = GlobalKey<FormState>();
  returnPolicyApi() {
    Map<String, dynamic> map = {};

      map['title'] = titleController.text.trim();
      map['days'] = daysController.text.trim();
      map['policy_description'] = descController.text.trim();


    FocusManager.instance.primaryFocus!.unfocus();
    repositories.postApi(url: ApiUrls.returnPolicyUrl, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      if (response.status == true) {
        showToast(response.message.toString());
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
              'Return Policy'.tr,
              style: GoogleFonts.poppins(color: Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Form(
            key: formKey1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VendorCommonTextfield(
                    controller: titleController,
                    hintText: "title".tr,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Please enter title".tr;
                      }
                      return null;
                    }),
                const SizedBox(height: 15,),
                VendorCommonTextfield(
                    controller: daysController,
                    hintText: "days".tr,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Please enter days".tr;
                      }
                      return null;
                    }),
                const SizedBox(height: 15,),
                VendorCommonTextfield(
                    controller: descController,
                    hintText: "policy description".tr,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Please enter policy description".tr;
                      }
                      return null;
                    }),
                const SizedBox(height: 15,),
                CustomOutlineButton(
                  title: 'Add',
                  onPressed: () {
                    if(formKey1.currentState!.validate()){
                      returnPolicyApi();
                    }

                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
