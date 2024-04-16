import 'dart:convert';

import 'package:dirise/model/common_modal.dart';
import 'package:dirise/repository/repository.dart';
import 'package:dirise/utils/api_constant.dart';
import 'package:dirise/utils/styles.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:dirise/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../model/vendor_models/model_payment_method.dart';
import '../../model/vendor_models/model_plan_list.dart';
import '../../widgets/dimension_screen.dart';
import '../dashboard/dashboard_screen.dart';
import 'payment_screen.dart';

const String navigationBackUrl = "navigationbackUrlCode/navigationbackUrlCode";
const String failureUrl = "navigationbackUrlCode/navigationbackUrlCode__failureUrl";

class ThankYouVendorScreen extends StatefulWidget {
  const ThankYouVendorScreen({Key? key, required this.planInfoData}) : super(key: key);
  final PlanInfoData planInfoData;
  @override
  State<ThankYouVendorScreen> createState() => _ThankYouVendorScreenState();
}

class _ThankYouVendorScreenState extends State<ThankYouVendorScreen> {
  final Repositories repositories = Repositories();
  ModelPaymentMethods? methods;
  String paymentMethod = "";

  getPaymentUrl() {
    if (paymentMethod.isEmpty) {
      showToast("Please select payment method".tr);
      return;
    }
    repositories.postApi(url: ApiUrls.createPaymentUrl, context: context, mapData: {
      'plan_id': widget.planInfoData.id.toString(),
      'callback_url': 'https://diriseapp.com/home/$navigationBackUrl',
      'failure_url': 'https://diriseapp.com/home/$failureUrl',
      'payment_method': paymentMethod,
    }).then((value) {
      ModelCommonResponse modelCommonResponse = ModelCommonResponse.fromJson(jsonDecode(value));
      if (modelCommonResponse.uRL != null) {
        Get.to(() => PaymentScreen(
              paymentUrl: modelCommonResponse.uRL,
            ));
      }
    });
  }

  getPaymentGateWays() {
    repositories.getApi(url: ApiUrls.paymentMethodsUrl).then((value) {
      methods = ModelPaymentMethods.fromJson(jsonDecode(value));
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    getPaymentGateWays();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        Get.back();
        Get.back();
        Get.to(() => const VendorDashBoardScreen());
        return false;
      },
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   surfaceTintColor: Colors.transparent,
        //   elevation: 0,
        //   leading: const SizedBox.shrink(),
        //   actions: [
        //     TextButton(
        //         onPressed: () {
        //           Get.back();
        //           Get.back();
        //           Get.back();
        //           Get.back();
        //           Get.back();
        //           Get.to(() => const VendorDashBoardScreen());
        //         },
        //         child: Text(
        //           "Skip".tr,
        //           style: titleStyle,
        //         ))
        //   ],
        // ),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: AddSize.size45,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Image(
                  height: AddSize.size300,
                  width: double.maxFinite,
                  image: const AssetImage('assets/images/thanku.png'),
                  fit: BoxFit.contain,
                  opacity: const AlwaysStoppedAnimation(.80),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Text(
                "Your Account Has Been Successfully Created".tr,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 30, color: const Color(0xff262F33)),
              ),
              SizedBox(
                height: AddSize.size15,
              ),
              SizedBox(
                height: AddSize.size10,
              ),
            ],
          ),
        )),
        bottomNavigationBar: methods != null && methods!.data != null
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.size40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Make payment to active plan".tr,
                      // textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontWeight: FontWeight.w500, fontSize: 15, color: const Color(0xff262F33)),
                    ),
                    const SizedBox(
                      height: 10,
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
                            paymentMethod = value;
                            setState(() {});
                          }),
                    const SizedBox(
                      height: 12,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          getPaymentUrl();
                          // Get.off(() => const VendorDashBoardScreen());
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.maxFinite, 60),
                            backgroundColor: AppTheme.buttonColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AddSize.size10)),
                            textStyle: GoogleFonts.poppins(fontSize: AddSize.font20, fontWeight: FontWeight.w600)),
                        child: Text(
                          "Continue".tr,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(color: Colors.white, fontWeight: FontWeight.w500, fontSize: AddSize.font22),
                        )),
                  ],
                ),
              )
            : const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  LoadingAnimation(),
                ],
              ),
      ),
    );
  }
}
