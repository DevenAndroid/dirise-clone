import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../language/app_strings.dart';
import '../model/returnPolicyModel.dart';
import '../personalizeyourstore/returnpolicyScreen.dart';
import '../repository/repository.dart';
import '../utils/api_constant.dart';
import '../widgets/common_colour.dart';
import '../widgets/dimension_screen.dart';

class ReturnnPolicyList extends StatefulWidget {
  const ReturnnPolicyList({super.key});

  static var route = "/returnPolicyScreen";

  @override
  State<ReturnnPolicyList> createState() => _ReturnnPolicyListState();
}

class _ReturnnPolicyListState extends State<ReturnnPolicyList> {
  int _radioValue1 = 1;

  RxInt returnPolicyLoaded = 0.obs;
  Rx<ReturnPolicyModel> modelReturnPolicy = ReturnPolicyModel().obs;
  // ReturnPolicyModel? modelReturnPolicy;
  final Repositories repositories = Repositories();

  getReturnPolicyData() {
    repositories.getApi(url: ApiUrls.returnPolicyUrl).then((value) {
      modelReturnPolicy.value = ReturnPolicyModel.fromJson(jsonDecode(value));
      returnPolicyLoaded.value = DateTime.now().millisecondsSinceEpoch;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getReturnPolicyData();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Color(0xff0D5877),
                size: 16,
              ),
              onPressed: () {
                // Handle back button press
              },
            ),
          ),
          titleSpacing: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.returnnPolicy.tr,
                style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                modelReturnPolicy.value.returnPolicy != null ?
                ListView.builder(
                    itemCount: modelReturnPolicy.value.returnPolicy!.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      var returnpolicy = modelReturnPolicy.value.returnPolicy![index];
                      return Container(
                        width: size.width,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                            border: Border.all(color: const Color(0xffE4E2E2))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("My Default Policy:",
                                        style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500)),
                                    const Image(image: AssetImage("assets/icons/tempImageYRVRjh 1.png"))
                                  ],
                                ),
                              ),
                              const Divider(
                                thickness: 1,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Return Within",
                                            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500)),
                                        Text("Return Shipping Fees",
                                            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500))
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.all(Radius.circular(5)),
                                              border: Border.all(color: const Color(0xffD9D9D9)),
                                              shape: BoxShape.rectangle),
                                          child:
                                          Text(returnpolicy.days,
                                              style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.all(Radius.circular(5)),
                                              border: Border.all(color: const Color(0xffD9D9D9)),
                                              shape: BoxShape.rectangle),
                                          child: Text("Days",
                                              style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
                                        ),
                                        Radio(
                                          value: 0,
                                          groupValue: _radioValue1,
                                          onChanged: (value) {
                                            setState(() {
                                              _radioValue1 = value!;
                                            });
                                          },
                                        ),
                                        Text('Buyer Pays',
                                            style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
                                        Radio(
                                          // Visual Density passed here
                                          visualDensity: const VisualDensity(horizontal: -2.0),
                                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          value: 1,
                                          groupValue: _radioValue1,
                                          onChanged: (value) {
                                            setState(() {
                                              _radioValue1 = value!;
                                            });
                                          },
                                        ),
                                        Text('Seller Pays ',
                                            style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
                                      ],
                                    ),
                                    Text("Return Policy Description",
                                        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500)),
                                    Text(
                                        returnpolicy.policyDiscreption,
                                        style: GoogleFonts.poppins(
                                          fontSize: 11,
                                        )),
                                    const SizedBox(
                                      height: 13,
                                    ),
                                    Row(
                                      children: [
                                        Text("Edit",
                                            style: GoogleFonts.poppins(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w300,
                                                color: const Color(0xff014E70))),
                                        Text("|Remove",
                                            style: GoogleFonts.poppins(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w300,
                                                color: const Color(0xff014E70))),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }) : CircularProgressIndicator(),

                const SizedBox(
                  height: 13,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(const ReturnPolicyScreens());
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "+Add New",
                        style: TextStyle(decoration: TextDecoration.underline, color: Color(0xff014E70)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 13,
                ),
                Text("DIRISE standard Policy", style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500)),
                const SizedBox(
                  height: 13,
                ),

                ListView.builder(
                  shrinkWrap: true,
                  itemCount: modelReturnPolicy.value.returnPolicy?.length ?? 0,
                  itemBuilder: (context, index) {
                    var returnPolicy = modelReturnPolicy.value.returnPolicy?[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(returnPolicy?.title ?? "", style: GoogleFonts.poppins(
                            fontSize: 20, fontWeight: FontWeight.w500)),
                        // Display other information about the return policy here
                        const SizedBox(height: 8),
                        const Divider(),
                      ],
                    );
                  },
                ),

                const SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffF5F2F2),
                        minimumSize: const Size(double.maxFinite, 60),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AddSize.size5),
                        ),
                        textStyle: GoogleFonts.poppins(fontSize: AddSize.font20, fontWeight: FontWeight.w600)),
                    child: Text(
                      "Save".tr,
                      style:
                      GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w500, fontSize: AddSize.font18),
                    )),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.maxFinite, 60),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AddSize.size5),
                        ),
                        backgroundColor: AppTheme.buttonColor,
                        textStyle: GoogleFonts.poppins(fontSize: AddSize.font20, fontWeight: FontWeight.w600)),
                    child: Text(
                      "Skip".tr,
                      style:
                      GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w500, fontSize: AddSize.font18),
                    )),
              ],
            );
          }),
        ));
  }
}
