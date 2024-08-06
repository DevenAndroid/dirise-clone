import 'package:dirise/bottomavbar.dart';
import 'package:dirise/model/faq_model.dart';
import 'package:dirise/screens/my_account_screens/contact_us_screen.dart';
import 'package:dirise/screens/my_account_screens/faqs_screen.dart';
import 'package:dirise/screens/order_screens/my_orders_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../controller/profile_controller.dart';
import '../widgets/common_button.dart';

class CongratulationScreen extends StatefulWidget {
  const CongratulationScreen({super.key});

  @override
  State<CongratulationScreen> createState() => _CongratulationScreenState();
}

class _CongratulationScreenState extends State<CongratulationScreen> {
  final profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
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
              'Done'.tr,
              style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 25,right: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/new_logo.png',height: 200,width: 200,),
              Text('Your job profile has been published successfully'.tr,
                style: GoogleFonts.poppins(color: const Color(0xff0D5877), fontWeight: FontWeight.w600, fontSize: 30),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child:  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: SvgPicture.asset(
                      'assets/images/right.svg',
                      width: 100,
                      height: 100,
                    )
                ),
              ),
              Text(
                'If you are having troubles:-'.tr,
                style: GoogleFonts.poppins(color: Color(0xff596774), fontWeight: FontWeight.w400, fontSize: 14),
              ),
              GestureDetector(
                onTap: (){
                  Get.to( const FrequentlyAskedQuestionsScreen());
                },
                child: Text(
                  'FAQs'.tr,
                  style: GoogleFonts.poppins(    color: Color(0xff014E70),
                      decoration: TextDecoration.underline, fontWeight: FontWeight.w400, fontSize: 14),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Get.to(const ContactUsScreen());
                  // Get.offNamed( .route);
                },
                child: Text(
                  'Cutomer Support'.tr,
                  style: GoogleFonts.poppins(    color: Color(0xff014E70),
                      decoration: TextDecoration.underline, fontWeight: FontWeight.w400, fontSize: 14),
                ),
              ),
              GestureDetector(
                onTap: (){
                  launchUrlString("tel://96565556490");
                },
                child: Text(
                  'call'.tr,
                  style: GoogleFonts.poppins(    color: Color(0xff014E70),
                      decoration: TextDecoration.underline, fontWeight: FontWeight.w400, fontSize: 14),
                ),
              ),
              const SizedBox(height: 20,),
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
