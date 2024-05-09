import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/common_button.dart';

class EligibleCustomers extends StatefulWidget {
  const EligibleCustomers({super.key});

  @override
  State<EligibleCustomers> createState() => _EligibleCustomersState();
}

class _EligibleCustomersState extends State<EligibleCustomers> {
  RangeValues _currentRangeValues = const RangeValues(40, 80);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eligible Customers'),
        leading: GestureDetector(
            onTap: (){
              Get.back();
            },
            child: const Icon(Icons.arrow_back_ios_new)),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 15,right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Age range',
                style: GoogleFonts.poppins(color: Color(0xff0D5877), fontWeight: FontWeight.w400, fontSize: 18),
              ),
              const SizedBox(
                height: 20,
              ),
              RangeSlider(
                values: _currentRangeValues,
                max: 100,
                divisions: 5,
                labels: RangeLabels(
                  _currentRangeValues.start.round().toString(),
                  _currentRangeValues.end.round().toString(),
                ),
                onChanged: (RangeValues values) {
                  setState(() {
                    _currentRangeValues = values;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    'Age range',
                    style: GoogleFonts.poppins(color: Color(0xff514949), fontWeight: FontWeight.w400, fontSize: 14),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.grey.shade300),
                    child: Text(
                      '32',
                      style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 13),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.grey.shade300),
                    child: Text(
                      '55',
                      style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 13),
                    ),
                  ),


                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'This program is for ',
                style: GoogleFonts.poppins(color: Color(0xff0D0C0C), fontWeight: FontWeight.w600, fontSize: 14),
              ),
              Row(
                children: [
                  Radio(value: 1, groupValue: 1, onChanged: (value) {}),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Male Only',
                    style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 13),
                  ),
                ],
              ),
              Row(
                children: [
                  Radio(value: 1, groupValue: 1, onChanged: (value) {}),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Female Only',
                    style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 13),
                  ),
                ],
              ),
              Row(
                children: [
                  Radio(value: 1, groupValue: 1, onChanged: (value) {}),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Both',
                    style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 13),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              CustomOutlineButton(
                title: 'Done',
                borderRadius: 11,
                onPressed: () {},
              ),
              const SizedBox(height: 10),
              Container(
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
            ],
          ),
        ),
      ),
    );
  }
}
