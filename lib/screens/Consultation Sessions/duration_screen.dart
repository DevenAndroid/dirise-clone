import 'dart:convert';

import 'package:dirise/utils/helper.dart';
import 'package:dirise/widgets/common_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/vendor_controllers/add_product_controller.dart';
import '../../model/create_slots_model.dart';
import '../../repository/repository.dart';
import '../../utils/api_constant.dart';
import '../../widgets/common_colour.dart';
import 'optional_details.dart';


class DurationScreen extends StatefulWidget {
  const  DurationScreen({super.key});

  @override
  State<DurationScreen> createState() => _DurationScreenState();
}

class _DurationScreenState extends State<DurationScreen> {
  String selectedItemDay = 'min';
  TextEditingController timeController = TextEditingController();
  TextEditingController timeControllerPreparation = TextEditingController();
  TextEditingController timeControllerRecovery = TextEditingController();
  TextEditingController timeController1 = TextEditingController();
  final Repositories repositories = Repositories();
  Rx<CreateSlotsModel> createSlotsModel = CreateSlotsModel().obs;
  final addProductController = Get.put(AddProductController());
  final formKey = GlobalKey<FormState>();
  createSlots() {
    Map<String, dynamic> map = {};

    // map["product_id"] = addProductController.productId.toString();
    map["product_id"] = '1237';
    map["todayDate"] = addProductController.formattedStartDate.toString();
    map["interval"] = timeController.text.trim().toString();
    repositories.postApi(url: ApiUrls.productCreateSlots, mapData: map, context: context).then((value) {
      createSlotsModel.value = CreateSlotsModel.fromJson(jsonDecode(value));
      showToast(createSlotsModel.value.message.toString());
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text('Duration'.tr,
            style: GoogleFonts.poppins(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: const Color(0xff423E5E),
            )),
        leading: GestureDetector(
          onTap: () {
            Get.back();
            // _scaffoldKey.currentState!.openDrawer();
          },
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Image.asset(
              'assets/icons/backicon.png',
              height: 20,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 18),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Expanded(
                    child: Text(
                      'Service Slot Duration',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Text color
                      ),
                    ),
                  ),
                   Expanded(
                      child: SizedBox(
                        height: 56,
                        child: CommonTextField(
                          keyboardType: TextInputType.number,
                          hintText: 'Time',
                          controller: timeController,
                          validator: (value){
                            if(value!.trim().isEmpty){
                              return 'Enter time';
                            }
                            return null;
                          },
                        ),
                      )
                  ),
                  6.spaceX,
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: selectedItemDay,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedItemDay = newValue!;
                        });
                      },
                      items: <String>['min', 'hours']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: const Color(0xffE2E2E2).withOpacity(.35),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10).copyWith(right: 8),
                        focusedErrorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: AppTheme.secondaryColor)),
                        errorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Color(0xffE2E2E2))),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: AppTheme.secondaryColor)),
                        disabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: AppTheme.secondaryColor),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: AppTheme.secondaryColor),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select an item';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              10.spaceY,
              Align(
                alignment: Alignment.topRight,
                child: Text('Price 30 KWD'.tr,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xffEB4335),
                    )),
              ),
              10.spaceY,
              Text('Allow multiple booking'.tr,
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff423E5E),
                  )),
              10.spaceY,
              Text('Preparation Block Time'.tr,
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff423E5E),
                  )),
              5.spaceY,
              Container(
                padding: const EdgeInsets.all(9),
                width: Get.width,
                decoration: BoxDecoration(
                  color: const Color(0xFFF9F9F9),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFFE3E3E3),
                  )
                ),
                child: Text('This is the time you need to prepare for the service. EXP. Preparation time set for two hours Customer at 10 O’clock will be able to book from 12 O’clock the at the earliest. '.tr,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff423E5E),
                    )),
              ),
              20.spaceY,
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text(
                      'I need',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Text color
                      ),
                    ),
                  ),
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: SizedBox(
                          height: 56,
                          child: CommonTextField(
                            keyboardType: TextInputType.number,
                            hintText: 'Time',
                            controller: timeControllerPreparation,
                          ),
                        ),
                      )
                  ),
                  6.spaceX,
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: selectedItemDay,
                      isDense: true,
                      isExpanded: true,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedItemDay = newValue!;
                        });
                      },
                      items: <String>['min', 'hours']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: const Color(0xffE2E2E2).withOpacity(.35),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10).copyWith(right: 8),
                        focusedErrorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: AppTheme.secondaryColor)),
                        errorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Color(0xffE2E2E2))),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: AppTheme.secondaryColor)),
                        disabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: AppTheme.secondaryColor),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: AppTheme.secondaryColor),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select an item';
                        }
                        return null;
                      },
                    ),
                  ),
                  6.spaceX,
                  const Expanded(
                    child: Text(
                      'to prepare.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Text color
                      ),
                    ),
                  ),
                ],
              ),
              20.spaceY,
              Text('Recovery Block Time'.tr,
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff423E5E),
                  )),
              5.spaceY,
              Container(
                padding: const EdgeInsets.all(9),
                width: Get.width,
                decoration: BoxDecoration(
                    color: const Color(0xFFF9F9F9),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xFFE3E3E3),
                    )
                ),
                child: Text('This time you need to rest or organize for the next available.EXP. Recovery time set for 15 minutes. If your service is blocked from 1000 till 1030, customer will be able to book the 1045 for the slot earlier.'.tr,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff423E5E),
                    )),
              ),
              20.spaceY,
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text(
                      'I need',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Text color
                      ),
                    ),
                  ),
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: SizedBox(
                          height: 56,
                          child: CommonTextField(
                            keyboardType: TextInputType.number,
                            hintText: 'Time',
                            controller: timeControllerRecovery,
                          ),
                        ),
                      )
                  ),
                  6.spaceX,
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: selectedItemDay,
                      isDense: true,
                      isExpanded: true,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedItemDay = newValue!;
                        });
                      },
                      items: <String>['min', 'hours']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: const Color(0xffE2E2E2).withOpacity(.35),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10).copyWith(right: 8),
                        focusedErrorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: AppTheme.secondaryColor)),
                        errorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Color(0xffE2E2E2))),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: AppTheme.secondaryColor)),
                        disabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: AppTheme.secondaryColor),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: AppTheme.secondaryColor),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select an item';
                        }
                        return null;
                      },
                    ),
                  ),
                  6.spaceX,
                  const Expanded(
                    child: Text(
                      'to organize.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Text color
                      ),
                    ),
                  ),
                ],
              ),
              20.spaceY,
              Text('Your slot will be divided into 45 and customer will see 30 minuets slot '.tr,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff423E5E),
                  )),
              30.spaceY,
              Align(
                alignment: Alignment.bottomRight,
                child:  InkWell(
                  onTap: (){
                    createSlots();
                  },
                  child: Container(
                    width: 140,
                    decoration: BoxDecoration(
                      color: AppTheme.buttonColor,
                      borderRadius: BorderRadius.circular(2), // Border radius
                    ),
                    padding: const EdgeInsets.all(10), // Padding inside the container
                    child: const Center(
                      child: Text(
                        'Create Slots',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Text color
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              40.spaceY,
              Text('Preview'.tr,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff423E5E),
                  )),
              40.spaceY,
              InkWell(
                onTap: (){
                  // updateProfile();
                  Get.to(()=>const OptionalDetailsScreen());
                },
                child: Container(
                  width: Get.width,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xffF5F2F2),
                    borderRadius: BorderRadius.circular(2), // Border radius
                  ),
                  padding: const EdgeInsets.all(10), // Padding inside the container
                  child: const Center(
                    child: Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff514949), // Text color
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: (){
                  Get.to(()=>const OptionalDetailsScreen());
                },
                child: Container(
                  width: Get.width,
                  height: 70,
                  decoration: BoxDecoration(
                    color: AppTheme.buttonColor,
                    borderRadius: BorderRadius.circular(2), // Border radius
                  ),
                  padding: const EdgeInsets.all(10), // Padding inside the container
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Skip',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Text color
                        ),
                      ),
                      Text(
                        'Product will show call for availability',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: Colors.white, // Text color
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
