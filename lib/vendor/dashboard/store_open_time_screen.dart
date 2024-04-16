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
import '../../controller/vendor_controllers/vendor_store_timing.dart';
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

  updateTime() {
    Map<String, dynamic> map = {};

    List<String> start = [];
    List<String> end = [];
    List<String> status = [];

    controller.modelStoreAvailability.data!.asMap().forEach((key, value) {
      start.add(value.startTime.toString().normalTime);
      end.add(value.endTime.toString().normalTime);
      status.add(value.status == true ? "1" : "0");
    });
    map["start_time"] = start;
    map["end_time"] = end;
    map["status"] = status;
    repositories.postApi(url: ApiUrls.storeAvailabilityUrl, mapData: map, context: context).then((value) {
      ModelCommonResponse modelCommonResponse = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(modelCommonResponse.message.toString());
      controller.getTime();
      if (modelCommonResponse.status == true) {
        Get.back();
      }
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
    controller.getTime();
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
        title: Text('Set Store Time'.tr,
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
        if(controller.refreshInt.value > 0){}
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
                      border: Border.all(color: AppTheme.buttonColor)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Theme(
                        data: ThemeData(
                            checkboxTheme: CheckboxThemeData(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)))),
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
                              color: Colors.grey.shade900, fontSize: 14, fontWeight: FontWeight.w400),
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
                                e.startTime.toString().normalTime,
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
                          "To".tr,
                          style: GoogleFonts.poppins(
                              color: Colors.grey.shade900, fontSize: 14, fontWeight: FontWeight.w400),
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
                                e.endTime.toString().normalTime,
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
                addHeight(15)
              ],
            ))
                .toList(),
            ElevatedButton(
                onPressed: () {
                  updateTime();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.buttonColor,
                    surfaceTintColor: AppTheme.buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text(
                    "Save".tr,
                    style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ))
          ],
        )
            : const LoadingAnimation();
      }),
    );
  }
}
