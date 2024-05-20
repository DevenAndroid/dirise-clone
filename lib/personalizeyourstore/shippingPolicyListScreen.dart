import 'dart:convert';
import 'dart:developer';

import 'package:dirise/vendor/shipping_policy.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
        log("Return Policy Data: ${modelShippingPolicy.value.shippingPolicy![0].id.toString()}");
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
          onTap: () {
            Navigator.pop(context);
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
                                  SizedBox(height: 10,),
                                  Text(shippingPolicy.description,maxLines: 3,),
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
