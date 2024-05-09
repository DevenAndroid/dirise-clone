import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../vendor/authentication/image_widget.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_textfield.dart';

class SponsorsScreen extends StatefulWidget {
  const SponsorsScreen({super.key});

  @override
  State<SponsorsScreen> createState() => _SponsorsScreenState();
}

class _SponsorsScreenState extends State<SponsorsScreen> {
  File idProof = File("");
  RxBool showValidation = false.obs;
  bool checkValidation(bool bool1, bool2) {
    if (bool1 == true && bool2 == true) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sponsors'),
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.arrow_back_ios_new)),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              CommonTextField(
                // controller: serialNumberController,
                obSecure: false,
                hintText: 'Sponsor type'.tr,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return 'Sponsor type is required'.tr;
                  }
                  return null; // Return null if validation passes
                },
              ),
              CommonTextField(
                // controller: serialNumberController,
                obSecure: false,
                hintText: 'Sponsor name'.tr,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return 'Sponsor name is required'.tr;
                  }
                  return null; // Return null if validation passes
                },
              ),
              Text(
                '+ Add more sponsor',
                style: GoogleFonts.poppins(color: Color(0xff014E70), fontWeight: FontWeight.w400, fontSize: 14),
              ),
              const SizedBox(
                height: 10,
              ),
              ImageWidget(
                // key: paymentReceiptCertificateKey,
                title: "Upload Sponsor logo".tr,
                file: idProof,
                validation: checkValidation(showValidation.value, idProof.path.isEmpty),
                filePicked: (File g) {
                  idProof = g;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '''Adding sponsor requires approval by admin,
                  Also sponsor letter is required with the following :-
              Written to DIRISE
              Not older than7 days on the day of submitting.
              Number of contact of the sponsor to verify verbally
              Email to verify electronic''',
                style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 12),
              ),
              Text(
                'Fees will apply. ',
                style: GoogleFonts.poppins(color: Color(0xffEB4335), fontWeight: FontWeight.w400, fontSize: 12),
              ),
              const SizedBox(height: 40),
              CustomOutlineButton(
                title: 'Done',
                borderRadius: 11,
                onPressed: () {},
              ),
              const SizedBox(height: 10),
              Container(
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
            ],
          ),
        ),
      ),
    );
  }
}
