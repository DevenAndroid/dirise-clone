import 'dart:convert';
import 'package:dirise/repository/repository.dart';
import 'package:dirise/screens/app_bar/common_app_bar.dart';
import 'package:dirise/utils/helper.dart';
import 'package:dirise/utils/styles.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:dirise/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/vendor_controllers/vendor_profile_controller.dart';
import '../../model/common_modal.dart';
import '../../model/vendor_models/model_payment_method.dart';
import '../../model/vendor_models/model_plan_list.dart';
import '../../utils/api_constant.dart';
import '../authentication/payment_screen.dart';
import '../authentication/thank_you_screen.dart';

class EditVendorPlan extends StatefulWidget {
  const EditVendorPlan({super.key, required this.selectedPlanId});

  final String selectedPlanId;

  @override
  State<EditVendorPlan> createState() => _EditVendorPlanState();
}

class _EditVendorPlanState extends State<EditVendorPlan> with SingleTickerProviderStateMixin {
  final Repositories repositories = Repositories();
  ModelPlansList? modelPlansList;

  final vendorProfileController = Get.put(VendorProfileController());

  getPlansList() {
    repositories.getApi(url: ApiUrls.vendorPlanUrl).then((value) {
      modelPlansList = ModelPlansList.fromJson(jsonDecode(value));
      modelPlansList!.allPlans.asMap().entries.forEach((element) {
        for (var element1 in element.value!) {
          if (widget.selectedPlanId == element1.id.toString()) {
            selectedPlan = element1;
            selectedPlan1 = element1;
            tabController.animateTo(element.key);
            setState(() {});
            break;
          }
        }
      });
      setState(() {});
    });
  }

  ModelPaymentMethods? methods;
  RxInt refreshInt = 0.obs;

  getPaymentGateWays() {
    if (methods != null) return;
    repositories.getApi(url: ApiUrls.paymentMethodsUrl).then((value) {
      methods = ModelPaymentMethods.fromJson(jsonDecode(value));
      refreshInt = 0.obs;
      setState(() {});
    });
  }

  String paymentMethod = "";

  getPaymentUrl() {
    if (paymentMethod.isEmpty) {
      showToast("Please select payment method".tr);
      return;
    }
    repositories.postApi(url: ApiUrls.createPaymentUrl, context: context, mapData: {
      'plan_id': selectedPlan!.id.toString(),
      'callback_url': 'https://diriseapp.com/home/$navigationBackUrl',
      'failure_url': 'https://diriseapp.com/home/$failureUrl',
      'payment_method': paymentMethod,
    }).then((value) {
      ModelCommonResponse modelCommonResponse = ModelCommonResponse.fromJson(jsonDecode(value));
      if (modelCommonResponse.uRL != null) {
        Get.back();
        Get.to(() => PaymentScreen(
              paymentUrl: modelCommonResponse.uRL,
            ));
      }
    });
  }

  late TabController tabController;

