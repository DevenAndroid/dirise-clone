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
import '../../controller/profile_controller.dart';
import '../../controller/vendor_controllers/add_product_controller.dart';
import '../../controller/vendor_controllers/vendor_store_timing.dart';
import '../../model/vendor_models/model_store_availability.dart';
import '../../widgets/customsize.dart';
import '../../widgets/loading_animation.dart';

class SetTimeScreen extends StatefulWidget {
  const SetTimeScreen({Key? key}) : super(key: key);
  static var route = "/setTimeScreen";

  @override
  State<SetTimeScreen> createState() => _SetTimeScreenState();
}

class _SetTimeScreenState extends State<SetTimeScreen> {
  final Repositories repositories = Repositories();

  Timer? debounce;
  RxInt refreshInt = 0.obs;
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

    modelStoreAvailability.value.data!.asMap().forEach((key, value) {
      start.add(value.startTime.toString().normalTime);
      end.add(value.endTime.toString().normalTime);
      start_break_time.add(value.startBreakTime.toString().normalTime);
      end_break_time.add(value.endBreakTime.toString().normalTime);
      status.add(value.status == true ? "1" : "0");
    });
    map["start_time"] = start;
    map["end_time"] = end;
    map["start_break_time"] = start_break_time;
    map["end_break_time"] = end_break_time;
    map["status"] = status;
    repositories.postApi(url: ApiUrls.storeAvailabilityUrl, mapData: map, context: context).then((value) {
      ModelCommonResponse modelCommonResponse = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(modelCommonResponse.message.toString());
      if (modelCommonResponse.status == true) {
        Get.back();
      }
    });
  }

  Rx<ModelStoreAvailability> modelStoreAvailability = ModelStoreAvailability().obs;
  void getStoreTime() {
    repositories.getApi(url: ApiUrls.storeTimingUrl).then((value) {
      ModelStoreAvailability newStoreAvailability = ModelStoreAvailability.fromJson(jsonDecode(value));

      if (newStoreAvailability.data != null) {
        modelStoreAvailability.value = newStoreAvailability; // Update the observable data
        refreshInt++; // Trigger UI refresh

        print("Store timing data updated successfully!");
      } else {
        print("Store timing data is empty!");
      }
    }).catchError((e) {
      print("Error fetching store timing data: $e");
      throw Exception(e);
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

  @override
  void initState() {
    super.initState();
    getStoreTime();
  }

  @override
  void dispose() {
    super.dispose();
    if (debounce != null) {
      debounce!.cancel();
    }
  }
  final profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text('Set Store Time'.tr,
            style: GoogleFonts.poppins(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: const Color(0xff423E5E),
            )),
        leading:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment : MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Padding(
                padding: const EdgeInsets.all(15),
                child:  profileController.selectedLAnguage.value != 'English' ?
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
              ),
            ),
          ],
        ),
      ),
      body: Obx(() {
        return modelStoreAvailability.value.data != null
            ? ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 10),
          children: [
            ...modelStoreAvailability.value.data!
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
                                        String hour = "${newDuration.inHours < 10 ? "0${newDuration.inHours}" : newDuration.inHours}";
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
                                    e.startTime.toString().normalTime,
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
                                        String hour = "${newDuration.inHours < 10 ? "0${newDuration.inHours}" : newDuration.inHours}";
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
                                    e.endTime.toString().normalTime,
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

                      addHeight(5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(width: 50),
                          Text(
                            "Break Time".tr,
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 20,),
                          Expanded(
                            flex: 2,
                            child: GestureDetector(
                              onTap: () {
                                if ((e.status ?? false) == false) return;
                                _showDialog(
                                  CupertinoTimerPicker(
                                    mode: CupertinoTimerPickerMode.hm,
                                    initialTimerDuration: e.startBreakTime.toString().durationTime,
                                    onTimerDurationChanged: (Duration newDuration) {
                                      makeDelay(nowPerform: (bool v) {
                                        String hour = "${newDuration.inHours < 10 ? "0${newDuration.inHours}" : newDuration.inHours}";
                                        int minute = newDuration.inMinutes % 60;
                                        String inMinute = "${minute < 10 ? "0$minute" : minute}";

                                        String selectedBreakTime = "$hour:$inMinute";
                                        if (selectedBreakTime.compareTo(e.startTime!) >= 0 &&
                                            selectedBreakTime.compareTo(e.endTime!) <= 0) {
                                          e.startBreakTime = selectedBreakTime;
                                        } else {
                                          showToast("Break time must be within working hours.");
                                        }
                                        setState(() {});
                                      });
                                    },
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Text(
                                    e.startBreakTime.toString().normalTime,
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
                                    initialTimerDuration: e.endBreakTime.toString().durationTime,
                                    onTimerDurationChanged: (Duration newDuration) {
                                      makeDelay(nowPerform: (bool v) {
                                        String hour = "${newDuration.inHours < 10 ? "0${newDuration.inHours}" : newDuration.inHours}";
                                        int minute = newDuration.inMinutes % 60;
                                        String inMinute = "${minute < 10 ? "0$minute" : minute}";

                                        String selectedEndBreakTime = "$hour:$inMinute";
                                        if (selectedEndBreakTime.compareTo(e.startTime!) >= 0 &&
                                            selectedEndBreakTime.compareTo(e.endTime!) <= 0) {
                                          e.endBreakTime = selectedEndBreakTime;
                                        } else {
                                          showToast("Break time must be within working hours.");
                                        }
                                        setState(() {});
                                      });
                                    },
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Text(
                                    e.endBreakTime.toString().normalTime,
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
                      addHeight(10),
                    ],
                  ),
                ),
                addHeight(10),
              ],
            ))
                .toList(),
            addHeight(10),
            GestureDetector(
              onTap: () {
                updateTime();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.buttonColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
                alignment: Alignment.center,
                child: Text(
                  "Save Time".tr,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            addHeight(20),
          ],
        )
            : Center(
          child: LoadingAnimation(),
        );
      }),
    );
  }
}
