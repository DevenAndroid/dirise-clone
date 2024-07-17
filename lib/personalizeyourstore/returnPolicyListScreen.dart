import 'dart:convert';
import 'dart:developer';

import 'package:dirise/personalizeyourstore/returnpolicyScreen.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/profile_controller.dart';
import '../model/common_modal.dart';
import '../model/returnPolicyModel.dart';
import '../repository/repository.dart';
import '../utils/api_constant.dart';

class ReturnPolicyListScreen extends StatefulWidget {
  const ReturnPolicyListScreen({super.key});

  @override
  State<ReturnPolicyListScreen> createState() => _ReturnPolicyListScreenState();
}

class _ReturnPolicyListScreenState extends State<ReturnPolicyListScreen> {
  final Repositories repositories = Repositories();
  final formKey1 = GlobalKey<FormState>();
  Rx<ReturnPolicyModel> modelReturnPolicy = ReturnPolicyModel().obs;
  getReturnPolicyData() {
    repositories.getApi(url: ApiUrls.returnPolicyUrl).then((value) {
      setState(() {
        modelReturnPolicy.value = ReturnPolicyModel.fromJson(jsonDecode(value));
      });
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
              'Return Policy List'.tr,
              style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Get.to(ReturnPolicyScreens());
                  },
                  child:  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Text(
                      '+Add New'.tr,
                      style: const TextStyle(color: AppTheme.buttonColor),
                    ),
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            modelReturnPolicy.value.returnPolicy != null
                ? ListView.builder(
                    itemCount: modelReturnPolicy.value.returnPolicy!.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      var ReturnPolicy = modelReturnPolicy.value.returnPolicy![index];
                      return GestureDetector(
                        onTap: () {
                          Get.to(ReturnPolicyScreens(
                            id: ReturnPolicy.id,
                            radiobutton: ReturnPolicy.returnShippingFees,
                            days: ReturnPolicy.days,
                            titleController: ReturnPolicy.title,
                            descController: ReturnPolicy.policyDiscreption,
                          ));
                        },
                        child: Container(
                            width: Get.width,
                            margin: const EdgeInsets.only(left: 15, right: 15,bottom: 15),
                            padding: const EdgeInsets.all(15),
                            decoration:
                                BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(11)),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ReturnPolicy.title,
                                        style: const TextStyle(
                                            color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
                                      ),
                                      const SizedBox(height: 10,),
                                      Text(ReturnPolicy.policyDiscreption,maxLines: 3,),
                                    ],
                                  ),
                                ),
                                // const Spacer(),
                                Column(
                                  children: [
                                    Text(
                                      'Edit'.tr,
                                      style: GoogleFonts.poppins(
                                          color: const Color(0xff292F45), fontWeight: FontWeight.w500, fontSize: 16),
                                    ),
                                    const SizedBox(height: 10,),
                                    GestureDetector(
                                      onTap: (){
                                        showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) => AlertDialog(
                                            title:  Text('Are you sure!'.tr),
                                            content: Text('Do you want to delete your return policy'.tr),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => Get.back(),
                                                child:  Text('Cancel'.tr),
                                              ),
                                              TextButton(
                                                onPressed: ()  {
                                                  repositories.postApi(url: ApiUrls.deleteReturnPolicy, context: context, mapData: {
                                                    'id': ReturnPolicy.id,
                                                  }).then((value) {
                                                    ModelCommonResponse modelCommonResponse = ModelCommonResponse.fromJson(jsonDecode(value));
                                                    showToast(modelCommonResponse.message.toString());
                                                    if (modelCommonResponse.status == true) {
                                                      setState(() {
                                                        Get.back();
                                                        getReturnPolicyData();
                                                      });
                                                    }
                                                  });
                                                },
                                                child:  Text('OK'.tr),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'Delete'.tr,
                                        style: GoogleFonts.poppins(
                                            color:Colors.red, fontWeight: FontWeight.w500, fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      );
                    })
                :  Center(child: Text('No Return policy Available'.tr)),
            modelReturnPolicy.value.returnPolicy != null ?
              Column(
                children: [
                  if(  modelReturnPolicy.value.returnPolicy!.isEmpty)
                    Center(child: Text('No Return policy Available'.tr)),
                ],
              )  : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
