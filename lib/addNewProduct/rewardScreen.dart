import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xff0D5877),
            size: 16,
          ),
        ),
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Reward'.tr,
              style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 15,right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/newlogoo.png'),
              Text(
                'Congratulations'.tr,
                style: GoogleFonts.poppins(color: const Color(0xff0D5877), fontWeight: FontWeight.w600, fontSize: 32),
              ),
              Text(
                'Thank you for your donation, you will get 1000 Dicoins as a reward for your generosity'.tr,
                style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 16),
              ),
              Text(
                'If you are having troubles:-'.tr,
                style: GoogleFonts.poppins(color: Color(0xff596774), fontWeight: FontWeight.w400, fontSize: 14),
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
              const SizedBox(height: 20,),
              CustomOutlineButton(
                title: 'Confirm',
                borderRadius: 11,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
