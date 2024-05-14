import 'package:dirise/screens/Consultation%20Sessions/review_screen.dart';
import 'package:dirise/screens/Extended%20programs/review_screen_extended.dart';
import 'package:dirise/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/common_button.dart';
import '../../widgets/common_colour.dart';


class EligibleCustomersExtended extends StatefulWidget {
  const EligibleCustomersExtended({super.key});

  @override
  State<EligibleCustomersExtended> createState() => _EligibleCustomersExtendedState();
}

class _EligibleCustomersExtendedState extends State<EligibleCustomersExtended> {
  RangeValues currentRangeValues = const RangeValues(10, 80);
  double startValue = 0.0;
  String startString = '';
  int decimalIndex = 0;
  String digitsBeforeDecimal = '';

  double endValue = 0.0;
  String endString = '';
  int endDecimalIndex = 0;
  String endDigitsBeforeDecimal = '';

  String selectedGender = 'Male Only';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xff0D5877),
            size: 16,
          ),
        ),
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Eligible Customers'.tr,
              style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Eligible Customers',
              style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w500
            ),),
            20.spaceY,
            RangeSlider(
              values: currentRangeValues,
              max: 100,
              divisions: 100,
              labels: RangeLabels(
                currentRangeValues.start.round().toString(),
                currentRangeValues.end.round().toString(),
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  currentRangeValues = values;
                   startValue = currentRangeValues.start;
                   startString = startValue.toString();
                   decimalIndex = startString.indexOf('.');
                   digitsBeforeDecimal = decimalIndex != -1 ? startString.substring(0, decimalIndex) : startString;

                   endValue = currentRangeValues.end;
                   endString = endValue.toString();
                   endDecimalIndex = endString.indexOf('.');
                   endDigitsBeforeDecimal = endDecimalIndex != -1 ? endString.substring(0, decimalIndex) : endString;



                });
              },
            ),
            20.spaceY,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Age range',
                  style: GoogleFonts.poppins(
                      color: const Color(0xFF514949),
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                  ),),
                9.spaceX,
                Container(
                  width: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Center(
                    child: Text( digitsBeforeDecimal.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14
                      )),
                  ),
                ),
                9.spaceX,
                Container(
                  width: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Center(
                    child: Text( endDigitsBeforeDecimal.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14
                      )),
                  ),
                ),
              ],
            ),
            30.spaceY,
            Text('This program is for',
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500
              ),),
            10.spaceY,
              RadioListTile<String>(
                contentPadding: EdgeInsets.zero,
              visualDensity: VisualDensity.comfortable,
              title: const Text('Male Only'),
              value: 'Male Only',
              groupValue: selectedGender,
              onChanged: (value) {
                setState(() {
                  selectedGender = value!;
                });
              },
            ),
            RadioListTile<String>(
              contentPadding: EdgeInsets.zero,
              visualDensity: VisualDensity.comfortable,
              title: const Text('Female Only'),
              value: 'Female Only',
              groupValue: selectedGender,
              onChanged: (value) {
                setState(() {
                  selectedGender = value!;
                });
              },
            ),
            RadioListTile<String>(
              contentPadding: EdgeInsets.zero,
              visualDensity: VisualDensity.comfortable,
              title: const Text('Both'),
              value: 'Both',
              groupValue: selectedGender,
              onChanged: (value) {
                setState(() {
                  selectedGender = value!;
                });
              },
            ),
            25.spaceY,
            CustomOutlineButton(
              title: 'Done',
              borderRadius: 11,
              onPressed: () {
                // if(formKey1.currentState!.validate()){
                // optionalApi();
                // }
                Get.to(()=> const ReviewScreenExtended());
              },
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Get.to(()=> const ReviewScreenExtended());
              },
              child: Container(
                width: Get.width,
                height: 55,
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
                    'Skip',
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
    );
  }
}