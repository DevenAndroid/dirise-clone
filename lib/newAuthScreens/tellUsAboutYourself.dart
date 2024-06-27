import 'package:dirise/iAmHereToSell/whichplantypedescribeyouScreen.dart';
import 'package:dirise/utils/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../addNewProduct/locationScreen.dart';
import '../language/app_strings.dart';
import '../newAddress/pickUpAddressScreen.dart';
import '../utils/api_constant.dart';

class TellUsAboutYourSelf extends StatefulWidget {
  static String route = "/TellUsAboutYourSelf";
  const TellUsAboutYourSelf({Key? key}) : super(key: key);

  @override
  State<TellUsAboutYourSelf> createState() => _TellUsAboutYourSelfState();
}

class _TellUsAboutYourSelfState extends State<TellUsAboutYourSelf> {
  String selectedRadio = '';

  void navigateNext() {
    if (selectedRadio == 'sell') {
      Get.to(const WhichplantypedescribeyouScreen());
    } else if (selectedRadio == 'shop') {
      Get.to( PickUpAddressScreen());
    }else{
      showToast('Select type of Account');
    }
  }

  @override
  Widget build(BuildContext context) {
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
              AppStrings.tellUsAboutYourself.tr,
              style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 35,horizontal: 10),
        child: Column(
          children: [
            GestureDetector(
              onTap: (){
                Get.to(PickUpAddressScreen());
                setState(() {

                });
              },
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(11), color: Colors.grey.shade100),
                child: Image.asset('assets/images/customer_img.png'),
              ),
            ),
            30.spaceY,
            GestureDetector(
              onTap: (){
                Get.to( const WhichplantypedescribeyouScreen());
                setState(() {

                });
              },
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(11), color: Colors.grey.shade100),
                child: Image.asset('assets/images/vendor-img.png'),
              ),
            ),
            // GestureDetector(
            //   onTap: () {
            //     navigateNext();
            //   },
            //   child: Container(
            //     margin: const EdgeInsets.only(left: 20, right: 20),
            //     width: Get.width,
            //     height: 50,
            //     decoration: BoxDecoration(
            //       border: Border.all(
            //         color: const Color(0xff0D5877),
            //         width: 1.0,
            //       ),
            //       borderRadius: BorderRadius.circular(2),
            //     ),
            //     padding: const EdgeInsets.all(10),
            //     child: const Center(
            //       child: Text(
            //         'Next',
            //         style: TextStyle(
            //           fontSize: 16,
            //           fontWeight: FontWeight.bold,
            //           color: Colors.black,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
