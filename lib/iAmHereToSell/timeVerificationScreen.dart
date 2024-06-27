import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../model/model_varification.dart';
import '../repository/repository.dart';
import '../utils/api_constant.dart';
import '../widgets/common_colour.dart';
import 'listofquestionScreen.dart';

class VerificationTimeScreen extends StatefulWidget {
  const VerificationTimeScreen({super.key});

  @override
  State<VerificationTimeScreen> createState() => _VerificationTimeScreenState();
}

class _VerificationTimeScreenState extends State<VerificationTimeScreen> {
  String selectedRadio = '';
  String code = '';
  TextEditingController phoneController = TextEditingController();
  final Repositories repositories = Repositories();
  Future verificationApi() async {
    Map<String, dynamic> map = {};

    map['verification_type'] = 'calling';
    map['verification_schedule'] = selectedRadio;
    map['verification_mode_type'] = "phone";
    map['verification_mode'] = "+"+code+phoneController.text.toString();
    // map['name'] = _nameController.text.trim();
    // map['phone'] = _mobileNumberController.text.trim();
    // map['password'] = _passwordController.text.trim();
    FocusManager.instance.primaryFocus!.unfocus();
    await repositories.postApi(url: ApiUrls.vendorVerification, context: context, mapData: map).then((value) {
      VarificationModel response = VarificationModel.fromJson(jsonDecode(value));
      // showToast(response.message.toString());

      if (response.status == true) {
showToast(response.message.toString());
        Get.to(ListOfQuestionsScreen());
      }
      else{
        showToast(response.message.toString());
      }
    });
  }

  void validateAndProceed() {
    if (selectedRadio == "") {
      showToast("Please select a time slot");
    }
    else if(phoneController.text.isEmpty){showToast("Please enter phone number");}
   else {
      verificationApi();
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
              'Verification'.tr,
              style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20,right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Here are some of the questions that we want to ask',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.black),
              ),
              const SizedBox(
                height: 20,
              ),
              Stack(
                children: [

                  Container(
                    margin: const EdgeInsets.only(bottom: 10, top: 15),
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 20,bottom: 15),
                    decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(11), boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(
                          0.2,
                          0.2,
                        ),
                        blurRadius: 1,
                      ),
                    ]),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/creditcard.png',
                              height: 50,
                              width: 50,
                            ),
                            const SizedBox(width: 10,),
                            Text(
                              'Morning',
                              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 24, color: Colors.black),
                            )
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Text(
                          'Between  10:00 AM to 12:00 PM GMT+3 Kuwait Time',
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),
                        )
                      ],
                    ),
                  ),
                   Positioned(
                    right: 20,
                    top: 20,
                    child:  Radio(
                      value: "morning",
                      groupValue: selectedRadio,
                      onChanged: (value) {
                        setState(() {
                          selectedRadio = value.toString();
                        });
                      },
                    ),
                  ),

                ],
              ),
              Stack(
                children: [

                  Container(
                    margin: const EdgeInsets.only(bottom: 10, top: 15),
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 20,bottom: 15),
                    decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(11), boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(
                          0.2,
                          0.2,
                        ),
                        blurRadius: 1,
                      ),
                    ]),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/creditcard.png',
                              height: 50,
                              width: 50,
                            ),
                            const SizedBox(width: 10,),
                            Text(
                              'Afternoon',
                              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 24, color: Colors.black),
                            )
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Text(
                          'Between  01:00 PM to 06:00 PM GMT+3 Kuwait Time',
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),
                        )
                      ],
                    ),
                  ),
                   Positioned(
                    right: 20,
                    top: 20,
                    child: Radio(
                      value: "afternoon",
                      groupValue: selectedRadio,
                      onChanged: (value) {
                        setState(() {
                          selectedRadio = value.toString();
                        });
                      },
                    ),
                  ),

                ],
              ),
              SizedBox(height: 20,),
              Text(
                'How can we reach you?',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black),
              ),
              Text(
                'Phone number',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),
              ),
              SizedBox(height: 20,),
              IntlPhoneField(
                flagsButtonPadding: const EdgeInsets.all(8),
                dropdownIconPosition: IconPosition.trailing,
                showDropdownIcon: true,
                cursorColor: Colors.black,
                textInputAction: TextInputAction.next,
                dropdownTextStyle: const TextStyle(color: Colors.black),
                style: const TextStyle(
                    color: AppTheme.textColor
                ),

              controller: phoneController,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    hintStyle: TextStyle(color: AppTheme.textColor),
                    hintText: 'Enter your phone number',
                    labelStyle: TextStyle(color: AppTheme.textColor),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppTheme.shadowColor)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppTheme.shadowColor))),
                initialCountryCode: '+91',
                languageCode: '+91',
                onCountryChanged: (phone) {
                   code = phone.dialCode;
                 print("code"+code);
                  // print(profileController.code.toString());
                },
                onChanged: (phone) {
                  // code = phone.countryISOCode;
                  // print("code"+code);
                  // print(phone.countryCode);
                  // print(profileController.code.toString());
                },
              ),
              SizedBox(height: 20,),

              InkWell(
                onTap:validateAndProceed,
                child: Container(
                  margin: EdgeInsets.only(left: 15,right: 15),
                  width: Get.width,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xff0D5877), // Border color
                      width: 1.0, // Border width
                    ),
                    borderRadius: BorderRadius.circular(2), // Border radius
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
            ],
          ),
        ),
      ),
    );
  }
}
