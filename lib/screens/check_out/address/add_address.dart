import 'package:dirise/screens/order_screens/my_orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../language/app_strings.dart';
import '../../../widgets/common_colour.dart';
import '../../../widgets/dimension_screen.dart';
import '../../return_policy.dart';
import '../../vendorinformation_screen.dart';
import 'edit_address_screen.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  static var route = "/addAddressScreen";

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
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
              AppStrings.yourAddress.tr,
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
  physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
          child: Column(
            children: [
              Container(
                width: size.width,
                height: 130,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    border: Border.all(color: Color(0xffE4E2E2))),
                child: GestureDetector(onTap: (){
                  Get.toNamed(VendorInformation.route);
                },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Icon(Icons.add,size: 35,color: Color(0xffE4E2E2),), Text("Address",style: GoogleFonts.poppins(fontSize:32,fontWeight:FontWeight.w400,color:Color(0xffACACAC)))],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ListView.builder(
                itemCount: 3,
                
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        width: size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            border: Border.all(color: Color(0xffE4E2E2))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 13),
        
                              child: Row(
                                children: [
        
                                  Text("Default:",
                                      style: GoogleFonts.poppins(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Image(
                                      image: AssetImage(
                                          "assets/icons/tempImageYRVRjh 1.png"))
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 2,
                            ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Text(
                          "fahad",
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "109 Lukens Drive #212122 Unit E new castle,Delaware 19720",
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Kuwait",
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Phone number:+1302568959",
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Add delivery instructions",
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff014E70)),
                        ),
                        SizedBox(
                          height: 30,
                        ),
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
                            Text("|Set as default",
                                style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300,
                                    color: Color(0xff014E70))),
                          ],
                        ),
                          SizedBox(height: 20,)
                      ],),
                    )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  );
                },
              ),
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
                      side: BorderSide(color: Color(0xff014E70)),
                      textStyle: GoogleFonts.poppins(
                          fontSize: AddSize.font20, fontWeight: FontWeight.w600)),
                  child: Text(
                    "Save".tr,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Color(0xff014E70),
                        fontWeight: FontWeight.w500,
                        fontSize: AddSize.font18),
                  )),
              SizedBox(height: 20,),
              ElevatedButton(
                  onPressed: () {
Get.toNamed(EditAddresss.route);

                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.maxFinite, 60),
                      backgroundColor: AppTheme.buttonColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AddSize.size5)),
        
                      textStyle: GoogleFonts.poppins(
                          fontSize: AddSize.font20, fontWeight: FontWeight.w600)),
                  child: Text(
                    "Skip".tr,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: AddSize.font18),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
