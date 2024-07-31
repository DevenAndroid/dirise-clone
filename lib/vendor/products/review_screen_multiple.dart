import 'package:dirise/bottomavbar.dart';
import 'package:dirise/utils/helper.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../screens/my_account_screens/contact_us_screen.dart';
import '../../screens/my_account_screens/faqs_screen.dart';
import '../../widgets/common_button.dart';

class RewardScreenMultiple extends StatefulWidget {
  const RewardScreenMultiple({super.key});

  @override
  State<RewardScreenMultiple> createState() => _RewardScreenMultipleState();
}

class _RewardScreenMultipleState extends State<RewardScreenMultiple> {
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
          'Done'.tr,
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
              40.spaceY,
              Image.asset(
                'assets/images/new_logo.png',
                height: 200,
                width: 200,
              ),

              const SizedBox(
                height: 20,
              ),
              Text(
                'Multiple items uploaded successfully'.tr,
                style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 24,),
                textAlign: TextAlign.center,
              ),
              20.spaceY,
              SvgPicture.asset('assets/svgs/thankyou_faq.svg'),
              Text(
                'If you are having troubles:-'.tr,
                style: GoogleFonts.poppins(color: Color(0xff596774), fontWeight: FontWeight.w400, fontSize: 14),
              ),
              20.spaceY,
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
                  Get.to(()=>const BottomNavbar());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
