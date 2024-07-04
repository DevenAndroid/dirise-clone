import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/profile_controller.dart';
import '../../controller/vendor_controllers/add_product_controller.dart';
import '../../model/common_modal.dart';
import '../../repository/repository.dart';
import '../../utils/api_constant.dart';
import '../../widgets/common_colour.dart';
import '../../widgets/common_textfield.dart';
import 'optional_details_academic.dart';

class WebinarScreen extends StatefulWidget {
   int? id;
   String? meetingWillBeat;
   String? startTime;
   String? endTime;
   String? extraNotes;
   String? spots;
  WebinarScreen({super.key, this.id,this.startTime,this.endTime,this.extraNotes,this.meetingWillBeat,this.spots});

  @override
  State<WebinarScreen> createState() => _WebinarScreenState();
}

class _WebinarScreenState extends State<WebinarScreen> {
  String meetingWillBe1 = 'zoom';
  List<String> meetingWillBe1List = [
    'zoom',
    'Google Meet',
  ];

  String meetingWillBe2 = 'zoom';
  List<String> meetingWillBe2List = [
    'zoom',
    'Google Meet',
  ];

  TimeOfDay? startTime = const TimeOfDay(hour: 9, minute: 30);
  TimeOfDay? endTime = const TimeOfDay(hour: 19, minute: 0);
  List<DateTime> selectedDates = [DateTime(2022, 10, 12)];

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStartTime ? startTime! : endTime!,
    );
    if (picked != null && picked != (isStartTime ? startTime : endTime)) {
      setState(() {
        if (isStartTime) {
          startTime = picked;
        } else {
          endTime = picked;
        }
      });
    }
  }

  final Repositories repositories = Repositories();
  final addProductController = Get.put(AddProductController());

  TextEditingController extraNotesController = TextEditingController();
  final profileController = Get.put(ProfileController());
  webinarApi() {
    log('fgdsgsdf');
    Map<String, dynamic> map = {};
    map['meeting_platform'] = meetingWillBe1;
    map['item_type'] = 'product';
    map['product_type'] = 'booking';
    map['booking_product_type'] = 'webinar';
    map['product_availability_id'] = profileController.productAvailabilityId;
    map['start_time'] = startTime?.format(context);
    map['end_time'] = endTime?.format(context);
    map['timing_extra_notes'] = extraNotesController.text.trim();
    map['date'] = selectedDates.map((date) => date.toIso8601String()).toList();
    map['id'] = addProductController.idProduct.value.toString();
    map['additional_start_time'] = '';
    map['additional_end_time'] = '';

    log('sdgafahrwtersfshdhhjgf');
    repositories.postApi(url: ApiUrls.giveawayProductAddress, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      log('sdgafahsfssdfvhdhhjgf');
      showToast(response.message.toString());
      if (response.status == true) {
        log('sdgafahsfshdhhjgf');
        Get.to(() =>  OptionalDetailsSeminarAndAttendable());
      }
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        selectedDates.add(picked);
      });
    }
  }

  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
  }
  TimeOfDay? parseTimeOfDay(String? timeString) {
    if (timeString == null) return null;
    final timeParts = timeString.split(":");
    final hour = int.tryParse(timeParts[0]);
    final minute = int.tryParse(timeParts[1]);
    if (hour != null && minute != null) {
      return TimeOfDay(hour: hour, minute: minute);
    }
    return null;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.id != null){
      meetingWillBe1 = widget.meetingWillBeat.toString();
      startTime = parseTimeOfDay(widget.startTime);
      endTime = parseTimeOfDay(widget.endTime);
      extraNotesController.text = widget.extraNotes.toString();
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
              'Webinars'.tr,
              style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Meeting will be at',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: meetingWillBe1,
                onChanged: (String? newValue) {
                  setState(() {
                    meetingWillBe1 = newValue!;
                  });
                },
                items: meetingWillBe1List.map<DropdownMenuItem<String>>((String value) {
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
              const SizedBox(height: 5),
              const Text(
                '+ Add other Platform',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: Colors.black),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text(
                    'Start Time',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectTime(context, true),
                      child: Text(
                        startTime?.format(context) ?? 'Select Start Time',
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
                      ),
                    ),
                  ),
                  const Text(
                    'End Time',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectTime(context, false),
                      child: Text(
                        endTime?.format(context) ?? 'Select End Time',
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Extra Notes',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
              ),
              const SizedBox(
                height: 5,
              ),
              CommonTextField(
                obSecure: false,
                hintText: 'Notes',
                controller: extraNotesController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return 'Product Notes is required'.tr;
                  }
                  return null; // Return null if validation passes
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Text(
                    'Spots',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 40,
                    width: 60,
                    child: TextFormField(
                      decoration: const InputDecoration(border: OutlineInputBorder()),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Add different timings for specific days.',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
              ),
              const Text(
                'Enter a code have a unique timing and use comma (,) then enter to create the dialogue ',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: Colors.black),
              ),
              const Text(
                'Write in this format dd/mm/yy example 13/06/25',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              CommonTextField(
                obSecure: false,
                hintText: 'dd/mm/yy, dd/mm/yy',
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return 'Product Notes is required'.tr;
                  }
                  return null; // Return null if validation passes
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Date',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  for (DateTime date in selectedDates)
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: Text(
                        formatDate(date),
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black),
                      ),
                    ),
                ],
              ),
              const Text(
                'Meeting will be at',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: meetingWillBe2,
                onChanged: (String? newValue) {
                  setState(() {
                    meetingWillBe2 = newValue!;
                  });
                },
                items: meetingWillBe2List.map<DropdownMenuItem<String>>((String value) {
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
              const SizedBox(height: 5),
              const Text(
                '+ Add other Platform',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: Colors.black),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text(
                    'Start Time',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectTime(context, true),
                      child: Text(
                        startTime?.format(context) ?? 'Select Start Time',
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
                      ),
                    ),
                  ),
                  const Text(
                    'End Time',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectTime(context, false),
                      child: Text(
                        endTime?.format(context) ?? 'Select End Time',
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Extra Notes',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
              ),
              const SizedBox(
                height: 5,
              ),
              CommonTextField(
                obSecure: false,
                hintText: 'Notes',
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return 'Product Notes is required'.tr;
                  }
                  return null; // Return null if validation passes
                },
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  webinarApi();
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
                onTap: () {

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
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
