import 'dart:async';
import 'dart:developer';
import 'package:dirise/utils/api_constant.dart';
import 'package:dirise/utils/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../controller/vendor_controllers/add_product_controller.dart';
import '../../../../widgets/common_colour.dart';
import '../../../../widgets/vendor_common_textfield.dart';
import 'single_slot.dart';

class CreateSlotsScreen extends StatefulWidget {
  const CreateSlotsScreen({super.key});

  @override
  State<CreateSlotsScreen> createState() => _CreateSlotsScreenState();
}

class _CreateSlotsScreenState extends State<CreateSlotsScreen> {
  final controller = Get.put(AddProductController());

  final DateFormat timeFormat = DateFormat("hh:mm a");

  Duration startDuration = const Duration(hours: 9, minutes: 00);
  Duration endDuration = const Duration(hours: 19, minutes: 00);

  DateTime get startDateTime => startDuration.fromTodayStart;

  DateTime get endDateTime => startDuration.inMinutes > endDuration.inMinutes
      ? endDuration.fromTodayStart.add(const Duration(days: 1))
      : endDuration.fromTodayStart;

  clearSlots() {
    if (controller.slots.isNotEmpty) {
      controller.slots.clear();
      setState(() {});
    }
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

  Timer? debounce;

  makeDelay({required Function(bool gg) nowPerform}) {
    if (debounce != null) {
      debounce!.cancel();
    }
    debounce = Timer(const Duration(milliseconds: 600), () {
      nowPerform(true);
    });
  }

  @override
  void initState() {
    super.initState();
    controller.startTime.clear();
    controller.endTime.clear();
    controller.serviceDuration.clear();
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
    if (kDebugMode) {
      print("CreateSlotsScreen...........      building");
    }
    return Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 3,
        margin: const EdgeInsets.only(bottom: 14),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15).copyWith(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        !controller.resetSlots ? "Edit Slots" : "Create Slot",
                        style:
                            GoogleFonts.poppins(fontWeight: FontWeight.w500, color: const Color(0xff2F2F2F), fontSize: 15),
                      ),
                    ),
                    if (controller.serviceTimeSloat.isNotEmpty && controller.productId.isNotEmpty)
                      TextButton(
                          onPressed: () {
                            controller.resetSlots = !controller.resetSlots;
                            setState(() {});
                          },
                          child: Text(!controller.resetSlots ? "Create Slots" : "Previous Slots"))
                  ],
                ),
                if (controller.resetSlots == true ||
                    !(controller.serviceTimeSloat.isNotEmpty && controller.productId.isNotEmpty)) ...[
                  12.spaceY,
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: VendorCommonTextfield(
                              readOnly: true,
                              onTap: () {
                                String hour =
                                    "${startDuration.inHours < 10 ? "0${startDuration.inHours}" : startDuration.inHours}";
                                int minute = startDuration.inMinutes % 60;
                                String inMinute = "${minute < 10 ? "0$minute" : minute}";
                                controller.startTime.text = "$hour : $inMinute";
                                clearSlots();
                                _showDialog(
                                  CupertinoTimerPicker(
                                    mode: CupertinoTimerPickerMode.hm,
                                    initialTimerDuration: startDuration,
                                    onTimerDurationChanged: (Duration newDuration) {
                                      makeDelay(nowPerform: (bool v) {
                                        startDuration = newDuration;
                                        if (kDebugMode) {
                                          print("performed....    $startDuration");
                                        }
                                        String hour =
                                            "${startDuration.inHours < 10 ? "0${startDuration.inHours}" : startDuration.inHours}";
                                        int minute = startDuration.inMinutes % 60;
                                        String inMinute = "${minute < 10 ? "0$minute" : minute}";
                                        controller.startTime.text = "$hour : $inMinute";
                                        clearSlots();
                                        setState(() {});
                                      });
                                    },
                                  ),
                                );
                              },
                              controller: controller.startTime,
                              key: controller.startTime.getKey,
                              hintText: "Start Time",
                              suffixIcon: const Icon(
                                CupertinoIcons.clock,
                                size: 20,
                              ),
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return "Start time is required";
                                }
                                return null;
                              }),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Flexible(
                          child: VendorCommonTextfield(
                              readOnly: true,
                              onTap: () {
                                String hour =
                                    "${endDuration.inHours < 10 ? "0${endDuration.inHours}" : endDuration.inHours}";
                                int minute = endDuration.inMinutes % 60;
                                String inMinute = "${minute < 10 ? "0$minute" : minute}";
                                controller.endTime.text = "$hour : $inMinute";
                                clearSlots();
                                _showDialog(
                                  CupertinoTimerPicker(
                                    mode: CupertinoTimerPickerMode.hm,
                                    initialTimerDuration: endDuration,
                                    // This is called when the user changes the timer's
                                    // duration.
                                    onTimerDurationChanged: (Duration newDuration) {
                                      makeDelay(nowPerform: (bool v) {
                                        endDuration = newDuration;
                                        if (kDebugMode) {
                                          print("performed....    $endDuration");
                                        }
                                        String hour =
                                            "${endDuration.inHours < 10 ? "0${endDuration.inHours}" : endDuration.inHours}";
                                        int minute = endDuration.inMinutes % 60;
                                        String inMinute = "${minute < 10 ? "0$minute" : minute}";
                                        controller.endTime.text = "$hour : $inMinute";
                                        clearSlots();
                                        setState(() {});
                                      });
                                    },
                                  ),
                                );
                              },
                              controller: controller.endTime,
                              key: controller.endTime.getKey,
                              hintText: "End Time",
                              suffixIcon: const Icon(
                                CupertinoIcons.clock,
                                size: 20,
                              ),
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return "End time is required";
                                }
                                return null;
                              }),
                        ),
                      ],
                    ),
                  ),
                  12.spaceY,
                  VendorCommonTextfield(
                      controller: controller.serviceDuration,
                      key: controller.serviceDuration.getKey,
                      onChanged: (f) {
                        clearSlots();
                      },
                      hintText: "Service Duration (in minutes)",
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Service duration is required";
                        }
                        if (startDateTime
                                .difference(endDateTime)
                                .abs()
                                .compareTo(Duration(minutes: int.tryParse(value) ?? 0)) ==
                            -1) {
                          return "Service duration is greater then start & end time duration";
                        }
                        return null;
                      }),
                  10.spaceY,
                  Row(
                    key: controller.slotKey,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (controller.startTime.text.trim().isEmpty) {
                              showToast("Select start time");
                              return;
                            }
                            if (controller.endTime.text.trim().isEmpty) {
                              showToast("Select end time");
                              return;
                            }
                            if (controller.serviceDuration.text.trim().isEmpty) {
                              showToast("Select service duration");
                              return;
                            }

                            controller.slots.clear();
                            if (kDebugMode) {
                              print(startDateTime.difference(endDateTime).abs());
                              print(startDateTime
                                  .difference(endDateTime)
                                  .abs()
                                  .compareTo(Duration(minutes: int.tryParse(controller.serviceDuration.text) ?? 0)));
                              print(startDateTime
                                      .difference(endDateTime)
                                      .abs()
                                      .compareTo(Duration(minutes: int.tryParse(controller.serviceDuration.text) ?? 0)) ==
                                  -1);
                            }

                            Duration minutes = Duration(minutes: int.tryParse(controller.serviceDuration.text) ?? 0);

                            DateTime temp = startDateTime;
                            while (temp.millisecondsSinceEpoch < endDateTime.millisecondsSinceEpoch) {
                              controller.slots[{temp: temp.add(minutes)}] = false;
                              temp = temp.add(minutes);
                            }
                            FocusManager.instance.primaryFocus!.unfocus();
                            setState(() {});
                            // updateValues();
                            log(controller.slots.toString());
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.buttonColor,
                              surfaceTintColor: AppTheme.buttonColor,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                          child: Text(
                            controller.slots.isEmpty ? "Create Slot" : "Slots Created - ${controller.slots.length}",
                            style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Container(
                    constraints: BoxConstraints(maxHeight: context.getSize.width * .52, minHeight: 0),
                    child: Scrollbar(
                      thumbVisibility: false, //always show scrollbar
                      thickness: 5, //width of scrollbar
                      interactive: true,
                      radius: const Radius.circular(20), //corner radius of scrollbar
                      scrollbarOrientation: ScrollbarOrientation.right, //which side to show scrollbar
                      child: ListView.builder(
                          itemCount: controller.slots.length,
                          padding: const EdgeInsets.only(top: 10),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return SingleSlotUI(
                              index: index,
                              endDateTime: endDateTime,
                            );
                          }),
                    ),
                  ),
                ] else
                  Container(
                    constraints: BoxConstraints(maxHeight: context.getSize.width * .52, minHeight: 0),
                    child: Scrollbar(
                      thumbVisibility: false, //always show scrollbar
                      thickness: 5, //width of scrollbar
                      interactive: true,
                      radius: const Radius.circular(20), //corner radius of scrollbar
                      scrollbarOrientation: ScrollbarOrientation.right, //which side to show scrollbar
                      child: ListView.builder(
                          itemCount: controller.serviceTimeSloat.length,
                          padding: const EdgeInsets.only(top: 10),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final item = controller.serviceTimeSloat[index];
                            return Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Start Time: ${item.timeSloat}",
                                    style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "End Time: ${item.timeSloatEnd.toString()}",
                                    style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      controller.serviceTimeSloat.removeAt(index);
                                      if (controller.serviceTimeSloat.isEmpty) {
                                        controller.resetSlots = true;
                                      }
                                      setState(() {});
                                    },
                                    padding: EdgeInsets.zero,
                                    visualDensity: VisualDensity.compact,
                                    icon: const Icon(Icons.clear))
                              ],
                            );
                          }),
                    ),
                  ),
              ],
            )));
  }
}
