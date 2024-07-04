import 'dart:convert';
import 'dart:developer';
import 'package:dirise/singleproductScreen/singleproductDeliverySize.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Services/locationwherecustomerwilljoin.dart';
import '../controller/profile_controller.dart';
import '../controller/service_controller.dart';
import '../controller/vendor_controllers/add_product_controller.dart';
import '../model/common_modal.dart';
import '../model/returnPolicyModel.dart';
import '../model/singlereturnPolicyModel.dart';
import '../repository/repository.dart';
import '../utils/api_constant.dart';
import '../widgets/common_button.dart';
import '../widgets/common_colour.dart';
import '../widgets/vendor_common_textfield.dart';

class ServicesReturnPolicy extends StatefulWidget {
  String? policyName;
  String? policyDescription;
  String? returnWithIn;
  String? returnShippingFees;
  int? id;
  ServicesReturnPolicy(
      {super.key, this.policyName, this.policyDescription, this.returnShippingFees, this.returnWithIn, this.id});

  @override
  State<ServicesReturnPolicy> createState() => _ServicesReturnPolicyState();
}

class _ServicesReturnPolicyState extends State<ServicesReturnPolicy> {
  final Repositories repositories = Repositories();
  final formKey1 = GlobalKey<FormState>();
  bool isRadioButtonSelected = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  String selectedItem = '1';
  String selectedItemDay = 'Days';

  List<String> itemList = List.generate(30, (index) => (index + 1).toString());
  List<String> daysList = [
    'days',
  ];
  RxInt returnPolicyLoaded = 0.obs;
  ReturnPolicyModel? modelReturnPolicy;
  ReturnPolicy? selectedReturnPolicy;
  String returnSelectId = '';
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

  Rx<SingleReturnPolicy> singleModelReturnPolicy = SingleReturnPolicy().obs;

  getSingleReturnPolicyData(id) {
    repositories.getApi(url: ApiUrls.singleReturnPolicyUrl + id).then((value) {
      setState(() {
        singleModelReturnPolicy.value = SingleReturnPolicy.fromJson(jsonDecode(value));
        radioButtonValue = singleModelReturnPolicy.value.data!.returnShippingFees.toString();
        titleController.text = singleModelReturnPolicy.value.data!.title.toString();
        descController.text = singleModelReturnPolicy.value.data!.policyDiscreption.toString();
      });
      returnPolicyLoaded.value = DateTime.now().millisecondsSinceEpoch;
    });
  }

  bool? noReturn;
  bool noReturnSelected = false;
  String radioButtonValue = 'buyer_pays';
  final addProductController = Get.put(AddProductController());
  returnPolicyApi() {
    Map<String, dynamic> map = {};

    map['title'] = titleController.text.trim();
    map['days'] = selectedItem;
    map['item_type'] = 'service';
    map['policy_description'] = descController.text.trim();
    map['return_shipping_fees'] = radioButtonValue.toString();
    map['no_return'] = noReturnSelected;

    FocusManager.instance.primaryFocus!.unfocus();
    repositories.postApi(url: ApiUrls.returnPolicyUrl, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      if (response.status == true) {
        // Refresh the return policy dropdown
        getReturnPolicyData();
        showToast(response.message.toString());
      }
    });
  }

  nextPageApi() {
    Map<String, dynamic> map = {};
    map['return_policy_desc'] = selectedReturnPolicy!.id.toString();
    map['item_type'] = 'service';
    map['id'] = addProductController.idProduct.value.toString();
    map['no_return'] = noReturnSelected;

    FocusManager.instance.primaryFocus!.unfocus();
    repositories.postApi(url: ApiUrls.giveawayProductAddress, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      print('API Response Status Code: ${response.status}');
      showToast(response.message.toString());
      if (response.status == true) {
        log("gfgfgfgfg${response.toJson()}");
        Get.to(() => const Locationwherecustomerwilljoin());
      } else {
        showToast(response.message.toString());
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getReturnPolicyData();
    if (widget.id != null) {
      titleController.text = widget.policyName.toString();
      descController.text = widget.policyDescription.toString();
    }
  }

  @override
  void dispose() {
    super.dispose();
    getReturnPolicyData();
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
          onTap: (){
            Get.back();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              profileController.selectedLAnguage.value != 'English' ?
              Image.asset(
                'assets/images/forward_icon.png',
                height: 19,
                width: 19,
              ) :
              Image.asset(
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
                            getSingleReturnPolicyData(selectedReturnPolicy!.id.toString());
                            returnSelectId = selectedReturnPolicy!.id.toString();
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
                        readOnly: singleModelReturnPolicy.value.data != null ? true : false,
                        controller: titleController,
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
                              if (singleModelReturnPolicy.value.data == null) {
                                setState(() {
                                  selectedItem = newValue!;
                                });
                              }
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
                            items: <String>['Days', 'Week', 'Month', 'Year']
                                .map<DropdownMenuItem<String>>((String value) {
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
                          value: 'buyer_pays',
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
                          value: 'seller_pays',
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
                      readOnly: singleModelReturnPolicy.value.data != null ? true : false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please write return policy description';
                        }
                        return null;
                      },
                      controller: descController,
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
                    onPressed: () {
                      if (noReturnSelected == false) {
                        if (formKey1.currentState!.validate()) {

                          if (radioButtonValue != '') {
                            if (returnSelectId.isEmpty) {
                              returnPolicyApi();
                            } else {
                              nextPageApi();
                            }
                          } else {
                            showToastCenter('Select Return shipping fees');
                          }
                        }
                      } else {
                        Get.to(() => const Locationwherecustomerwilljoin());
                      }
                    } // Disable button if no radio button is selected
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


