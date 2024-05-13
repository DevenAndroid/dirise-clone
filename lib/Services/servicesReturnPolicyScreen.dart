import 'dart:convert';
import 'dart:developer';

import 'package:dirise/singleproductScreen/singleproductDeliverySize.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/service_controller.dart';
import '../controller/vendor_controllers/add_product_controller.dart';
import '../controller/vendor_controllers/vendor_profile_controller.dart';
import '../model/common_modal.dart';
import '../model/returnPolicyModel.dart';
import '../model/vendor_models/model_vendor_details.dart';
import '../model/vendor_models/vendor_category_model.dart';
import '../repository/repository.dart';
import '../screens/return_policy.dart';
import '../utils/api_constant.dart';
import '../widgets/common_button.dart';
import '../widgets/common_colour.dart';
import '../widgets/common_textfield.dart';
import '../widgets/vendor_common_textfield.dart';
import 'locationwherecustomerwilljoin.dart';

class ServicesReturnPolicy extends StatefulWidget {
  const ServicesReturnPolicy({super.key});

  @override
  State<ServicesReturnPolicy> createState() => _ServicesReturnPolicyState();
}

class _ServicesReturnPolicyState extends State<ServicesReturnPolicy> {
  final Repositories repositories = Repositories();
  final formKey1 = GlobalKey<FormState>();
  bool isRadioButtonSelected = false;

  String selectedItem = '1';
  String selectedItemDay = 'days';

  List<String> itemList = List.generate(30, (index) => (index + 1).toString());
  List<String> daysList = [
    'days',
  ];
  RxInt returnPolicyLoaded = 0.obs;
  ReturnPolicyModel? modelReturnPolicy;
  ReturnPolicy? selectedReturnPolicy;

  bool isButtonEnabled = false;
  void updateButtonState() {
    setState(() {
      isButtonEnabled = radioButtonValue != null || noReturnSelected;
    });
  }

  getReturnPolicyData() {
    repositories.getApi(url: ApiUrls.returnPolicyUrl).then((value) {
      setState(() {
        modelReturnPolicy = ReturnPolicyModel.fromJson(jsonDecode(value));
        log("Return Policy Data: ${modelReturnPolicy!.toJson()}");
      });
      log("Return Policy Data: ${modelReturnPolicy!.toJson()}");
      returnPolicyLoaded.value = DateTime.now().millisecondsSinceEpoch;
    });
  }

