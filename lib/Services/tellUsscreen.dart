import 'dart:convert';

import 'package:dirise/Services/servicesReturnPolicyScreen.dart';
import 'package:dirise/singleproductScreen/singleProductReturnPolicy.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/service_controller.dart';
import '../model/common_modal.dart';
import '../repository/repository.dart';
import '../utils/api_constant.dart';
import '../widgets/common_colour.dart';
import '../widgets/common_textfield.dart';

class TellUsScreen extends StatefulWidget {
  const TellUsScreen({super.key});

  @override
  State<TellUsScreen> createState() => _TellUsScreenState();
}

class _TellUsScreenState extends State<TellUsScreen> {
  final serviceController = Get.put(ServiceController());
  String enteredText = '';
  final formKey = GlobalKey<FormState>();

  serviceApi() {
    Map<String, dynamic> map = {};
    map['short_description'] = serviceController.shortDescriptionController.text.trim();
    map['item_type'] = 'service';
    map['in_stock'] = serviceController.inStockController.text.trim();
    map['stock_alert'] = serviceController.stockAlertController.text.trim();
    map['seo_tags'] = serviceController.writeTagsController.text.trim();


    final Repositories repositories = Repositories();
    FocusManager.instance.primaryFocus!.unfocus();
    repositories.postApi(url: ApiUrls.giveawayProductAddress, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      print('API Response Status Code: ${response.status}');
      // showToast(response.message.toString());
      if (response.status == true) {
        Get.to(const ServicesReturnPolicy());
      }
    });
  }
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
              'Tell Us'.tr,
              style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Short Description*'.tr,
                  style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
                ),
                const SizedBox(
                  height: 5,
                ),

                TextFormField(
                  maxLines: 2,
                  minLines: 2,
                  controller: serviceController.shortDescriptionController,
                  decoration: InputDecoration(
                    counterStyle: GoogleFonts.poppins(
                      color: AppTheme.primaryColor,
                      fontSize: 25,
                    ),
                    counter: const Offstage(),
                    errorMaxLines: 2,
                    contentPadding: const EdgeInsets.all(15),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    hintText: 'Description',
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
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Enter short description';
                    }
                    return null; // Return null if validation passes
                  },

                ),

                const SizedBox(
                  height: 20,
                ),

                Text(
                  'Stock quantity *'.tr,
                  style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 14),
                ),
                CommonTextField(
                  controller: serviceController.inStockController,
                    obSecure: false,
                    // hintText: 'Name',
                    keyboardType: TextInputType.number,
                    hintText: 'Stock quantity'.tr,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Stock number is required'.tr;
                    }
                    return null; // Return null if validation passes
                  },
                    // validator: MultiValidator([
                    //   RequiredValidator(errorText: 'Stock number is required'.tr),
                    // ])
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 40,
                  width: Get.width,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(11), color: Colors.grey.shade200),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'Item doesn’t need stock number'.tr,
                      style:
                      GoogleFonts.poppins(color: const Color(0xff514949), fontWeight: FontWeight.w400, fontSize: 13),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Set stock alert *'.tr,
                  style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 14),
                ),
                CommonTextField(
                  controller: serviceController.stockAlertController,
                    obSecure: false,
                    keyboardType: TextInputType.number,
                    onChanged: (value){
                      double sellingPrice = double.tryParse(value) ?? 0.0;
                      double purchasePrice = double.tryParse(serviceController.inStockController.text) ?? 0.0;
                      if (serviceController.inStockController.text.isEmpty) {
                        FocusManager.instance.primaryFocus!.unfocus();
                        serviceController.stockAlertController.clear();
                        showToastCenter('Enter stock quantity first');
                        return;
                      }
                      if (sellingPrice > purchasePrice) {
                        FocusManager.instance.primaryFocus!.unfocus();
                        serviceController.stockAlertController.clear();
                        showToastCenter('Stock alert cannot be higher than stock quantity');
                      }
                    },
                    hintText: 'Get notification on your stock quantity'.tr,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Set stock alert is required';
                      }
                      return null; // Return null if validation passes
                    },
                   ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'SEO Tags*'.tr,
                  style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 14),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Add Tags separated by commas”,”'.tr,
                  style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w400, fontSize: 13),
                ),
                const SizedBox(
                  height: 5,
                ),
                CommonTextField(
                  controller: serviceController.writeTagsController,
                    obSecure: false,
                    textInputAction: TextInputAction.done,
                    onChanged: (text){
                      setState(() {
                        enteredText = text;
                      });
                    },
                    // hintText: 'Name',
                    hintText: 'Write Tags'.tr,
                    validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Write Tags is required'.tr;
                    }
                    return null; // Return null if validation passes
                  },
                ),
                // Container(
                //   padding: const EdgeInsets.all(15),
                //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(11), color: Colors.grey.shade200),
                //   child: Column(
                //     children: [
                //       Row(
                //         children: [
                //           enteredText != '' ? Container(
                //             padding: const EdgeInsets.only(left: 10, right: 10),
                //             height: 40,
                //             decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                //             child:  Row(
                //               children: [
                //                 Text(enteredText.toString()),
                //                 const SizedBox(
                //                   width: 10,
                //                 ),
                //
                //                 GestureDetector(
                //                     onTap: (){
                //                       setState(() {
                //                         serviceController.writeTagsController.clear();
                //                         enteredText = '';
                //                       });
                //                     },
                //                     child: const Icon(Icons.cancel_outlined))
                //               ],
                //             ),
                //           ): const SizedBox.shrink(),
                //           const SizedBox(
                //             width: 30,
                //           ),
                //         ],
                //       ),
                //       const SizedBox(
                //         height: 20,
                //       ),
                //     ],
                //   ),
                // ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: (){
                    if(formKey.currentState!.validate()){
                      serviceApi();
                    }
                  },
                  child: Container(
                    width: Get.width,
                    height: 55,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black, // Border color
                        width: 1.0, // Border width
                      ),
                      borderRadius: BorderRadius.circular(10), // Border radius
                    ),
                    padding: const EdgeInsets.all(10), // Padding inside the container
                    child: const Center(
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Text color
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
