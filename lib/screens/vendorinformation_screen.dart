import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../addNewProduct/pickUpAddressScreen.dart';
import '../iAmHereToSell/PersonalizeAddAddressScreen.dart';
import '../iAmHereToSell/personalizeyourstoreScreen.dart';
import '../language/app_strings.dart';
import '../model/common_modal.dart';
import '../repository/repository.dart';
import '../utils/api_constant.dart';
import '../widgets/common_colour.dart';
import '../widgets/dimension_screen.dart';

class VendorInformation extends StatefulWidget {
  const VendorInformation({super.key});

  static var route = "/Vendorinformation";
  @override
  State<VendorInformation> createState() => _VendorInformationState();
}

class _VendorInformationState extends State<VendorInformation> {
  final formKey1 = GlobalKey<FormState>();

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
  bool? _isValue = false;
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
      showToast(response.message.toString());
      if (response.status == true) {
        Get.to(const PersonalizeyourstoreScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Color(0xff0D5877),
              size: 16,
            ),
            onPressed: () {
              // Handle back button press
            },
          ),
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
        physics: ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...commonField(
                  hintText: "Company Name",
                  textController: companyNameController,
                  title: 'Company Name',
                  validator: (String? value) {},
                  keyboardType: TextInputType.name),
              ...commonField(
                  hintText: "Company Number",
                  textController: companyNumberController,
                  title: 'Company Number',
                  validator: (String? value) {},
                  keyboardType: TextInputType.number),
              ...commonField(
                  hintText: "Store URL",
                  textController: storeUrlController,
                  title: 'Store URL',
                  validator: (String? value) {},
                  keyboardType: TextInputType.name),
              ...commonField(
                  hintText: "Work Email",
                  textController: workEmailController,
                  title: 'Work Email',
                  validator: (String? value) {},
                  keyboardType: TextInputType.name),
              ...commonField(
                  hintText: "Work Address",
                  textController: workAddressController,
                  title: 'Work Address',
                  validator: (String? value) {},
                  keyboardType: TextInputType.name),
              SizedBox(
                height: 13,
              ),
              Center(
                  child: Text(
                "Bank Details",
                style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),
              )),
              SizedBox(
                height: 13,
              ),
              ...commonField(
                  textController: bankNameController,
                  title: 'Bank Name',
                  validator: (String? value) {},
                  keyboardType: TextInputType.name,
                  hintText: ''),
              ...commonField(
                  hintText: "",
                  textController: bankAccountHolderNameController,
                  title: 'Bank Account Holder Name',
                  validator: (String? value) {},
                  keyboardType: TextInputType.name),
              ...commonField(
                  hintText: "",
                  textController: bankAccountNumberController,
                  title: "Bank Account Number",
                  validator: (String? value) {},
                  keyboardType: TextInputType.number),
              ...commonField(
                  hintText: "",
                  textController: ibanNumberController,
                  title: 'IBAN Number',
                  validator: (String? value) {},
                  keyboardType: TextInputType.name),
              SizedBox(
                height: 13,
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
    );
  }
}
