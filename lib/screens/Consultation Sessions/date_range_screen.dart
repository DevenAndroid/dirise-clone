import 'dart:convert';
import 'dart:math';
import 'package:dirise/screens/Consultation%20Sessions/review_screen.dart';
import 'package:dirise/screens/Consultation%20Sessions/set_store_time.dart';
import 'package:dirise/screens/Consultation%20Sessions/timeScreen.dart';
import 'package:dirise/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../controller/vendor_controllers/add_product_controller.dart';
import '../../model/jobResponceModel.dart';
import '../../repository/repository.dart';
import '../../utils/api_constant.dart';
import '../../widgets/common_colour.dart';

class DateRangeScreen extends StatefulWidget {
  int? id;
  String? from_date;
  String? to_date;
  String? vacation_from_date;
  String? vacation_to_date;

  DateRangeScreen({super.key, this.from_date, this.to_date, this.vacation_from_date, this.vacation_to_date, this.id});

  @override
  State<DateRangeScreen> createState() => _DateRangeScreenState();
}

class _DateRangeScreenState extends State<DateRangeScreen> {
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  final addProductController = Get.put(AddProductController());
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
        addProductController.formattedStartDate = DateFormat('yyyy/MM/dd').format(_startDate);
        print('Now Select........${addProductController.formattedStartDate.toString()}');
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
        formattedStartDate1 = DateFormat('yyyy/MM/dd').format(_endDate);
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
      });
    }
  }

  final Repositories repositories = Repositories();
  int index = 0;
  void updateProfile() {
    Map<String, dynamic> map = {};
    Map<String, dynamic> vacationTypeMap = {};
    Map<String, dynamic> vacationFromDateMap = {};
    Map<String, dynamic> vacationToDateMap = {};

    map["product_type"] = "booking";
    map["id"] = addProductController.idProduct.value.toString();
    map["group"] = addProductController.formattedStartDate == formattedStartDate1 ? "date" : "range";

    if (addProductController.formattedStartDate == formattedStartDate1) {
      map["single_date"] = addProductController.formattedStartDate.toString();
    } else {
      map["from_date"] = addProductController.formattedStartDate.toString();
      map["to_date"] = formattedStartDate1.toString();
    }

    for (int i = 0; i < startDateList.length; i++) {
      if (i < lastDateList.length) { // Add this check to prevent out-of-bounds access
        vacationTypeMap['$i'] = startDateList[i] == lastDateList[i] ? "date" : "range";
        if (startDateList[i] == lastDateList[i]) {
          map["vacation_single_date[]"] = startDateList[i].toString();
        } else {
          vacationFromDateMap["$i"] = startDateList[i].toString();
          vacationToDateMap["$i"] = lastDateList[i].toString();
        }
      } else {
        // Handle the case where startDateList and lastDateList lengths are mismatched
        print('Mismatch in list lengths: startDateList length is ${startDateList.length}, but lastDateList length is ${lastDateList.length}');
      }
    }

    map['vacation_type'] = vacationTypeMap;
    map['vacation_from_date'] = vacationFromDateMap;
    map['vacation_to_date'] = vacationToDateMap;

    repositories.postApi(url: ApiUrls.giveawayProductAddress, context: context, mapData: map).then((value) {
      print('object${value.toString()}');
      JobResponceModel response = JobResponceModel.fromJson(jsonDecode(value));
      if (response.status == true) {
        showToast(response.message.toString());
        if (widget.id != null) {
          Get.to(ReviewScreen());
        } else {
          Get.to(() => const TimeScreen());
        }

        print('value isssss${response.toJson()}');
      } else {
        showToast(response.message.toString());
      }
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.id != null) {
      addProductController.formattedStartDate = widget.from_date;
      formattedStartDate1 = widget.to_date;
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
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Dates range', style: GoogleFonts.poppins(fontSize: 19, fontWeight: FontWeight.w600)),
            15.spaceY,
            Text('The start date and end date which this service offered',
                style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w400)),
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
                      Text(
                        'Start Date: ${addProductController.formattedStartDate ?? ''}',
                        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                      10.spaceY,
                      ElevatedButton(
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppTheme.primaryColor)),
                        onPressed: () {
                          _selectStartDate(context);
                        },
                        child: const Text('Select Start Date'),
                      )
                    ],
                  ),
                ),
                10.spaceX,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'End Date: $formattedStartDate1',
                        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                      10.spaceY,
                      ElevatedButton(
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppTheme.primaryColor)),
                        onPressed: () {
                          _selectEndDate(context);
                        },
                        child: const Text('Select End Date'),
                      )
                    ],
                  ),
                ),
              ],
            ),
            30.spaceY,
            Row(
              children: [
                Obx(() => Checkbox(
                      checkColor: Colors.white,
                      activeColor: Colors.blue,
                      value: addProductController.check.value,
                      onChanged: (value) {
                        addProductController.check.value = value!;
                      },
                    )),
                Text('What service do you provide?',
                    style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600))
              ],
            ),
            10.spaceY,
            Text('Add date to display', style: GoogleFonts.poppins(fontSize: 19, fontWeight: FontWeight.w600)),
            10.spaceY,
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: min(startDateList.length, lastDateList.length),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Start Date: ${startDateList[index] ?? ''}',
                          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                      ),
                      10.spaceX,
                      Expanded(
                        child: Text(
                          'End Date: ${lastDateList[index] ?? ''}',
                          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            20.spaceY,
            ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppTheme.primaryColor)),
              onPressed: () {
                selectStartDateVacation(context);
              },
              child: const Text('Add Start Date Vacation'),
            ),
            10.spaceY,
            ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppTheme.primaryColor)),
              onPressed: () {
                selectEndDateVacation(context);
              },
              child: const Text('Add End Date Vacation'),
            ),
            20.spaceY,
            InkWell(
              onTap: (){
                updateProfile();
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
                    'Update Profile',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff514949), // Text color
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
