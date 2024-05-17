import 'dart:async';
import 'dart:convert';
import 'package:dirise/model/common_modal.dart';
import 'package:dirise/repository/repository.dart';
import 'package:dirise/utils/api_constant.dart';
import 'package:dirise/utils/helper.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/vendor_controllers/add_product_controller.dart';
import '../../controller/vendor_controllers/vendor_store_timing.dart';
import '../../model/jobResponceModel.dart';
import '../../widgets/customsize.dart';
import '../../widgets/loading_animation.dart';
import 'duration_screen.dart';

class SetTimeScreenConsultation extends StatefulWidget {
  const SetTimeScreenConsultation({Key? key}) : super(key: key);
  static var route = "/SetTimeScreenConsultation";

  @override
  State<SetTimeScreenConsultation> createState() => _SetTimeScreenConsultationState();
}

class _SetTimeScreenConsultationState extends State<SetTimeScreenConsultation> {
  final Repositories repositories = Repositories();
  final controller = Get.put(VendorStoreTimingController());

  Timer? debounce;

  makeDelay({required Function(bool gg) nowPerform}) {
    if (debounce != null) {
      debounce!.cancel();
    }
    debounce = Timer(const Duration(milliseconds: 600), () {
      nowPerform(true);
    });
  }
  final addProductController = Get.put(AddProductController());
  updateTime() {
    Map<String, dynamic> map = {};

    List<String> start = [];
    List<String> end = [];
    List<String> status = [];
    List<String> start_break_time = [];
    List<String> end_break_time = [];

    controller.modelStoreAvailability.data!.asMap().forEach((key, value) {
      start.add(value.startTime.toString().normalTime);
      end.add(value.endTime.toString().normalTime);
      start_break_time.add(value.startBreakTime.toString().normalTime);
      end_break_time.add(value.endBreakTime.toString().normalTime);
      status.add(value.status == true ? "1" : "0");
    });
    map["start_time"] = start;
    map["product_id"] =  addProductController.idProduct.value.toString();
    map["end_time"] = end;
    map["start_break_time"] = start_break_time;
    map["end_break_time"] = end_break_time;
    map["status"] = status;
    repositories.postApi(url: ApiUrls.productAvailabilityUrl, mapData: map, context: context).then((value) {
      ModelCommonResponse modelCommonResponse = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(modelCommonResponse.message.toString());
      controller.getTime( addProductController.idProduct.value.toString());
      if (modelCommonResponse.status == true) {
        Get.to(()=> const DurationScreen());
        // Get.back();
      }
    });
  }
  RxString weakDays = "".obs;
  RxString startTime = "".obs;
  RxString endTime = "".obs;
  RxString breakStart = "".obs;
  RxString breakEnd = "".obs;
  RxBool status = false.obs;
  int index = 0;
  // void updateProfile() {
  //   Map<String, dynamic> map = {};
  //   Map<String, dynamic> map1 = {};
  //   Map<String, dynamic> map2 = {};
  //   Map<String, dynamic> map3 = {};
  //   Map<String, dynamic> map4 = {};
  //   Map<String, dynamic> map5 = {};
  //   Map<String, dynamic> map6 = {};
  //   map['week_day'] = map1;
  //   map['start_time'] = map2;
  //   map['end_time'] = map3;
  //   map['start_break_time'] = map4;
  //   map['end_break_time'] = map5;
  //   map['status'] = map6;
  //   map1['$index'] =
  //   map["product_type"] = "booking";
  //
  //
  //   repositories.postApi(url: ApiUrls.giveawayProductAddress, context: context, mapData: map).then((value) {
  //     print('object${value.toString()}');
  //     JobResponceModel response = JobResponceModel.fromJson(jsonDecode(value));
  //     if (response.status == true) {
  //       showToast(response.message.toString());
  //       Get.to(()=> const SetTimeScreenConsultation());
  //       print('value isssss${response.toJson()}');
  //     }else{
  //       showToast(response.message.toString());
  //     }
  //   });
  // }
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

  @override
  void initState() {
    super.initState();
    controller.getTime(addProductController.idProduct.value.toString());
  }

