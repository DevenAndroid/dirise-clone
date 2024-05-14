import 'package:dirise/screens/Extended%20programs/sponsors_screen_extended.dart';
import 'package:dirise/utils/helper.dart';
import 'package:dirise/widgets/common_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/common_colour.dart';
import '../Consultation Sessions/optional_details.dart';


class DurationAndSpots extends StatefulWidget {
  const DurationAndSpots({super.key});

  @override
  State<DurationAndSpots> createState() => _DurationAndSpotsState();
}

class _DurationAndSpotsState extends State<DurationAndSpots> {
  String selectedItemDay = 'Am';
  String selectedItemMin = 'Min';
  bool sundaySelected = false;
  bool mondaySelected = false;
  bool tueSelected = false;
  bool wedSelected = false;
  bool thurSelected = false;
  bool friSelected = false;
  bool satSelected = false;
  TextEditingController timeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text('Duration & Spots'.tr,
            style: GoogleFonts.poppins(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: const Color(0xff423E5E),
            )),
        leading: GestureDetector(
          onTap: () {
            Get.back();
            // _scaffoldKey.currentState!.openDrawer();
          },
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Image.asset(
              'assets/icons/backicon.png',
              height: 20,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      'Starting Time',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Text color
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: SizedBox(
                      height: 56,
                      child: CommonTextField(
                        keyboardType: TextInputType.number,
                        hintText: 'Time',
                        controller: timeController,
                      ),
                    )
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
                    items: <String>['Am', 'Pm']
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
            const Text(
              'Duration',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Text color
              ),
            ),
            10.spaceY,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Text(
                      'Service Slot Duration',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w300,
                        color: Colors.black, // Text color
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: SizedBox(
                      height: 56,
                      child: CommonTextField(
                        keyboardType: TextInputType.number,
                        hintText: 'Time',
                        controller: timeController,
                      ),
                    )
                ),
                6.spaceX,
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedItemMin,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedItemMin = newValue!;
                      });
                    },
                    items: <String>['Min', 'Hours','Day']
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
            10.spaceY,
            Row(
              children: [
                Column(
                  children: [
                    Checkbox(
                      value: mondaySelected,
                      onChanged: (value) {
                        setState(() {
                          mondaySelected = value!;
                        });
                      },
                    ),
                    const Text('Mun',
                      style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF9C9CB4)
                    ),),
                  ],
                ),
                Column(
                  children: [
                    Checkbox(
                      value: tueSelected,
                      onChanged: (value) {
                        setState(() {
                          tueSelected = value!;
                        });
                      },
                    ),
                    const Text('Tue',style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF9C9CB4)
                    ),),
                  ],
                ),
                Column(
                  children: [
                    Checkbox(
                      value: wedSelected,
                      onChanged: (value) {
                        setState(() {
                          wedSelected = value!;
                        });
                      },
                    ),
                    const Text('Wed',style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF9C9CB4)
                    ),),
                  ],
                ),
                Column(
                  children: [
                    Checkbox(
                      value: thurSelected,
                      onChanged: (value) {
                        setState(() {
                          thurSelected = value!;
                        });
                      },
                    ),
                    const Text('Thu',style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF9C9CB4)
                    ),),
                  ],
                ),
                Column(
                  children: [
                    Checkbox(
                      value: friSelected,
                      onChanged: (value) {
                        setState(() {
                          friSelected = value!;
                        });
                      },
                    ),
                    const Text('Fri',style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF9C9CB4)
                    ),),
                  ],
                ),
                Column(
                  children: [
                    Checkbox(
                      value: satSelected,
                      onChanged: (value) {
                        setState(() {
                          satSelected = value!;
                        });
                      },
                    ),
                    const Text('Sat',style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF9C9CB4)
                    ),),
                  ],
                ),
                Column(
                  children: [
                    Checkbox(
                      value: sundaySelected,
                      onChanged: (value) {
                        setState(() {
                          sundaySelected = value!;
                        });
                      },
                    ),
                    const Text('Sun',style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF9C9CB4)
                    ),),
                  ],
                ),
              ],
            ),
            20.spaceY,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: Text(
                    'Spots',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w300,
                      color: Colors.black, // Text color
                    ),
                  ),
                ),
                15.spaceX,
                SizedBox(
                  height: 56,
                  width: 60,
                  child: CommonTextField(
                    keyboardType: TextInputType.number,
                    hintText: 'Time',
                    controller: timeController,
                  ),
                ),
              ],
            ),
            40.spaceY,
            InkWell(
              onTap: (){
                // updateProfile();
                Get.to(()=>const SponsorsScreenExtended());
              },
              child: Container(
                width: Get.width,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xffF5F2F2),
                  borderRadius: BorderRadius.circular(2),
                  border: Border.all(
                    color: AppTheme.buttonColor
                  )
                ),
                padding: const EdgeInsets.all(10),
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
                Get.to(()=>const SponsorsScreenExtended());
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
