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
import '../controller/profile_controller.dart';
import '../controller/vendor_controllers/add_product_controller.dart';
import '../language/app_strings.dart';
import '../model/common_modal.dart';
import '../model/getShippingModel.dart';
import '../model/single_shipping_policy.dart';
import '../repository/repository.dart';
import '../singleproductScreen/singlePInternationalshippingdetails.dart';
import '../utils/api_constant.dart';
import '../widgets/common_button.dart';
import '../widgets/common_colour.dart';
import '../widgets/common_textfield.dart';
import '../widgets/vendor_common_textfield.dart';

class SingleProductShippingPolicyScreen extends StatefulWidget {
  String? policyName;
  int? id;
  String? policydesc;
  String? policyDiscount;
  int? priceLimit;
  String? selectZone;
  SingleProductShippingPolicyScreen(
      {super.key, this.policyName, this.policydesc, this.policyDiscount, this.priceLimit, this.id, this.selectZone});
  static var route = "/shippingPolicyScreen";

  @override
  State<SingleProductShippingPolicyScreen> createState() => _SingleProductShippingPolicyScreenState();
}

class _SingleProductShippingPolicyScreenState extends State<SingleProductShippingPolicyScreen> {
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
  TextEditingController freeController = TextEditingController();

  String selectedRadio = 'free_shipping';
  // String? selectedRadio;
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

