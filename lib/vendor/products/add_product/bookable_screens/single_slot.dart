import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../controller/vendor_controllers/add_product_controller.dart';
import '../../../../widgets/common_colour.dart';

class SingleSlotUI extends StatefulWidget {
  final int index;
  final DateTime endDateTime;
  const SingleSlotUI({super.key, required this.index, required this.endDateTime});

  @override
  State<SingleSlotUI> createState() => _SingleSlotUIState();
}

class _SingleSlotUIState extends State<SingleSlotUI> {
  final controller = Get.put(AddProductController());

  final DateFormat timeFormat = DateFormat("hh:mm a");

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("SingleSlotUI...........      building");
    }
    return CheckboxListTile(
        value: controller.slots.values.toList()[widget.index],
        onChanged: (ff) {
          if (ff == null) return;
          controller.slots[controller.slots.keys.toList()[widget.index]] = ff;
          setState(() {});
        },
        visualDensity: const VisualDensity(vertical: -4, horizontal: -3),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              child: Text("${timeFormat.format(controller.slots.keys.toList()[widget.index].keys.first)} -- "
                  "${timeFormat.format(controller.slots.keys.toList()[widget.index].values.first)}"),
            ),
            if (controller.slots.keys.toList()[widget.index].values.first.millisecondsSinceEpoch >
                widget.endDateTime.millisecondsSinceEpoch)
              Text(
                " Exceeded",
                style:
                    GoogleFonts.poppins(color: AppTheme.buttonColor, fontWeight: FontWeight.w500, height: 1.8, fontSize: 12),
              )
          ],
        ));
  }
}
