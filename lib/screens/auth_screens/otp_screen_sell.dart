import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dirise/language/app_strings.dart';
import 'package:dirise/repository/repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import '../../controller/profile_controller.dart';
import '../../model/common_modal.dart';
import '../../model/login_model.dart';
import '../../utils/api_constant.dart';
import '../../utils/helper.dart';
import '../../vendor/authentication/vendor_plans_screen.dart';
import '../../vendor/dashboard/dashboard_screen.dart';
import '../../widgets/common_colour.dart';
import '../../bottomavbar.dart';
import 'package:http/http.dart' as http;
import 'newpasswordscreen.dart';

class OtpScreenSell extends StatefulWidget {
  static String route = "/OtpScreenSell";

  const OtpScreenSell({Key? key}) : super(key: key);

  @override
  State<OtpScreenSell> createState() => _OtpScreenSellState();
}

class _OtpScreenSellState extends State<OtpScreenSell> {
  final TextEditingController _otpController = TextEditingController();
  final Repositories repositories = Repositories();
  late bool check;
  final profileController = Get.put(ProfileController());
  String email = "";
  Map<String, dynamic> tempMap = {};
  verifyOtp() async {
    String? token = await FirebaseMessaging.instance.getToken();
    String? token1 = await FirebaseMessaging.instance.getToken();
    if (_otpController.text.trim().isEmpty) {
      showToast("Please enter OTP".tr);
      return;
    }
    if (_otpController.text.trim().length < 4) {
      showToast("Enter complete OTP".tr);
      return;
    }
    FocusManager.instance.primaryFocus!.unfocus();
    Map<String, dynamic> map = {};
    map['email'] = email;
    map['otp'] = _otpController.text.trim();
    map['fcm_token'] = Platform.isAndroid?token.toString():token1.toString();
    map['key'] = 'forget';
    repositories.postApi(url: ApiUrls.verifyOtpEmail, context: context, mapData: map).then((value) async {
      LoginModal response = LoginModal.fromJson(jsonDecode(value));
      showToast(response.message);
      if (response.status == true) {
        if (check == true) {
          repositories.saveLoginDetails(jsonEncode(response));
          Get.offAllNamed(VendorPlansScreen.route);
        } else {
          Get.offNamed(NewPasswordScreen.route, arguments: [email]);
        }
      }
    });
  }

  Future registerApi() async {
    // Map<String, dynamic> map = {};
    // map['email'] = _emailController.text.trim();
    // map['name'] = _nameController.text.trim();
    // map['phone'] = _mobileNumberController.text.trim();
    // map['password'] = _passwordController.text.trim();
    FocusManager.instance.primaryFocus!.unfocus();
    await repositories.postApi(url: ApiUrls.signInUrl, context: context, mapData: tempMap).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      // showToast(response.message.toString());
      log(response.toString());
      if (response.status == true) {
        setTimer();
        showToast("OTP sent successfully".tr);
      }
    });
  }
  Future resendApi() async {
    Map<String, dynamic> map = {};
    map['email'] = email.toString();
    map['key'] = 'forget';
    // map['name'] = _nameController.text.trim();
    // map['phone'] = _mobileNumberController.text.trim();
    // map['password'] = _passwordController.text.trim();
    FocusManager.instance.primaryFocus!.unfocus();
    await repositories.postApi(url: ApiUrls.resendOtpUrl, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      // showToast(response.message.toString());
      log(response.otp.toString());
      if (response.status == true) {
        setTimer();
        showToast("OTP sent successfully".tr);
      }
    });
  }

  Future<ModelCommonResponse> forgotPasswordRepo() async {
    OverlayEntry loader = Helpers.overlayLoader(context);
    Overlay.of(context).insert(loader);
    // var map = <String, dynamic>{};
    // map['email'] = email;
    var header = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json",
    };
    FocusManager.instance.primaryFocus!.unfocus();
    final response = await http.post(Uri.parse(ApiUrls.forgotPasswordUrl), body: jsonEncode(tempMap), headers: header);
    if (response.statusCode == 200 || response.statusCode == 400) {
      log(response.body);
      Helpers.hideLoader(loader);
      return ModelCommonResponse.fromJson(jsonDecode(response.body));
    } else {
      Helpers.hideLoader(loader);
      throw Exception(response.body);
    }
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
    profileController.getDataProfile();
    check = Get.arguments[1];
    email = Get.arguments[0];
    tempMap = Get.arguments[2];
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
                      AppStrings.otpVerification.tr,
                      style: GoogleFonts.poppins(fontSize: 23, fontWeight: FontWeight.w700, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      AppStrings.resendOTP.tr,
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
                            AppStrings.notReceive.tr,
                            style: GoogleFonts.poppins(color: const Color(0xff3D4260), fontSize: 17),
                          ),
                          SizedBox(
                            height: size.height * .03,
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (timerInt.value == 0) {
                                if (check) {
                                  resendApi();
                                } else {
                                  await forgotPasswordRepo().then((value) {
                                    if (value.status == true) {
                                      setTimer();
                                      showToast("OTP sent successfully".tr);
                                    }
                                  });
                                }
                              }
                            },
                            child: Obx(() {
                              return Text(
                                ' Resend OTP\n'
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
