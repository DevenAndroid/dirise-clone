import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dirise/screens/Consultation%20Sessions/review_screen.dart';
import 'package:dirise/utils/helper.dart';
import 'package:dirise/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/profile_controller.dart';
import '../../controller/vendor_controllers/add_product_controller.dart';
import '../../model/common_modal.dart';
import '../../model/sponsors_list_model.dart';
import '../../repository/repository.dart';
import '../../utils/api_constant.dart';
import '../../vendor/authentication/image_widget.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_colour.dart';
import '../../widgets/common_textfield.dart';
import '../../widgets/dimension_screen.dart';
import 'optional_details_academic.dart';

class SponsorsScreenAcademic extends StatefulWidget {
  int? id;
  String? sponsorType;
  String? sponsorName;
  String? image;
  dynamic sponsorsID;

  SponsorsScreenAcademic({super.key, this.id, this.sponsorName, this.sponsorType,this.sponsorsID,this.image});

  @override
  State<SponsorsScreenAcademic> createState() => _SponsorsScreenAcademicState();
}

class _SponsorsScreenAcademicState extends State<SponsorsScreenAcademic> {
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

  String sponsorValue = '';
  String sponsorImage = '';
  RxBool showValidation = false.obs;
  TextEditingController sponsorTypeController = TextEditingController();
  TextEditingController sponsorNameController = TextEditingController();
  Rx<SponsorsDetailsModel> sponsorsDetailsModel = SponsorsDetailsModel().obs;
  final addProductController = Get.put(AddProductController());
  addSponsors() {
    Map<String, String> map = {};
    Map<String, File> images = {};
    map['sponsor_type'] = sponsorTypeController.text.trim();
    map['sponsor_name'] = sponsorNameController.text.trim();
    images['sponsor_logo'] = idProof;
// map["id"] =  addProductController.idProduct.value.toString();

    FocusManager.instance.primaryFocus!.unfocus();
    repositories
        .multiPartApi(
            onProgress: (gg, kk) {}, images: images, url: ApiUrls.addProductSponsor, context: context, mapData: map)
        .then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      print('API Response Status Code: ${response.status}');
      showToast(response.message.toString());
      if (response.status == true) {
        showToast(response.message.toString());
        if (formKey1.currentState!.validate()) {
          getSponsors();
          setState(() {});
          sponsorTypeController.clear();
          sponsorNameController.clear();
          setState(() {
            idProof = File("");
            sponsorImage = '';
          });
        }
      }
    });
  }

  getSponsors() {
    repositories.getApi(url: ApiUrls.sponsorList).then((value) {
      sponsorsDetailsModel.value = SponsorsDetailsModel.fromJson(jsonDecode(value));
      if (sponsorsDetailsModel.value.status == true) {
        showToast(sponsorsDetailsModel.value.message.toString());
      } else {
        showToast(sponsorsDetailsModel.value.message.toString());
      }
    });
  }

  createSponsors() {
    Map<String, dynamic> map = {};
    map['product_sponsors_id'] = sponsorValue.toString();
    map["id"] = addProductController.idProduct.value.toString();
    FocusManager.instance.primaryFocus!.unfocus();
    repositories.postApi(url: ApiUrls.giveawayProductAddress, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      print('API Response Status Code: ${response.status}');
// showToast(response.message.toString());
      if (response.status == true) {
        showToast(response.message.toString());
        if (formKey1.currentState!.validate()) {
          if (widget.id != null) {
            Get.to(() => const ReviewScreen());
          } else {
            Get.to(() => OptionalDetailsAcademicScreen());
          }
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getSponsors();
    });
    if (widget.id != null) {
      sponsorTypeController.text = widget.sponsorType.toString();
      sponsorNameController.text = widget.sponsorName.toString();
      idProof = File(widget.image.toString());
      sponsorValue = widget.sponsorsID.toString();
    }
  }

  final profileController = Get.put(ProfileController());
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                profileController.selectedLAnguage.value != 'English'
                    ? Image.asset(
                        'assets/images/forward_icon.png',
                        height: 19,
                        width: 19,
                      )
                    : Image.asset(
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
                'Sponsors'.tr,
                style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 20),
              ),
            ],
          ),
        ),
        body: Obx(() {
          return sponsorsDetailsModel.value.data != null
              ? SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Form(
                    key: formKey1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sponsorsDetailsModel.value.data != null
                            ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(8)),
                                      borderSide: BorderSide(color: AppTheme.secondaryColor),
                                    ),
                                    enabled: true,
                                    filled: true,
                                    hintText: "Select Sponsor Type".tr,
                                    labelStyle: GoogleFonts.poppins(color: Colors.black),
                                    labelText: "Select Sponsor Type".tr,
                                    fillColor: const Color(0xffE2E2E2).withOpacity(.35),
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                                    enabledBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(8)),
                                      borderSide: BorderSide(color: AppTheme.secondaryColor),
                                    ),
                                  ),
                                  isExpanded: true,
                                  items: sponsorsDetailsModel.value.data!
                                      .map((e) => DropdownMenuItem(
                                            value: e.id.toString(),
                                            child: Row(
                                              children: [
                                                Expanded(child: Text(e.sponsorType.toString())),
                                                SizedBox(
                                                    width: 35,
                                                    height: 35,
                                                    child: Image.network(e.sponsorLogo.toString()))
                                              ],
                                            ),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    if (value == null) return;
                                    final selectedSponsor = sponsorsDetailsModel.value.data!
                                        .firstWhere((element) => element.id.toString() == value);
                                    sponsorValue = value;
                                    sponsorTypeController.text = selectedSponsor.sponsorType.toString();
                                    sponsorNameController.text = selectedSponsor.sponsorName.toString();
                                    sponsorImage = selectedSponsor.sponsorLogo.toString();
                                    setState(() {});
                                  },
                                ),
                              ])
                            : const SizedBox.shrink(),
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
                        const SizedBox(
                          height: 10,
                        ),
                        CommonTextField(
                          controller: sponsorNameController,
                          obSecure: false,
                          hintText: 'Sponsor name'.tr,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Sponsor name is required".tr;
                            }
                            return null;
                          },
                        ),
                        25.spaceY,
                        sponsorImage.isEmpty
                            ? ImageWidget(
// key: paymentReceiptCertificateKey,
                                title: "Upload Sponsor logo".tr,
                                file: idProof,
                                validation: checkValidation(showValidation.value, idProof.path.isEmpty),
                                filePicked: (File g) {
                                  idProof = g;
                                },
                              )
                            : Container(
                                padding:
                                    EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding16),
                                width: AddSize.screenWidth,
                                height: context.getSize.width * .38,
                                decoration: BoxDecoration(
                                    color: const Color(0xffE2E2E2).withOpacity(.4),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    )),
                                child: CachedNetworkImage(
                                  imageUrl: sponsorImage.toString(),
                                  errorWidget: (context, url, error) {
                                    return const SizedBox.shrink();
                                  },
                                ),
                              ),
                        20.spaceY,
                        const Text(
                          'Adding sponsor requires approval by admin, Also sponsor letter is required with the following :- Written to DIRISE Not older than7 days on the day of submitting.Number of contact of the sponsor to verify verbally Email to verify electronic',
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                        ),
                        6.spaceY,
                        const Text(
                          'Fees will apply. ',
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: Colors.red),
                        ),
                        6.spaceY,
                        sponsorImage.isEmpty
                            ? GestureDetector(
                                onTap: () {
                                  if (formKey1.currentState!.validate()) {
                                    addSponsors();
                                  }
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
                              )
                            : const SizedBox(),
                        25.spaceY,
                        CustomOutlineButton(
                          title: 'Done',
                          borderRadius: 11,
                          onPressed: () {
                            if (sponsorValue != '') {
                              createSponsors();
                            } else {
                              showToastCenter('Select Sponsor Type');
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            if (widget.id != null) {
                              Get.to(() => const ReviewScreen());
                            } else {
                              Get.to(() => OptionalDetailsAcademicScreen());
                            }
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
                )
              : const Center(child: LoadingAnimation());
        }));
  }
}
