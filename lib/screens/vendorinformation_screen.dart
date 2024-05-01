import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../addNewProduct/pickUpAddressScreen.dart';
import '../controller/profile_controller.dart';
import '../iAmHereToSell/PersonalizeAddAddressScreen.dart';
import '../iAmHereToSell/personalizeyourstoreScreen.dart';
import '../language/app_strings.dart';
import '../model/common_modal.dart';
import '../model/vendor_models/model_vendor_details.dart';
import '../repository/repository.dart';
import '../utils/api_constant.dart';
import '../widgets/common_colour.dart';
import '../widgets/common_textfield.dart';
import '../widgets/dimension_screen.dart';

class VendorInformation extends StatefulWidget {
  const VendorInformation({super.key});

  static var route = "/Vendorinformation";
  @override
  State<VendorInformation> createState() => _VendorInformationState();
}

class _VendorInformationState extends State<VendorInformation> {
  final formKey1 = GlobalKey<FormState>();
  final profileController = Get.put(ProfileController());
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController companyNumberController = TextEditingController();
  final TextEditingController storeUrlController = TextEditingController();
  final TextEditingController workEmailController = TextEditingController();
  final TextEditingController workAddressController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController bankAccountHolderNameController = TextEditingController();
  final TextEditingController bankAccountNumberController = TextEditingController();
  final TextEditingController ibanNumberController = TextEditingController();
  RxBool hide = true.obs;
  RxBool hide1 = true.obs;
  bool showValidation = false;
  final Repositories repositories = Repositories();
  String code = "+91";
  vendorInformation() {
    Map<String, dynamic> map = {};
    map['company_name'] = companyNameController.text.trim();
    map['phone'] = companyNumberController.text.trim();
    map['store_url'] = storeUrlController.text.trim();
    map['work_email'] = workEmailController.text.trim();
    map['work_address'] = workAddressController.text.trim();
    map['bank_name'] = bankNameController.text.trim();
    map['account_holder_name'] = bankAccountHolderNameController.text.trim();
    map['account_number'] = bankAccountNumberController.text.trim();
    map['ibn_number'] = ibanNumberController.text.trim();
    FocusManager.instance.primaryFocus!.unfocus();
    repositories.postApi(url: ApiUrls.editVendorDetailsUrl, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      if (response.status == true) {
        if (formKey1.currentState!.validate()) {
          Get.to(const PersonalizeyourstoreScreen());
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    profileController.getVendorDetails();
    if (profileController.modelVendorProfile.value.user != null) {
      companyNameController.text =
          profileController.modelVendorProfile.value.user!.vendorProfile!.companyName.toString();
      companyNumberController.text =
          profileController.modelVendorProfile.value.user!.phone.toString();
      storeUrlController.text = profileController.modelVendorProfile.value.user!.storeUrl.toString();
      workEmailController.text = profileController.modelVendorProfile.value.user!.vendorProfile!.workEmail.toString();
      workAddressController.text =
          profileController.modelVendorProfile.value.user!.vendorProfile!.workAddress.toString();
      bankNameController.text = profileController.modelVendorProfile.value.user!.vendorProfile!.bankName.toString();
      bankAccountHolderNameController.text =
          profileController.modelVendorProfile.value.user!.vendorProfile!.accountHolderName.toString();
      bankAccountNumberController.text =
          profileController.modelVendorProfile.value.user!.vendorProfile!.accountNumber.toString();
      ibanNumberController.text =
          profileController.modelVendorProfile.value.user!.vendorProfile!.ibnNumber.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xff0D5877),
            size: 16,
          ),
          onPressed: () {
            Get.back();
            // Handle back button press
          },
        ),
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.Vendorinformation.tr,
              style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Form(
            key: formKey1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Company Name".tr,
                  style: GoogleFonts.poppins(color: const Color(0xff044484), fontWeight: FontWeight.w500, fontSize: 14),
                ),
                const SizedBox(
                  height: 5,
                ),
                CommonTextField(
                    controller: companyNameController,
                    obSecure: false,
                    hintText: 'Company Name'.tr,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Company Name is required'),
                    ])),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Company Number".tr,
                  style: GoogleFonts.poppins(color: const Color(0xff044484), fontWeight: FontWeight.w500, fontSize: 14),
                ),
                const SizedBox(
                  height: 5,
                ),
                CommonTextField(
                    controller: companyNumberController,
                    obSecure: false,
                    hintText: 'Company Number'.tr,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Company Number is required'),
                    ])),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Store URL".tr,
                  style: GoogleFonts.poppins(color: const Color(0xff044484), fontWeight: FontWeight.w500, fontSize: 14),
                ),
                const SizedBox(
                  height: 5,
                ),
                CommonTextField(
                    controller: storeUrlController,
                    obSecure: false,
                    hintText: 'Store URL'.tr,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Store URL is required'),
                    ])),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Work Email".tr,
                  style: GoogleFonts.poppins(color: const Color(0xff044484), fontWeight: FontWeight.w500, fontSize: 14),
                ),
                const SizedBox(
                  height: 5,
                ),
                CommonTextField(
                    controller: workEmailController,
                    obSecure: false,
                    hintText: 'Work Email'.tr,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Work Email is required'),
                    ])),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Work Address".tr,
                  style: GoogleFonts.poppins(color: const Color(0xff044484), fontWeight: FontWeight.w500, fontSize: 14),
                ),
                const SizedBox(
                  height: 5,
                ),
                CommonTextField(
                    controller: workAddressController,
                    obSecure: false,
                    hintText: 'Work Address'.tr,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Work Address is required'),
                    ])),
                const SizedBox(
                  height: 13,
                ),
                Center(
                    child: Text(
                  "Bank Details",
                  style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),
                )),
                const SizedBox(
                  height: 13,
                ),
                Text(
                  "Bank Name".tr,
                  style: GoogleFonts.poppins(color: const Color(0xff044484), fontWeight: FontWeight.w500, fontSize: 14),
                ),
                const SizedBox(
                  height: 5,
                ),
                CommonTextField(
                    controller: bankNameController,
                    obSecure: false,
                    hintText: 'Bank Name'.tr,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Bank Name is required'),
                    ])),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Bank Account Holder Name".tr,
                  style: GoogleFonts.poppins(color: const Color(0xff044484), fontWeight: FontWeight.w500, fontSize: 14),
                ),
                const SizedBox(
                  height: 5,
                ),
                CommonTextField(
                    controller: bankAccountHolderNameController,
                    obSecure: false,
                    hintText: 'Bank Account Holder Name'.tr,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Bank Account Holder Name is required'),
                    ])),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Bank Account Number".tr,
                  style: GoogleFonts.poppins(color: const Color(0xff044484), fontWeight: FontWeight.w500, fontSize: 14),
                ),
                const SizedBox(
                  height: 5,
                ),
                CommonTextField(
                    controller: bankAccountNumberController,
                    obSecure: false,
                    hintText: 'Bank Account Number'.tr,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Bank Account Number is required'),
                    ])),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "IBAN Number".tr,
                  style: GoogleFonts.poppins(color: const Color(0xff044484), fontWeight: FontWeight.w500, fontSize: 14),
                ),
                const SizedBox(
                  height: 5,
                ),
                CommonTextField(
                    controller: ibanNumberController,
                    obSecure: false,
                    hintText: 'IBAN Number'.tr,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'IBAN Number is required'),
                    ])),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: ElevatedButton(
                      onPressed: () {
                        vendorInformation();
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(320, 60),
                          backgroundColor: AppTheme.buttonColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AddSize.size5)),
                          textStyle: GoogleFonts.poppins(fontSize: AddSize.font20, fontWeight: FontWeight.w600)),
                      child: Text(
                        "Update".tr,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(color: Colors.white, fontWeight: FontWeight.w500, fontSize: AddSize.font18),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
