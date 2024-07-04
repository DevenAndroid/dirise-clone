import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../bottomavbar.dart';
import '../../controller/profile_controller.dart';
import '../../widgets/common_button.dart';

class ConsulationThankYouScreen extends StatefulWidget {
  const ConsulationThankYouScreen({super.key});

  @override
  State<ConsulationThankYouScreen> createState() => _ConsulationThankYouScreenState();
}

class _ConsulationThankYouScreenState extends State<ConsulationThankYouScreen> {
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
          margin: const EdgeInsets.only(left: 25, right: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/newlogoo1.png',
                height: 200,
                width: 200,
              ),
              Text(
                'Service have been added  successfully'.tr,
                style: GoogleFonts.poppins(color: const Color(0xff0D5877), fontWeight: FontWeight.w600, fontSize: 30),
              ),
              const SizedBox(
                height: 10,
              ),
              Image.asset(
                'assets/images/check.png',
                height: 100,
                width: 100,
              ),
              Text(
                'If you are having troubles:-'.tr,
                style: GoogleFonts.poppins(color: const Color(0xff596774), fontWeight: FontWeight.w400, fontSize: 14),
              ),
              Text(
                'FAQs'.tr,
                style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14),
              ),
              Text(
                'Cutomer Support'.tr,
                style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14),
              ),
              Text(
                'call'.tr,
                style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomOutlineButton(
                title: 'Continue',
                borderRadius: 11,
                onPressed: () {
                  Get.to(BottomNavbar());

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
