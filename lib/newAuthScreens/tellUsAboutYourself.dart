import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../language/app_strings.dart';
import '../newAddress/pickUpAddressScreen.dart';

class TellUsAboutYourSelf extends StatefulWidget {
  const TellUsAboutYourSelf({super.key});

  @override
  State<TellUsAboutYourSelf> createState() => _TellUsAboutYourSelfState();
}

class _TellUsAboutYourSelfState extends State<TellUsAboutYourSelf> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: const Icon(
          Icons.arrow_back_ios_new,
          color: Color(0xff0D5877),
          size: 16,
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
        child: Column(
          children: [
            Container(
              height: 250,
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(11), color: Colors.grey.shade100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/images/homestore.png',
                          height: 40,
                          width: 40,
                        ),
                        const Radio(
                          value: 1,
                          groupValue: 1,
                          onChanged: null,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 60,right: 60),
                    child: Text(
                      AppStrings.iAmHereToSell.tr,
                      style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w300, fontSize: 36),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 250,
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(11), color: Colors.grey.shade100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/images/bagicon.png',
                          height: 40,
                          width: 40,
                        ),
                        const Radio(
                          value: 1,
                          groupValue: 1,
                          onChanged: null,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50,right: 50),
                    child: Text(
                      AppStrings.iWantToGoShopping.tr,
                      style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w300, fontSize: 36),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: (){
                Get.to(const PickUpAddressScreen());
              },
              child: Container(
                margin: const EdgeInsets.only(left: 20,right: 20),
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
                child: const Center(
                  child: Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Text color
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