  final serviceController = Get.put(ServiceController());
  bool? noReturn;
  bool noReturnSelected = false;
  String radioButtonValue = 'buyer_pays';
  final addProductController = Get.put(AddProductController());
  returnPolicyApi() {
    Map<String, dynamic> map = {};

    map['title'] = serviceController.titleController.text.trim();
    map['days'] = selectedItem;
    map['item_type'] = 'service';
    map['policy_description'] = serviceController.descController.text.trim();
    map['return_shipping_fees'] = radioButtonValue.toString();
    map['no_return'] = noReturnSelected;
    map['id'] = addProductController.idProduct.value.toString();

    FocusManager.instance.primaryFocus!.unfocus();
    repositories.postApi(url: ApiUrls.returnPolicyUrl, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      if (response.status == true) {
        Get.to(() => const Locationwherecustomerwilljoin());
        showToast(response.message.toString());
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getReturnPolicyData();
  }

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
              'Return Policy'.tr,
              style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Form(
            key: formKey1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: noReturnSelected,
                      onChanged: (value) {
                        setState(() {
                          noReturnSelected = value!;
                        });
                      },
                    ),
                    Text(
                      'No return'.tr,
                      style: GoogleFonts.poppins(
                          color: const Color(0xff292F45), fontWeight: FontWeight.w400, fontSize: 15),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                noReturnSelected == false
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Select Your Return Policy*'.tr,
                            style: GoogleFonts.poppins(
                                color: const Color(0xff292F45), fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          if (modelReturnPolicy?.returnPolicy != null)
                            DropdownButtonFormField<ReturnPolicy>(
                              value: selectedReturnPolicy,
                              hint: const Text("Select a Return Policy"),
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

                                });
                              },
                              // validator: (value){
                              //   if (value == null) {
                              //     return 'Please select a return policy';
                              //   }
                              //   return null;
                              // },
                              items: modelReturnPolicy!.returnPolicy!.map((policy) {
                                return DropdownMenuItem<ReturnPolicy>(
                                  value: policy,
                                  child: Text(policy.title), // Assuming 'title' is a property in ReturnPolicy
                                );
                              }).toList(),
                            ),
                          const SizedBox(
                            height: 20,
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
                              controller: serviceController.titleController,
                              hintText: selectedReturnPolicy != null
                                  ? selectedReturnPolicy!.title.toString()
                                  : 'DIRISE Standard Policy',
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return "DIRISE standard Policy".tr;
                                }
                                return null;
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                'Return Within'.tr,
                                style: GoogleFonts.poppins(
                                    color: const Color(0xff292F45), fontWeight: FontWeight.w500, fontSize: 18),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  value: selectedReturnPolicy != null
                                      ? selectedReturnPolicy!.days.toString()
                                      : selectedItem,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedItem = newValue!;
                                    });
                                  },
                                  items: itemList.map<DropdownMenuItem<String>>((String value) {
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
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please select an item';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  value: selectedItemDay,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedItemDay = newValue!;
                                    });
                                  },
                                  items: <String>['Days', 'Week', 'Month', 'Year'].map<DropdownMenuItem<String>>((String value) {
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
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Return Shipping Fees'.tr,
                            style: GoogleFonts.poppins(
                                color: const Color(0xff292F45), fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                          Row(
                            children: [
                              Radio(
                                value: selectedReturnPolicy != null
                                    ? selectedReturnPolicy!.returnShippingFees.toString()
                                    :  'buyer_pays',
                                groupValue: radioButtonValue,
                                onChanged: (value) {
                                  setState(() {
                                    radioButtonValue = value!;
                                    updateButtonState();
                                  });
                                },
                              ),
                              Text(
                                'Buyer Pays Return Shipping'.tr,
                                style: GoogleFonts.poppins(
                                    color: const Color(0xff292F45), fontWeight: FontWeight.w400, fontSize: 15),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: selectedReturnPolicy != null
                                    ? selectedReturnPolicy!.returnShippingFees.toString()
                                    : 'seller_pays',
                                groupValue: radioButtonValue,
                                onChanged: (value) {
                                  setState(() {
                                    radioButtonValue = value!;
                                    updateButtonState();
                                  });
                                },
                              ),
                              Text(
                                'Seller Pays Return Shipping'.tr,
                                style: GoogleFonts.poppins(
                                    color: const Color(0xff292F45), fontWeight: FontWeight.w400, fontSize: 15),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Return Policy Description'.tr,
                            style: GoogleFonts.poppins(
                                color: const Color(0xff292F45), fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            maxLines: 4,
                            minLines: 4,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please write return policy description';
                              }
                              return null;
                            },
                            controller: serviceController.descController,
                            decoration: InputDecoration(
                              counterStyle: GoogleFonts.poppins(
                                color: AppTheme.primaryColor,
                                fontSize: 25,
                              ),
                              counter: const Offstage(),
                              errorMaxLines: 2,
                              contentPadding: const EdgeInsets.all(15),
                              fillColor: Colors.grey.shade100,
                              hintText: selectedReturnPolicy != null
                                  ? selectedReturnPolicy!.policyDiscreption.toString()
                                  : 'policy description',
                              hintStyle: GoogleFonts.poppins(
                                color: AppTheme.primaryColor,
                                fontSize: 15,
                              ),
                              border: InputBorder.none,
                              focusedErrorBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide(color: AppTheme.secondaryColor)),
                              errorBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide(color: AppTheme.secondaryColor)),
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
                          ),
                        ],
                      )
                    : SizedBox(),
                const SizedBox(
                  height: 15,
                ),
                CustomOutlineButton(
                  title: 'Next',
                  borderRadius: 11,
                  onPressed: isButtonEnabled || noReturnSelected == true
                      ? () {
                          if (noReturnSelected == false) {
                            if (formKey1.currentState!.validate()) {
                              if (radioButtonValue != '') {
                                returnPolicyApi();
                              } else {
                                showToastCenter('Select Return shipping fees');
                              }
                            }
                          } else {
                            Get.to(const Locationwherecustomerwilljoin());
                          }
                        }
                      : null, // Disable button if no radio button is selected
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
