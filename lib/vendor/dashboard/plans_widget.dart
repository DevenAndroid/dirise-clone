import 'package:dirise/language/app_strings.dart';
import 'package:dirise/utils/shimmer_extension.dart';
import 'package:dirise/utils/styles.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/vendor_controllers/vendor_profile_controller.dart';
import '../profile/edit_plan_screen.dart';
import '../profile/vendor_profile_screen.dart';

class PlanWidget extends StatefulWidget {
  const PlanWidget({super.key});

  @override
  State<PlanWidget> createState() => _PlanWidgetState();
}

class _PlanWidgetState extends State<PlanWidget> {
  final vendorProfileController = Get.put(VendorProfileController());

  bool get paymentDone => vendorProfileController.model.user!.subscription_status.toString() == "pending";
  bool get profileComplete => vendorProfileController.model.user!.vendorProfile!.is_complete == "false";

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Obx(() {
        if (vendorProfileController.refreshInt.value > 0) {}
        return vendorProfileController.model.user != null
            ? Card(
                margin: const EdgeInsets.only(top: 10),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Theme(
                    data: ThemeData(useMaterial3: true, dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      textColor: const Color(0xFF393A3C),
                      initiallyExpanded: true,
                      iconColor: Colors.grey,
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text("Active Plan".tr),
                          Text(
                            vendorProfileController.model.user!.vendorType.toString().capitalize!,
                            style: titleStyle,
                          ),
                        ],
                      ),
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      expandedAlignment: Alignment.centerLeft,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (paymentDone) ...[
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => EditVendorPlan(
                                          selectedPlanId: vendorProfileController.model.user!.activePlanId.toString(),
                                        ));
                                  },
                                  behavior: HitTestBehavior.translucent,
                                  child: Row(
                                    children: [
                                      Text(
                                        "${'Subscription Payment'.tr}: ",
                                        style: normalStyle,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Pending".tr,
                                          style: titleStyle.copyWith(color: Colors.redAccent),
                                        ).convertToShimmerRed,
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                              // if ((paymentDone == false && profileComplete)) ...[
                              //   GestureDetector(
                              //     onTap: () {
                              //       Get.toNamed(VendorProfileScreen.route);
                              //     },
                              //     behavior: HitTestBehavior.translucent,
                              //     child: Row(
                              //       children: [
                              //         Text(
                              //           "Profile Form: ",
                              //           style: normalStyle,
                              //         ),
                              //         Expanded(
                              //           child: Text(
                              //             "Pending",
                              //             style: titleStyle.copyWith(color: Colors.redAccent),
                              //           ),
                              //         ),
                              //         Expanded(
                              //           child: Align(
                              //             alignment: Alignment.centerRight,
                              //             child: IconButton(
                              //               onPressed: () {
                              //                 Get.toNamed(VendorProfileScreen.route);
                              //               },
                              //               icon: const Icon(
                              //                 Icons.arrow_forward_ios_rounded,
                              //                 size: 18,
                              //               ),
                              //             ),
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ],
                              if (vendorProfileController.model.user!.planStartDate != null) ...[
                                 Text("Plan Start Date".tr),
                                Text(
                                  vendorProfileController.model.user!.planStartDate.toString().capitalize!,
                                  style: titleStyle,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                              ],
                              if (vendorProfileController.model.user!.planExpireDate != null) ...[
                                 Text("Plan Expiry Date".tr),
                                Text(
                                  vendorProfileController.model.user!.planExpireDate.toString().capitalize!,
                                  style: titleStyle,
                                ),
                                const SizedBox(
                                  height: 14,
                                ),
                              ],
                              if (vendorProfileController.model.user!.planStartDate == null &&
                                  vendorProfileController.model.user!.planExpireDate == null)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Text(
                                    "Plan Info Not Available".tr,
                                    style: normalStyle,
                                  ),
                                ),
                              Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton(
                                        onPressed: () {
                                          Get.to(() => EditVendorPlan(
                                                selectedPlanId:
                                                    vendorProfileController.model.user!.activePlanId.toString(),
                                              ));
                                        },
                                        style: OutlinedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          side: BorderSide(
                                              color: paymentDone ? Colors.redAccent : const Color(0xffECB403)),
                                          surfaceTintColor: Colors.white,
                                          elevation: 2,
                                          shadowColor: paymentDone ? Colors.redAccent : const Color(0xffECB403),
                                          backgroundColor: Colors.white,
                                        ),
                                        child: FittedBox(
                                          child: Text(
                                            AppStrings.renewPlan.tr,
                                            style: titleStyle.copyWith(
                                                color: paymentDone ? Colors.redAccent : const Color(0xffECB403),
                                                fontSize: 18),
                                          ),
                                        )),
                                  ),
                                  if (vendorProfileController.model.user!.vendorType.toString().toLowerCase() !=
                                      "company")
                                    const SizedBox(
                                      width: 16,
                                    ),
                                  if (vendorProfileController.model.user!.vendorType.toString().toLowerCase() !=
                                      "company")
                                    Expanded(
                                      child: OutlinedButton(
                                          onPressed: () {
                                            Get.to(() => EditVendorPlan(
                                                  selectedPlanId:
                                                      vendorProfileController.model.user!.activePlanId.toString(),
                                                ));
                                          },
                                          style: OutlinedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                            side: const BorderSide(color: Color(0xff13BFA6)),
                                            surfaceTintColor: Colors.white,
                                            elevation: 2,
                                            shadowColor: const Color(0xff13BFA6),
                                            backgroundColor: Colors.white,
                                          ),
                                          child: FittedBox(
                                            child: Text(
                                              AppStrings.upgradePlan.tr,
                                              style: titleStyle.copyWith(color: const Color(0xff13BFA6), fontSize: 18),
                                            ),
                                          )),
                                    ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink();
      }),
    );
  }
}
