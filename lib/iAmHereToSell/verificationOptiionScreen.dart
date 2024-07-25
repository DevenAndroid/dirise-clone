import 'package:dirise/iAmHereToSell/securityDetailsScreen.dart';
import 'package:dirise/iAmHereToSell/timeVerificationScreen.dart';
import 'package:dirise/iAmHereToSell/vendoraccountcreatedsuccessfullyScreen.dart';
import 'package:dirise/iAmHereToSell/verificationSelectDateScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/profile_controller.dart';
import '../language/app_strings.dart';
import '../utils/api_constant.dart';
import '../widgets/common_colour.dart';

class VerificationOptionScreen extends StatefulWidget {
  const VerificationOptionScreen({super.key});

  @override
  State<VerificationOptionScreen> createState() => _VerificationOptionScreenState();
}

class _VerificationOptionScreenState extends State<VerificationOptionScreen> {
  String selectedRadio = '';

  void navigateNext() {
    if (selectedRadio == 'creditCard') {
      Get.to(SecurityDetailsScreen());

    } else if (selectedRadio == 'virtual') {

      Get.to(VerificationSelectDateScreen());
    }
    else if (selectedRadio == 'voice') {
      Get.to(VerificationTimeScreen());
    }
    else if (selectedRadio == 'skip') {
      Get.to(VendorAccountCreatedSuccessfullyScreen());
    }else{
      showToast('Select type of product'.tr);
    }
  }

  final profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
              'Verification'.tr,
              style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 200,
                  margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 15),
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(11),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(
                            0.2,
                            0.2,
                          ),
                          blurRadius: 1,
                        ),
                      ]),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/creditcard.png',
                            height: 50,
                            width: 50,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Credit card'.tr,
                            style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 24, color: Colors.black),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Flexible(
                        child: Text(
                          'We ask you for your credit card to make sure that you are not a robot, helps us reduce fraud and theft.  Any charges, will be refunded. No auto-charge after free trial ends'.tr,
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),
                        ),
                      ),
                      Text(
                        'Not available in your region'.tr,
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black),
                      )
                    ],
                  ),
                ),
                //  Positioned(
                //   right: 20,
                //   top: 20,
                //   child:  Radio(
                //     value: 'creditCard',
                //     groupValue: selectedRadio,
                //     onChanged: (value) {
                //       setState(() {
                //         selectedRadio = value.toString();
                //       });
                //     },
                //   ),
                // ),
              ],
            ),
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 15),
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(11),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(
                            0.2,
                            0.2,
                          ),
                          blurRadius: 1,
                        ),
                      ]),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/metting.png',
                            height: 50,
                            width: 50,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Virtual Meeting'.tr,
                            style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 24, color: Colors.black),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Schedule a time for the verification'.tr,
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),
                      )
                    ],
                  ),
                ),
                Positioned(
                  right: 20,
                  top: 20,
                  child:  Radio(
                    value: 'virtual',
                    groupValue: selectedRadio,
                    onChanged: (value) {
                      setState(() {
                        selectedRadio = value.toString();
                      });
                    },
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 15),
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(11),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(
                            0.2,
                            0.2,
                          ),
                          blurRadius: 1,
                        ),
                      ]),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/voicecall.png',
                            height: 50,
                            width: 50,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Voice Call'.tr,
                            style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 24, color: Colors.black),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Choose the best time to receive the verification call.'.tr,
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),
                      )
                    ],
                  ),
                ),
                Positioned(
                  right: 20,
                  top: 20,
                  child: Radio(
                    value: 'voice',
                    groupValue: selectedRadio,
                    onChanged: (value) {
                      setState(() {
                        selectedRadio = value.toString();
                      });
                    },
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 15),
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(11),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(
                            0.2,
                            0.2,
                          ),
                          blurRadius: 1,
                        ),
                      ]),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/pause.png',
                            height: 50,
                            width: 50,
                          ),
                          Text(
                            'Skip verification'.tr,
                            style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 24, color: Colors.black),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Earnings will be on hold until verification is done.'.tr,
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),
                      )
                    ],
                  ),
                ),
                Positioned(
                  right: 20,
                  top: 20,
                  child:  Radio(
                    value: 'skip',
                    groupValue: selectedRadio,
                    onChanged: (value) {
                      setState(() {
                        selectedRadio = value.toString();
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: (){
                navigateNext();
              },
              child: Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                width: Get.width,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xff0D5877), // Border color
                    width: 1.0, // Border width
                  ),
                  borderRadius: BorderRadius.circular(2), // Border radius
                ),
                padding: const EdgeInsets.all(10), // Padding inside the container
                child:   Center(
                  child: Text(
                    'Next'.tr,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.buttonColor, // Text color
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}