  final addProductController = Get.put(AddProductController());
  nextPageApi() {
    Map<String, dynamic> map = {};
    map['shipping_policy_desc'] = policyId.toString();
    map['item_type'] = 'product';
    map['id'] = addProductController.idProduct.value.toString();

    FocusManager.instance.primaryFocus!.unfocus();
    repositories.postApi(url: ApiUrls.giveawayProductAddress, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      print('API Response Status Code: ${response.status}');
      showToast(response.message.toString());
      if (response.status == true) {
        Get.to( SinglePInternationalshippingdetailsScreen());

      } else {
        showToast(response.message.toString());
      }
    });
  }

  @override
  void initState() {
    super.initState();
    thenController.addListener(updateHintText);
    upTo40Controller.addListener(updateHintText);
    getShippingPolicyData();
    if (widget.policyName != null) {
      policyNameController.text = widget.policyName ?? "";
      policyDescController.text = widget.policydesc ?? "";
      policyPriceController.text = widget.priceLimit.toString();
      selectedRadio = widget.policyDiscount!;
      selectZone = widget.selectZone.toString();
    }
  }

  @override
  void dispose() {
    getShippingPolicyData();
    thenController.dispose();
    upTo40Controller.dispose();
    super.dispose();
  }
  String returnSelectId = '';
  String policyId = '';
  shippingPolicyApi() {
    Map<String, dynamic> map = {};

    map['title'] = titleController.text.trim();
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

    FocusManager.instance.primaryFocus!.unfocus();
    repositories.postApi(url: ApiUrls.vendorShippingPolicy, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      if (response.status == true) {
        // Refresh the return policy dropdown
        getShippingPolicyData();
        showToast(response.message.toString());
      }
    });
  }

  ShippingPolicy? selectedReturnPolicy;

  Rx<GetShippingModel> modelShippingPolicy = GetShippingModel().obs;
  getShippingPolicyData() {
    repositories.getApi(url: ApiUrls.getShippingPolicy).then((value) {
      setState(() {
        modelShippingPolicy.value = GetShippingModel.fromJson(jsonDecode(value));
        // log("Return Policy Data: ${modelShippingPolicy.value.shippingPolicy.toString()}");
      });
    });
  }
  bool? noReturn;
  bool noReturnSelected = false;
  // String radioButtonValue = 'buyer_pays';
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  Rx<SinglePolicy> singleShippingPolicy = SinglePolicy().obs;
  RxInt returnPolicyLoaded = 0.obs;
  getSingleReturnPolicyData(id) {
    repositories.getApi(url: ApiUrls.singleShippingPolicyUrl + id).then((value) {
      setState(() {
        singleShippingPolicy.value = SinglePolicy.fromJson(jsonDecode(value));
      selectedRadio = singleShippingPolicy.value.singleShippingPolicy!.shippingType.toString();
        titleController.text = singleShippingPolicy.value.singleShippingPolicy!.title.toString();
        policyDescController.text = singleShippingPolicy.value.singleShippingPolicy!.description.toString();
        iPayController.text = singleShippingPolicy.value.singleShippingPolicy!.range1Min.toString();
        iPayController.text = singleShippingPolicy.value.singleShippingPolicy!.range1Percent.toString();
        from1KWDController.text = singleShippingPolicy.value.singleShippingPolicy!.range1Min.toString();
        upTo20Controller.text = singleShippingPolicy.value.singleShippingPolicy!.range1Max.toString();
        thenController.text = singleShippingPolicy.value.singleShippingPolicy!.range2Percent.toString();
        from2KWDController.text = singleShippingPolicy.value.singleShippingPolicy!.range2Min.toString();
        upTo40Controller.text = singleShippingPolicy.value.singleShippingPolicy!.range2Max.toString();
        calculatedPercentageController.text = singleShippingPolicy.value.singleShippingPolicy!.priceLimit.toString();
        // freeController.text = singleShippingPolicy.value.singleShippingPolicy!.description.toString();
      });
      returnPolicyLoaded.value = DateTime.now().millisecondsSinceEpoch;
    });
  }
  bool isButtonEnabled = false;
  void updateButtonState() {
    setState(() {
      isButtonEnabled = selectedRadio != null || noReturnSelected;
    });
  }

  final profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shipping Policy",
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        leading: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () {
                 Get.back();
                },
                child: profileController.selectedLAnguage.value != 'English' ? Image.asset(
                      'assets/images/forward_icon.png',
                      height: 19,
                      width: 19,
                    )
                  : Image.asset(
                      'assets/images/back_icon_new.png',
                      height: 19,
                      width: 19,
                    ),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        // centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Form(
          key: formKey1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text("Select Your Shipping Policy*", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
              ),
              const SizedBox(
                height: 8,
              ),
              if (modelShippingPolicy.value.shippingPolicy != null)
                DropdownButtonFormField<ShippingPolicy>(
                  value: selectedReturnPolicy,
                  hint: const Text("Select a Shipping Policy"),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    fillColor: const Color(0xffE2E2E2).withOpacity(.35),
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10).copyWith(right: 8),
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
                  onChanged: (value) {
                    setState(() {
                      selectedReturnPolicy = value;
                     getSingleReturnPolicyData(selectedReturnPolicy!.id.toString());
                      returnSelectId = selectedReturnPolicy!.id.toString();
                      policyId = selectedReturnPolicy!.id.toString();

                    });
                  },
                  // validator: (value){
                  //   if (value == null) {
                  //     return 'Please select a return policy';
                  //   }
                  //   return null;
                  // },
                  items: modelShippingPolicy.value.shippingPolicy!.map((policy) {
                    return DropdownMenuItem<ShippingPolicy>(
                      value: policy,
                      child: Text(policy.title), // Assuming 'title' is a property in ReturnPolicy
                    );
                  }).toList(),
                ),

              //     ])),
              const SizedBox(
                height: 18,
              ),
              Text(
                'Policy Name'.tr,
                style: GoogleFonts.poppins(
                    color: const Color(0xff292F45), fontWeight: FontWeight.w500, fontSize: 18),
              ),
              const SizedBox(
                height: 5,
              ),
              VendorCommonTextfield(
                  readOnly: singleShippingPolicy.value.singleShippingPolicy  != null ? true : false,
                  controller: titleController,
                  hintText: selectedReturnPolicy != null
                      ? selectedReturnPolicy!.title.toString()
                      : 'Policy name',
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Policy name".tr;
                    }
                    return null;
                  }),
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
                readOnly: singleShippingPolicy.value.singleShippingPolicy != null ? true : false,
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
                  Row(
                    children: [
                      Radio<String>(
                        value: 'free_shipping',
                        groupValue: selectedRadio,
                        onChanged: (value) {
                          setState(() {
                            selectedRadio = value!;
                            updateButtonState();
                            log(selectedRadio.toString());
                          });
                        },
                      ),
                      Expanded(
                        child: Text("I want to offer free shipping",
                            style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400)),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'partial_shipping',
                        groupValue: selectedRadio,
                        onChanged: (value) {
                          setState(() {
                            selectedRadio = value!;
                            updateButtonState();
                            log(selectedRadio.toString());
                          });
                        },
                      ),
                      Expanded(
                        child: Text("Pay partial of the shipping",
                            style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400)),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'charge_my_customer',
                        groupValue: selectedRadio,
                        onChanged: (value) {
                          setState(() {
                            selectedRadio = value!;
                            updateButtonState();
                            log(selectedRadio.toString());
                          });
                        },
                      ),
                      Expanded(
                        child: Text("Charge my customer for shipping",
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
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          readOnly: true,
                          controller: freeController,
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
                            hintText: 'I pay 15%',
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
                            hintText: 'From 01kwd',
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
                            hintText: 'Up to 20 KWD',
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
                            hintText: 'Then  10%',
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
                            hintText: 'From  20 kwd',
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
                            hintText: 'Up to 40 KWD',
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
                      // if (selectedRadio == 'free_shipping' || selectedRadio == 'partial_shipping' || selectedRadio == 'charge_my_customer') {
                        if(returnSelectId.isEmpty){
                          shippingPolicyApi();
                        }
                       else{
                         nextPageApi();
                        }
                      }
                    else {
                        showToast('Please select Shipping Shipping Fees');
                      }

                    // }
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
