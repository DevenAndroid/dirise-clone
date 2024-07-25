import 'package:dirise/bottomavbar.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../widgets/dimension_screen.dart';
import '../screens/my_account_screens/contact_us_screen.dart';
import '../screens/my_account_screens/faqs_screen.dart';

const String navigationBackUrl = "navigationbackUrlCode/navigationbackUrlCode";
const String failureUrl = "navigationbackUrlCode/navigationbackUrlCode__failureUrl";

class VendorAccountCreatedSuccessfullyScreen extends StatefulWidget {
  const VendorAccountCreatedSuccessfullyScreen({
    Key? key,
  }) : super(key: key);
  // final PlanInfoData planInfoData;
  @override
  State<VendorAccountCreatedSuccessfullyScreen> createState() => _VendorAccountCreatedSuccessfullyScreenState();
}

class _VendorAccountCreatedSuccessfullyScreenState extends State<VendorAccountCreatedSuccessfullyScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: AddSize.size45,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Image(
                height: AddSize.size300,
                width: double.maxFinite,
                image: const AssetImage('assets/images/new_logo.png'),
                fit: BoxFit.contain,
                opacity: const AlwaysStoppedAnimation(.80),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Text(
              "Vendor account created successfully".tr,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.w500, fontSize: 30, color: const Color(0xff262F33)),
            ),
            SizedBox(
              height: AddSize.size15,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Image(
                height: 100,
                width: double.maxFinite,
                image: AssetImage('assets/images/thanku.png'),
                fit: BoxFit.contain,
                opacity: AlwaysStoppedAnimation(.80),
              ),
            ),
            SizedBox(
              height: AddSize.size10,
            ),
            Text(
              "If you are having troubles:-".tr,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.w500, fontSize: 14, color: const Color(0xff596774)),
            ),
            GestureDetector(
              onTap: () {
                Get.offNamed(FrequentlyAskedQuestionsScreen.route);
              },
              child: Text(
                'FAQs'.tr,
                style: GoogleFonts.poppins(
                    color: Color(0xff014E70),
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(const ContactUsScreen());
                // Get.offNamed( .route);
              },
              child: Text(
                'Customer Support'.tr,
                style: GoogleFonts.poppins(
                    color: Color(0xff014E70),
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
              ),
            ),
            GestureDetector(
              onTap: () {
                launchUrlString("tel://+96565556490");
              },
              child: Text(
                'call'.tr,
                style: GoogleFonts.poppins(
                    color: Color(0xff014E70),
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
              ),
            ),
            SizedBox(
              height: AddSize.size10,
            ),
            ElevatedButton(
                onPressed: () {
                  Get.offAllNamed(BottomNavbar.route);
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.maxFinite, 60),
                    backgroundColor: AppTheme.buttonColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AddSize.size10)),
                    textStyle: GoogleFonts.poppins(fontSize: AddSize.font20, fontWeight: FontWeight.w600)),
                child: Text(
                  "Continue".tr,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: Colors.white, fontWeight: FontWeight.w500, fontSize: AddSize.font22),
                )),
          ],
        ),
      )),
    );
  }
}
