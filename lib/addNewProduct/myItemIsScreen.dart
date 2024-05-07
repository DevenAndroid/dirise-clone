import 'package:dirise/addNewProduct/itemdetailsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../iAmHereToSell/whichplantypedescribeyouScreen.dart';
import '../jobOffers/tellusaboutyourselfScreen.dart';
import '../language/app_strings.dart';
import '../newAddress/pickUpAddressScreen.dart';
import '../singleproductScreen/product_information_screen.dart';
import '../widgets/common_button.dart';

class MyItemISScreen extends StatefulWidget {
  static String route = "/TellUsAboutYourSelf";
  const MyItemISScreen({Key? key}) : super(key: key);

  @override
  State<MyItemISScreen> createState() => _MyItemISScreenState();
}

class _MyItemISScreenState extends State<MyItemISScreen> {
  String selectedRadio = '';

  List<String> itemTexts = [
    'Giveaway',
    'Product',
    'Job',
    'Service',
    'Virtual',
  ];

  void navigateNext() {
    if (selectedRadio == 'Giveaway') {
      Get.to(const ItemDetailsScreens());
    } else if (selectedRadio == 'Product') {
      Get.to(ProductInformationScreens());
    }
    else if (selectedRadio == 'Job') {
      Get.to(JobTellusaboutyourselfScreen());
    }
    else if (selectedRadio == 'Service') {
      Get.to(PickUpAddressScreen());
    }
    else if (selectedRadio == 'Virtual') {
      Get.to(PickUpAddressScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
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
              'My Item is  a'.tr,
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
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  mainAxisExtent: 200,
                  childAspectRatio: 2, // Aspect ratio can be adjusted
                ),
                itemCount: itemTexts.length, // Number of grid items
                itemBuilder: (BuildContext context, int index) {
                  return buildStack(itemTexts[index]);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  navigateNext();
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
                  child: const Center(
                    child: Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Text color
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
          height: 300,
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
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  color: Colors.black, // Text color
                ),
              ),
              SizedBox(height: 10,),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Some other text',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
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
