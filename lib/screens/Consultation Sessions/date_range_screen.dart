import 'package:dirise/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/common_button.dart';
import '../../widgets/common_colour.dart';


class DateRangeScreen extends StatefulWidget {
  const DateRangeScreen({super.key});

  @override
  State<DateRangeScreen> createState() => _DateRangeScreenState();
}

class _DateRangeScreenState extends State<DateRangeScreen> {
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

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
      });
    }
  }
  bool val1 = false;
  bool val2 = false;
  bool val3 = false;
  bool val4 = false;
  bool val5 = false;
  bool val6 = false;
  bool val7 = false;
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
            10.spaceY,
            Text('The start date and end date which this service offered',style:GoogleFonts.poppins(fontSize:15,fontWeight:FontWeight.w400)),
            20.spaceY,
            Text('Start Date: ${_startDate.toString().split(' ')[0]}'),
            10.spaceY,
            ElevatedButton(
              onPressed: () => _selectStartDate(context),
              child: const Text('Select Start Date'),
            ),
            const SizedBox(height: 20),
            Text('End Date: ${_endDate.toString().split(' ')[0]}'),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _selectEndDate(context),
              child: const Text('Select End Date'),
            ),
            const SizedBox(height: 40),
            Text('Add vacations ',style:GoogleFonts.poppins(fontSize:19,fontWeight:FontWeight.w500)),
            20.spaceY,
            Text('Start Date: ${_startDate.toString().split(' ')[0]}'),
            10.spaceY,
            ElevatedButton(
              onPressed: () => _selectStartDate(context),
              child: const Text('Select Start Date'),
            ),
            const SizedBox(height: 20),
            Text('End Date: ${_endDate.toString().split(' ')[0]}'),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _selectEndDate(context),
              child: const Text('Select End Date'),
            ),
            const SizedBox(height: 40),
            Text('Off Days',style:GoogleFonts.poppins(fontSize:19,fontWeight:FontWeight.w500)),
            5.spaceY,
            Text('Days which service is not offered, like weekends',style:GoogleFonts.poppins(fontSize:15,fontWeight:FontWeight.w400)),
            10.spaceY,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Checkbox(
                      value: val1,
                      onChanged: (value) {
                        setState(() {
                          val1 = value!;
                        });
                      },
                    ),
                    Text('Mon',style:GoogleFonts.poppins(fontSize:15,fontWeight:FontWeight.w400,color: const Color(0xFF9C9CB4))),
                  ],
                ),
                Column(
                  children: [
                    Checkbox(
                      value: val2,
                      onChanged: (value) {
                        setState(() {
                          val2 = value!;
                        });
                      },
                    ),
                    Text('Tue',style:GoogleFonts.poppins(fontSize:15,fontWeight:FontWeight.w400,color: const Color(0xFF9C9CB4))),
                  ],
                ),
                Column(
                  children: [
                    Checkbox(
                      value: val3,
                      onChanged: (value) {
                        setState(() {
                          val3   = value!;
                        });
                      },
                    ),
                    Text('Wed',style:GoogleFonts.poppins(fontSize:15,fontWeight:FontWeight.w400,color: const Color(0xFF9C9CB4))),
                  ],
                ),
                Column(
                  children: [
                    Checkbox(
                      value: val4,
                      onChanged: (value) {
                        setState(() {
                          val4 = value!;
                        });
                      },
                    ),
                    Text('Thu',style:GoogleFonts.poppins(fontSize:15,fontWeight:FontWeight.w400,color: const Color(0xFF9C9CB4))),
                  ],
                ),
                Column(
                  children: [
                    Checkbox(
                      value: val5,
                      onChanged: (value) {
                        setState(() {
                          val5 = value!;
                        });
                      },
                    ),
                    Text('Fri',style:GoogleFonts.poppins(fontSize:15,fontWeight:FontWeight.w400,color: const Color(0xFF9C9CB4))),
                  ],
                ),
                Column(
                  children: [
                    Checkbox(
                      value: val6,
                      onChanged: (value) {
                        setState(() {
                          val6 = value!;
                        });
                      },
                    ),
                    Text('Sat',style:GoogleFonts.poppins(fontSize:15,fontWeight:FontWeight.w400,color: const Color(0xFF9C9CB4))),
                  ],
                ),
                Column(
                  children: [
                    Checkbox(
                      value: val7,
                      onChanged: (value) {
                        setState(() {
                          val7 = value!;
                        });
                      },
                    ),
                    Text('Sun',style:GoogleFonts.poppins(fontSize:15,fontWeight:FontWeight.w400,color: const Color(0xFF9C9CB4))),
                  ],
                ),
              ],
            ),
            10.spaceY,
            Text('Mark the day to remove availability',style:GoogleFonts.poppins(fontSize:15,fontWeight:FontWeight.w400,color: Color(0xFF0D5877))),
            20.spaceY,
            InkWell(
              onTap: (){
                // updateProfile();

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
