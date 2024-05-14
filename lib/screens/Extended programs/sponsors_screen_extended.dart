import 'dart:io';
import 'package:dirise/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../vendor/authentication/image_widget.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_textfield.dart';
import 'optional_details_extended.dart';


class SponsorsScreenExtended extends StatefulWidget {
  const SponsorsScreenExtended({super.key});

  @override
  State<SponsorsScreenExtended> createState() => _SponsorsScreenExtendedState();
}

class _SponsorsScreenExtendedState extends State<SponsorsScreenExtended> {
  final formKey1 = GlobalKey<FormState>();
  File idProof = File("");
  List<Map<String, dynamic>> sponsorData = [];
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
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: sponsorData.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'New Field'.tr,
                            style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete,color: Colors.red,),
                            onPressed: () {
                              setState(() {
                                sponsorData.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                      10.spaceY,
                      CommonTextField(
                        controller: sponsorData[index]['typeController'],
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
                        controller: sponsorData[index]['nameController'],
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
                      SizedBox(height: 25),
                      ImageWidget(
                        title: "Upload Sponsor logo".tr,
                        file: sponsorData[index]['imageFile'],
                        validation: checkValidation(
                          showValidation.value,
                          sponsorData[index]['imageFile']?.path?.isEmpty ?? true,
                        ),
                        filePicked: (File? g) {
                          if (g != null) {
                            setState(() {
                              sponsorData[index]['imageFile'] = g;
                            });
                          }
                        },
                      ),
                    ],
                  );
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
                    int newIndex = sponsorData.length;
                    sponsorData.add({
                      'id': newIndex,
                      'typeController': TextEditingController(),
                      'nameController': TextEditingController(),
                      'imageFile': idProof,
                    });
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
                  // if(formKey1.currentState!.validate()){
                  // optionalApi();
                  // }
                  Get.to(()=> const OptionalDetailsScreenExtended());
                },
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Get.to(()=> const OptionalDetailsScreenExtended());
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
