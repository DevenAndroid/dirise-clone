
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../language/app_strings.dart';
enum BestTutorSite { javatpoint, w3schools, tutorialandexample }
class ReturnnPolicy extends StatefulWidget {
  const ReturnnPolicy({super.key});

  static var route = "/returnPolicyScreen";

  @override
  State<ReturnnPolicy> createState() => _ReturnnPolicyState();
}

class _ReturnnPolicyState extends State<ReturnnPolicy> {

  @override
  BestTutorSite _site = BestTutorSite.javatpoint;
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Color(0xff0D5877),
              size: 16,
            ),
            onPressed: () {
              // Handle back button press
            },
          ),
        ),
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.returnnPolicy.tr,
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            width: size.width,

            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                border: Border.all(color: Color(0xffE4E2E2))),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Text("Default:",
                        style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w500)),

                    Image(
                        image: AssetImage(
                            "assets/icons/tempImageYRVRjh 1.png"))
                  ],
                ),
                Divider(thickness: 1,),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text("Return Within"),
                     Text("Return Shipping Fees")
                  ],
                ),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
decoration: BoxDecoration(
    border: Border.all(color: Color(0xffD9D9D9)),
    shape: BoxShape.rectangle),
                      child: Text("14"),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xffD9D9D9)),
                          shape: BoxShape.rectangle),
                      child: Text(
                          "Days"),
                    ),
                    ListTile(
                      title: const Text('www.javatpoint.com'),
                      leading: Radio(
                        value: BestTutorSite.javatpoint,
                        groupValue: _site,
                        // onChanged: (BestTutorSite value) {
                        //   setState(() {
                        //     _site = value;
                        //   });
                        // },
                      ),
                    ),
                    ListTile(
                      title: const Text('www.w3school.com'),
                      leading: Radio(
                        value: BestTutorSite.w3schools,
                        groupValue: _site,
                        // onChanged: (BestTutorSite value) {
                        //   setState(() {
                        //     _site = value;
                        //   });
                        // },
                      ),
                    ),
                  ],
                ),
                Text("Return Policy Description"),
                Text("Customer pay if he return the product because he made mistake or because he didn’t like the product.Vendor pay if the problem is from the product."),
                Row(
                  children: [
                    Text("Edit",
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            color: Color(0xff014E70))),
                    Text("|Remove",
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            color: Color(0xff014E70))),

                  ],
                ),
              ],
            ),


          )
        ],
        )
    );
  }
}
