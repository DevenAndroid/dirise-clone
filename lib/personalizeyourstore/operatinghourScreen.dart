import 'dart:async';
import 'dart:developer';
import 'package:dirise/utils/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../model/common_modal.dart';
import '../repository/repository.dart';
import '../utils/api_constant.dart';
import '../widgets/common_button.dart';
import '../widgets/common_colour.dart';

class OperatingHourScreen extends StatefulWidget {
  const OperatingHourScreen({Key? key}) : super(key: key);
  static var route = "/setTimeScreen";

  @override
  State<OperatingHourScreen> createState() => _OperatingHourScreenState();
}

class _OperatingHourScreenState extends State<OperatingHourScreen> {
  Timer? debounce;

  makeDelay({required Function(bool gg) nowPerform}) {
    if (debounce != null) {
      debounce!.cancel();
    }
    debounce = Timer(const Duration(milliseconds: 600), () {
      nowPerform(true);
    });
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  List<String> weekDays = [
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat",
    "Sun",
  ];

  final Repositories repositories = Repositories();
  String code = "+91";
  // registerApi() {
  //   Map<String, dynamic> map = {};
  //   map['first_name'] = firstNameController.text.trim();
  //   map['last_name'] = lastNameController.text.trim();
  //   map['email'] = _emailController.text.trim();
  //   map['password'] = _passwordController.text.trim();
  //   FocusManager.instance.primaryFocus!.unfocus();
  //   repositories.postApi(url: ApiUrls.newRegisterUrl, context: context, mapData: map).then((value) {
  //     ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
  //     showToast(response.message.toString());
  //     if (response.status == true) {
  //     }
  //   });
  // }

  List<Map<dynamic, dynamic>> weekSchedule = [];
  List<Map<String, dynamic>> weekSchedule1 = [];
  @override
  void initState() {
    super.initState();
    weekSchedule.clear();
    weekSchedule = generateWeekSchedule();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Map<dynamic, dynamic>> generateWeekSchedule() {
    List<Map<dynamic, dynamic>> weekSchedule = [];

    DateTime currentDate = DateTime.now();
    DateTime startTime = DateTime(currentDate.year, currentDate.month, currentDate.day, 9, 0);
    DateTime endTime = DateTime(currentDate.year, currentDate.month, currentDate.day, 19, 0);
    String formattedStartTime = DateFormat.Hm().format(startTime);
    String formattedEndTime = DateFormat.Hm().format(endTime);
    bool status = false;
    for (var element in weekDays) {
      weekSchedule.add({
        'day': element,
        'start_time': formattedStartTime,
        'end_time': formattedEndTime,
        'status': status,
      });
    }
    setState(() {

    });
    return weekSchedule;
  }



  @override
  Widget build(BuildContext context) {
    for(var i = 0; i < 20; i++){
      print(DateFormat('EEE').format(DateTime.now().add(Duration(days: i))));
    }
    return Scaffold(
        backgroundColor: Colors.white,
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
                'Operating hour'.tr,
                style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 18),
              ),
            ],
          ),
        ),
        body: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 10),
          children: [
            if (weekSchedule.isNotEmpty && weekSchedule1.isEmpty)
              ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemCount: weekSchedule.length,
                  itemBuilder: (context, index) {
                    var itemData = weekSchedule[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: AppTheme.primaryColor)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Theme(
                              data: ThemeData(
                                  checkboxTheme:
                                  CheckboxThemeData(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)))),
                              child: Checkbox(
                                activeColor: AppTheme.primaryColor,
                                checkColor: Colors.white,
                                value: itemData["status"],
                                onChanged: (value) {
                                  itemData["status"] = value;
                                  log(itemData["status"].toString());
                                  setState(() {});
                                },
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                itemData["day"].toString(),
                                style:
                                GoogleFonts.poppins(color: Colors.grey.shade900, fontSize: 14, fontWeight: FontWeight.w400),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: GestureDetector(
                                onTap: () {
                                  if ((itemData["status"] ?? false) == false) return;
                                  _showDialog(
                                    CupertinoTimerPicker(
                                      mode: CupertinoTimerPickerMode.hm,
                                      initialTimerDuration: itemData["start_time"].toString().durationTime,
                                      onTimerDurationChanged: (Duration newDuration) {
                                        makeDelay(nowPerform: (bool v) {
                                          String hour =
                                              "${newDuration.inHours < 10 ? "0${newDuration.inHours}" : newDuration.inHours}";
                                          int minute = newDuration.inMinutes % 60;
                                          String inMinute = "${minute < 10 ? "0$minute" : minute}";
                                          itemData["start_time"] = "$hour:$inMinute";
                                          setState(() {});
                                        });
                                      },
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      itemData["start_time"].toString().normalTime,
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500, fontSize: 15, color: Colors.grey.shade700),
                                    ),
                                    const Icon(Icons.keyboard_arrow_down_rounded)
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "To",
                                style:
                                GoogleFonts.poppins(color: Colors.grey.shade900, fontSize: 14, fontWeight: FontWeight.w400),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: GestureDetector(
                                onTap: () {
                                  if ((itemData["status"] ?? false) == false) return;
                                  _showDialog(
                                    CupertinoTimerPicker(
                                      mode: CupertinoTimerPickerMode.hm,
                                      initialTimerDuration: itemData["end_time"].toString().durationTime,
                                      onTimerDurationChanged: (Duration newDuration) {
                                        makeDelay(nowPerform: (bool v) {
                                          String hour =
                                              "${newDuration.inHours < 10 ? "0${newDuration.inHours}" : newDuration.inHours}";
                                          int minute = newDuration.inMinutes % 60;
                                          String inMinute = "${minute < 10 ? "0$minute" : minute}";
                                          itemData["end_time"] = "$hour:$inMinute";
                                          setState(() {});
                                        });
                                      },
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      itemData["end_time"].toString().normalTime,
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500, fontSize: 15, color: Colors.grey.shade700),
                                    ),
                                    const Icon(Icons.keyboard_arrow_down_rounded)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            if(weekSchedule1.isNotEmpty)
              ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: weekSchedule1.length,
                itemBuilder: (context, index) {
                  var daySchedule = weekSchedule1[index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: AppTheme.primaryColor)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Theme(
                            data: ThemeData(
                                checkboxTheme:
                                CheckboxThemeData(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)))),
                            child: Checkbox(
                              activeColor: AppTheme.primaryColor,
                              checkColor: Colors.white,
                              value: daySchedule["status"],
                              onChanged: (value) {
                                daySchedule["status"] = value;
                                log(daySchedule["status"].toString());
                                setState(() {});
                              },
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              daySchedule["day"].toString(),
                              style: GoogleFonts.poppins(color: Colors.grey.shade900, fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: GestureDetector(
                              onTap: () {
                                if ((daySchedule["status"] ?? false) == false) return;
                                _showDialog(
                                  CupertinoTimerPicker(
                                    mode: CupertinoTimerPickerMode.hm,
                                    initialTimerDuration: daySchedule["start_time"].toString().durationTime,
                                    onTimerDurationChanged: (Duration newDuration) {
                                      makeDelay(nowPerform: (bool v) {
                                        String hour =
                                            "${newDuration.inHours < 10 ? "0${newDuration.inHours}" : newDuration.inHours}";
                                        int minute = newDuration.inMinutes % 60;
                                        String inMinute = "${minute < 10 ? "0$minute" : minute}";
                                        daySchedule["start_time"] = "$hour:$inMinute";
                                        setState(() {});
                                      });
                                    },
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Text(
                                    daySchedule["start_time"].toString().normalTime,
                                    style:
                                    GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 15, color: Colors.grey.shade700),
                                  ),
                                  const Icon(Icons.keyboard_arrow_down_rounded)
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "To",
                              style: GoogleFonts.poppins(color: Colors.grey.shade900, fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: GestureDetector(
                              onTap: () {
                                if ((daySchedule["status"] ?? false) == false) return;
                                _showDialog(
                                  CupertinoTimerPicker(
                                    mode: CupertinoTimerPickerMode.hm,
                                    initialTimerDuration: daySchedule["end_time"].toString().durationTime,
                                    onTimerDurationChanged: (Duration newDuration) {
                                      makeDelay(nowPerform: (bool v) {
                                        String hour =
                                            "${newDuration.inHours < 10 ? "0${newDuration.inHours}" : newDuration.inHours}";
                                        int minute = newDuration.inMinutes % 60;
                                        String inMinute = "${minute < 10 ? "0$minute" : minute}";
                                        daySchedule["end_time"] = "$hour:$inMinute";
                                        setState(() {});
                                      });
                                    },
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Text(
                                    daySchedule["end_time"].toString().normalTime,
                                    style:
                                    GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 15, color: Colors.grey.shade700),
                                  ),
                                  const Icon(Icons.keyboard_arrow_down_rounded)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            const SizedBox(
              height: 20,
            ),
            CustomOutlineButton(
              title: 'Add Operating hour',
              onPressed: () {
              },
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ));
  }
}