  PlanInfoData? selectedPlan;
  PlanInfoData? selectedPlan1;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    getPlansList();
    getPaymentGateWays();
  }

  showPaymentOption() {
    paymentMethod = "";
    getPaymentGateWays();
    showDialog(
        context: context,
        builder: (context1) {
          return Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 18),
            child: Obx(() {
              if (refreshInt.value > 0) {}
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Select Payment Option".tr,
                    style: titleStyle,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (methods != null && methods!.data != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(color: AppTheme.secondaryColor),
                            ),
                            enabled: true,
                            filled: true,
                            hintText: "Select Payment Method".tr,
                            labelStyle: GoogleFonts.poppins(color: Colors.black),
                            labelText: "Select Payment Method".tr,
                            fillColor: const Color(0xffE2E2E2).withOpacity(.35),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(color: AppTheme.secondaryColor),
                            ),
                          ),
                          validator: (value) {
                            if (paymentMethod.isEmpty) {
                              return "Please select payment method".tr;
                            }
                            return null;
                          },
                          isExpanded: true,
                          items: methods!.data!
                              .map((e) => DropdownMenuItem(
                                  value: e.paymentMethodId.toString(),
                                  child: Row(
                                    children: [
                                      Expanded(child: Text(e.paymentMethodEn.toString())),
                                      SizedBox(width: 35, height: 35, child: Image.network(e.imageUrl.toString()))
                                    ],
                                  )))
                              .toList(),
                          onChanged: (value) {
                            if (value == null) return;
                            paymentMethod = value;
                          }),
                    )
                  else
                    const SizedBox(
                      height: 50,
                    ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 25),
                    child: ElevatedButton(
                      onPressed: () {
                        getPaymentUrl();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.buttonColor,
                          surfaceTintColor: AppTheme.buttonColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          "Make Payment".tr,
                          style: titleStyle.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        titleText: 'Plans'.tr,
        bottom: modelPlansList != null
            ? PreferredSize(
                preferredSize: Size(context.getSize.width, kToolbarHeight + 50),
                child: TabBar(
                  controller: tabController,
                  isScrollable: true,
                  tabs: modelPlansList!.allPlans
                      .map((e) => Tab(
                            child: Text(
                              e!.first.businessType.toString().capitalize!,
                              // style: titleStyle,
                            ),
                          ))
                      .toList(),
                  unselectedLabelStyle: titleStyle.copyWith(fontWeight: FontWeight.w400),
                  labelStyle: titleStyle,
                ),
              )
            : null,
      ),
      backgroundColor: Colors.grey.shade100,
      body: modelPlansList != null
          ? TabBarView(
              controller: tabController,
              children: modelPlansList!.allPlans.asMap().entries.map((e) {
                bool allowSelect = false;
                bool showDiscount = true;
                if (selectedPlan1 != null &&
                    selectedPlan1!.businessType.toString().toLowerCase() ==
                        e.value!.first.businessType.toString().toLowerCase()) {
                  showDiscount = false;
                }
                if (selectedPlan1 == null) {
                  showDiscount = false;
                }

                if (selectedPlan1 == null) {
                  allowSelect = true;
                } else if (selectedPlan1!.businessType.toString().toLowerCase() == "advertisement") {
                  allowSelect = true;
                } else if (selectedPlan1!.businessType.toString().toLowerCase() == "personal") {
                  if (e.value!.first.businessType.toString() != "advertisement") {
                    allowSelect = true;
                  }
                } else if (selectedPlan1!.businessType.toString().toLowerCase() == "company") {
                  if (e.value!.first.businessType.toString() == "company") {
                    allowSelect = true;
                  }
                }
                return SingleChildScrollView(
                    child: Card(
                  margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      //const SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Column(
                          children: [
                            allowSelect && modelPlansList!.plansDiscount != null && showDiscount
                                ? Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                        child: Text(
                                          e.key == 1
                                              ? "${modelPlansList!.plansDiscount!.companyDiscount}% ${'Off'}"
                                              : e.key == 2
                                                  ? "${modelPlansList!.plansDiscount!.personalDiscount}% ${'Off'}"
                                                  : "",
                                          style: GoogleFonts.poppins(
                                            color: AppTheme.buttonColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )),
                                  )
                                : const SizedBox(),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              e.value!.first.businessType.toString().capitalize!,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: allowSelect ? AppTheme.buttonColor : Colors.grey.shade400),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Color(0xFFC2ECEC),
                        height: 0,
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      IgnorePointer(
                        ignoring: !allowSelect,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'PLANS'.tr,
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xFF111727),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  /*if (allowSelect && modelPlansList!.plansDiscount != null && showDiscount)
                                    Text(
                                      e.key == 1
                                          ? "${modelPlansList!.plansDiscount!.companyDiscount} %Off"
                                          : e.key == 2
                                              ? "${modelPlansList!.plansDiscount!.personalDiscount} %Off"
                                              : "",
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xFF111727),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),*/
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: e.value!
                                    .asMap()
                                    .entries
                                    .map((e1) => GestureDetector(
                                          onTap: () {
                                            if (!allowSelect) return;
                                            selectedPlan = e1.value;
                                            setState(() {});
                                          },
                                          behavior: HitTestBehavior.translucent,
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Radio<PlanInfoData?>(
                                                      value: e1.value,
                                                      groupValue: selectedPlan,
                                                      toggleable: allowSelect,
                                                      visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
                                                      onChanged: (value) {
                                                        if (!allowSelect) return;
                                                        selectedPlan = value;
                                                        if (selectedPlan == null) return;
                                                        setState(() {});
                                                      }),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Expanded(
                                                      flex: 3,
                                                      child: Text(
                                                        e1.value.label.toString().capitalize!,
                                                        style:
                                                            titleStyle.copyWith(color: allowSelect ? Colors.black : Colors.grey),
                                                      )),
                                                  const SizedBox(
                                                    width: 4,
                                                  ),
                                                  Expanded(
                                                      flex: 2,
                                                      child: Text(
                                                        "${e1.value.amount} ${e1.value.currency}",
                                                        style: titleStyle.copyWith(
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: 14,
                                                            color: allowSelect ? Colors.black : Colors.grey,
                                                            decoration: allowSelect && modelPlansList!.plansDiscount != null && showDiscount ? TextDecoration.lineThrough :
                                                        TextDecoration.none),
                                                      )),
                                                  //e.value!.first.businessType.toString() == "company" && e.value!.first.businessType.toString() == "personal"
                                                  allowSelect && modelPlansList!.plansDiscount != null && showDiscount
                                                      ? Expanded(
                                                          flex: 2,
                                                          child: Text(
                                                            "${e1.value.discountPlan} ${e1.value.currency}",
                                                            style: titleStyle.copyWith(
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: 14,
                                                              color: allowSelect ? Colors.black : Colors.grey,
                                                            ),
                                                          ))
                                                      : const SizedBox(),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ));
              }).toList(),
            )
          : const LoadingAnimation(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 25),
        child: ElevatedButton(
          onPressed: () {
            if (selectedPlan == null) {
              showToast("Please select any plan".tr);
              return;
            }
            showPaymentOption();
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.buttonColor,
              surfaceTintColor: AppTheme.buttonColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              "Update".tr,
              style: titleStyle.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
