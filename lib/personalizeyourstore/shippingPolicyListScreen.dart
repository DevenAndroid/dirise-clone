import 'dart:convert';
import 'dart:developer';

import 'package:dirise/vendor/shipping_policy.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/profile_controller.dart';
import '../model/common_modal.dart';
import '../model/getShippingModel.dart';
import '../repository/repository.dart';
import '../utils/api_constant.dart';
import '../widgets/common_colour.dart';

class ShippingPolicyListScreen extends StatefulWidget {
  const ShippingPolicyListScreen({super.key});

  @override
  State<ShippingPolicyListScreen> createState() => _ShippingPolicyListScreenState();
}

class _ShippingPolicyListScreenState extends State<ShippingPolicyListScreen> {
  final Repositories repositories = Repositories();
  final formKey1 = GlobalKey<FormState>();
  Rx<GetShippingModel> modelShippingPolicy = GetShippingModel().obs;
  getShippingPolicyData() {
    repositories.getApi(url: ApiUrls.getShippingPolicy).then((value) {
      setState(() {
        modelShippingPolicy.value = GetShippingModel.fromJson(jsonDecode(value));
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getShippingPolicyData();
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
              'Shipping Policy List'.tr,
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
              Get.to(ShippingPolicyScreen());
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
            modelShippingPolicy.value.shippingPolicy != null
                ? ListView.builder(
                itemCount: modelShippingPolicy.value.shippingPolicy!.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var shippingPolicy = modelShippingPolicy.value.shippingPolicy![index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(ShippingPolicyScreen(
                        id: shippingPolicy.id,
                        policydesc: shippingPolicy.description,
                        policyDiscount: shippingPolicy.shippingType,
                        policyName: shippingPolicy.title,
                        priceLimit: shippingPolicy.priceLimit,
                        selectZone: shippingPolicy.shippingZone,

                      ));

                      log('ddddddd${shippingPolicy.shippingType.toString()}');
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
                                    shippingPolicy.title,
                                    style: const TextStyle(
                                        color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
                                  ),
                                  const SizedBox(height: 10,),
                                  Text(shippingPolicy.description,maxLines: 3,),
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
                                        content: Text('Do you want to delete your shipping policy'.tr),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () => Get.back(),
                                            child:  Text('Cancel'.tr),
                                          ),
                                          TextButton(
                                            onPressed: ()  {
                                              repositories.postApi(url: ApiUrls.deleteShippingPolicy, context: context, mapData: {
                                                'id': shippingPolicy.id,
                                              }).then((value) {
                                                ModelCommonResponse modelCommonResponse = ModelCommonResponse.fromJson(jsonDecode(value));
                                                showToast(modelCommonResponse.message.toString());
                                                if (modelCommonResponse.status == true) {
                                                  setState(() {
                                                    Get.back();
                                                    getShippingPolicyData();
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
                :  Center(child: Text('No Shipping policy Available'.tr)),
            modelShippingPolicy.value.shippingPolicy != null ?
            Column(
              children: [
                if(   modelShippingPolicy.value.shippingPolicy!.isEmpty)
                   Center(child: Text('No Shipping policy Available'.tr)),
              ],
            )  : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
