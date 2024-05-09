import 'dart:convert';
import 'dart:developer';

import 'package:dirise/controller/profile_controller.dart';
import 'package:dirise/iAmHereToSell/whatdoyousellScreen.dart';
import 'package:dirise/model/vendor_models/newVendorPlanlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
  final  profileController = Get.put(ProfileController());

  final Repositories repositories = Repositories();
  ModelPlansList? modelPlansList;

  getPlansList() {
    repositories.getApi(url: ApiUrls.vendorPlanUrl).then((value) {
      modelPlansList = ModelPlansList.fromJson(jsonDecode(value));
      setState(() {});
      log("message");
    });
  }

  Advertisement? selectedPlan;
  Personal? selectedPlan1;
  Company? selectedPlan2;

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
          onTap: (){
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
              'Which plan type describe you?'.tr,
              style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                'Individuals:'.tr,
                style: GoogleFonts.poppins(color: const Color(0xff0D5877), fontWeight: FontWeight.w500, fontSize: 16),
              ),
              Text(
                'Limited to advertising only, any payments will be done outside the platform.'.tr,
                style: GoogleFonts.poppins(color: const Color(0xff514949), fontWeight: FontWeight.w400, fontSize: 13),
              ),
              Text(
                'Startups:'.tr,
                style: GoogleFonts.poppins(color: const Color(0xff0D5877), fontWeight: FontWeight.w500, fontSize: 16),
              ),
              Text(
                'For start ups that want to sell their products in the Dirise platform.'.tr,
                style: GoogleFonts.poppins(color: const Color(0xff514949), fontWeight: FontWeight.w400, fontSize: 13),
              ),
              Text(
                'Enterprise:'.tr,
                style: GoogleFonts.poppins(color: const Color(0xff0D5877), fontWeight: FontWeight.w500, fontSize: 16),
              ),
              Text(
                'For companies with commercial license and corporate bank account.'.tr,
                style: GoogleFonts.poppins(color: const Color(0xff514949), fontWeight: FontWeight.w400, fontSize: 13),
              ),
              const SizedBox(height: 20,),
              Text(
                'Click here for Full comparison'.tr,
                style: GoogleFonts.poppins(color: const Color(0xff0D5877), fontWeight: FontWeight.w400, fontSize: 16),
              ),
              const SizedBox(height: 20,),
              Container(
                width: Get.width,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade200
                ),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Individuals:'.tr,
                            style: GoogleFonts.poppins(color: const Color(0xff111727), fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                          Text(
                            'Advertising only'.tr,
                            style: GoogleFonts.poppins(color: const Color(0xff111727), fontWeight: FontWeight.w400, fontSize: 13),
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
                SizedBox(height: 10,),
              if (_selectedOption == 1) ...[
                Container(
                  height: 410,
                  padding: const EdgeInsets.only(left: 5,right: 5),
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                    border: Border.all(color: const Color(0xff0D5877), width: 1.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Individuals'.tr,
                                style: GoogleFonts.raleway(
                                  color: const Color(0xff0D5877),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                      const Divider(thickness: 1,color: Colors.grey,),
                      Text(
                        'Plan'.tr,
                        style: GoogleFonts.poppins(
                          color: const Color(0xff0D5877),
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        '10 KWD will charge for 1st month. 11 Months Free'.tr,
                        style: GoogleFonts.poppins(
                          color: const Color(0xff514949),
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Limited to advertising only, any payments will be done outside the platform.'.tr,
                        style: GoogleFonts.poppins(
                          color: const Color(0xff514949),
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                        ),
                      ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                'PLANS'.tr,
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFF111727),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            modelPlansList?.plans!.advertisement != null ?
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: modelPlansList!.plans!.advertisement!.length,
                                itemBuilder: (context, index) {
                                  var advertisement = modelPlansList!.plans!.advertisement![index];
                              return  Row(
                                children: [
                                  Radio<Advertisement?>(
                                      value: advertisement,
                                      groupValue: selectedPlan,
                                      visualDensity:
                                      const VisualDensity(horizontal: -4, vertical: -2),
                                      onChanged: (value) {
                                        selectedPlan = value;
                                        profileController.planID = value!.id.toString();
                                        if (selectedPlan == null) return;
                                        setState(() {});
                                      }),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                      flex: 3,
                                      child: Text(
                                        advertisement.label,
                                        style: titleStyle,
                                      )),
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                        "${advertisement.amount} ${advertisement.currency ?? 'KWD'}",
                                        style: titleStyle.copyWith(
                                            fontWeight: FontWeight.w400, fontSize: 14),
                                      )),
                                ],
                              );
                            }) : const CircularProgressIndicator()

                          ],
                        )


                    ],
                  ),
                ),
              ],
              const SizedBox(height: 20,),
              Container(
                width: Get.width,

                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade200
                ),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Startup stores'.tr,
                            style: GoogleFonts.poppins(color: const Color(0xff111727), fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                          Text(
                            'Just started the business journey'.tr,
                            style: GoogleFonts.poppins(color: const Color(0xff111727), fontWeight: FontWeight.w400, fontSize: 13),
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
              SizedBox(height: 10,),
              if (_selectedOption == 2) ...[
                Container(
                  height: 400,
                  padding: const EdgeInsets.only(left: 5,right: 5),
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                    border: Border.all(color: const Color(0xff0D5877), width: 1.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Startup stores'.tr,
                                style: GoogleFonts.raleway(
                                  color: const Color(0xff0D5877),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          const Radio(
                            value: 1,
                            groupValue: 1,
                            onChanged: null,
                          ),
                        ],
                      ),
                      const Divider(thickness: 1,color: Colors.grey,),
                      Text(
                        'Plan'.tr,
                        style: GoogleFonts.poppins(
                          color: const Color(0xff0D5877),
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        '10 KWD will charge for 1st month. 11 Months Free'.tr,
                        style: GoogleFonts.poppins(
                          color: const Color(0xff514949),
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Limited to advertising only, any payments will be done outside the platform.'.tr,
                        style: GoogleFonts.poppins(
                          color: const Color(0xff514949),
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                        ),
                      ),
                      modelPlansList?.plans!.personal != null ?
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: modelPlansList!.plans!.personal!.length,
                          itemBuilder: (context, index) {
                            var personal = modelPlansList!.plans!.personal![index];
                            return  Row(
                              children: [
                                Radio<Personal?>(
                                    value: personal,
                                    groupValue: selectedPlan1,
                                    visualDensity:
                                    const VisualDensity(horizontal: -4, vertical: -2),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedPlan1 = value;
                                        profileController.planID = value!.id.toString();
                                        if (selectedPlan == null) return;
                                      });


                                    }),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                    flex: 3,
                                    child: Text(
                                      personal.label,
                                      style: titleStyle,
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: Text(
                                      "${personal.amount} ${personal.currency ?? 'KWD'}",
                                      style: titleStyle.copyWith(
                                          fontWeight: FontWeight.w400, fontSize: 14),
                                    )),
                              ],
                            );
                          }) : const CircularProgressIndicator()
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 20,),
              Container(
                width: Get.width,

                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade200
                ),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Enterprise stores:'.tr,
                            style: GoogleFonts.poppins(color: const Color(0xff111727), fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                          Text(
                            'Advertising only'.tr,
                            style: GoogleFonts.poppins(color: const Color(0xff111727), fontWeight: FontWeight.w400, fontSize: 13),
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
              SizedBox(height: 10,),
              if (_selectedOption == 3) ...[
                Container(
                  height: 400,
                  padding: const EdgeInsets.only(left: 5,right: 5),
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                    border: Border.all(color: const Color(0xff0D5877), width: 1.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Enterprise stores'.tr,
                                style: GoogleFonts.raleway(
                                  color: const Color(0xff0D5877),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          const Radio(
                            value: 1,
                            groupValue: 1,
                            onChanged: null,
                          ),
                        ],
                      ),
                      const Divider(thickness: 1,color: Colors.grey,),
                      Text(
                        'Plan'.tr,
                        style: GoogleFonts.poppins(
                          color: const Color(0xff0D5877),
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        '10 KWD will charge for 1st month. 11 Months Free'.tr,
                        style: GoogleFonts.poppins(
                          color: const Color(0xff514949),
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Limited to advertising only, any payments will be done outside the platform.'.tr,
                        style: GoogleFonts.poppins(
                          color: const Color(0xff514949),
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                        ),
                      ),
                      modelPlansList?.plans!.company != null ?
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: modelPlansList!.plans!.company!.length,
                          itemBuilder: (context, index) {
                            var company = modelPlansList!.plans!.company![index];
                            return  Row(
                              children: [
                                Radio<Company?>(
                                    value: company,
                                    groupValue: selectedPlan2,
                                    visualDensity:
                                    const VisualDensity(horizontal: -4, vertical: -2),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedPlan2 = value;
                                        profileController.planID = value!.id.toString();
                                        if (value == null) return;
                                      });
                                    },
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                    flex: 3,
                                    child: Text(
                                      company.label,
                                      style: titleStyle,
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: Text(
                                      "${company.amount} ${company.currency ?? 'KWD'}",
                                      style: titleStyle.copyWith(
                                          fontWeight: FontWeight.w400, fontSize: 14),
                                    )),
                              ],
                            );
                          }) : const CircularProgressIndicator()
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 20,),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Our Plans'.tr,
                  style: GoogleFonts.poppins(color: const Color(0xff014E70), fontWeight: FontWeight.w500, fontSize: 24),
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              Container(
                padding: const EdgeInsets.only(bottom: 10,top: 10),
                margin: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: const Color(0xff353A21), width: 1.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.white,
                      child: Table(
                        // Remove TableBorder to remove lines between columns
                        // border: TableBorder.all(color: Colors.black),
                        columnWidths: const {
                          0: FlexColumnWidth(3),
                        },
                        children: [
                          TableRow(children: [
                            Text('Service'.tr,
                              style: GoogleFonts.poppins(
                                color: const Color(0xff0D0C0C),
                                fontWeight: FontWeight.w600,
                                fontSize: 10,
                              ),
                            ),
                            Text('Individuals'.tr,
                              style: GoogleFonts.poppins(
                                color: const Color(0xff0D0C0C),
                                fontWeight: FontWeight.w600,
                                fontSize: 10,
                              ),
                            ),
                            Text('Startup Stores'.tr,
                              style: GoogleFonts.poppins(
                                color: const Color(0xff0D0C0C),
                                fontWeight: FontWeight.w600,
                                fontSize: 10,
                              ),
                            ),
                            Text('Enterprise Stores'.tr,
                              style: GoogleFonts.poppins(
                                color: const Color(0xff0D0C0C),
                                fontWeight: FontWeight.w600,
                                fontSize: 10,
                              ),
                            ),
                          ]),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Table(
                        border: TableBorder.all(color: Colors.black),
                        columnWidths: const {
                          0: FlexColumnWidth(3), // Adjust the value (3) as needed to increase or decrease the width
                        },
                        children: const [
                          TableRow(children: [
                            Text('11 Month + 500 Products',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                            Text('10 KWD',style: TextStyle(fontSize: 12),),
                            Text('11 KWD',style: TextStyle(fontSize: 12),),
                            Text('12 KWD',style: TextStyle(fontSize: 12),),
                          ]),
                          TableRow(children: [
                            Text('1st Month Charge Only',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                            Icon(Icons.check,color: Colors.green,),
                            Icon(Icons.check,color: Colors.green,),
                            Icon(Icons.check,color: Colors.green,),
                          ]),
                          TableRow(children: [
                            Text('1st Month Charge Only',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                            Icon(Icons.cancel_outlined,color: Colors.red,),
                            Icon(Icons.cancel_outlined,color: Colors.red,),
                            Text('Must',style: TextStyle(fontSize: 12),),
                          ]),
                          TableRow(children: [
                            Text('Selling ',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                            Text('Advertising only',style: TextStyle(fontSize: 12),),
                            Icon(Icons.check,color: Colors.green,),
                            Icon(Icons.check,color: Colors.green,),
                          ]),
                          TableRow(children: [
                            Text('Receiving Money',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                            Icon(Icons.cancel_outlined,color: Colors.red,),
                            Icon(Icons.check,color: Colors.green,),
                            Icon(Icons.check,color: Colors.green,),
                          ]),
                          TableRow(children: [
                            Text('Withdrawing earning',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                            Icon(Icons.cancel_outlined,color: Colors.red,),
                            Text('Verified deliveries',style: TextStyle(fontSize: 12),),
                            Text('Documents Review',style: TextStyle(fontSize: 12),),
                          ]),
                          TableRow(children: [
                            Text('Fees',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                            Icon(Icons.cancel_outlined,color: Colors.red,),
                            Text('Up to 5%',style: TextStyle(fontSize: 12),),
                            Text('Up to 5%',style: TextStyle(fontSize: 12),),
                          ]),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Table(
                        border: TableBorder.all(color: Colors.black),
                        columnWidths: const {
                          0: FlexColumnWidth(1), // Adjust the value (3) as needed to increase or decrease the width
                        },
                        children: const [
                          TableRow(children: [
                            Text('Extra 500 products',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),
                            Text('4 KWD',style: TextStyle(fontSize: 12),),

                          ]),
                          TableRow(children: [
                            Text('Photography session',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),
                            Text('Available upon request',style: TextStyle(fontSize: 12),),

                          ]),
                          TableRow(children: [
                            Text('Photography session with discription',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),
                            Text('Available upon request',style: TextStyle(fontSize: 12),),

                          ]),
                        ],
                      ),
                    ),
                  ],
                ),
              ),




const SizedBox(height: 10,),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Contact  +965 6555 6490 if you need assistance'.tr,
                  style: GoogleFonts.poppins(color: const Color(0xff014E70), fontWeight: FontWeight.w400, fontSize: 10),
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
                      style: GoogleFonts.poppins(color: const Color(0xff7B7D7C), fontWeight: FontWeight.w400, fontSize: 13),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: (){
                  if(selectedPlan != null ||  selectedPlan1 != null || selectedPlan2 != null) {
                    // Check if any plan is selected
                    if(_isValue == true) {
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
