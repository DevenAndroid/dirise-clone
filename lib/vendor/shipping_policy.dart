import 'dart:convert';
import 'dart:developer';

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

class ShippingPolicyScreen extends StatefulWidget {

  String? policyName;
  int? id;
  String? policydesc;
  int? policyDiscount;
  int? priceLimit;
  ShippingPolicyScreen({super.key, this.policyName, this.policydesc, this.policyDiscount, this.priceLimit,this.id});
  static var route = "/shippingPolicyScreen";

  @override
  State<ShippingPolicyScreen> createState() => _ShippingPolicyScreenState();
}

class _ShippingPolicyScreenState extends State<ShippingPolicyScreen> {
  TextEditingController policyNameController = TextEditingController();
  TextEditingController policyDescController = TextEditingController();
  TextEditingController policyPriceController = TextEditingController();
  TextEditingController iPayController = TextEditingController();
  TextEditingController from1KWDController = TextEditingController();
  TextEditingController upTo20Controller = TextEditingController();
  TextEditingController thenController = TextEditingController();
  TextEditingController from2KWDController = TextEditingController();
  TextEditingController upTo40Controller = TextEditingController();
  TextEditingController calculatedPercentageController = TextEditingController();

  String selectHandlingTime = 'Select your handling time';
  int? selectedRadio;
  final formKey1 = GlobalKey<FormState>();
  final Repositories repositories = Repositories();

  String hintText = 'Enter values to calculate percentage';

  void updateHintText() {
    if (thenController.text.isNotEmpty && upTo40Controller.text.isNotEmpty) {
      double value1 = double.tryParse(thenController.text) ?? 0;
      double value2 = double.tryParse(upTo40Controller.text) ?? 0;
      double percentage = (value1 / value2) * 100;
      setState(() {
        hintText = 'Percentage: ${percentage.toStringAsFixed(2)}%';
      });
    } else {
      setState(() {
        hintText = 'Enter values to calculate percentage';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    thenController.addListener(updateHintText);
    upTo40Controller.addListener(updateHintText);

    if (widget.policyName != null) {
      policyNameController.text = widget.policyName ?? "";
      policyDescController.text = widget.policydesc ?? "";
      policyPriceController.text = widget.priceLimit.toString();
      selectedRadio = widget.policyDiscount;

      // daysItem = widget.daysItem ?? "";
    }
  }

  @override
  void dispose() {
    thenController.dispose();
    upTo40Controller.dispose();
    super.dispose();
  }

  shippingPolicyApi(String deliverySize) {
    Map<String, dynamic> map = {};
    map['title'] = policyNameController.text.trim();
    map['description'] = policyDescController.text.trim();
    map['price_limit'] = policyPriceController.text.trim();
    map['range1_percent'] = iPayController.text.trim();
    map['range2_percent'] = thenController.text.trim();
    map['range1_min'] = from1KWDController.text.trim();
    map['range1_max'] = upTo20Controller.text.trim();
    map['range2_min'] = from2KWDController.text.trim();
    map['range2_max'] = upTo40Controller.text.trim();
    map['shipping_type'] = deliverySize;
    map['shipping_zone'] = selectZone;

    FocusManager.instance.primaryFocus!.unfocus();
    repositories.postApi(url: ApiUrls.vendorShippingPolicy, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      if (response.status == true) {
        Get.to(const ShippingPolicyListScreen());
      }
    });
  }

  List<String> selectHandlingTimeList = [
    'Select your handling time',
    'lb/inch',
  ];
  String selectZone = 'Select Zones';
  List<String> selectZoneList = [
    'Select Zones',
    'lb/inch',
  ];
  String unitSShipping = 'Shipping';
  List<String> unitSShippingList = [
    'Shipping',
    'lb/inch',
  ];
  int? _radioValue1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shipping Policy",
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

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
                child: Text("Shipping Discounts & Charges",
                    style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text("The amount you want to charge or offer your customers.",
                    style: GoogleFonts.poppins(fontSize: 14)),
              ),
              Column(
                children: [
                  buildRadioTile('I want to offer free shipping', 1),
                  buildRadioTile('Pay partial of the shipping', 2),
                  buildRadioTile('Charge my customer for shipping', 3),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    child: CommonTextField(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      readOnly: true,
                      obSecure: false,
                      hintText: 'Free for',
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: selectZone,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectZone = newValue!;
                        });
                      },
                      items: selectZoneList.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: GoogleFonts.poppins(fontSize: 13),
                          ),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: const Color(0xffE2E2E2).withOpacity(.35),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8).copyWith(right: 3),
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
                      child: const Text('Shipping'),
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
                      hintText: 'Enter Price limit',
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Visibility(
                visible: selectedRadio == 2,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CommonTextField(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                            controller: iPayController,
                            keyboardType: TextInputType.number,
                            obSecure: false,
                            hintText: 'I pay 15%',
                          ),
                        ),
                        Expanded(
                          child: CommonTextField(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                            controller: from1KWDController,
                            keyboardType: TextInputType.number,
                            obSecure: false,
                            hintText: 'From 01kwd',
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: CommonTextField(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                            controller: upTo20Controller,
                            keyboardType: TextInputType.number,
                            obSecure: false,
                            hintText: 'Up to 20 KWD',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CommonTextField(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                            controller: thenController,
                            keyboardType: TextInputType.number,
                            obSecure: false,
                            hintText: 'Then  10%',
                          ),
                        ),
                        Expanded(
                          child: CommonTextField(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                            controller: from2KWDController,
                            keyboardType: TextInputType.number,
                            obSecure: false,
                            hintText: 'From  20 kwd',
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: CommonTextField(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                            controller: upTo40Controller,
                            keyboardType: TextInputType.number,
                            obSecure: false,
                            hintText: 'Up to 40 KWD',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CommonTextField(
                            controller: calculatedPercentageController,
                            contentPadding: EdgeInsets.symmetric(horizontal: 20),
                            readOnly: true,
                            obSecure: false,
                            hintText: hintText,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child:
                              Text("After  that  charge full to my customer", style: GoogleFonts.poppins(fontSize: 14)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomOutlineButton(
                  title: 'Next',
                  borderRadius: 11,
                  onPressed: () {
                    if (formKey1.currentState!.validate()) {
                      if (selectedRadio == 1) {
                        shippingPolicyApi('free_shipping');
                      } else if (selectedRadio == 2) {
                        shippingPolicyApi('partial_shipping');
                      } else if (selectedRadio == 3) {
                        shippingPolicyApi('charge_my_customer');
                      } else {
                        showToast('Select delivery size');
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
        Text(
          title,
          style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ],
    );
  }
}
