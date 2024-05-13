import 'dart:convert';

import 'package:dirise/model/returnPolicyModel.dart';

import 'package:dirise/singleproductScreen/singleproductDeliverySize.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/vendor_controllers/vendor_profile_controller.dart';
import '../model/vendor_models/model_vendor_details.dart';
import '../model/vendor_models/vendor_category_model.dart';
import '../repository/repository.dart';
import '../utils/api_constant.dart';
import '../widgets/common_button.dart';
import '../widgets/common_colour.dart';
import '../widgets/common_textfield.dart';

class SingleProductReturnPolicy extends StatefulWidget {
  const SingleProductReturnPolicy({super.key});

  @override
  State<SingleProductReturnPolicy> createState() => _SingleProductReturnPolicyState();
}

class _SingleProductReturnPolicyState extends State<SingleProductReturnPolicy> {
  ModelVendorCategory modelVendorCategory = ModelVendorCategory(usphone: []);
  ReturnPolicyModel policyModel = ReturnPolicyModel(returnPolicy: []);
  Rx<RxStatus> vendorCategoryStatus = RxStatus.empty().obs;
  final GlobalKey categoryKey = GlobalKey();
  final formKey1 = GlobalKey<FormState>();
  final GlobalKey subcategoryKey = GlobalKey();
  final GlobalKey productsubcategoryKey = GlobalKey();
  Map<String, VendorCategoriesData> allSelectedCategory = {};
  Map<String, ReturnPolicy> allSelectedCategory1 = {};

  final Repositories repositories = Repositories();
  VendorUser get vendorInfo => vendorProfileController.model.user!;
  final vendorProfileController = Get.put(VendorProfileController());
  void getVendorCategories() {
    vendorCategoryStatus.value = RxStatus.loading();
    repositories.getApi(url: ApiUrls.returnPolicyUrl).then((value) {
      policyModel = ReturnPolicyModel.fromJson(jsonDecode(value));
      vendorCategoryStatus.value = RxStatus.success();

      for (var element in policyModel.returnPolicy!) {
        allSelectedCategory1[element.id.toString()] = ReturnPolicy.fromJson(element.toJson());
      }
      setState(() {});
    }).catchError((e) {
      vendorCategoryStatus.value = RxStatus.error();
    });
  }

  String selectedItem = '1';
  String selectedItemDay = 'days';

  List<String> itemList = List.generate(30, (index) => (index + 1).toString());
  List<String> daysList = [
    'days',
    'week',
    'year'
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVendorCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: const Icon(
          Icons.arrow_back_ios_new,
          color: Color(0xff0D5877),
          size: 16,
        ),
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Return Policy'.tr,
              style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          child: Form(
            key: formKey1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Radio(value: 1, groupValue: 1, onChanged: (value) {}),
                    Text(
                      'No return'.tr,
                      style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 15),
                    ),
                  ],
                ),
                const Text(
                  'Select Vendor Category',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Obx(() {
                  if (kDebugMode) {
                    print(policyModel.returnPolicy!
                        .map((e) => DropdownMenuItem(value: e, child: Text(e.title.toString().capitalize!)))
                        .toList());
                  }
                  return DropdownButtonFormField<ReturnPolicy>(
                    key: categoryKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    icon: vendorCategoryStatus.value.isLoading
                        ? const CupertinoActivityIndicator()
                        : const Icon(Icons.keyboard_arrow_down_rounded),
                    iconSize: 30,
                    iconDisabledColor: const Color(0xff97949A),
                    iconEnabledColor: const Color(0xff97949A),
                    value: null,
                    style: GoogleFonts.poppins(color: Colors.black, fontSize: 16),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      fillColor: const Color(0xffE2E2E2).withOpacity(.35),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10).copyWith(right: 8),
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
                    items:

                    policyModel.returnPolicy!
                      .map((e) =>
                        DropdownMenuItem(value: e, child:

                    Text(

                        e.title.toString().capitalize!))
                    ).toList(),
                    hint: Text('Search category to choose'.tr),
                    onChanged: (value) {
                      // selectedCategory = value;

                       if (value == null) return;
                       if (allSelectedCategory1.isNotEmpty) return;
                       allSelectedCategory1[value.id.toString()] = value;
                      setState(() {});
                    },
                    validator: (value) {
                      if (allSelectedCategory1.isEmpty) {
                        return "Please select Category".tr;
                      }
                      return null;
                    },
                  );
                }),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Policy Name'.tr,
                  style: GoogleFonts.poppins(color: Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 18),
                ),
                CommonTextField(
                    // controller: ProductNameController,
                    obSecure: false,
                    hintText: 'DIRISE standard Policy',
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'SDIRISE standard Policy is required'.tr;
                      }
                      return null; // Return null if validation passes
                    },
                    ),
                Row(
                  children: [
                    Text(
                      'Return Within'.tr,
                      style: GoogleFonts.poppins(color: Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    SizedBox(
                      width: 16,
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
                          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10).copyWith(right: 8),
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
                      width: 20,
                    ),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: selectedItemDay,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedItemDay = newValue!;
                          });
                        },
                        items: <String>['days', 'Week', 'Year']
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
                          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10).copyWith(right: 8),
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
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Return Shipping Fees'.tr,
                  style: GoogleFonts.poppins(color: Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Radio(value: 1, groupValue: 1, onChanged: (value) {}),
                    Text(
                      'Buyer Pays Return Shipping'.tr,
                      style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 13),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Radio(value: 1, groupValue: 1, onChanged: (value) {}),
                    Text(
                      'Seller Pays Return Shipping'.tr,
                      style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 13),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Return Policy Description'.tr,
                  style: GoogleFonts.poppins(color: Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 18),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                    border: Border.all(color: Colors.grey,width: 1)
                  ),
                  child: Text(
                    '''Customer pay if he return the product because he made mistake or because he didn’t like the product. 
                      Vendor pay if the problem is from the product.
                  Item must be in the original condition, undamaged, Tags and labels not removed.
                  '''.tr,
                    style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 11),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomOutlineButton(
                  title: 'Next',
                  borderRadius: 11,
                  onPressed: () {
    if (formKey1.currentState!.validate()) {
                     Get.to(SingleProductDeliverySize());}
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