  @override
  void dispose() {
    super.dispose();
    if (debounce != null) {
      debounce!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text('Time'.tr,
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
      body: Obx(() {
        if (controller.refreshInt.value > 0) {}
        return controller.modelStoreAvailability.data != null
            ? ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 10),
          children: [
            ...controller.modelStoreAvailability.data!
                .map((e) => Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppTheme.buttonColor),
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Theme(
                            data: ThemeData(
                              checkboxTheme: CheckboxThemeData(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                              ),
                            ),
                            child: Checkbox(
                              activeColor: AppTheme.buttonColor,
                              checkColor: Colors.white,
                              value: e.status ?? false,
                              onChanged: (value) {
                                e.status = value;
                                weakDays.value = e.weekDay.toString();
                                startTime.value = e.startTime.toString();
                                endTime.value = e.endTime.toString();
                                breakEnd.value = e.endBreakTime.toString();
                                breakStart.value = e.startBreakTime.toString();
                                status.value = e.status;
print(weakDays.value.toString());
print( startTime.value.toString());
print( endTime.value.toString());
print( breakEnd.value.toString());
print( breakStart.value.toString());
print( status.value.toString());
                                setState(() {});
                              },
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              e.weekDay.toString(),
                              style: GoogleFonts.poppins(
                                color: Colors.grey.shade900,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: GestureDetector(
                              onTap: () {
                                if ((e.status ?? false) == false) return;
                                _showDialog(
                                  CupertinoTimerPicker(
                                    mode: CupertinoTimerPickerMode.hm,
                                    initialTimerDuration: e.startTime.toString().durationTime,
                                    onTimerDurationChanged: (Duration newDuration) {
                                      makeDelay(nowPerform: (bool v) {
                                        String hour =
                                            "${newDuration.inHours < 10 ? "0${newDuration.inHours}" : newDuration.inHours}";
                                        int minute = newDuration.inMinutes % 60;
                                        String inMinute = "${minute < 10 ? "0$minute" : minute}";
                                        e.startTime = "$hour:$inMinute";
                                        setState(() {});
                                      });
                                    },
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Text(
                                    e.startTime!.isNotEmpty?   e.startTime.toString().normalTime:"0.90",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                  const Icon(Icons.keyboard_arrow_down_rounded)
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "To".tr,
                              style: GoogleFonts.poppins(
                                color: Colors.grey.shade900,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: GestureDetector(
                              onTap: () {
                                if ((e.status ?? false) == false) return;
                                _showDialog(
                                  CupertinoTimerPicker(
                                    mode: CupertinoTimerPickerMode.hm,
                                    initialTimerDuration: e.endTime.toString().durationTime,
                                    onTimerDurationChanged: (Duration newDuration) {
                                      makeDelay(nowPerform: (bool v) {
                                        String hour =
                                            "${newDuration.inHours < 10 ? "0${newDuration.inHours}" : newDuration.inHours}";
                                        int minute = newDuration.inMinutes % 60;
                                        String inMinute = "${minute < 10 ? "0$minute" : minute}";
                                        e.endTime = "$hour:$inMinute";
                                        setState(() {});
                                      });
                                    },
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Text(
                                    e.endTime!.isNotEmpty?      e.endTime.toString().normalTime:"0:0",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                  const Icon(Icons.keyboard_arrow_down_rounded)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      addHeight(15),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 48), // Match the width of checkbox column
                          Expanded(
                            flex: 3,
                            child: Text(
                              'Break'.tr,
                              style: GoogleFonts.poppins(
                                color: Colors.grey.shade900,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: GestureDetector(
                              onTap: () {
                                if ((e.status ?? false) == false) return;
                                _showDialog(
                                  CupertinoTimerPicker(
                                    mode: CupertinoTimerPickerMode.hm,
                                    initialTimerDuration:
                                    (e.startBreakTime ?? "00:00").toString().durationTime,
                                    onTimerDurationChanged: (Duration newDuration) {
                                      makeDelay(nowPerform: (bool v) {
                                        String hour =
                                            "${newDuration.inHours < 10 ? "0${newDuration.inHours}" : newDuration.inHours}";
                                        int minute = newDuration.inMinutes % 60;
                                        String inMinute = "${minute < 10 ? "0$minute" : minute}";
                                        e.startBreakTime = "$hour:$inMinute";
                                        setState(() {});
                                      });
                                    },
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Text(
                                    (e.startBreakTime ?? "00:00").toString().normalTime,
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                  const Icon(Icons.keyboard_arrow_down_rounded)
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "To".tr,
                              style: GoogleFonts.poppins(
                                color: Colors.grey.shade900,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: GestureDetector(
                              onTap: () {
                                if ((e.status ?? false) == false) return;
                                _showDialog(
                                  CupertinoTimerPicker(
                                    mode: CupertinoTimerPickerMode.hm,
                                    initialTimerDuration:
                                    (e.endBreakTime ?? "00:00").toString().durationTime,
                                    onTimerDurationChanged: (Duration newDuration) {
                                      makeDelay(nowPerform: (bool v) {
                                        String hour =
                                            "${newDuration.inHours < 10 ? "0${newDuration.inHours}" : newDuration.inHours}";
                                        int minute = newDuration.inMinutes % 60;
                                        String inMinute = "${minute < 10 ? "0$minute" : minute}";
                                        e.endBreakTime = "$hour:$inMinute";
                                        setState(() {});
                                      });
                                    },
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Text(
                                    (e.endBreakTime ?? "00:00").toString().normalTime,
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                  const Icon(Icons.keyboard_arrow_down_rounded)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      addHeight(15),
                    ],
                  ),
                ),
                addHeight(15),
              ],
            ))
                .toList(),
            InkWell(
              onTap: (){
                updateTime();
                // updateProfile();
                // Get.to(()=> const DurationScreen());
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
                // updateTime();
           Get.to(()=> const DurationScreen());
              },
              child: Container(
                width: Get.width,
                // height: 60,
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
        )
            : const LoadingAnimation();
      }),
    );
  }
}
