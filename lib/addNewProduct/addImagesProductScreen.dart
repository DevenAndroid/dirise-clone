import 'dart:io';

import 'package:dirise/addNewProduct/myItemIsScreen.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/profile_controller.dart';
import '../model/vendor_models/model_vendor_details.dart';
import '../repository/repository.dart';
import '../vendor/authentication/image_widget.dart';
import '../vendor/products/add_product/product_gallery_images.dart';
import '../widgets/common_button.dart';

class AddImagesProductScreen extends StatefulWidget {
  const AddImagesProductScreen({super.key});

  @override
  State<AddImagesProductScreen> createState() => _AddImagesProductScreenState();
}

class _AddImagesProductScreenState extends State<AddImagesProductScreen> {
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
  final profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
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
              'Add Product'.tr,
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
                      title: "Click To Edit Uploaded  Image".tr,
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
                      title: "Click To Edit Uploaded  Video".tr,
                      file: idProof,
                      validation: checkValidation(showValidation.value, idProof.path.isEmpty),
                      filePicked: (File g) {
                        idProof = g;
                      },
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
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
                          title: "Confirm".tr,
                          file: idProof,
                          validation: checkValidation(showValidation.value, idProof.path.isEmpty),
                          filePicked: (File g) {
                            idProof = g;
                          },
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 20,
                    child: Text(
                      'Choose More'.tr,
                      style: GoogleFonts.poppins(color: const Color(0xff014E70), fontWeight: FontWeight.w600, fontSize: 12),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Container(
                margin: EdgeInsets.only(left: 10,right: 10),
                child: CustomOutlineButton(
                  title: "Upload".tr,
                  borderRadius: 11,
                  onPressed: () {
                    Get.to(MyItemISScreen());
                  },
                ),
              ),
              const SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
