import 'dart:io';

import 'package:dirise/addNewProduct/itemdetailsScreen.dart';
import 'package:dirise/controller/profile_controller.dart';
import 'package:dirise/utils/api_constant.dart';
import 'package:dirise/utils/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Services/whatServiceDoYouProvide.dart';
import '../iAmHereToSell/whichplantypedescribeyouScreen.dart';
import '../jobOffers/tellusaboutyourselfScreen.dart';
import '../language/app_strings.dart';
import '../newAddress/pickUpAddressScreen.dart';
import '../singleproductScreen/product_information_screen.dart';
import '../widgets/common_button.dart';

class Giveway1Screen extends StatefulWidget {
  static String route = "/TellUsAboutYourSelf";
  File? featureImage;
  Giveway1Screen({Key? key,this.featureImage}) : super(key: key);

  @override
  State<Giveway1Screen> createState() => _Giveway1ScreenState();
}

class _Giveway1ScreenState extends State<Giveway1Screen> {
  String selectedRadio = '';
  final profileController = Get.put(ProfileController());

  List<String> itemTexts = [
    'Working',
    'Not Working',
    'Scrap',

  ];

  void navigateNext() {
    if (profileController.model.user!.isVendor == true) {
      // If user is a vendor, allow all radio buttons
      if (selectedRadio == 'Working') {
        Get.to( ItemDetailsScreens());
      } else if (selectedRadio == 'Not Working') {
        Get.to( ItemDetailsScreens());
        // Get.to(ProductInformationScreens(fetaureImage: widget.featureImage,));
      } else if (selectedRadio == 'Scrap') {
        Get.to( ItemDetailsScreens());
        // Get.to(JobTellusaboutyourselfScreen());
      } else {
        // Handle the case where the selected radio doesn't match any case
        // For example, show a message or perform a different action
      }
    } else {
      // If user is not a vendor, only allow 'Giveaway' option
      if (selectedRadio == 'Giveaway') {
        Get.to( ItemDetailsScreens());
      } else {
        showToast('Please Register As A Vendor');
      }
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
              'My Item is  a'.tr,
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              30.spaceY,
              GestureDetector(
                onTap: (){
                  selectedRadio = 'Working';
                  navigateNext();
                  setState(() {});
                },
                  child: Image.asset('assets/images/working_logo.png')),
              20.spaceY,
              GestureDetector(
                  onTap: (){
                    selectedRadio = 'Not Working';
                    navigateNext();
                    setState(() {});
                  },
                  child: Image.asset('assets/images/need_maintenance.png')),
              20.spaceY,
              GestureDetector(
                  onTap: (){
                    selectedRadio = 'Scrap';
                    navigateNext();
                    setState(() {});
                  },
                  child: Image.asset('assets/images/scrap_img.png')),
              // Expanded(
              //   child: GridView.builder(
              //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 2,
              //       crossAxisSpacing: 5,
              //       mainAxisSpacing: 5,
              //       mainAxisExtent: 200,
              //       childAspectRatio: 2, // Aspect ratio can be adjusted
              //     ),
              //     itemCount: itemTexts.length, // Number of grid items
              //     itemBuilder: (BuildContext context, int index) {
              //       return buildStack(itemTexts[index]);
              //     },
              //   ),
              // ),


              // 30.spaceY,
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: GestureDetector(
              //     onTap: () {
              //       if(selectedRadio.isNotEmpty){
              //         navigateNext();
              //       }
              //       else{
              //         showToast('Please select any item type');
              //       }
              //     },
              //     child: Container(
              //       width: Get.width,
              //       height: 55,
              //       decoration: BoxDecoration(
              //         border: Border.all(
              //           color: Colors.black, // Border color
              //           width: 1.0, // Border width
              //         ),
              //         borderRadius: BorderRadius.circular(1), // Border radius
              //       ),
              //       padding: const EdgeInsets.all(10), // Padding inside the container
              //       child: const Center(
              //         child: Text(
              //           'Next',
              //           style: TextStyle(
              //             fontSize: 16,
              //             fontWeight: FontWeight.bold,
              //             color: Colors.black, // Text color
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStack(String text) {
    return Stack(
      children: [
        Container(
         width: Get.width,
          height: 300,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11),
            color: Colors.grey.shade100,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                text,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  color: Colors.black, // Text color
                ),
              ),
              SizedBox(height: 10,),

            ],
          ),
        ),
        Positioned(
          top: 2,
          right: 3,
          child: Radio(
            value: text,
            groupValue: selectedRadio,
            onChanged: (value) {
              setState(() {

                selectedRadio = value.toString();
              });
            },
          ),
        ),
      ],
    );
  }
}
