import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controller/vendor_controllers/vendor_profile_controller.dart';
import '../../utils/styles.dart';
import '../profile/vendor_profile_screen.dart';

class StatusWidget extends StatefulWidget {
  const StatusWidget({Key? key}) : super(key: key);

  @override
  State<StatusWidget> createState() => _StatusWidgetState();
}

class _StatusWidgetState extends State<StatusWidget> {
  final vendorProfileController = Get.put(VendorProfileController());

  bool get paymentDone => vendorProfileController.model.user!.subscription_status.toString() == "pending";
  bool get profileComplete => vendorProfileController.model.user!.vendorProfile!.is_complete == "false";

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Obx(() {
        if (vendorProfileController.refreshInt.value > 0) {}
        return vendorProfileController.model.user != null
            ? GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  Get.toNamed(VendorProfileScreen.route);
                },
                child: Card(
                  margin: const EdgeInsets.only(top: 10),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Theme(
                      data: ThemeData(useMaterial3: true, dividerColor: Colors.transparent),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Vendor Publish Status".tr),
                            const SizedBox(
                              height: 5,
                            ),
                            vendorProfileController.model.user!.vendorPublishStatus.toString() == 'pending'
                                ? Text(
                                    'Pre-approved: You must upload the required documents to be approved and able to receive your payments.',
                                    style: titleStyle.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.red
                                    ),
                                  )
                                : Text(
                                    vendorProfileController.model.user!.vendorPublishStatus
                                        .toString()
                                        .capitalizeFirst
                                        .toString(),
                                    style: titleStyle.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.red
                                    ),
                                  )
                            /*== 'approved' ?
                          Text( vendorProfileController.model.user!.vendorPublishStatus.toString().capitalizeFirst.toString(),style: titleStyle,) :
                      const SizedBox(),*/
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink();
      }),
    );
  }
}
