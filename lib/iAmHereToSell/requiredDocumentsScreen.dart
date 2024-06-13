import 'dart:convert';
import 'dart:io';

import 'package:dirise/iAmHereToSell/requiredInformationImageScreen.dart';
import 'package:dirise/iAmHereToSell/securityDetailsScreen.dart';
import 'package:dirise/iAmHereToSell/verificationOptiionScreen.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../controller/profile_controller.dart';
import '../controller/vendor_controllers/add_product_controller.dart';
import '../model/common_modal.dart';
import '../model/vendor_models/model_vendor_details.dart';
import '../repository/repository.dart';
import '../utils/api_constant.dart';
import '../utils/helper.dart';
import '../vendor/authentication/image_widget.dart';
import '../vendor/products/add_product/product_gallery_images.dart';
import '../vendor/products/add_product/vertual_product_and_image.dart';
import '../widgets/common_button.dart';
import '../widgets/dimension_screen.dart';
import '../widgets/vendor_common_textfield.dart';

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
  final controller = Get.put(AddProductController());
  final profileController = Get.put(ProfileController());

  File payment_certificate = File("");
  File commercial_license = File("");
  File memorandum_of_association = File("");
  File ministy_of_commerce = File("");
  File original_civil_information = File("");
  File signature_approval = File("");
  File company_bank_account = File("");
  Map<String, File> images = {};
  void updateProfile() {
    Map<String, String> map = {};
    images["payment_certificate"] = payment_certificate;
    images["commercial_license"] = commercial_license;
    images["memorandum_of_association"] = memorandum_of_association;
    images["ministy_of_commerce"] = ministy_of_commerce;
    images["original_civil_information"] = original_civil_information;
    images["signature_approval"] = signature_approval;
    images["company_bank_account"] = company_bank_account;

    repositories
        .multiPartApi(
        mapData: map,
        images: images,
        context: context,
        url: ApiUrls.editVendorDetailsUrl,
        onProgress: (int bytes, int totalBytes) {

        })
        .then((value) {
      showToast('Add Image successfully');
      Get.to(const VerificationOptionScreen());

    });
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
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
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
              'Required Documents'.tr,
              style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              Text(
                'You can set later, but your experience will be limited untill you submit all'.tr,
                style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 13),
              ),
              profileController.selectedPlan == '1' ?
              Column(
                children: [
                  ImageWidget(
                    // key: paymentReceiptCertificateKey,
                    title: "Id Card Front".tr,
                    file: commercial_license,
                    validation: checkValidation(showValidation.value, commercial_license.path.isEmpty),
                    filePicked: (File g) {
                      commercial_license = g;
                    },
                  ),
                  ImageWidget(
                    // key: paymentReceiptCertificateKey,
                    title: "Id Card Back".tr,
                    file: memorandum_of_association,
                    validation: checkValidation(showValidation.value, memorandum_of_association.path.isEmpty),
                    filePicked: (File g) {
                      memorandum_of_association = g;
                    },
                  ),
                  ImageWidget(
                    // key: paymentReceiptCertificateKey,
                    title: "Bank Statement".tr,
                    file: ministy_of_commerce,
                    validation: checkValidation(showValidation.value, ministy_of_commerce.path.isEmpty),
                    filePicked: (File g) {
                      ministy_of_commerce = g;
                    },
                  ),
                  ImageWidget(
                    // key: paymentReceiptCertificateKey,
                    title: "Documents".tr,
                    file: original_civil_information,
                    validation: checkValidation(showValidation.value, original_civil_information.path.isEmpty),
                    filePicked: (File g) {
                      original_civil_information = g;
                    },
                  ),
                  ImageWidget(
                    // key: paymentReceiptCertificateKey,
                    title: "Other".tr,
                    file: signature_approval,
                    validation: checkValidation(showValidation.value, signature_approval.path.isEmpty),
                    filePicked: (File g) {
                      signature_approval = g;
                    },
                  ),
                  ImageWidget(
                    // key: paymentReceiptCertificateKey,
                    title: "Documents".tr,
                    file: company_bank_account,
                    validation: checkValidation(showValidation.value, company_bank_account.path.isEmpty),
                    filePicked: (File g) {
                      company_bank_account = g;
                    },
                  ),

                ],
              ):const SizedBox(),
              profileController.selectedPlan == '2' ?
              ImageWidget(
                // key: paymentReceiptCertificateKey,
                title: "Documents".tr,
                file: payment_certificate,
                validation: checkValidation(showValidation.value, payment_certificate.path.isEmpty),
                filePicked: (File g) {
                  payment_certificate = g;
                },
              )
                  :const SizedBox(),
              profileController.selectedPlan == '3' ?
              ImageWidget(
                // key: paymentReceiptCertificateKey,
                title: "Documents".tr,
                file: payment_certificate,
                validation: checkValidation(showValidation.value, payment_certificate.path.isEmpty),
                filePicked: (File g) {
                  payment_certificate = g;
                },
              )
                  :const SizedBox(),
              const SizedBox(
                height: 20,
              ),
              CustomOutlineButton(
                title: "Upload".tr,
                onPressed: () {
                  if(payment_certificate.path.isEmpty &&
                      commercial_license.path.isEmpty &&
                      memorandum_of_association.path.isEmpty){
                    showToast('Please select Required Documents');
                  }else
                  {
                    updateProfile();
                  }

                },
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {

                  Get.to(const VerificationOptionScreen());
                },
                child: Container(
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text(
          'Select Picture from',
          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () {
              Helpers.addImagePicker(imageSource: ImageSource.camera, imageQuality: 50).then((value) async {
                CroppedFile? croppedFile = await ImageCropper().cropImage(
                  sourcePath: value.path,
                  aspectRatioPresets: [
                    // CropAspectRatioPreset.square,
                    // CropAspectRatioPreset.ratio3x2,
                    // CropAspectRatioPreset.original,
                    CropAspectRatioPreset.ratio4x3,
                    // CropAspectRatioPreset.ratio16x9
                  ],
                  uiSettings: [
                    AndroidUiSettings(
                        toolbarTitle: 'Cropper',
                        toolbarColor: Colors.deepOrange,
                        toolbarWidgetColor: Colors.white,
                        initAspectRatio: CropAspectRatioPreset.ratio4x3,
                        lockAspectRatio: true),
                    IOSUiSettings(title: 'Cropper', aspectRatioLockEnabled: true),
                    WebUiSettings(
                      context: context,
                    ),
                  ],
                );
                if (croppedFile != null) {
                  controller.productImage = File(croppedFile.path);
                  setState(() {});
                }

                Get.back();
              });
            },
            child: const Text("Camera"),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Helpers.addImagePicker(imageSource: ImageSource.gallery, imageQuality: 75).then((value) async {
                CroppedFile? croppedFile = await ImageCropper().cropImage(
                  sourcePath: value.path,
                  aspectRatioPresets: [
                    // CropAspectRatioPreset.square,
                    // CropAspectRatioPreset.ratio3x2,
                    // CropAspectRatioPreset.original,
                    CropAspectRatioPreset.ratio4x3,
                    // CropAspectRatioPreset.ratio16x9
                  ],
                  uiSettings: [
                    AndroidUiSettings(
                        toolbarTitle: 'Cropper',
                        toolbarColor: Colors.deepOrange,
                        toolbarWidgetColor: Colors.white,
                        initAspectRatio: CropAspectRatioPreset.ratio4x3,
                        lockAspectRatio: true),
                    IOSUiSettings(
                      title: 'Cropper',
                      aspectRatioLockEnabled: true,
                      minimumAspectRatio: 4.3,
                    ),
                    WebUiSettings(
                      context: context,
                    ),
                  ],
                );
                if (croppedFile != null) {
                  controller.productImage = File(croppedFile.path);
                  setState(() {});
                }

                Get.back();
              });
            },
            child: const Text('Gallery'),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Get.back();
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  GestureDetector productImageWidget(BuildContext context, double height) {
    return GestureDetector(
      onTap: () {
        // showActionSheet(context);
        showActionSheet(context);
      },
      child: DottedBorder(
        radius: const Radius.circular(10),
        borderType: BorderType.RRect,
        dashPattern: const [3, 5],
        color: Colors.grey.shade500,
        strokeWidth: 1,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding16),
          width: AddSize.screenWidth,
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: controller.productImage.path.isNotEmpty
              ? Container(
            constraints: BoxConstraints(minHeight: 0, maxHeight: context.getSize.width * .36),
            child: Image.file(
              controller.productImage,
              errorBuilder: (_, __, ___) => Image.network(
                controller.productImage.path,
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              ),
            ),
          )
              : Column(
            children: [
              const Image(
                height: 30,
                image: AssetImage(
                  'assets/icons/pdfdownload.png',
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "Upload Product image".tr,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w300, color: const Color(0xff463B57), fontSize: AddSize.font14),
              ),
              SizedBox(
                height: height * .01,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
