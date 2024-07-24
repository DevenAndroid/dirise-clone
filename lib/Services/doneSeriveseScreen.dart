import 'package:dirise/bottomavbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../screens/my_account_screens/contact_us_screen.dart';
import '../screens/my_account_screens/faqs_screen.dart';
import '../widgets/common_button.dart';

class DoneServiceScreen extends StatefulWidget {
  const DoneServiceScreen({super.key});

  @override
  State<DoneServiceScreen> createState() => _DoneServiceScreenState();
}

class _DoneServiceScreenState extends State<DoneServiceScreen> {
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
                'assets/images/new_logo.png',
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
                'Service have been added successfully '.tr,
                style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 16,),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                'If you are having troubles:-'.tr,
                style: GoogleFonts.poppins(color: Color(0xff596774), fontWeight: FontWeight.w400, fontSize: 14),
              ),
              GestureDetector(
                onTap: () {
                  Get.offNamed(FrequentlyAskedQuestionsScreen.route);
                },
                child: Text(
                  'FAQs'.tr,
                  style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(const ContactUsScreen());
                  // Get.offNamed( .route);
                },
                child: Text(
                  'Cutomer Support'.tr,
                  style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14),
                ),
              ),
              GestureDetector(
                onTap: (){
                  launchUrlString("tel://96565556490");
                },
                child: Text(
                  'call'.tr,
                  style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomOutlineButton(
                title: 'Continue',
                borderRadius: 11,
                onPressed: () {
                  Get.to(const BottomNavbar());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
