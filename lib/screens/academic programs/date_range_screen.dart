import 'dart:math';

import 'package:dirise/screens/Consultation%20Sessions/set_store_time.dart';
import 'package:dirise/screens/academic%20programs/set_store_time_academic.dart';
import 'package:dirise/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../widgets/common_colour.dart';


class AcademicdateScreen extends StatefulWidget {
  const AcademicdateScreen({super.key});

  @override
  State<AcademicdateScreen> createState() => _AcademicdateScreenState();
}

class _AcademicdateScreenState extends State<AcademicdateScreen> {
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  String? formattedStartDate;
  String? formattedStartDate1;
  RxBool isServiceProvide = false.obs;

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

  //Add Vacation
  DateTime startDateVacation = DateTime.now();
  DateTime endDateVacation = DateTime.now();
  String? formattedStartDateVacation;
  String? formattedStartDate1Vacation;
  List<String?> startDateList = [];
  List<String?> lastDateList = [];
  Future<void> selectStartDateVacation(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDateVacation,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != startDateVacation) {
      setState(() {
        startDateVacation = picked;
        formattedStartDateVacation = DateFormat('yyyy/MM/dd').format(startDateVacation);
        startDateList.add(formattedStartDateVacation.toString());
        print('Now Select........${formattedStartDateVacation.toString()}');
        print('Now Select....List....${startDateList.toString()}');
      });
    }
  }
  Future<void> selectEndDateVacation(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endDateVacation,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != endDateVacation) {
      setState(() {
        endDateVacation = picked;
        formattedStartDate1Vacation = DateFormat('yyyy/MM/dd').format(endDateVacation);
        lastDateList.add(formattedStartDate1Vacation.toString());
        print('Now Select........${formattedStartDate1Vacation.toString()}');
      });
    }
  }


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
            Text('Dates range',style:GoogleFonts.poppins(fontSize:19,fontWeight:FontWeight.w500)),
            15.spaceY,
            Text('The start date and end date which this service offered',style:GoogleFonts.poppins(fontSize:15,fontWeight:FontWeight.w400)),
            20.spaceY,
            Text('Start Date: ${formattedStartDate ?? ''}'),
            10.spaceY,
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith((states) => const Color(0xff014E70))
              ),
              onPressed: () => _selectStartDate(context),
              child: const Text('Select Start Date',style: TextStyle(color: Colors.white),),
            ),
            const SizedBox(height: 20),
            Text('End Date: ${formattedStartDate1 ?? ''}'),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith((states) => const Color(0xff014E70))
              ),
              onPressed: () => _selectEndDate(context),
              child: const Text('Select End Date',style: TextStyle(color: Colors.white),),
            ),
            const SizedBox(height: 40),
            Text('Add vacations ',style:GoogleFonts.poppins(fontSize:19,fontWeight:FontWeight.w500)),

            20.spaceY,
            Text('Start Date: ${formattedStartDateVacation ?? ''}'),
            10.spaceY,
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith((states) => const Color(0xFF014E70))
              ),
              onPressed: () => selectStartDateVacation(context),
              child: const Text('Select Start Date',style: TextStyle(color: Colors.white),),
            ),
            const SizedBox(height: 20),
            Text('End Date: ${formattedStartDate1Vacation ?? ''}'),

            const SizedBox(height: 10),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith((states) => const Color(0xFF014E70))
              ),
              onPressed: () => selectEndDateVacation(context),
              child: const Text('Select End Date',style: TextStyle(color: Colors.white),),
            ),
            20.spaceY,
            GestureDetector(
              onTap: (){
                setState(() {
                  isServiceProvide.toggle();
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 12),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppTheme.secondaryColor)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Range of vacations',style: GoogleFonts.poppins(
                      color: AppTheme.primaryColor,
                      fontSize: 15,
                    ),),
                    GestureDetector(
                      child: isServiceProvide.value == true ? const Icon(Icons.keyboard_arrow_up_rounded) : const Icon(Icons.keyboard_arrow_down_outlined),
                      onTap: (){
                        setState(() {
                          isServiceProvide.toggle();
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            if(isServiceProvide.value == true)
              20.spaceY,
            if(isServiceProvide.value == true)
              ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemCount: min(startDateList.length, lastDateList.length),
                itemBuilder: (context, index) {
                  return Container(
                    color: const Color(0xFFF9F9F9),
                    padding: const EdgeInsets.all(10).copyWith(bottom: 0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex:3,
                              child: Text('Start ${startDateList[index]!} End ${lastDateList[index]!}', style: const TextStyle(
                                color: AppTheme.buttonColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              )),
                            ),
                            Expanded(
                              child: GestureDetector(
                                  onTap: (){
                                    startDateList.removeAt(index);
                                    setState(() {});
                                    print('object');
                                  },
                                  child: const Icon(Icons.cancel)),
                            )
                          ],
                        ),
                        const SizedBox(height: 5), // Use SizedBox instead of 5.spaceY
                      ],
                    ),
                  );
                },
              ),
            const SizedBox(height: 40),
            20.spaceY,
            InkWell(
              onTap: (){
                // updateProfile();
                Get.to(()=> const SetTimeAcademicScreen());
              },
              child: Container(
                width: Get.width,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xffF5F2F2),
                  borderRadius: BorderRadius.circular(2), // Border radius
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
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: (){
                // updateProfile();
                Get.to(()=> const SetTimeAcademicScreen());
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
