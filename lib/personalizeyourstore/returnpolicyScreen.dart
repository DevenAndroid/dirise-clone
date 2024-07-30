import 'dart:convert';
import 'dart:developer';
import 'package:dirise/personalizeyourstore/returnPolicyListScreen.dart';
import 'package:dirise/screens/return_policy.dart';
import 'package:dirise/utils/api_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/profile_controller.dart';
import '../model/common_modal.dart';
import '../model/returnPolicyModel.dart';
import '../repository/repository.dart';
import '../widgets/common_button.dart';
import '../widgets/common_colour.dart';
import '../widgets/vendor_common_textfield.dart';

class ReturnPolicyScreens extends StatefulWidget {
  String? titleController;
  String? descController;
  String? days;
  int? id;
  String? radiobutton;

  ReturnPolicyScreens({super.key, this.titleController, this.descController, this.days, this.id,this.radiobutton});

  @override
  State<ReturnPolicyScreens> createState() => _ReturnPolicyScreensState();
}

class _ReturnPolicyScreensState extends State<ReturnPolicyScreens> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  final Repositories repositories = Repositories();
  final formKey1 = GlobalKey<FormState>();
  String? _shippingFeesValue;

  String selectedItem = '1';
  String daysItem = 'days';
  List<String> daysList = ['days'];
  List<String> itemList = List.generate(30, (index) => (index + 1).toString());

  RxInt returnPolicyLoaded = 0.obs;
  ReturnPolicy? selectedReturnPolicy;
  // ReturnPolicyModel? modelReturnPolicy;
  Rx<ReturnPolicyModel> modelReturnPolicy = ReturnPolicyModel().obs;
  getReturnPolicyData() {
    repositories.getApi(url: ApiUrls.returnPolicyUrl).then((value) {
      setState(() {
        modelReturnPolicy.value = ReturnPolicyModel.fromJson(jsonDecode(value));
      });
      // Print the fetched data
      returnPolicyLoaded.value = DateTime.now().millisecondsSinceEpoch;
    });
  }

  bool? noReturn;
  bool noReturnSelected = false;
  bool? radioButtonValue;

  returnPolicyApi() {
    Map<String, dynamic> map = {};

    if (widget.id != null) {
      map['title'] = titleController.text.trim();
      map['days'] = selectedItem;
      map['policy_description'] = descController.text.trim();
      map['return_shipping_fees'] = _shippingFeesValue;
      map['no_return'] = noReturnSelected;
      map['unit'] = daysItem;
      map['is_default'] = 1;
      map['id'] = widget.id;
    }

    map['title'] = titleController.text.trim();
    map['days'] = selectedItem;
    map['policy_description'] = descController.text.trim();
    map['return_shipping_fees'] = _shippingFeesValue;
    map['no_return'] = noReturnSelected;
    map['unit'] = daysItem;
    map['is_default'] = 1;

    FocusManager.instance.primaryFocus!.unfocus();
    repositories.postApi(url: ApiUrls.returnPolicyUrl, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      if (response.status == true) {
        Get.to(ReturnPolicyListScreen(

        ));
        showToast(response.message.toString());
        log('gggg' + response.message.toString());
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getReturnPolicyData();
    if (widget.titleController != null) {
      titleController.text = widget.titleController ?? "";
      descController.text = widget.descController ?? "";
      selectedItem = widget.days!;
      _shippingFeesValue = widget.radiobutton;
      // daysItem = widget.daysItem ?? "";
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
                          // Obx(() {
                          //   return modelReturnPolicy.value.returnPolicy != null
                          //       ? Column(
                          //     mainAxisAlignment: MainAxisAlignment.start,
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //           children: [
                          //             Text(
                          //               'Select Your Return Policy*'.tr,
                          //               style: GoogleFonts.poppins(
                          //                   color: const Color(0xff292F45), fontWeight: FontWeight.w500, fontSize: 18),
                          //             ),
                          //             const SizedBox(
                          //               height: 5,
                          //             ),
                          //             DropdownButtonFormField<ReturnPolicy>(
                          //               value: selectedReturnPolicy,
                          //               hint: const Text("Select a Return Policy"),
                          //               decoration: InputDecoration(
                          //                 border: InputBorder.none,
                          //                 filled: true,
                          //                 fillColor: const Color(0xffE2E2E2).withOpacity(.35),
                          //                 contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10)
                          //                     .copyWith(right: 8),
                          //                 focusedErrorBorder: const OutlineInputBorder(
                          //                     borderRadius: BorderRadius.all(Radius.circular(8)),
                          //                     borderSide: BorderSide(color: AppTheme.secondaryColor)),
                          //                 errorBorder: const OutlineInputBorder(
                          //                     borderRadius: BorderRadius.all(Radius.circular(8)),
                          //                     borderSide: BorderSide(color: Color(0xffE2E2E2))),
                          //                 focusedBorder: const OutlineInputBorder(
                          //                     borderRadius: BorderRadius.all(Radius.circular(8)),
                          //                     borderSide: BorderSide(color: AppTheme.secondaryColor)),
                          //                 disabledBorder: const OutlineInputBorder(
                          //                   borderRadius: BorderRadius.all(Radius.circular(8)),
                          //                   borderSide: BorderSide(color: AppTheme.secondaryColor),
                          //                 ),
                          //                 enabledBorder: const OutlineInputBorder(
                          //                   borderRadius: BorderRadius.all(Radius.circular(8)),
                          //                   borderSide: BorderSide(color: AppTheme.secondaryColor),
                          //                 ),
                          //               ),
                          //               onChanged: (value) {
                          //                 setState(() {
                          //                   selectedReturnPolicy = value;
                          //                 });
                          //               },
                          //               items: modelReturnPolicy.value.returnPolicy!.map((policy) {
                          //                 return DropdownMenuItem<ReturnPolicy>(
                          //                   value: policy,
                          //                   child: Text(policy.title), // Assuming 'title' is a property in ReturnPolicy
                          //                 );
                          //               }).toList(),
                          //             ),
                          //           ],
                          //         )
                          //       : const SizedBox();
                          // }),
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
                              controller: titleController,
                              hintText: "Policy name".tr,
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return "Policy name".tr;
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
                                width: 20,
                              ),
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  value: selectedItem,
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
                                width: 5,
                              ),
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  value: daysItem,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      daysItem = newValue!;
                                    });
                                  },
                                  items: daysList.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(fontSize: 15),
                                      ),
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
                              Radio<String>(
                                value: 'buyer_pays',
                                groupValue: _shippingFeesValue,
                                onChanged: (String? value) {
                                  setState(() {
                                    _shippingFeesValue = value;
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
                              Radio<String>(
                                visualDensity: const VisualDensity(horizontal: 2.0),
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                value: 'seller_pays',
                                groupValue: _shippingFeesValue,
                                onChanged: (String? value) {
                                  setState(() {
                                    _shippingFeesValue = value;
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
                            controller: descController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please write return policy description';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              counterStyle: GoogleFonts.poppins(
                                color: AppTheme.primaryColor,
                                fontSize: 25,
                              ),
                              counter: const Offstage(),
                              errorMaxLines: 2,
                              contentPadding: const EdgeInsets.all(15),
                              fillColor: Colors.grey.shade100,
                              hintText: 'policy description',
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
                    if (noReturnSelected == true) {
                      Get.to(ReturnnPolicyList());
                    } else {
                      if (formKey1.currentState!.validate()) {
                        if (_shippingFeesValue == 'buyer_pays' || _shippingFeesValue == 'seller_pays') {
                          returnPolicyApi();
                        } else {
                          showToast('Please select Return Shipping Fees');
                        }
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
