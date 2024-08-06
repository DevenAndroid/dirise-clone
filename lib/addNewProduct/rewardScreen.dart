import 'package:dirise/bottomavbar.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../screens/my_account_screens/contact_us_screen.dart';
import '../screens/my_account_screens/faqs_screen.dart';
import '../tellaboutself/ExtraInformation.dart';
import '../widgets/common_button.dart';

class RewardScreen extends StatefulWidget {
  const RewardScreen({super.key});

  @override
  State<RewardScreen> createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading:SizedBox(),
        titleSpacing: 0,
        centerTitle: true,
        title: Text(
          'Reward'.tr,
          style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 25, right: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Image.asset(
                'assets/images/reward_logo.png',
                height: 200,
                width: 200,
              ),

              Text(
                'Congratulations'.tr,
                style: GoogleFonts.poppins(color: const Color(0xff0D5877), fontWeight: FontWeight.w600, fontSize: 32),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Thank you for your donation, you will get 1000 Dicoins as a reward for your generosity'.tr,
                style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16,),
                textAlign: TextAlign.center,
              ),
              Text(
                'If you are having troubles:-'.tr,
                style: GoogleFonts.poppins(color: Color(0xff596774), fontWeight: FontWeight.w400, fontSize: 14),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(()=>const FrequentlyAskedQuestionsScreen());
                  // Get.offNamed(FrequentlyAskedQuestionsScreen.route);
                },
                child: Text(
                  'FAQs'.tr,
                  style: GoogleFonts.poppins(color: AppTheme.buttonColor, fontWeight: FontWeight.w500, fontSize: 14,decoration: TextDecoration.underline),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(const ContactUsScreen());
                  // Get.offNamed( .route);
                },
                child: Text(
                  'Cutomer Support'.tr,
                  style: GoogleFonts.poppins(color: AppTheme.buttonColor, fontWeight: FontWeight.w500, fontSize: 14,decoration: TextDecoration.underline),
                ),
              ),
              GestureDetector(
                onTap: (){
                  launchUrlString("tel://96565556490");
                },
                child: Text(
                  'call'.tr,
                  style: GoogleFonts.poppins(color: AppTheme.buttonColor, fontWeight: FontWeight.w500, fontSize: 14,decoration: TextDecoration.underline),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomOutlineButton(
                title: 'Continue'.tr,
                borderRadius: 11,
                onPressed: () {
                  Get.offAllNamed(BottomNavbar.route);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
