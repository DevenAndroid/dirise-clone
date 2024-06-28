import 'dart:convert';
import 'dart:developer';

import 'package:dirise/iAmHereToSell/personalizeyourstoreScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/profile_controller.dart';
import '../language/app_strings.dart';
import '../model/common_modal.dart';
import '../model/returnPolicyModel.dart';
import '../personalizeyourstore/returnpolicyScreen.dart';
import '../repository/repository.dart';
import '../utils/api_constant.dart';
import '../widgets/common_colour.dart';
import '../widgets/dimension_screen.dart';

class ReturnnPolicyList extends StatefulWidget {
  bool? noreturnPolicy;
  ReturnnPolicyList({super.key,this.noreturnPolicy});

  static var route = "/returnPolicyScreen";

  @override
  State<ReturnnPolicyList> createState() => _ReturnnPolicyListState();
}

class _ReturnnPolicyListState extends State<ReturnnPolicyList> {
  bool? _radioValue1;
  String? _shippingFeesValue;
  RxInt returnPolicyLoaded = 0.obs;
  Rx<ReturnPolicyModel> modelReturnPolicy = ReturnPolicyModel().obs;
  // ReturnPolicyModel? modelReturnPolicy;
  final Repositories repositories = Repositories();

  getReturnPolicyData() {
    repositories.getApi(url: ApiUrls.returnPolicyUrl).then((value) {
      modelReturnPolicy.value = ReturnPolicyModel.fromJson(jsonDecode(value));
      log('dadaaaada${modelReturnPolicy.value.returnPolicy![0].id.toString()}');
      returnPolicyLoaded.value = DateTime.now().millisecondsSinceEpoch;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getReturnPolicyData();
  }
  final profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
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
                AppStrings.returnnPolicy.tr,
                style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Obx(() {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // if(widget.noreturnPolicy == false)
                  modelReturnPolicy.value.returnPolicy != null ?
                  ListView.builder(
                      itemCount: modelReturnPolicy.value.returnPolicy!.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var returnpolicy = modelReturnPolicy.value.returnPolicy![index];
                        _shippingFeesValue = returnpolicy.returnShippingFees;
                        return Container(
                          margin: EdgeInsets.only(bottom: 20),
                          width: size.width,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(15)),
                              border: Border.all(color: const Color(0xffE4E2E2))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text("My Default Policy: ${returnpolicy.title}",
                                            style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500)),
                                      ),
                                      const Image(image: AssetImage("assets/icons/tempImageYRVRjh 1.png"))
                                    ],
                                  ),
                                ),
                                const Divider(
                                  thickness: 1,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Return Within",
                                              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500)),
                                          Text("Return Shipping Fees",
                                              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500))
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius: const BorderRadius.all(Radius.circular(5)),
                                                border: Border.all(color: const Color(0xffD9D9D9)),
                                                shape: BoxShape.rectangle),
                                            child:
                                            Text(returnpolicy.days,
                                                style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius: const BorderRadius.all(Radius.circular(5)),
                                                border: Border.all(color: const Color(0xffD9D9D9)),
                                                shape: BoxShape.rectangle),
                                            child: Text("Days",
                                                style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
                                          ),
                                          Radio<String>(
                                            value: 'buyer_pays',
                                            groupValue: _shippingFeesValue,
                                            onChanged: (String? value) {
                                              setState(() {
                                                _shippingFeesValue = value;
                                              });
                                            },
                                          ),

                                          Text('Buyer Pays',
                                              style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)) ,
                                          Radio<String>(
                                            visualDensity: const VisualDensity(horizontal: -2.0),
                                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                            value: 'seller_pays',
                                            groupValue: _shippingFeesValue,
                                            onChanged: (String? value) {
                                              setState(() {
                                                _shippingFeesValue = value;
                                              });
                                            },
                                          ),
                                          Text('Seller Pays ',
                                              style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
                                        ],
                                      ),
                                      Text("Return Policy Description",
                                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500)),
                                      Text(
                                          returnpolicy.policyDiscreption,
                                          style: GoogleFonts.poppins(
                                            fontSize: 11,
                                          )),
                                      const SizedBox(
                                        height: 13,
                                      ),
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap:(){
                                              Get.to(ReturnPolicyScreens(
                                                // daysItem: returnpolicy.days,
                                                days: returnpolicy.days,
                                                id: returnpolicy.id,
                                                descController: returnpolicy.policyDiscreption,
                                                radiobutton: returnpolicy.returnShippingFees,
                                                // noReturn: returnpolicy.noReturn,
                                                titleController: returnpolicy.title ,
                                              ));

                                            },
                                            child: Text("Edit",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w300,
                                                    color: const Color(0xff014E70))),
                                          ),
                                          GestureDetector(
                                            onTap: (){
                                              repositories.postApi(url: ApiUrls.deleteReturnPolicy, context: context, mapData: {
                                                'id': returnpolicy.id,
                                              }).then((value) {
                                                ModelCommonResponse modelCommonResponse = ModelCommonResponse.fromJson(jsonDecode(value));
                                                showToast(modelCommonResponse.message.toString());
                                                if (modelCommonResponse.status == true) {
                                                    setState(() {
                                                      Get.to(const PersonalizeyourstoreScreen());
                                                    });
                                                }
                                              });
                                            },
                                            child: Text("|Remove",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w300,
                                                    color: const Color(0xff014E70))),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }) : CircularProgressIndicator(),

                  const SizedBox(
                    height: 13,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(ReturnPolicyScreens(


                      ));
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "+Add New",
                          style: TextStyle(decoration: TextDecoration.underline, color: Color(0xff014E70)),
                        ),
                      ],
                    ),
                  ),


                  const SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Get.to(const PersonalizeyourstoreScreen());
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffF5F2F2),
                          minimumSize: const Size(double.maxFinite, 60),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AddSize.size5),
                          ),
                          textStyle: GoogleFonts.poppins(fontSize: AddSize.font20, fontWeight: FontWeight.w600)),
                      child: Text(
                        "Save".tr,
                        style:
                        GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w500, fontSize: AddSize.font18),
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Get.to(const PersonalizeyourstoreScreen());
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.maxFinite, 60),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AddSize.size5),
                          ),
                          backgroundColor: AppTheme.buttonColor,
                          textStyle: GoogleFonts.poppins(fontSize: AddSize.font20, fontWeight: FontWeight.w600)),
                      child: Text(
                        "Skip".tr,
                        style:
                        GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w500, fontSize: AddSize.font18),
                      )),
                ],
              ),
            );
          }),
        ));
  }
}
