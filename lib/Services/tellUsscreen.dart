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
              'Tell Us'.tr,
              style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
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
                  hintText: 'Stock number'.tr,
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
                  // hintText: 'Name',
                  hintText: 'Get notification on your stock quantity'.tr,
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'Set stock alert is required'.tr),
                  ])),
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
                  // hintText: 'Name',
                  hintText: 'Write Tags'.tr,
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'Write Tags is required'.tr),
                  ])),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(11), color: Colors.grey.shade200),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          height: 40,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                          child: const Row(
                            children: [
                              Text('Books'),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.cancel_outlined)
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          height: 40,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                          child: const Row(
                            children: [
                              Text('Electronics'),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.cancel_outlined)
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          height: 40,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                          child: const Row(
                            children: [
                              Text('Writer'),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.cancel_outlined)
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          height: 40,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                          child: const Row(
                            children: [
                              Text('Teachers'),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.cancel_outlined)
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: (){
                  serviceApi();
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
            ],
          ),
        ),
      ),
    );
  }
}
