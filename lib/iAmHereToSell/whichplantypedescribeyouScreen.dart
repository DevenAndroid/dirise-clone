import 'dart:convert';
import 'dart:developer';

import 'package:dirise/controller/profile_controller.dart';
import 'package:dirise/iAmHereToSell/whatdoyousellScreen.dart';
import 'package:dirise/model/vendor_models/newVendorPlanlist.dart';
import 'package:dirise/utils/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../repository/repository.dart';
import '../utils/api_constant.dart';
import '../utils/styles.dart';
import '../widgets/common_colour.dart';

class WhichplantypedescribeyouScreen extends StatefulWidget {
  const WhichplantypedescribeyouScreen({super.key});

  @override
  State<WhichplantypedescribeyouScreen> createState() => _WhichplantypedescribeyouScreenState();
}

class _WhichplantypedescribeyouScreenState extends State<WhichplantypedescribeyouScreen> {
  bool showValidation = false;
  bool? _isValue = false;
  int _selectedOption = 0;
  final profileController = Get.put(ProfileController());

  final Repositories repositories = Repositories();
  ModelPlansList? modelPlansList;

  getPlansList() {
    repositories.getApi(url: ApiUrls.vendorPlanUrl).then((value) {
      modelPlansList = ModelPlansList.fromJson(jsonDecode(value));
      setState(() {});
      log("message");
    });
  }

  final ScrollController _scrollController = ScrollController();
  final GlobalKey _cloudComparisonKey = GlobalKey();

  void _scrollToCloudComparison() {
    final RenderBox renderBox = _cloudComparisonKey.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero, ancestor: null).dy;

