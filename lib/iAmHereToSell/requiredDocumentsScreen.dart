import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/vendor_models/model_vendor_details.dart';
import '../repository/repository.dart';
import '../vendor/authentication/image_widget.dart';
import '../vendor/products/add_product/product_gallery_images.dart';
import '../widgets/common_button.dart';

class RequiredDocumentsScreen extends StatefulWidget {
  const RequiredDocumentsScreen({super.key});

  @override
  State<RequiredDocumentsScreen> createState() => _RequiredDocumentsScreenState();
}

class _RequiredDocumentsScreenState extends State<RequiredDocumentsScreen> {
  File idProof = File("");
  bool checkValidation(bool bool1, bool2) {
    if (bool1 == true && bool2 == true) {
      return true;
    } else {
      return false;
    }
  }
  ModelVendorDetails model = ModelVendorDetails();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey categoryKey = GlobalKey();
  final GlobalKey idProofKey = GlobalKey();
  final Repositories repositories = Repositories();
  bool apiLoaded = false;
  RxInt refreshInt = 0.obs;
  RxBool showValidation = false.obs;
  get updateUI => refreshInt.value = DateTime.now().millisecondsSinceEpoch;
  File storeBanner = File("");
  Map<String, File> images = {};
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
              'Required Documents'.tr,
              style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 10,right: 10),
          child: Column(
            children: [
              Text(
                'You can set later, but your experience will be limited untill you submit all'.tr,
                style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 13),
              ),
              Container(
                margin: const EdgeInsets.only(left: 15,right: 15,bottom: 10,top: 15),
                padding: const EdgeInsets.only(left: 15,right: 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(11),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(
                          0.2,
                          0.2,
                        ),
                        blurRadius: 1,
                      ),
                    ]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    ImageWidget(
                      // key: paymentReceiptCertificateKey,
                      title: "Id Card Front".tr,
                      file: idProof,
                      validation: checkValidation(showValidation.value, idProof.path.isEmpty),
                      filePicked: (File g) {
                        idProof = g;
                      },
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 15,right: 15,bottom: 10),
                padding: const EdgeInsets.only(left: 15,right: 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(11),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(
                          0.2,
                          0.2,
                        ),
                        blurRadius: 1,
                      ),
                    ]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ImageWidget(
                      // key: paymentReceiptCertificateKey,
                      title: "Id Card Back".tr,
                      file: idProof,
                      validation: checkValidation(showValidation.value, idProof.path.isEmpty),
                      filePicked: (File g) {
                        idProof = g;
                      },
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 15,right: 15,bottom: 10),
                padding: const EdgeInsets.only(left: 15,right: 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(11),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(
                          0.2,
                          0.2,
                        ),
                        blurRadius: 1,
                      ),
                    ]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ImageWidget(
                      // key: paymentReceiptCertificateKey,
                      title: "Bank Statement".tr,
                      file: idProof,
                      validation: checkValidation(showValidation.value, idProof.path.isEmpty),
                      filePicked: (File g) {
                        idProof = g;
                      },
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 15,right: 15,bottom: 10),
                padding: const EdgeInsets.only(left: 15,right: 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(11),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(
                          0.2,
                          0.2,
                        ),
                        blurRadius: 1,
                      ),
                    ]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ImageWidget(
                      // key: paymentReceiptCertificateKey,
                      title: "other".tr,
                      file: idProof,
                      validation: checkValidation(showValidation.value, idProof.path.isEmpty),
                      filePicked: (File g) {
                        idProof = g;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              CustomOutlineButton(
                title: "Upload".tr,
                onPressed: () {
                },
              ),
              const SizedBox(height: 20,),
              Container(

                width: Get.width,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey, // Border color
                    width: 1.0, // Border width
                  ),
                  borderRadius: BorderRadius.circular(2), // Border radius
                ),
                padding: const EdgeInsets.all(10), // Padding inside the container
                child: const Center(
                  child: Text(
                    'I will set later',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff514949), // Text color
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
