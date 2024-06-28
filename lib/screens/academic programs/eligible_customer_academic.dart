import 'dart:convert';

import 'package:dirise/screens/Consultation%20Sessions/review_screen.dart';
import 'package:dirise/screens/academic%20programs/review_screen_academic.dart';
import 'package:dirise/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/profile_controller.dart';
import '../../controller/vendor_controllers/add_product_controller.dart';
import '../../model/common_modal.dart';
import '../../repository/repository.dart';
import '../../utils/api_constant.dart';
import '../../widgets/common_button.dart';

class EligibleCustomersAcademic extends StatefulWidget {
  int? id;
  int? eligibleMinAge;
  int? eligibleMaxAge;
  String? eligibleGender;

  EligibleCustomersAcademic({super.key,this.id,this.eligibleGender,this.eligibleMaxAge,this.eligibleMinAge});


  @override
  State<EligibleCustomersAcademic> createState() => _EligibleCustomersAcademicState();
}

class _EligibleCustomersAcademicState extends State<EligibleCustomersAcademic> {
  final Repositories repositories = Repositories();
  RangeValues currentRangeValues = const RangeValues(10, 80);
  double startValue = 0.0;
  String startString = '';
  int decimalIndex = 0;
  String digitsBeforeDecimal = '';

  double endValue = 0.0;
  String endString = '';
  int endDecimalIndex = 0;
  String endDigitsBeforeDecimal = '';
  final addProductController = Get.put(AddProductController());
  String selectedGender = 'Male Only';
  createEligbleCustomer() {
    Map<String, dynamic> map = {};
    map['eligible_min_age'] = digitsBeforeDecimal.toString();
    map['eligible_max_age'] = endDigitsBeforeDecimal.toString();
    map['eligible_gender'] = selectedGender.toString();
    map["id"] = addProductController.idProduct.value.toString();
    FocusManager.instance.primaryFocus!.unfocus();
    repositories.postApi(url: ApiUrls.giveawayProductAddress, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      print('API Response Status Code: ${response.status}');
      // showToast(response.message.toString());
      if (response.status == true) {
        showToast(response.message.toString());
        Get.to(() => const ReviewScreenAcademic());
      }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.id != null){
      digitsBeforeDecimal = widget.eligibleMinAge.toString();
      endDigitsBeforeDecimal = widget.eligibleMaxAge.toString();
      selectedGender = widget.eligibleGender.toString();
    }
  }
   final profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading:GestureDetector(
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
              'Eligible Customers'.tr,
              style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Eligible Customers',
              style: GoogleFonts.poppins(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
            ),
            20.spaceY,
            RangeSlider(
              values: currentRangeValues,
              max: 99,
              divisions: 99,
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
                Text(
                  'Age range',
                  style: GoogleFonts.poppins(color: const Color(0xFF514949), fontSize: 16, fontWeight: FontWeight.w500),
                ),
                9.spaceX,
                Container(
                  width: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  decoration: BoxDecoration(color: const Color(0xFFF2F2F2), borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: Text(digitsBeforeDecimal.toString(),
                        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14)),
                  ),
                ),
                9.spaceX,
                Container(
                  width: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  decoration: BoxDecoration(color: const Color(0xFFF2F2F2), borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: Text(endDigitsBeforeDecimal.toString(),
                        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14)),
                  ),
                ),
              ],
            ),
            30.spaceY,
            Text(
              'This program is for',
              style: GoogleFonts.poppins(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
            ),
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
                if (selectedGender != '' && digitsBeforeDecimal != '' && endDigitsBeforeDecimal != '') {
                  createEligbleCustomer();
                } else {
                  showToastCenter('Select Age Range'.tr);
                }
              },
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Get.to(() => const ReviewScreenAcademic());
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
