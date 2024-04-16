import 'package:dirise/utils/helper.dart';
import 'package:dirise/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../controller/vendor_controllers/vendor_profile_controller.dart';
import '../../controller/vendor_controllers/vendor_store_timing.dart';
import '../../model/vendor_models/model_store_availability.dart';
import '../../widgets/common_colour.dart';
import '../profile/vendor_profile_screen.dart';
import 'store_open_time_screen.dart';

class AppBarScreen extends StatefulWidget implements PreferredSizeWidget {
  const AppBarScreen({super.key});

  @override
  State<AppBarScreen> createState() => _AppBarScreenState();

  @override
  Size get preferredSize => const Size(double.maxFinite, 100);
}

class _AppBarScreenState extends State<AppBarScreen> {
  final vendorProfileController = Get.put(VendorProfileController());
  final vendorStoreTimingController = Get.put(VendorStoreTimingController());

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Image.asset(
                  'assets/icons/backicon.png',
                  height: 25,
                ),
              ),
            ),
          ],
        ),
      ),
      toolbarHeight: 100,
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleSpacing: 0,
      title: Obx(() {
        if (vendorProfileController.refreshInt.value > 0) {}
        return vendorProfileController.apiLoaded
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const SizedBox(height: 10,),
            Text(
              "${'Hi'.tr}, ${vendorProfileController.model.user!
                  .firstName
                  .toString()
                  .checkNullable} ${vendorProfileController.model.user!
                  .lastName
                  .toString()
                  .checkNullable}",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600, fontSize: 20, color: const Color(0xff292F45)),
            ),
            const SizedBox(height: 10,),
            GestureDetector(
              onTap: () {
                Get.toNamed(SetTimeScreen.route);
              },
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      "${'Store Time'.tr} :",
                      style:
                      GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 15, color: const Color(0xff737A8A)),
                    ),
                  ),
                  Expanded(
                    child: Obx(() {
                      if(vendorStoreTimingController.refreshInt.value > 0){}
                      return Text(
                        vendorStoreTimingController.modelStoreAvailability.data != null ?
                        "${vendorStoreTimingController.modelStoreAvailability.data!.firstWhere((element) =>
                        element.weekDay.toString().toLowerCase() == DateFormat("EEEE").format(DateTime.now()).toLowerCase(),
                            orElse: () =>
                                TimeData(
                                    startTime: " 09 AM"
                                )).startTime.toString().normalTime} to ${(vendorStoreTimingController.modelStoreAvailability.data!.firstWhere((
                            element) =>
                        element.weekDay.toString().toLowerCase() == DateFormat("EEEE").format(DateTime.now()).toLowerCase(),
                            orElse: () =>
                                TimeData(
                                    endTime: "7 PM"
                                )).endTime ?? "").toString().normalTime}" : "",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400, fontSize: 16, color: AppTheme.buttonColor),
                      );
                    }),
                  ),
                  const Icon(
                    Icons.edit,
                    color: AppTheme.buttonColor,
                    size: 15,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4,),
            if(vendorProfileController.model.user!.vendorPublishStatus.toString() != "approved")
              Text("Status: ${vendorProfileController.model.user!.vendorPublishStatus}".capitalize!,style: normalStyle,)
          ],
        )
            : const SizedBox();
      }),
      actions: [
        GestureDetector(
          onTap: () {
            Get.toNamed(VendorProfileScreen.route);
          },
          child: Obx(() {
            // log(vendorController.model.data!.storeBusinessId.toString());
            if (vendorProfileController.refreshInt.value > 0) {}
            return vendorProfileController.apiLoaded
                ? Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0, top: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(1000),
                    child: Container(
                        height: 45,
                        width: 45,
                        clipBehavior: Clip.antiAlias,
                        // margin: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          // color: Colors.brown
                        ),
                        child: Image.network(
                          vendorProfileController.model.user!.storeImage.toString(),
                          errorBuilder: (_, __, ___) =>
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(1000),
                                      border: Border.all(color: Colors.grey)),
                                  child: Icon(
                                    Icons.person_2_rounded,
                                    color: Colors.grey.shade500,
                                  )),
                        )),
                  ),
                ),
                // Positioned(
                //     top: 9,
                //     child: Column(children: [
                //       Image.asset(
                //         'assets/icons/active.png',
                //         height: 12,
                //       ),
                //     ]))
              ],
            )
                : const Padding(
              padding: EdgeInsets.only(right: 14),
              child: Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }),
        )
      ],
    );
  }
}
