import 'dart:convert';
import 'dart:developer';

import 'package:dirise/personalizeyourstore/pickupPolicyListScreen.dart';
import 'package:dirise/personalizeyourstore/shippingPolicyListScreen.dart';
import 'package:dirise/utils/helper.dart';
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
  int? id;
  String? policydesc;
  int? vendor_will_pay;
  int? handling_days;
  String? pick_option;
  PickUpPolicyPolicyScreen(
      {super.key,
      this.policyName,
      this.policydesc,
      this.vendor_will_pay,
      this.handling_days,
      this.pick_option,
      this.id});
  static var route = "/shippingPolicyScreen";

  @override
  State<PickUpPolicyPolicyScreen> createState() => _PickUpPolicyPolicyScreenState();
}

class _PickUpPolicyPolicyScreenState extends State<PickUpPolicyPolicyScreen> {
  TextEditingController policyNameController = TextEditingController();
  TextEditingController policyDescController = TextEditingController();
  TextEditingController handlingDaysController = TextEditingController();
  TextEditingController vendorWillPayController = TextEditingController();

  String selectHandlingTime = 'Select your handling time';
  String? selectedRadio;
  final formKey1 = GlobalKey<FormState>();
  final Repositories repositories = Repositories();

  String hintText = 'Enter values to calculate percentage';

  @override
  void initState() {
    super.initState();

    if (widget.policyName != null) {
      policyNameController.text = widget.policyName ?? "";
      policyDescController.text = widget.policydesc ?? "";
      vendorWillPayController.text = widget.vendor_will_pay.toString();
      handlingDaysController.text = widget.handling_days.toString();
      selectedRadio = widget.pick_option;
    }
  }
  final List<String> timeUnits = ["Minutes", "Hours", "Days", "Weeks", "Months"];
  String selectedTimeUnit = 'Minutes';
  @override
  void dispose() {
    super.dispose();
  }

  pickUpPolicyApi() {
    Map<String, dynamic> map = {};

    if (widget.id != null) {
      map['title'] = policyNameController.text.trim();
      map['description'] = policyDescController.text.trim();
      map['vendor_will_pay'] = vendorWillPayController.text.trim();
      map['handling_days'] = handlingDaysController.text.trim();
      map['pick_option'] = selectedRadio;
      map['id'] = widget.id;
    }

    map['title'] = policyNameController.text.trim();
    map['description'] = policyDescController.text.trim();
    map['vendor_will_pay'] = vendorWillPayController.text.trim();
    map['handling_days'] = handlingDaysController.text.trim();
    map['pick_option'] = selectedRadio;
    log("API Request Map: ${map.toString()}");

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
            margin: EdgeInsets.only(left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                  child: Text("Policy Name", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
                ),
                const SizedBox(
                  height: 8,
                ),
                CommonTextField(
                    contentPadding: const EdgeInsets.all(5),
                    controller: policyNameController,
                    obSecure: false,
                    hintText: 'Policy name',
                    validator: MultiValidator([
                      RequiredValidator(
                          errorText: 'Policy name must be required'
                              .tr),
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
                  child: Text("Pick Up Option", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600)),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Radio<String>(
                          value: 'dropoff_package',
                          groupValue: selectedRadio,
                          onChanged: (String? value) {
                            setState(() {
                              selectedRadio = value;
                              log(selectedRadio.toString());
                            });
                          },
                        ),
                        Expanded(
                          child: Text("I want to drop off my package at my local shipping carrier",
                              style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400)),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Radio<String>(
                          value: 'picked_from_my_location',
                          groupValue: selectedRadio,
                          onChanged: (String? value) {
                            setState(() {
                              selectedRadio = value;
                              log(selectedRadio.toString());
                            });
                          },
                        ),
                        Expanded(
                          child: Text("I want the package to be picked up from my location.",
                              style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400)),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Radio<String>(
                          value: 'split_charges',
                          groupValue: selectedRadio,
                          onChanged: (String? value) {
                            setState(() {
                              selectedRadio = value;
                              log(selectedRadio.toString());
                            });
                          },
                        ),
                        Expanded(
                          child: Text(
                              "Always schedule a pick up for me but split the charge between me and my customer",
                              style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400)),
                        )
                      ],
                    ),
                  ],
                ),
                selectedRadio == "split_charges"
                    ? Row(
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
                              controller: vendorWillPayController,
                              keyboardType: TextInputType.number,
                              obSecure: false,
                              hintText: 'Amount per package',
                            ),
                          ),
                        ],
                      )
                    : SizedBox(),
                const SizedBox(
                  height: 10,
                ),
                Text(
                    "''* We try to make your experience as easy and affordable as possible. However, extra fees might apply according to your location and the nearest shipping carrier. Fees typically range from 5 to 15. This fee is not determined by DIRISE and we cant predict until we organize your shipment with our partners in your country.''",
                    style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.red)),
                const SizedBox(
                  height: 10,
                ),
                Text("Handling time", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
                const SizedBox(
                  height: 10,
                ),
                Text(
                    "The time that you need to process the order and get it ready to be shipped or dropped off to the shipping company.",
                    style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: selectedTimeUnit,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedTimeUnit = newValue!;
                          });
                        },
                        items: timeUnits.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          fillColor: const Color(0xffE2E2E2).withOpacity(.35),
                          contentPadding:
                          const EdgeInsets.symmetric(horizontal: 15, vertical: 15).copyWith(right: 8),
                          focusedErrorBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(color: AppTheme.secondaryColor)),
                          errorBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(color: Color(0xffE2E2E2))),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(color: AppTheme.secondaryColor)),
                          disabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: AppTheme.secondaryColor),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: AppTheme.secondaryColor),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select an item';
                          }
                          return null;
                        },
                      ),
                    ),
                    10.spaceX,
                    Expanded(
                      child: CommonTextField(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 15,),
                          controller: handlingDaysController,
                          keyboardType: TextInputType.number,
                          obSecure: false,
                          hintText: 'Select Your handling time',
                          validator: MultiValidator([
                            RequiredValidator(errorText: 'handling time must be required'.tr),
                          ])),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomOutlineButton(
                    title: 'Next',
                    borderRadius: 11,
                    onPressed: () {
                      if (formKey1.currentState!.validate()) {
                        if (selectedRadio == 'dropoff_package' ||
                            selectedRadio == 'picked_from_my_location' ||
                            selectedRadio == 'split_charges') {
                          pickUpPolicyApi();
                        } else {
                          showToast('Please select PickUp Fees');
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
}
