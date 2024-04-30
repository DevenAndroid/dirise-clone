
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../language/app_strings.dart';
import '../widgets/common_colour.dart';
import '../widgets/dimension_screen.dart';
class ReturnnPolicy extends StatefulWidget {
  const ReturnnPolicy({super.key});

  static var route = "/returnPolicyScreen";

  @override
  State<ReturnnPolicy> createState() => _ReturnnPolicyState();
}

class _ReturnnPolicyState extends State<ReturnnPolicy> {
  int _radioValue1 = 1;

  // RxInt returnPolicyLoaded = 0.obs;
  // ReturnPolicyModel? modelReturnPolicy;
  // ReturnPolicy? selectedReturnPolicy;
  // final Repositories repositories = Repositories();
  // getReturnPolicyData() {
  //   repositories.getApi(url: ApiUrls.returnPolicyUrl).then((value) {
  //     modelReturnPolicy = ReturnPolicyModel.fromJson(jsonDecode(value));
  //     returnPolicyLoaded.value = DateTime.now().millisecondsSinceEpoch;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: size.width,

                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    border: Border.all(color: Color(0xffE4E2E2))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [


                            Text("My Default Policy:",
                                style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500)),

                            Image(
                                image: AssetImage(
                                    "assets/icons/tempImageYRVRjh 1.png"))
                          ],
                        ),

                      ),
                      Divider(thickness: 1,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Return Within",    style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500)),
                            Text("Return Shipping Fees",    style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500))
                          ],
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                  border: Border.all(color: Color(0xffD9D9D9)),
                                  shape: BoxShape.rectangle),
                              child: Text("14",    style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500)),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  border: Border.all(color: Color(0xffD9D9D9)),
                                  shape: BoxShape.rectangle),
                              child: Text("Days",    style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500)),
                            ),
                            Radio(
                              value: 0,
                              groupValue: _radioValue1,
                              onChanged: (value) {
                                setState(() {
                                  _radioValue1 = value!;
                                });
                              },
                            ),
                            Text(
                              'Buyer Pays',
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500)
                            ),
                            Radio(
                              // Visual Density passed here
                              visualDensity: const VisualDensity(horizontal: -2.0),
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              value: 1,
                              groupValue: _radioValue1,
                              onChanged: (value) {
                                setState(() {
                                  _radioValue1 = value!;
                                });
                              },
                            ),
                            Text(
                              'Seller Pays ',
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500)
                            ),
                          ],
                        ),
                        Text("Return Policy Description",    style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500)),
                        Text("Customer pay if he return the product because he made mistake or because he didn’t like the product.Vendor pay if the problem is from the product.",    style: GoogleFonts.poppins(
                            fontSize:11,
                            )),
                        SizedBox(height: 13,),
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
                      ],),
                    )
                    ],
                  ),
                ),


              ),
              SizedBox(height: 13,),
              Row(mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("+Add New",style: TextStyle(decoration: TextDecoration.underline,color: Color(0xff014E70)
                  ),),
                ],
              ),
              SizedBox(height: 13,),
              Text("DIRISE standard Policy",    style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w500)),
              SizedBox(height: 13,),
              Text("Policy 2",    style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w500)),
              Text("Policy 2",    style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w500)),
              Text("Policy 2",    style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w500)),
              SizedBox(height: 25,),
              ElevatedButton(
                  onPressed: () {
                    Get.toNamed(ReturnnPolicy.route);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffF5F2F2),
                      minimumSize: const Size(double.maxFinite, 60),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AddSize.size5),
                      ),

                      textStyle: GoogleFonts.poppins(
                          fontSize: AddSize.font20, fontWeight: FontWeight.w600)),
                  child: Text(
                    "Save".tr,
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: AddSize.font18),
                  )),
              SizedBox(height: 15,),
              ElevatedButton(
                  onPressed: () {
                    Get.toNamed(ReturnnPolicy.route);
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.maxFinite, 60),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AddSize.size5),
                      ),
                      backgroundColor: AppTheme.buttonColor,
                      textStyle: GoogleFonts.poppins(
                          fontSize: AddSize.font20, fontWeight: FontWeight.w600)),
                  child: Text(
                    "Skip".tr,
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: AddSize.font18),
                  )),

            ],
          ),
        )
    );
  }
}
