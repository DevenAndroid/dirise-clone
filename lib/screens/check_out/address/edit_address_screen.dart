import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../language/app_strings.dart';
import '../../my_account_screens/editprofile_screen.dart';

class EditAddresss extends StatefulWidget {
  const EditAddresss({super.key});
  static var route = "/editAddressScreen";
  @override
  State<EditAddresss> createState() => _EditAddresssState();
}

class _EditAddresssState extends State<EditAddresss> {
  // Country? selectedCountry;
  @override
  Widget build(BuildContext context) {
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
              AppStrings.editAddress.tr,
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text("Save time by choosing your current location.",),
        Column(crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text("Save",),
          ],
        ),
          ...fieldWithName(
            title: 'Country/Region',
            hintText: 'Select Country',
            readOnly: true,


            validator: (v) {
              if (v!.trim().isEmpty) {
                return "Please select country";
              }
              return null;
            }, controller: TextEditingController(),
          ),
          ...fieldWithName(
            title: 'Name',
            hintText: 'fahad',
            readOnly: true,


            validator: (v) {
              if (v!.trim().isEmpty) {
                return "Please select country";
              }
              return null;
            }, controller: TextEditingController(),
          ),
          ...fieldWithName(
            title: 'Phone number',
            hintText: '111111111',
            readOnly: true,


            validator: (v) {
              if (v!.trim().isEmpty) {
                return "Please select country";
              }
              return null;
            }, controller: TextEditingController(),
          ),
          ...fieldWithName(
            title: 'Country/Region',
            hintText: 'Select Country',
            readOnly: true,


            validator: (v) {
              if (v!.trim().isEmpty) {
                return "Please select country";
              }
              return null;
            }, controller: TextEditingController(),
          ),
          ...fieldWithName(
            title: 'Country/Region',
            hintText: 'Select Country',
            readOnly: true,


            validator: (v) {
              if (v!.trim().isEmpty) {
                return "Please select country";
              }
              return null;
            }, controller: TextEditingController(),
          ),
          ...fieldWithName(
            title: 'Country/Region',
            hintText: 'Select Country',
            readOnly: true,


            validator: (v) {
              if (v!.trim().isEmpty) {
                return "Please select country";
              }
              return null;
            }, controller: TextEditingController(),
          ),...fieldWithName(
            title: 'Country/Region',
            hintText: 'Select Country',
            readOnly: true,


            validator: (v) {
              if (v!.trim().isEmpty) {
                return "Please select country";
              }
              return null;
            }, controller: TextEditingController(),
          ),


      ],),
    );
  }
}
