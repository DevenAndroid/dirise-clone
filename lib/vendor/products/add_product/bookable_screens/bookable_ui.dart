import 'package:dirise/utils/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../controller/vendor_controllers/add_product_controller.dart';
import '../../../../widgets/dimension_screen.dart';
import '../../../../widgets/vendor_common_textfield.dart';
import 'create_slots_screen.dart';

class BookableUI extends StatefulWidget {
  const BookableUI({super.key});

  @override
  State<BookableUI> createState() => _BookableUIState();
}

class _BookableUIState extends State<BookableUI> {
  final controller = Get.put(AddProductController());
  final DateFormat selectedDateFormat = DateFormat("dd-MMM-yyyy");
  // DateTime? selectedStartDateTime;
  // DateTime? selectedEndDateTIme;

  pickDate({required Function(DateTime gg) onPick, DateTime? initialDate, DateTime? firstDate, DateTime? lastDate}) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: initialDate ?? DateTime.now(),
        firstDate: firstDate ?? DateTime.now(),
        lastDate: lastDate ?? DateTime(2101),
        initialEntryMode: DatePickerEntryMode.calendarOnly);
    if (pickedDate == null) return;
    onPick(pickedDate);
    // updateValues();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        bookingTypeCard(),
        const CreateSlotsScreen(),
        productAvailability(),
      ],
    );
  }

  Card bookingTypeCard() {
    return Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 3,
        margin: const EdgeInsets.only(bottom: 14),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Booking Type",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500, color: const Color(0xff2F2F2F), fontSize: 15),
                ),
                Row(
                  children: [
                    Flexible(
                        child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Obx(() {
                          return Radio<String>(
                              value: "Virtual",
                              groupValue: controller.bookingType.value,
                              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                              onChanged: (v) {
                                if (v == null) return;
                                controller.bookingType.value = v;
                                // updateValues();
                              });
                        }),
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              controller.bookingType.value = "Virtual";
                              // updateValues();
                            },
                            behavior: HitTestBehavior.translucent,
                            child: Text(
                              "Virtual",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400, color: const Color(0xff2F2F2F), fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    )),
                    const SizedBox(
                      width: 16,
                    ),
                    Flexible(
                        child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Obx(() {
                          return Radio<String>(
                              value: "Personal",
                              groupValue: controller.bookingType.value,
                              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                              onChanged: (v) {
                                if (v == null) return;
                                controller.bookingType.value = v;
                                // updateValues();
                              });
                        }),
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              controller.bookingType.value = "Personal";
                              // updateValues();
                            },
                            behavior: HitTestBehavior.translucent,
                            child: Text(
                              "Personal",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400, color: const Color(0xff2F2F2F), fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    )),
                  ],
                ),
              ],
            )));
  }

  Card productAvailability() {
    return Card(
        key: controller.productAvailabilityKey,
        color: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 3,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding20).copyWith(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Product Availability",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500, color: const Color(0xff2F2F2F), fontSize: 15),
                ),
                12.spaceY,
                Row(
                  children: [
                    Flexible(
                        child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Obx(() {
                          return Radio<String>(
                              value: "date",
                              groupValue: controller.dateType.value,
                              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                              onChanged: (v) {
                                if (v == null) return;
                                controller.dateType.value = v;
                                // updateValues();
                              });
                        }),
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              controller.dateType.value = "date";
                              // updateValues();
                            },
                            behavior: HitTestBehavior.translucent,
                            child: Text(
                              "Single Date",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400, color: const Color(0xff2F2F2F), fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    )),
                    const SizedBox(
                      width: 16,
                    ),
                    Flexible(
                        child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Obx(() {
                          return Radio<String>(
                              value: "range",
                              groupValue: controller.dateType.value,
                              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                              onChanged: (v) {
                                if (v == null) return;
                                controller.dateType.value = v;
                                // updateValues();
                              });
                        }),
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              controller.dateType.value = "range";
                              // updateValues();
                            },
                            behavior: HitTestBehavior.translucent,
                            child: Text(
                              "Date Range",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400, color: const Color(0xff2F2F2F), fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    )),
                  ],
                ),
                Obx(() {
                  return controller.dateType.value == "range"
                      ? Column(
                          children: [
                            12.spaceY,
                            VendorCommonTextfield(
                                readOnly: true,
                                onTap: () {
                                  pickDate(
                                      onPick: (DateTime gg) {
                                        controller.startDate.text = selectedDateFormat.format(gg);
                                        controller.selectedStartDateTime = gg;
                                      },
                                      initialDate: controller.selectedStartDateTime,
                                      lastDate: controller.selectedEndDateTIme);
                                },
                                controller: controller.startDate,
                                key: controller.startDate.getKey,
                                hintText: "Start Time",
                                suffixIcon: const Icon(
                                  CupertinoIcons.clock,
                                  size: 20,
                                ),
                                validator: (value) {
                                  if (value!.trim().isEmpty) {
                                    return "Start date is required";
                                  }
                                  return null;
                                }),
                            20.spaceY,
                            VendorCommonTextfield(
                                readOnly: true,
                                onTap: () {
                                  pickDate(
                                      onPick: (DateTime gg) {
                                        controller.endDate.text = selectedDateFormat.format(gg);
                                        controller.selectedEndDateTIme = gg;
                                      },
                                      initialDate: controller.selectedEndDateTIme ?? controller.selectedStartDateTime,
                                      firstDate: controller.selectedStartDateTime);
                                },
                                controller: controller.endDate,
                                key: controller.endDate.getKey,
                                // key: endTime.getKey,
                                hintText: "End Time",
                                suffixIcon: const Icon(
                                  CupertinoIcons.clock,
                                  size: 20,
                                ),
                                validator: (value) {
                                  if (value!.trim().isEmpty) {
                                    return "End date is required";
                                  }
                                  return null;
                                }),
                          ],
                        )
                      : Column(
                          children: [
                            12.spaceY,
                            VendorCommonTextfield(
                                readOnly: true,
                                onTap: () {
                                  pickDate(
                                    onPick: (DateTime gg) {
                                      controller.startDate.text = selectedDateFormat.format(gg);
                                      controller.selectedStartDateTime = gg;
                                    },
                                    initialDate: controller.selectedStartDateTime,
                                  );
                                },
                                controller: controller.startDate,
                                key: controller.startDate.getKey,
                                // key: startTime.getKey,
                                hintText: "Single Date",
                                suffixIcon: const Icon(
                                  CupertinoIcons.clock,
                                  size: 20,
                                ),
                                validator: (value) {
                                  if (value!.trim().isEmpty) {
                                    return "Single date is required";
                                  }
                                  return null;
                                }),
                          ],
                        );
                }),
                10.spaceY,
              ],
            )));
  }
}
