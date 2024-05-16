import 'dart:convert';
import 'dart:io';

import 'package:dirise/screens/Consultation%20Sessions/review_screen.dart';
import 'package:dirise/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/common_modal.dart';
import '../../repository/repository.dart';
import '../../utils/api_constant.dart';
import '../../vendor/authentication/image_widget.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_textfield.dart';
import 'EligibleCustomers.dart';


class SponsorsScreen extends StatefulWidget {
  const SponsorsScreen({super.key});

  @override
  State<SponsorsScreen> createState() => _SponsorsScreenState();
}

class _SponsorsScreenState extends State<SponsorsScreen> {
  final formKey1 = GlobalKey<FormState>();
  File idProof = File("");
  List<Map<String, dynamic>> sponsorData = [];
  final Repositories repositories = Repositories();
  bool checkValidation(bool bool1, bool2) {
    if (bool1 == true && bool2 == true) {
      return true;
    } else {
      return false;
    }
  }
  RxBool showValidation = false.obs;
  TextEditingController sponsorTypeController = TextEditingController();
  TextEditingController sponsorNameController = TextEditingController();
  addSponsors() {
    Map<String, String> map = {};
    Map<String, File> images = {};
    map['sponsor_type'] = sponsorTypeController.text.trim();
    map['sponsor_name'] = sponsorNameController.text.trim();
    images['sponsor_logo'] = idProof;

    FocusManager.instance.primaryFocus!.unfocus();
    repositories.multiPartApi(onProgress: (gg,kk){},images: images,url: ApiUrls.addProductSponsor, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      print('API Response Status Code: ${response.status}');
      showToast(response.message.toString());
      if (response.status == true) {
        showToast(response.message.toString());
        if(formKey1.currentState!.validate()){
          // Get.to(()=> const SponsorsScreen());
        }
      }
    });
  }
  getSponsors() {
    repositories.getApi(url: ApiUrls.sponsorList, context: context).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      print('API Response Status Code: ${response.status}');
      showToast(response.message.toString());
      if (response.status == true) {
        showToast(response.message.toString());
      }
    });
  }
  @override
  void initState() {
    super.initState();
    getSponsors();
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
              'Sponsors'.tr,
              style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
        child: Form(
          key: formKey1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              15.spaceY,
              CommonTextField(
                controller: sponsorTypeController,
                obSecure: false,
                hintText: 'Sponsor type'.tr,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Sponsor type is required".tr;
                  }
                  return null;
                },

              ),
              CommonTextField(
                controller: sponsorNameController,
                obSecure: false,
                hintText: 'Sponsor name'.tr,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Sponsor name is required".tr;
                  }
                  return null;
                },

              ),
              25.spaceY,
              ImageWidget(
                // key: paymentReceiptCertificateKey,
                title: "Upload Sponsor logo".tr,
                file: idProof,
                validation: checkValidation(showValidation.value, idProof.path.isEmpty),
                filePicked: (File g) {
                  idProof = g;
                },
              ),
              20.spaceY,
              const Text('Adding sponsor requires approval by admin, Also sponsor letter is required with the following :- Written to DIRISE Not older than7 days on the day of submitting.Number of contact of the sponsor to verify verbally Email to verify electronic',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12
              ),
              ),
              6.spaceY,
              const Text('Fees will apply. ',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Colors.red
              ),),
              6.spaceY,
              GestureDetector(
                onTap: () {
                  setState(() {
                  });
                },
                child: const Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    '+ Add more sponsor',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              25.spaceY,
              CustomOutlineButton(
                title: 'Done',
                borderRadius: 11,
                onPressed: () {
                  if(formKey1.currentState!.validate()){
                  addSponsors();
                  }
                  // Get.to(()=> const EligibleCustomers());
                },
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Get.to(()=> const EligibleCustomers());
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
    );
  }
}
