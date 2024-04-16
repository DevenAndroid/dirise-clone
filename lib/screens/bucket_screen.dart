import 'package:dirise/language/app_strings.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BucketScreen extends StatefulWidget {
  const BucketScreen({Key? key}) : super(key: key);

  @override
  State<BucketScreen> createState() => _BucketScreenState();
}

class _BucketScreenState extends State<BucketScreen> {
  @override
  Widget build(BuildContext context) {
    Size height = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
              height: height.height * .3,
              image: const AssetImage(
                'assets/images/bucket.png',
              )),
          Center(
            child: Text(
              AppStrings.bagEmpty.tr,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppTheme.buttonColor),
                padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 35, vertical: 13)),
              ),
              child: Text(
                AppStrings.shopNow.tr,
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
              ))
        ],
      ),
    );
  }
}
