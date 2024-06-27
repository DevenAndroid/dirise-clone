import 'dart:convert';
import 'dart:developer';

import 'package:dirise/personalizeyourstore/pickUpPolicyScreen.dart';
import 'package:dirise/vendor/shipping_policy.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/getShippingModel.dart';
import '../model/pickUpModel.dart';
import '../repository/repository.dart';
import '../utils/api_constant.dart';
import '../widgets/common_colour.dart';

class PickUpPolicyListScreen extends StatefulWidget {
  const PickUpPolicyListScreen({super.key});

  @override
  State<PickUpPolicyListScreen> createState() => _PickUpPolicyListScreenState();
}

class _PickUpPolicyListScreenState extends State<PickUpPolicyListScreen> {
  final Repositories repositories = Repositories();
  final formKey1 = GlobalKey<FormState>();
  Rx<PickUpPolicyModel> modelPickUpPolicy = PickUpPolicyModel().obs;
  getShippingPolicyData() {
    repositories.getApi(url: ApiUrls.getPickUpPolicy).then((value) {
      setState(() {
        modelPickUpPolicy.value = PickUpPolicyModel.fromJson(jsonDecode(value));
        log("Return Policy Data: ${modelPickUpPolicy.value.pickupPolicy![0].id.toString()}");
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getShippingPolicyData();
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
              'PickUp Policy List'.tr,
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
                    Get.to(PickUpPolicyPolicyScreen());
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: Text(
                      '+Add New',
                      style: TextStyle(color: AppTheme.buttonColor),
                    ),
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            modelPickUpPolicy.value.pickupPolicy != null
                ? ListView.builder(
                    itemCount: modelPickUpPolicy.value.pickupPolicy!.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      var pickUpPolicyPolicy = modelPickUpPolicy.value.pickupPolicy![index];
                      return GestureDetector(
                        onTap: () {
                          Get.to(PickUpPolicyPolicyScreen(
                            id: pickUpPolicyPolicy.id,
                            policydesc: pickUpPolicyPolicy.description,
                            policyName: pickUpPolicyPolicy.title,
                            handling_days: pickUpPolicyPolicy.handlingDays,
                            pick_option: pickUpPolicyPolicy.pickOption,
                            vendor_will_pay: pickUpPolicyPolicy.vendor_will_pay,
                          ));
                          log(pickUpPolicyPolicy.handlingDays.toString());
                        },
                        child: Container(
                            width: Get.width,
                            margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
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
                                        pickUpPolicyPolicy.title,
                                        style: const TextStyle(
                                            color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        pickUpPolicyPolicy.description,
                                        maxLines: 3,
                                      ),
                                    ],
                                  ),
                                ),
                                // const Spacer(),
                                Text(
                                  'Edit'.tr,
                                  style: GoogleFonts.poppins(
                                      color: const Color(0xff292F45), fontWeight: FontWeight.w500, fontSize: 16),
                                ),
                              ],
                            )),
                      );
                    })
                : const Center(child: Text('No Shipping policy Available'))
          ],
        ),
      ),
    );
  }
}
