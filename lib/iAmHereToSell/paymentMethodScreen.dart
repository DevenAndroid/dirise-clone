import 'dart:convert';

import 'package:dirise/iAmHereToSell/vendoraccountcreatedsuccessfullyScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/cart_controller.dart';
import '../controller/profile_controller.dart';
import '../model/common_modal.dart';
import '../model/vendor_models/model_payment_method.dart';
import '../repository/repository.dart';
import '../utils/api_constant.dart';
import '../vendor/authentication/payment_screen.dart';
import '../widgets/common_colour.dart';
import '../widgets/loading_animation.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  ModelPaymentMethods? methods;
  String paymentMethod1 = "";
  final cartController = Get.put(CartController());
  final profileController = Get.put(ProfileController());
  RxBool showValidation = false.obs;
  getPaymentGateWays() {
    Repositories().getApi(url: ApiUrls.paymentMethodsUrl).then((value) {
      methods = ModelPaymentMethods.fromJson(jsonDecode(value));
      setState(() {});
    });
  }
  final Repositories repositories = Repositories();
  void paymetRedirect() {
    Map<String, dynamic> map = {};
    map['plan_id'] =      profileController.planID.toString();
    map['callback_url'] =  'https://diriseapp.com/home/$navigationBackUrl';
    map['payment_method'] = paymentMethod1;
    map['failure_url'] = 'https://diriseapp.com/home/$failureUrl';
    map['RecurringType'] = 'Custom';
    map['IntervalDays'] = '54';
    map['Iteration'] = '';
    FocusManager.instance.primaryFocus!.unfocus();
    repositories.postApi(url: ApiUrls.createPaymentUrl, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      if (response.status == true) {
        Get.to(() => PaymentScreen(
          paymentUrl: response.uRL.toString(),
          onSuccess: () {
            Get.to(VendorAccountCreatedSuccessfullyScreen());
            // Get.offNamed(OrderCompleteScreen.route, arguments: response.order_id.toString());
          },
        ));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPaymentGateWays();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading:GestureDetector(
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
              'Payment Method'.tr,
              style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {
          cartController.dialogOpened = false;
          if (paymentMethod1.isEmpty) {
            showToast("Please select payment Method".tr);
            return;
          }else{
            paymetRedirect();
          }
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          backgroundColor: const Color(0xff014E70),
        ),
        child: Container(
          // decoration: const BoxDecoration(color: Color(0xff014E70)),
          height: 56,
          alignment: Alignment.bottomCenter,
          child: Align(
              alignment: Alignment.center,
              child: Text("Complete Payment".tr,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white))),
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  Text("Payment".tr, style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18)),
                  const SizedBox(
                    height: 15,
                  ),
                  if (methods != null && methods!.data != null)
                    DropdownButtonFormField(
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: AppTheme.secondaryColor),
                          ),
                          enabled: true,
                          filled: true,
                          hintText: "Select Payment Method".tr,
                          labelStyle: GoogleFonts.poppins(color: Colors.black),
                          labelText: "Select Payment Method".tr,
                          fillColor: const Color(0xffE2E2E2).withOpacity(.35),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: AppTheme.secondaryColor),
                          ),
                        ),
                        isExpanded: true,
                        items: methods!.data!
                            .map((e) => DropdownMenuItem(
                                value: e.paymentMethodId.toString(),
                                child: Row(
                                  children: [
                                    Expanded(child: Text(e.paymentMethodEn.toString())),
                                    SizedBox(width: 35, height: 35, child: Image.network(e.imageUrl.toString()))
                                  ],
                                )))
                            .toList(),
                        onChanged: (value) {
                          if (value == null) return;
                          paymentMethod1 = value;
                          setState(() {});
                        })
                  else
                    const LoadingAnimation(),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}
