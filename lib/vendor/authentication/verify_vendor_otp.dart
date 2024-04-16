import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import '../../../model/common_modal.dart';
import '../../../utils/api_constant.dart';
import '../../../widgets/common_colour.dart';
import '../../controller/profile_controller.dart';
import '../../model/vendor_models/model_plan_list.dart';
import '../../repository/repository.dart';
import 'thank_you_screen.dart';

class VendorOTPVerification extends StatefulWidget {
  static String route = "/VendorOTPVerification";

  const VendorOTPVerification({Key? key}) : super(key: key);

  @override
  State<VendorOTPVerification> createState() => _VendorOTPVerificationState();
}

class _VendorOTPVerificationState extends State<VendorOTPVerification> {
  final TextEditingController _otpController = TextEditingController();
  final Repositories repositories = Repositories();
  String email = "";
  PlanInfoData selectedPlan = PlanInfoData();
  final profileController = Get.put(ProfileController());

  verifyOtp() {
    if (_otpController.text.trim().isEmpty) {
      showToast("Please enter OTP".tr);
      return;
    }
    if (_otpController.text.trim().length < 4) {
      showToast("Enter complete OTP".tr);
      return;
    }
    Map<String, dynamic> map = {};
    map['email'] = email;
    map['otp'] = _otpController.text.trim();
    repositories.postApi(url: ApiUrls.verifyVendorOTPEmailUrl, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message);
      if (response.status == true) {
        profileController.getDataProfile();
        Get.back();
        Get.back();
        Get.back();
        Get.back();
        Get.back();
        Get.to(() => ThankYouVendorScreen(planInfoData: selectedPlan,));
      }
    });
  }

  Future resendOTP() async {
    await repositories.postApi(
      url: ApiUrls.vendorResendOTPUrl,
      context: context,
      mapData: {"email": email},
    ).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      if (response.status == true) {
        setTimer();
        // showToast("OTP sent successfully");
      }
    });
  }

  RxInt timerInt = 30.obs;
  Timer? timer;

  setTimer() {
    timerInt.value = 30;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      timerInt.value--;
      if (timerInt.value == 0) {
        timer.cancel();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    email = Get.arguments[0];
    selectedPlan = Get.arguments[1];
    setTimer();
  }

  @override
  void dispose() {
    super.dispose();
    if (timer != null) {
      timer!.cancel();
    }
  }

  final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: GoogleFonts.poppins(
        fontSize: 22,
        color: const Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: Colors.grey.shade300,
        width: 4.0,
      ))));

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
            height: size.height,
            width: size.width,
            child: Stack(children: [
              Container(
                height: size.height,
                width: size.width,
                decoration: const BoxDecoration(color: AppTheme.buttonColor),
                padding: EdgeInsets.symmetric(horizontal: size.width * .02, vertical: size.height * .06),
                child: Column(
                  children: [
                    Image.asset(height: size.height * .15, 'assets/images/otplogo.png'),
                    const SizedBox(
                      height: 13,
                    ),
                    Text(
                      'OTP Verification'.tr,
                      style: GoogleFonts.poppins(fontSize: 23, fontWeight: FontWeight.w700, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Enter the otp sent to your email'.tr,
                      style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
                    )
                  ],
                ),
              ),
              Positioned(
                  top: size.height * .40,
                  right: 0,
                  left: 0,
                  bottom: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        // borderRadius: BorderRadius.only(topLeft: Radius.circular(100))
                      ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 60, left: 10, right: 10),
                      child: Column(
                        children: [
                          Pinput(
                            controller: _otpController,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            keyboardType: TextInputType.number,
                            length: 4,
                            defaultPinTheme: defaultPinTheme,
                          ),
                          SizedBox(
                            height: size.height * .05,
                          ),
                          Text(
                            "Didn't you receive the OTP?".tr,
                            style: GoogleFonts.poppins(color: const Color(0xff3D4260), fontSize: 17),
                          ),
                          SizedBox(
                            height: size.height * .03,
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (timerInt.value == 0) {
                                resendOTP();
                              }
                            },
                            child: Obx(() {
                              return Text(
                                '${'Resend OTP'.tr}\n'
                                '${timerInt.value > 0 ? "In ${timerInt.value > 9 ? timerInt.value : "0${timerInt.value}"}" : ""}',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600, color: const Color(0xff578AE8), fontSize: 16),
                              );
                            }),
                          ),
                          SizedBox(
                            height: size.height * .2,
                          ),
                        ],
                      ),
                    ),
                  ))
            ])),
      ),
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(15.0).copyWith(bottom: 10),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.buttonColor,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                textStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                )),
            onPressed: () {
              verifyOtp();
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Verify OTP'.tr,
                style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
