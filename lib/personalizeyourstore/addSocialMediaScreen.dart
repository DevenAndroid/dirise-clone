import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddSocialMediaScreen extends StatefulWidget {
  const AddSocialMediaScreen({super.key});

  @override
  State<AddSocialMediaScreen> createState() => _AddSocialMediaScreenState();
}

class _AddSocialMediaScreenState extends State<AddSocialMediaScreen> {
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
              'Social Media'.tr,
              style: GoogleFonts.poppins(color: Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Add Custom social media link to your profile'.tr,
                style: GoogleFonts.poppins(color: Color(0xff292F45), fontWeight: FontWeight.w400, fontSize: 16),
              ),
              SizedBox(
                height: 60,
              ),
              Text(
                'Upload the custom logo'.tr,
                style: GoogleFonts.poppins(color: Color(0xff014E70), fontWeight: FontWeight.w400, fontSize: 24),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 30,
                width: 100,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(11), color: Colors.grey.shade100),
                child: Center(
                  child: Text(
                    'Choose file'.tr,
                    style: GoogleFonts.poppins(color: Color(0xff2F2F2F), fontWeight: FontWeight.w400, fontSize: 12),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(10),
                height: 140,
                width: 180,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                    color: Colors.white,
                    border: Border.all(color: Color(0xff014E70))),
                child: Center(
                    child: Image.asset(
                  'assets/images/newlogoo.png',
                  height: 40,
                  width: 40,
                )),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 100,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black, // Border color
                    width: 1.0, // Border width
                  ),
                  borderRadius: BorderRadius.circular(10), // Border radius
                ),
                padding: const EdgeInsets.all(10), // Padding inside the container
                child: const Center(
                  child: Text(
                    'upload',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Text color
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