    _scrollController.animateTo(
      position,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }
  @override
  void initState() {
    super.initState();

    getPlansList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xff0D5877),
            size: 16,
          ),
        ),
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Which Cloud type suits you?'.tr,
              style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.spaceY,
              Center(
                child: Text(
                  'DIRISE CLOUD SPACE'.tr,
                  style: GoogleFonts.poppins(color: const Color(0xff0D5877), fontWeight: FontWeight.w500, fontSize: 19),
                ),
              ),
              30.spaceY,
              Center(
                child: Text(
                  'A Cloud Area Is The Area That You Are Going To Rent From Dirise For A Period Of 12 Months For Your Business'.tr,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(color: const Color(0xff514949), fontWeight: FontWeight.w400, fontSize: 13),
                ),
              ),
              // Text(
              //   'Startups:'.tr,
              //   style: GoogleFonts.poppins(color: const Color(0xff0D5877), fontWeight: FontWeight.w500, fontSize: 16),
              // ),
              // Text(
              //   'For start ups that want to sell their products in the Dirise platform.'.tr,
              //   style: GoogleFonts.poppins(color: const Color(0xff514949), fontWeight: FontWeight.w400, fontSize: 13),
              // ),
              // Text(
              //   'Enterprise:'.tr,
              //   style: GoogleFonts.poppins(color: const Color(0xff0D5877), fontWeight: FontWeight.w500, fontSize: 16),
              // ),
              // Text(
              //   'For companies with commercial license and corporate bank account.'.tr,
              //   style: GoogleFonts.poppins(color: const Color(0xff514949), fontWeight: FontWeight.w400, fontSize: 13),
              // ),
              const SizedBox(
                height: 20,
              ),   
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset('assets/images/monthtrail.png',width: 120,),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Showcasing Cloud Space'.tr,
                style: GoogleFonts.poppins(color: const Color(0xff0D5877), fontWeight: FontWeight.w600, fontSize: 19),
              ),
              Text(
                'S-SPACE'.tr,
                style: GoogleFonts.poppins(color: const Color(0xff0D5877), fontWeight: FontWeight.w600, fontSize: 19),
              ),
              Text(
                'Limited to showcasing only, any payments will be done outside the platform.'.tr,
                style: GoogleFonts.poppins(color: const Color(0xff514949), fontWeight: FontWeight.w400, fontSize: 13),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Cloud Office Space'.tr,
                style: GoogleFonts.poppins(color: const Color(0xff0D5877), fontWeight: FontWeight.w600, fontSize: 19),
              ),
              Text(
                'C-SPACE'.tr,
                style: GoogleFonts.poppins(color: const Color(0xff0D5877), fontWeight: FontWeight.w600, fontSize: 19),
              ),
              Text(
                'For small business that are in the process of becoming an official business'.tr,
                style: GoogleFonts.poppins(color: const Color(0xff514949), fontWeight: FontWeight.w400, fontSize: 13),
              ),
               const SizedBox(
                height: 20,
              ),
              Text(
                'Enterprise Cloud Space'.tr,
                style: GoogleFonts.poppins(color: const Color(0xff0D5877), fontWeight: FontWeight.w600, fontSize: 19),
              ),
              Text(
                'E-SPACE'.tr,
                style: GoogleFonts.poppins(color: const Color(0xff0D5877), fontWeight: FontWeight.w600, fontSize: 19),
              ),
              Text(
                'For companies with commercial license and corporate bank account'.tr,
                style: GoogleFonts.poppins(color: const Color(0xff514949), fontWeight: FontWeight.w400, fontSize: 13),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: _scrollToCloudComparison,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Full comparison'.tr,
                          style: GoogleFonts.poppins(color: const Color(0xff0D5877), fontWeight: FontWeight.w500, fontSize: 15,
                          decoration: TextDecoration.underline
                          ),
                        ),
                        Text(
                          'Read more info'.tr,
                          style: GoogleFonts.poppins(color: const Color(0xff0D5877), fontWeight: FontWeight.w500, fontSize: 15,
                          decoration: TextDecoration.underline
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                width: Get.width,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey.shade200),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Showcasing Cloud Space '.tr,
                            style: GoogleFonts.poppins(
                                color: const Color(0xff111727), fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                          Text(
                            'Showcasing only'.tr,
                            style: GoogleFonts.poppins(
                                color: const Color(0xff111727), fontWeight: FontWeight.w400, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    Radio(
                      value: 1,
                      groupValue: _selectedOption,
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value!; // Update selected option
                          profileController.selectedPlan = value.toString();
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              if (_selectedOption == 1) ...[
                Container(
                    padding: const EdgeInsets.all(10),
                    width: Get.width,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [
                      const BoxShadow(
                          offset: Offset(1, 1),
                          color: Colors.grey,
                          blurRadius: 1,
                          blurStyle: BlurStyle.outer,
                          spreadRadius: 1)
                    ]),
                    child: Column(
                      children: [
                        // Text(
                        //   "Showcasing Cloud Space ",
                        //   style: GoogleFonts.poppins(
                        //       color: const Color(0xff111727), fontWeight: FontWeight.w600, fontSize: 16),
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Cloud Description  ",
                                  style: GoogleFonts.poppins(
                                      color: const Color(0xff111727), fontWeight: FontWeight.w600, fontSize: 12),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Limited to showcasing only  ",
                                  style: GoogleFonts.poppins(
                                      color: const Color(0xff111727), fontWeight: FontWeight.w600, fontSize: 10),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Image.asset(
                              "assets/images/trial.png",
                              width: 80,
                            ),
                          ],
                        ),
                        Text(
                          "Owners of the Showcasing cloud can only showcase their products, all payments will be done outside of the DIRISE platform. Customers will contact the vendor directly through a phone number or messages  ",
                          style: GoogleFonts.poppins(
                              color: const Color(0xff111727), fontWeight: FontWeight.w600, fontSize: 10),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                            child: Image.asset(
                              "assets/images/p1.png",
                            )),
                        Center(
                            child: Image.asset(
                              "assets/images/plan1.png",
                            )),
                      ],
                    )),
              ],
              const SizedBox(
                height: 20,
              ),
              Container(
                width: Get.width,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey.shade200),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cloud Office Space'.tr,
                            style: GoogleFonts.poppins(
                                color: const Color(0xff111727), fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                          Text(
                            'Small businesses & start ups '.tr,
                            style: GoogleFonts.poppins(
                                color: const Color(0xff111727), fontWeight: FontWeight.w400, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    Radio(
                      value: 2,
                      groupValue: _selectedOption,
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value!; // Update selected option
                          profileController.selectedPlan = value.toString();
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              if (_selectedOption == 2) ...[
                Container(
                    padding: const EdgeInsets.all(10),
                    width: Get.width,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [
                      const BoxShadow(
                          offset: Offset(1, 1),
                          color: Colors.grey,
                          blurRadius: 1,
                          blurStyle: BlurStyle.outer,
                          spreadRadius: 1)
                    ]),
                    child: Column(
                      children: [
                        // Text(
                        //   "Cloud Office Space ",
                        //   style: GoogleFonts.poppins(
                        //       color: const Color(0xff111727), fontWeight: FontWeight.w600, fontSize: 16),
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Cloud Description  ",
                                  style: GoogleFonts.poppins(
                                      color: const Color(0xff111727), fontWeight: FontWeight.w600, fontSize: 12),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Small businesses & start ups  ",
                                  style: GoogleFonts.poppins(
                                      color: const Color(0xff111727), fontWeight: FontWeight.w600, fontSize: 10),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Image.asset(
                              "assets/images/trial.png",
                              width: 80,
                            ),
                          ],
                        ),
                        Text(
                          "For businesses that are working on getting the required official document to be recognized as an official company",
                          style: GoogleFonts.poppins(
                              color: const Color(0xff111727), fontWeight: FontWeight.w600, fontSize: 10),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                            child: Image.asset(
                          "assets/images/p2.png",
                        )),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                            child: Image.asset(
                          "assets/images/plan2.png",
                        )),
                      ],
                    )),
              ],
              const SizedBox(
                height: 20,
              ),
              Container(
                width: Get.width,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey.shade200),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Enterprise Cloud Space '.tr,
                            style: GoogleFonts.poppins(
                                color: const Color(0xff111727), fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                          Text(
                            'Established official businesses '.tr,
                            style: GoogleFonts.poppins(
                                color: const Color(0xff111727), fontWeight: FontWeight.w400, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    Radio(
                      value: 3,
                      groupValue: _selectedOption,
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value!; // Update selected option
                          profileController.selectedPlan = value.toString();
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              if (_selectedOption == 3) ...[
                Container(
                    padding: const EdgeInsets.all(10),
                    width: Get.width,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: const[
                       BoxShadow(
                          offset: Offset(1, 1),
                          color: Colors.grey,
                          blurRadius: 1,
                          blurStyle: BlurStyle.outer,
                          spreadRadius: 1)
                    ]),
                    child: Column(
                      children: [
                        // Text(
                        //   "Enterprise Cloud Space  ",
                        //   style: GoogleFonts.poppins(
                        //       color: const Color(0xff111727), fontWeight: FontWeight.w600, fontSize: 16),
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Cloud Description",
                                    style: GoogleFonts.poppins(
                                        color: AppTheme.buttonColor, fontWeight: FontWeight.w500, fontSize: 18),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    "Official businesses  ",
                                    style: GoogleFonts.poppins(
                                        color: const Color(0xff111727), fontWeight: FontWeight.w500, fontSize: 16),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    "This Cloud is suitable for any official business that has already been established with a corporate bank account",
                                    style: GoogleFonts.poppins(
                                        color: const Color(0xff514949), fontWeight: FontWeight.w400, fontSize: 11),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Image.asset(
                              "assets/images/trial.png",
                              width: 80,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Center(
                            child: Image.asset(
                          "assets/images/p2.png",
                        )),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                            child: Image.asset(
                          "assets/images/plan2.png",
                        )),
                      ],
                    )),
              ],
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Clouds Comparison'.tr,
                  style: GoogleFonts.poppins(color: const Color(0xff014E70), fontWeight: FontWeight.w500, fontSize: 24),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // Container(
              //   padding: const EdgeInsets.only(bottom: 10, top: 10),
              //   margin: const EdgeInsets.only(left: 10, right: 10),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(4),
              //     border: Border.all(color: const Color(0xff353A21), width: 1.0),
              //   ),
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Container(
              //         color: Colors.white,
              //         child: Table(
              //           // Remove TableBorder to remove lines between columns
              //           // border: TableBorder.all(color: Colors.black),
              //           columnWidths: const {
              //             0: FlexColumnWidth(3),
              //           },
              //           children: [
              //             TableRow(children: [
              //               Text(
              //                 'Cloud'.tr,
              //                 style: GoogleFonts.poppins(
              //                   color: const Color(0xff0D0C0C),
              //                   fontWeight: FontWeight.w600,
              //                   fontSize: 10,
              //                 ),
              //               ),
              //               Text(
              //                 'Showcasing'.tr,
              //                 style: GoogleFonts.poppins(
              //                   color: const Color(0xff0D0C0C),
              //                   fontWeight: FontWeight.w600,
              //                   fontSize: 10,
              //                 ),
              //               ),
              //               Text(
              //                 'Office'.tr,
              //                 style: GoogleFonts.poppins(
              //                   color: const Color(0xff0D0C0C),
              //                   fontWeight: FontWeight.w600,
              //                   fontSize: 10,
              //                 ),
              //               ),
              //               Text(
              //                 'Enterprise'.tr,
              //                 style: GoogleFonts.poppins(
              //                   color: const Color(0xff0D0C0C),
              //                   fontWeight: FontWeight.w600,
              //                   fontSize: 10,
              //                 ),
              //               ),
              //             ]),
              //           ],
              //         ),
              //       ),
              //       Container(
              //         color: Colors.white,
              //         child: Table(
              //           border: TableBorder.all(color: Colors.black),
              //           columnWidths: const {
              //             0: FlexColumnWidth(3), // Adjust the value (3) as needed to increase or decrease the width
              //           },
              //           children: const [
              //             TableRow(children: [
              //               Text(
              //                 '11 Month + 500 Products',
              //                 style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              //               ),
              //               Text(
              //                 '10 KWD',
              //                 style: TextStyle(fontSize: 12),
              //               ),
              //               Text(
              //                 '11 KWD',
              //                 style: TextStyle(fontSize: 12),
              //               ),
              //               Text(
              //                 '12 KWD',
              //                 style: TextStyle(fontSize: 12),
              //               ),
              //             ]),
              //             TableRow(children: [
              //               Text(
              //                 '1st Month Charge Only',
              //                 style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              //               ),
              //               Icon(
              //                 Icons.check,
              //                 color: Colors.green,
              //               ),
              //               Icon(
              //                 Icons.check,
              //                 color: Colors.green,
              //               ),
              //               Icon(
              //                 Icons.check,
              //                 color: Colors.green,
              //               ),
              //             ]),
              //             TableRow(children: [
              //               Text(
              //                 '1st Month Charge Only',
              //                 style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              //               ),
              //               Icon(
              //                 Icons.cancel_outlined,
              //                 color: Colors.red,
              //               ),
              //               Icon(
              //                 Icons.cancel_outlined,
              //                 color: Colors.red,
              //               ),
              //               Text(
              //                 'Must',
              //                 style: TextStyle(fontSize: 12),
              //               ),
              //             ]),
              //             TableRow(children: [
              //               Text(
              //                 'Selling ',
              //                 style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              //               ),
              //               Text(
              //                 'Advertising only',
              //                 style: TextStyle(fontSize: 12),
              //               ),
              //               Icon(
              //                 Icons.check,
              //                 color: Colors.green,
              //               ),
              //               Icon(
              //                 Icons.check,
              //                 color: Colors.green,
              //               ),
              //             ]),
              //             TableRow(children: [
              //               Text(
              //                 'Receiving Money',
              //                 style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              //               ),
              //               Icon(
              //                 Icons.cancel_outlined,
              //                 color: Colors.red,
              //               ),
              //               Icon(
              //                 Icons.check,
              //                 color: Colors.green,
              //               ),
              //               Icon(
              //                 Icons.check,
              //                 color: Colors.green,
              //               ),
              //             ]),
              //             TableRow(children: [
              //               Text(
              //                 'Withdrawing earning',
              //                 style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              //               ),
              //               Icon(
              //                 Icons.cancel_outlined,
              //                 color: Colors.red,
              //               ),
              //               Text(
              //                 'Verified deliveries',
              //                 style: TextStyle(fontSize: 12),
              //               ),
              //               Text(
              //                 'Documents Review',
              //                 style: TextStyle(fontSize: 12),
              //               ),
              //             ]),
              //             TableRow(children: [
              //               Text(
              //                 'Fees',
              //                 style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              //               ),
              //               Icon(
              //                 Icons.cancel_outlined,
              //                 color: Colors.red,
              //               ),
              //               Text(
              //                 'Up to 5%',
              //                 style: TextStyle(fontSize: 12),
              //               ),
              //               Text(
              //                 'Up to 5%',
              //                 style: TextStyle(fontSize: 12),
              //               ),
              //             ]),
              //           ],
              //         ),
              //       ),
              //       Container(
              //         color: Colors.white,
              //         child: Table(
              //           border: TableBorder.all(color: Colors.black),
              //           columnWidths: const {
              //             0: FlexColumnWidth(1), // Adjust the value (3) as needed to increase or decrease the width
              //           },
              //           children: const [
              //             TableRow(children: [
              //               Text('Extra 500 products', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              //               Text(
              //                 '4 KWD',
              //                 style: TextStyle(fontSize: 12),
              //               ),
              //             ]),
              //             TableRow(children: [
              //               Text('Photography session', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              //               Text(
              //                 'Available upon request',
              //                 style: TextStyle(fontSize: 12),
              //               ),
              //             ]),
              //             TableRow(children: [
              //               Text('Photography session with discription',
              //                   style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              //               Text(
              //                 'Available upon request',
              //                 style: TextStyle(fontSize: 12),
              //               ),
              //             ]),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Container(
                  key: _cloudComparisonKey,
                  child: Image.asset('assets/images/table.png')),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: (){
                  launchUrlString("tel://+965 6555 6490");
                },
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Contact  +965 6555 6490 if you need assistance'.tr,
                    style: GoogleFonts.poppins(color: const Color(0xff014E70), fontWeight: FontWeight.w400, fontSize: 10),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Transform.translate(
                    offset: const Offset(-6, 0),
                    child: Checkbox(
                        visualDensity: const VisualDensity(horizontal: -1, vertical: -3),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        value: _isValue,
                        side: BorderSide(
                          color: showValidation == false ? const Color(0xff0D5877) : Colors.red,
                        ),
                        onChanged: (bool? value) {
                          setState(() {
                            _isValue = value;
                          });
                        }),
                  ),
                  Expanded(
                    child: Text(
                      'So i agree to DIRISE terms & condition, privacy policy and DIRISE free program*'.tr,
                      style: GoogleFonts.poppins(
                          color: const Color(0xff7B7D7C), fontWeight: FontWeight.w400, fontSize: 13),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  if (_selectedOption == 1 || _selectedOption == 2 || _selectedOption == 3 ) {
                    if (_isValue == true) {
                      Get.to(const WhatdoyousellScreen());
                    } else {
                      showToast("Agree terms and Conditions");
                    }
                  } else {
                    showToast("Please select a plan first");
                  }
                },
                child: Container(
                  width: Get.width,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xff0D5877), // Border color
                      width: 1.0, // Border width
                    ),
                    borderRadius: BorderRadius.circular(2), // Border radius
                  ),
                  padding: const EdgeInsets.all(10), // Padding inside the container
                  child: const Center(
                    child: Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Text color
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
