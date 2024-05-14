import 'dart:math';
import 'package:dirise/screens/Consultation%20Sessions/set_store_time.dart';
import 'package:dirise/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../widgets/common_colour.dart';
import '../../widgets/common_textfield.dart';


class DateRangeScreenTour extends StatefulWidget {
  const DateRangeScreenTour({super.key});

  @override
  State<DateRangeScreenTour> createState() => _DateRangeScreenTourState();
}

class _DateRangeScreenTourState extends State<DateRangeScreenTour> {
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  String? formattedStartDate;
  String? formattedStartDate1;
  TextEditingController notesController = TextEditingController();
  RxBool isServiceProvide = false.obs;
  String selectedItemDay = 'Location';
  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _startDate) {
      setState(() {
        _startDate = picked;
        formattedStartDate = DateFormat('yyyy/MM/dd').format(_startDate);
        print('Now Select........${formattedStartDate.toString()}');
      });
    }
  }
  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _endDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _endDate) {
      setState(() {
        _endDate = picked;
        formattedStartDate1 = DateFormat('yyyy/MM/dd').format(_startDate);
        print('Now Select........${formattedStartDate1.toString()}');
      });
    }
  }
  bool isChecked = false;



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
              'Date'.tr,
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
            Text('Dates range',
                style:GoogleFonts.poppins(fontSize:19,fontWeight:FontWeight.w600)),
            15.spaceY,
            Text('The start date and end date which this service offered',
                style:GoogleFonts.poppins(fontSize:15,fontWeight:FontWeight.w400)),
            40.spaceY,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Start Date: ${formattedStartDate ?? ''}',
                        style:const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500
                        ),),
                      10.spaceY,
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith((states) => const Color(0xff014E70))
                        ),
                        onPressed: () => _selectStartDate(context),
                        child: const Text('Select Start Date',style: TextStyle(color: Colors.white),),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('End Date: ${formattedStartDate1 ?? ''}',
                        style:const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500
                        ),),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith((states) => const Color(0xff014E70))
                        ),
                        onPressed: () => _selectEndDate(context),
                        child: const Text('Select End Date',style: TextStyle(color: Colors.white),),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 40),
            const Text('Places',
              style:TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600
              ),),
            30.spaceY,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      'From',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Text color
                      ),
                    ),
                  ),
                ),
                6.spaceX,
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedItemDay,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedItemDay = newValue!;
                      });
                    },
                    items: <String>['Location', 'Russia']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      fillColor: const Color(0xffE2E2E2).withOpacity(.35),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10).copyWith(right: 8),
                      focusedErrorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: AppTheme.secondaryColor)),
                      errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Color(0xffE2E2E2))),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: AppTheme.secondaryColor)),
                      disabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: AppTheme.secondaryColor),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: AppTheme.secondaryColor),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select an item';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            20.spaceY,
            const Text('Extra Notes',
              style:TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600
              ),),
            20.spaceY,
            CommonTextField(
              controller: notesController,
              obSecure: false,
              hintText: 'Notes'.tr,
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return "Notes is required".tr;
                }
                return null;
              },

            ),
            30.spaceY,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    'To',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Text color
                    ),
                  ),
                ),
                20.spaceX,
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedItemDay,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedItemDay = newValue!;
                      });
                    },
                    items: <String>['Location', 'Russia']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      fillColor: const Color(0xffE2E2E2).withOpacity(.35),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10).copyWith(right: 8),
                      focusedErrorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: AppTheme.secondaryColor)),
                      errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Color(0xffE2E2E2))),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: AppTheme.secondaryColor)),
                      disabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: AppTheme.secondaryColor),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: AppTheme.secondaryColor),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select an item';
                      }
                      return null;
                    },
                  ),
                ),
                20.spaceX,
                Expanded(
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            isChecked = !isChecked;
                          });
                        },
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFF000000).withOpacity(.25),
                              width: 1.0,
                            ),
                          ),
                          child: isChecked
                              ? const Icon(
                            Icons.check,
                            size: 15,
                            color: AppTheme.buttonColor,
                          )
                              : null,
                        ),
                      ),
                      20.spaceX,
                      const Expanded(
                        child: Text('Same as above',
                          style:TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400
                          ),),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            30.spaceY,
            const Align(
              alignment: Alignment.center,
            child: Text(
                '+ Add Place',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Text color
                ),
              ),
            ),
            20.spaceY,
            InkWell(
              onTap: (){
                // updateProfile();
                Get.to(()=> const SetTimeScreenConsultation());
              },
              child: Container(
                width: Get.width,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xffF5F2F2),
                  borderRadius: BorderRadius.circular(2),
                  border: Border.all(color: AppTheme.buttonColor)
                ),
                padding: const EdgeInsets.all(10), // Padding inside the container
                child: const Center(
                  child: Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff514949), // Text color
                    ),
                  ),
                ),
              ),
            ),
            20.spaceY,
            InkWell(
              onTap: (){
                // updateProfile();
                Get.to(()=> const SetTimeScreenConsultation());
              },
              child: Container(
                width: Get.width,
                height: 70,
                decoration: BoxDecoration(
                  color: AppTheme.buttonColor,
                  borderRadius: BorderRadius.circular(2), // Border radius
                ),
                padding: const EdgeInsets.all(10), // Padding inside the container
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Skip',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Text color
                      ),
                    ),
                    Text(
                      'Product will show call for availability',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: Colors.white, // Text color
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
