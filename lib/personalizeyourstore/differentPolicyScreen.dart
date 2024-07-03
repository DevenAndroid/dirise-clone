import 'dart:io';

import 'package:dirise/addNewProduct/itemdetailsScreen.dart';
import 'package:dirise/controller/profile_controller.dart';
import 'package:dirise/personalizeyourstore/pickUpPolicyScreen.dart';
import 'package:dirise/personalizeyourstore/pickupPolicyListScreen.dart';
import 'package:dirise/personalizeyourstore/returnPolicyListScreen.dart';
import 'package:dirise/personalizeyourstore/returnpolicyScreen.dart';
import 'package:dirise/personalizeyourstore/shippingPolicyListScreen.dart';
import 'package:dirise/utils/api_constant.dart';
import 'package:dirise/vendor/shipping_policy.dart';
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
import '../widgets/common_colour.dart';

class DifferentPolicyScreen extends StatefulWidget {
  static String route = "/TellUsAboutYourSelf";
  File? featureImage;
  DifferentPolicyScreen({Key? key,this.featureImage}) : super(key: key);

  @override
  State<DifferentPolicyScreen> createState() => _DifferentPolicyScreenState();
}

class _DifferentPolicyScreenState extends State<DifferentPolicyScreen> {
  String selectedRadio = '';
  final profileController = Get.put(ProfileController());

  List<String> itemTexts = [
    'Return Policy',
    'Shipping Policy',
    'Pickup Policy',

  ];
  List<String> itemTextsArab = [
    'سياسة العائدات',
    'سياسة الشحن',
    'سياسة الالتقاط',

  ];

  void navigateNext() {

      if (selectedRadio == 'Return Policy' || selectedRadio ==  'سياسة العائدات') {
        Get.to(const ReturnPolicyListScreen());
      } else if (selectedRadio == 'Shipping Policy' || selectedRadio ==  'سياسة الشحن') {
        Get.to(const ShippingPolicyListScreen());
      } else if (selectedRadio == 'Pickup Policy' || selectedRadio == 'سياسة الالتقاط') {
        Get.to(const PickUpPolicyListScreen());
      } else {
        // Handle the case where the selected radio doesn't match any case
        // For example, show a message or perform a different action
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
              'Select Policy'.tr,
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
            ),
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  mainAxisExtent: 200,
                  childAspectRatio: 2, // Aspect ratio can be adjusted
                ),
                itemCount: itemTexts.length, // Number of grid items
                itemBuilder: (BuildContext context, int index) {
                  return     profileController.selectedLAnguage.value == 'English' ? buildStack(itemTexts[index]) : buildStack(itemTextsArab[index]);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  if(selectedRadio.isNotEmpty){
                    navigateNext();
                  }
                  else{
                    showToast('Please select any policy'.tr);
                  }
                },
                child: Container(
                  width: Get.width,
                  height: 55,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black, // Border color
                      width: 1.0, // Border width
                    ),
                    borderRadius: BorderRadius.circular(1), // Border radius
                  ),
                  padding: const EdgeInsets.all(10), // Padding inside the container
                  child:  Center(
                    child: Text(
                      'Next'.tr,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.buttonColor
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
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
