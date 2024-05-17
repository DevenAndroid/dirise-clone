import 'dart:convert';
import 'dart:developer';

import 'package:dirise/personalizeyourstore/pickupPolicyListScreen.dart';
import 'package:dirise/personalizeyourstore/shippingPolicyListScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../language/app_strings.dart';
import '../model/common_modal.dart';
import '../repository/repository.dart';
import '../singleproductScreen/singlePInternationalshippingdetails.dart';
import '../utils/api_constant.dart';
import '../widgets/common_button.dart';
import '../widgets/common_colour.dart';
import '../widgets/common_textfield.dart';

class PickUpPolicyPolicyScreen extends StatefulWidget {
  String? policyName;
  int?     id;
  String? policydesc;
  String? vendor_will_pay;
  int?    handling_days;
  int?  pick_option;
  PickUpPolicyPolicyScreen(
      {super.key, this.policyName, this.policydesc, this.vendor_will_pay, this.handling_days,this.pick_option, this.id});
  static var route = "/shippingPolicyScreen";

  @override
  State<PickUpPolicyPolicyScreen> createState() => _PickUpPolicyPolicyScreenState();
}

class _PickUpPolicyPolicyScreenState extends State<PickUpPolicyPolicyScreen> {
  TextEditingController policyNameController = TextEditingController();
  TextEditingController policyDescController = TextEditingController();
  TextEditingController policyPriceController = TextEditingController();
  TextEditingController policyDaysController = TextEditingController();

  String selectHandlingTime = 'Select your handling time';
  int? selectedRadio;
  final formKey1 = GlobalKey<FormState>();
  final Repositories repositories = Repositories();

  String hintText = 'Enter values to calculate percentage';

  @override
  void initState() {
    super.initState();

    if (widget.policyName != null) {
      policyNameController.text = widget.policyName ?? "";
      policyDescController.text = widget.policydesc ?? "";
      policyPriceController.text = widget.vendor_will_pay.toString();
      policyPriceController.text = widget.handling_days.toString();
      selectedRadio = widget.pick_option;

      // daysItem = widget.daysItem ?? "";
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  pickUpPolicyApi(String deliverySize) {
    Map<String, dynamic> map = {};
    map['title'] = policyNameController.text.trim();
    map['description'] = policyDescController.text.trim();
    map['vendor_will_pay'] = policyPriceController.text.trim();
    map['handling_days'] = policyDaysController.text.trim();
    map['pick_option'] = selectedRadio;

    FocusManager.instance.primaryFocus!.unfocus();
    repositories.postApi(url: ApiUrls.vendorPickUpPolicy, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      if (response.status == true) {
        Get.to(const PickUpPolicyListScreen());
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "PickUp Policy",
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.arrow_back)),
        automaticallyImplyLeading: false,
        // centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey1,
          child: Container(
            margin: EdgeInsets.only(left: 15,right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  children: [
                    // Radio(value: 1, groupValue: 1, onChanged: (value) {}),
                    Text("Item Is Not eligible for shipping",
                        style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w600)),
                    const SizedBox(
                      width: 20,
                    ),
                    Text("Add New Policy+",
                        style: GoogleFonts.poppins(
                            fontSize: 10, fontWeight: FontWeight.w600, color: const Color(0xff292F45))),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text("Policy Name", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
                ),
                const SizedBox(
                  height: 8,
                ),
                CommonTextField(
                    contentPadding: const EdgeInsets.all(5),
                    controller: policyNameController,
                    obSecure: false,
                    hintText: 'DIRISE standard Policy',
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Weight Of the Item is required'.tr),
                    ])),
                const SizedBox(
                  height: 18,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text("Policy Description (Optional)",
                      style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
                ),
                const SizedBox(
                  height: 8,
                ),
                CommonTextField(
                  contentPadding: const EdgeInsets.all(5),
                  controller: policyDescController,
                  isMulti: true,
                  obSecure: false,
                  hintText: '',
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text("Pick Up Option",
                      style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
                ),

                Column(
                  children: [
                    buildRadioTile('I want to drop off my package at my local shipping carrier', 1),
                    buildRadioTile('I want the package to be picked up from my location.', 2),
                    buildRadioTile('Always schedule a pick up for me but split the charge between me and my customer', 3),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.only(left: 15, top: 12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text('I will pay up to '),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: CommonTextField(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                        controller: policyPriceController,
                        keyboardType: TextInputType.number,
                        obSecure: false,
                        hintText: 'Amount per package',
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),

                Text("''* We try to make your experience as easy and affordable as possible. However, extra fees might apply according to your location and the nearest shipping carrier. Fees typically range from 5 to 15. This fee is not determined by DIRISE and we cant predict until we organize your shipment with our partners in your country.''",
                    style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w600,color:Colors.red)
                ),
                const SizedBox(
                  height: 10,
                ),

                Text("Handling time",
                    style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
                const SizedBox(
                  height: 10,
                ),

                Text("The time that you need to process the order and get it ready to be shipped or dropped off to the shipping company.",
                    style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),

                const SizedBox(
                  height: 10,
                ),
                CommonTextField(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  controller: policyDaysController,
                  keyboardType: TextInputType.number,
                  obSecure: false,
                  hintText: 'Select Your handling time',
                ),
                CustomOutlineButton(
                    title: 'Next',
                    borderRadius: 11,
                    onPressed: () {
                      if (formKey1.currentState!.validate()) {
                        if (selectedRadio == 1) {
                          pickUpPolicyApi('dropoff_package');
                        } else if (selectedRadio == 2) {
                          pickUpPolicyApi('picked_from_my_location');
                        } else if (selectedRadio == 3) {
                          pickUpPolicyApi('split_charges');
                        } else {
                          showToast('Select pickUp Option size');
                        }
                      }
                    }),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRadioTile(String title, int value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Radio(
          value: value,
          groupValue: selectedRadio,
          onChanged: (int? newValue) {
            setState(() {
              selectedRadio = newValue;
            });
          },
        ),
        Expanded(
          child: Text(
            title,
            style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 14),
          ),
        ),
      ],
    );
  }
}
