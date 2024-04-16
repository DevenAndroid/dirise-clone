import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicy extends StatefulWidget {
  static String route = "/PrivacyPolicy";
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: SafeArea(
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Color(0xff014E70), size: 20),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                Text(
                  'Privacy Policy'.tr,
                  style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
                )
              ],
            ),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
          child: Column(
            children: [
              Text(
                "For users with a separate Doc Send or Drop Sign account, the DocSend Terms of Service can found here, and the  Sign Terms of Service can found here.".tr,
                style: GoogleFonts.poppins(fontSize: 15, height: 1.7, color: const Color(0xff3B484A)),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "Thanks for using Dropbox! Our mission is to create a more enlightened way of working, and help you and those you work with stay coordinated. We do so by providing an intuitive, unified platform and suite of apps and services that keep your content safe, accessible and in sync. These terms of service (“Terms”) cover your use and access to our services".tr,
                style: GoogleFonts.poppins(fontSize: 15, height: 1.7, color: const Color(0xff3B484A)),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "When you use our Services, you provide us with things like your files, content, messages, contacts, and so on (“Your Stuff”). Your Stuff is yours.".tr,
                style: GoogleFonts.poppins(fontSize: 15, height: 1.7, color: const Color(0xff3B484A)),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "unified platform and suite of apps and services that keep your content safe, accessible and in sync. These terms of service (“Terms”) cover your use and access to our ".tr,
                style: GoogleFonts.poppins(fontSize: 15, height: 1.7, color: const Color(0xff3B484A)),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "unified platform and suite of apps and services that keep your content safe, accessible and in sync. These terms of service (“Terms”) cover your use and access to our ".tr,
                style: GoogleFonts.poppins(fontSize: 15, height: 1.7, color: const Color(0xff3B484A)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
