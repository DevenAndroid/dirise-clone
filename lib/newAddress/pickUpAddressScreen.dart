import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../language/app_strings.dart';
import '../widgets/common_textfield.dart';
import 'locationScreen.dart';

class PickUpAddressScreen extends StatefulWidget {
  const PickUpAddressScreen({super.key});

  @override
  State<PickUpAddressScreen> createState() => _PickUpAddressScreenState();
}

class _PickUpAddressScreenState extends State<PickUpAddressScreen> {
  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
              AppStrings.pickUpAddress.tr,
              style: GoogleFonts.poppins(color: Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * .02,
              ),
              Text(
                "Where do you want to receive your orders".tr,
                style: GoogleFonts.poppins(color: Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 16),
              ),
              SizedBox(
                height: size.height * .02,
              ),
              Text(
                "Select your location on the map".tr,
                style: GoogleFonts.poppins(color: Color(0xff292F45), fontWeight: FontWeight.w400, fontSize: 14),
              ),
              ...commonField(
                  hintText: "Street",
                  textController: cityController,
                  title: 'Street*',
                  validator: (String? value) {},
                  keyboardType: TextInputType.name),
              ...commonField(
                  hintText: "city",
                  textController: cityController,
                  title: 'City*',
                  validator: (String? value) {},
                  keyboardType: TextInputType.name),
              ...commonField(
                  hintText: "state",
                  textController: cityController,
                  title: 'State*',
                  validator: (String? value) {},
                  keyboardType: TextInputType.name),
              ...commonField(
                  hintText: "Zip Code",
                  textController: cityController,
                  title: 'Zip Code*',
                  validator: (String? value) {},
                  keyboardType: TextInputType.name),
              ...commonField(
                  hintText: "Town",
                  textController: cityController,
                  title: 'Town*',
                  validator: (String? value) {},
                  keyboardType: TextInputType.name),
              ...commonField(
                  hintText: "Special instruction",
                  textController: cityController,
                  title: 'Special instruction*',
                  validator: (String? value) {},
                  keyboardType: TextInputType.name),
              SizedBox(
                height: size.height * .02,
              ),
              GestureDetector(
                onTap: (){
                  Get.to(ChooseAddress());
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  width: Get.width,
                  height: 50,
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
                      'Confirm Your Location',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Text color
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * .02,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<Widget> commonField({
  required TextEditingController textController,
  required String title,
  required String hintText,
  required FormFieldValidator<String>? validator,
  required TextInputType keyboardType,
}) {
  return [
    const SizedBox(
      height: 5,
    ),
    Text(
      title.tr,
      style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16, color: const Color(0xff0D5877)),
    ),
    const SizedBox(
      height: 8,
    ),
    CommonTextField(
      controller: textController,
      obSecure: false,
      hintText: hintText.tr,
      validator: validator,
      keyboardType: keyboardType,
    ),
  ];
}
