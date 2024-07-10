import 'dart:convert';
import 'dart:developer';

import 'package:dirise/personalizeyourstore/shippingPolicyListScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Services/service_international_shipping_details.dart';
import '../iAmHereToSell/personalizeyourstoreScreen.dart';
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
  String? policyDiscount;
  int? priceLimit;
  String? selectZone;
  ShippingPolicyScreen(
      {super.key, this.policyName, this.policydesc, this.policyDiscount, this.priceLimit, this.id, this.selectZone});
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

  String? selectedRadio;
  final formKey1 = GlobalKey<FormState>();
  final Repositories repositories = Repositories();

  String hintText = 'Enter values to calculate percentage';

  List<String> selectZoneList = [
    'zone_1',
    'zone_2',
    'zone_3',
    'zone_4',
  ];
  String? selectZone = 'zone_1';

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
      selectZone = widget.selectZone.toString();
    }
  }

  @override
  void dispose() {
    thenController.dispose();
    upTo40Controller.dispose();
    super.dispose();
  }

  shippingPolicyApi() {
    Map<String, dynamic> map = {};

    if (widget.id != null) {
      map['title'] = policyNameController.text.trim();
      map['description'] = policyDescController.text.trim();
      map['price_limit'] = policyPriceController.text.trim();
      map['range1_percent'] = iPayController.text.trim();
      map['range2_percent'] = thenController.text.trim();
      map['range1_min'] = from1KWDController.text.trim();
      map['range1_max'] = upTo20Controller.text.trim();
      map['range2_min'] = from2KWDController.text.trim();
      map['range2_max'] = upTo40Controller.text.trim();
      map['shipping_type'] = selectedRadio;
      map['shipping_zone'] = selectZone;
      map['id'] = widget.id;
    }

    map['title'] = policyNameController.text.trim();
    map['description'] = policyDescController.text.trim();
    map['price_limit'] = policyPriceController.text.trim();
    map['range1_percent'] = iPayController.text.trim();
    map['range2_percent'] = thenController.text.trim();
    map['range1_min'] = from1KWDController.text.trim();
    map['range1_max'] = upTo20Controller.text.trim();
    map['range2_min'] = from2KWDController.text.trim();
    map['range2_max'] = upTo40Controller.text.trim();
    map['shipping_type'] = selectedRadio;
    map['shipping_zone'] = selectZone;
    log("API Request Map: ${map.toString()}");
    log('ghfkhjsdgsd${selectZone}');
    FocusManager.instance.primaryFocus!.unfocus();
    repositories.postApi(url: ApiUrls.vendorShippingPolicy, context: context, mapData: map).then((value) {
      log('ffffffff${jsonDecode(value)}');
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      if (response.status == true) {
        log('ghfkhjsdgsd${selectZone}');
        // Get.to(const PersonalizeyourstoreScreen());
        Get.back();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shipping Policy".tr,
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back)),
        automaticallyImplyLeading: false,
        // centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: formKey1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text("Policy Name".tr, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
              ),
              const SizedBox(
                height: 8,
              ),
              CommonTextField(
                  contentPadding: const EdgeInsets.all(5),
                  controller: policyNameController,
                  obSecure: false,
                  hintText: 'DIRISE standard Policy'.tr,
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'Dirise standard policy must be required'.tr),
                  ])
              ),
              const SizedBox(
                height: 18,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text("Policy Description (Optional)".tr,
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
                  // validator: MultiValidator([
                  //   RequiredValidator(errorText: 'Policy Description must be required'.tr),
                  // ])
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text("Shipping Discounts & Charges".tr,
                    style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text("The amount you want to charge or offer your customers.".tr,
                    style: GoogleFonts.poppins(fontSize: 14)),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Radio<String>(
                        value: 'free_shipping',
                        groupValue: selectedRadio,
                        onChanged: (String? value) {
                          setState(() {
                            selectedRadio = value;
                            log(selectedRadio.toString());
                          });
                        },
                      ),
                      Expanded(
                        child: Text("I want to offer free shipping".tr,
                            style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400)),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'partial_shipping',
                        groupValue: selectedRadio,
                        onChanged: (String? value) {
                          setState(() {
                            selectedRadio = value;
                            log(selectedRadio.toString());
                          });
                        },
                      ),
                      Expanded(
                        child: Text("Pay partial of the shipping".tr,
                            style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400)),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'charge_my_customer',
                        groupValue: selectedRadio,
                        onChanged: (String? value) {
                          setState(() {
                            selectedRadio = value;
                            log(selectedRadio.toString());
                          });
                        },
                      ),
                      Expanded(
                        child: Text("Charge my customer for shipping".tr,
                            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400)),
                      )
                    ],
                  ),
                ],
              ),
              selectedRadio == "free_shipping"
                  ? Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Expanded(
                              child: CommonTextField(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                                readOnly: true,
                                obSecure: false,
                                hintText: 'Free for'.tr,
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
                                  contentPadding:
                                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8).copyWith(right: 3),
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
                                    return 'Please select an item'.tr;
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
                                child:  Text('Shipping'.tr),
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
                                hintText: 'Enter Price limit'.tr,
                                validator: (value) {
                                  if (value!.trim().isEmpty) {
                                    return "Enter Price limit".tr;
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : const SizedBox(),
              const SizedBox(
                height: 10,
              ),
              Visibility(
                visible: selectedRadio == 'partial_shipping',
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
                            hintText: 'I pay 15%'.tr,
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return "Enter Value".tr;
                              }
                              return null;
                            },
                          ),
                        ),
                        Expanded(
                          child: CommonTextField(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                            controller: from1KWDController,
                            keyboardType: TextInputType.number,
                            obSecure: false,
                            hintText: 'From 01kwd'.tr,
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return "Enter Value".tr;
                              }
                              return null;
                            },
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
                            hintText: 'Up to 20 KWD'.tr,
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return "Enter Value".tr;
                              }
                              return null;
                            },
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
                            hintText: 'Then  10%'.tr,
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return "Enter Value".tr;
                              }
                              return null;
                            },
                          ),
                        ),
                        Expanded(
                          child: CommonTextField(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                            controller: from2KWDController,
                            keyboardType: TextInputType.number,
                            obSecure: false,
                            hintText: 'From  20 kwd'.tr,
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return "Enter Value".tr;
                              }
                              return null;
                            },
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
                            hintText: 'Up to 40 KWD'.tr,
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return "Enter Value".tr;
                              }
                              return null;
                            },
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
                              Text("After that charge full to my customer", style: GoogleFonts.poppins(fontSize: 14)),
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
                      if (selectedRadio == 'free_shipping' ||
                          selectedRadio == 'partial_shipping' ||
                          selectedRadio == 'charge_my_customer') {
                        shippingPolicyApi();
                      } else {
                        showToast('Please select Shipping Shipping Fees'.tr);
                      }
                    }
                    // Get.to(()=> const SinglePInternationalshippingdetailsScreen());
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
}
