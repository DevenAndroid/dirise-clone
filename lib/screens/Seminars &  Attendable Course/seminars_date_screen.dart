import 'dart:convert';
import 'dart:developer';
import 'dart:math';
import 'package:dirise/screens/Consultation%20Sessions/set_store_time.dart';
import 'package:dirise/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../controller/vendor_controllers/add_product_controller.dart';
import '../../model/jobResponceModel.dart';
import '../../repository/repository.dart';
import '../../utils/api_constant.dart';
import '../../widgets/common_colour.dart';
import 'optinal_detail_seminars.dart';


class DateRangeSeminarsScreen extends StatefulWidget {
  const DateRangeSeminarsScreen({super.key});

  @override
  State<DateRangeSeminarsScreen> createState() => _DateRangeSeminarsScreenState();
}

class _DateRangeSeminarsScreenState extends State<DateRangeSeminarsScreen> {
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  final addProductController = Get.put(AddProductController());
  String? formattedStartDate1;
  RxBool isServiceProvide = false.obs;
  bool sundaySelected = false;
  bool mondaySelected = false;
  bool tueSelected = false;
  bool wedSelected = false;
  bool thurSelected = false;
  bool friSelected = false;
  bool satSelected = false;
  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _startDate) {
      setState(() {
        _startDate = picked;
        addProductController.formattedStartDate = DateFormat('yyyy/MM/dd').format(_startDate);
        print('Now Select........${addProductController.formattedStartDate.toString()}');
      });
    }
  }
  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _endDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _endDate) {
      setState(() {
        _endDate = picked;
        formattedStartDate1 = DateFormat('yyyy/MM/dd').format(_endDate);
        print('Now Select........${formattedStartDate1.toString()}');
      });
    }
  }

  final Repositories repositories = Repositories();
  int index = 0;
  void updateProfile() {
    Map<String, dynamic> map = {};

    map["product_type"] = "booking";
    map["id"] =  addProductController.idProduct.value.toString();
    map["from_date"] = addProductController.formattedStartDate.toString();
    map["to_date"] = formattedStartDate1.toString();

    repositories.postApi(url: ApiUrls.giveawayProductAddress, context: context, mapData: map).then((value) {
      print('object${value.toString()}');
      JobResponceModel response = JobResponceModel.fromJson(jsonDecode(value));
      if (response.status == true) {
        showToast(response.message.toString());
        Get.to(()=> const OptionalDetailsSeminarScreen());
        print('value isssss${response.toJson()}');
      }else{
        showToast(response.message.toString());
      }
    });
  }
  @override
  void initState() {
    super.initState();
    addProductController.startDate.text  = '';
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
              'Date'.tr,
              style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Dates range',
                style:GoogleFonts.poppins(fontSize:19,fontWeight:FontWeight.w600)),
            15.spaceY,
            Text('The start date and end date which this service offered',
                style:GoogleFonts.poppins(fontSize:15,fontWeight:FontWeight.w400)),
            40.spaceY,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Start Date: ${addProductController.formattedStartDate ?? ''}',
                        style:const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500
                        ),),
                      10.spaceY,
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith((states) => const Color(0xff014E70))
                        ),
                        onPressed: () => _selectStartDate(context),
                        child: const Text('Select Start Date',style: TextStyle(color: Colors.white),),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('End Date: ${formattedStartDate1 ?? ''}',
                        style:const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500
                        ),),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith((states) => const Color(0xff014E70))
                        ),
                        onPressed: () => _selectEndDate(context),
                        child: const Text('Select End Date',style: TextStyle(color: Colors.white),),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 40),
            Text('Off Days',
                style:GoogleFonts.poppins(fontSize:19,fontWeight:FontWeight.w600)),
            15.spaceY,
            Text('Days which service is not offered, like weekends',
                style:GoogleFonts.poppins(fontSize:15,fontWeight:FontWeight.w400)),
            10.spaceY,
            Row(
              children: [
                Column(
                  children: [
                    Checkbox(
                      value: mondaySelected,
                      onChanged: (value) {
                        setState(() {
                          mondaySelected = value!;
                        });
                      },
                    ),
                    const Text('Mun',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF9C9CB4)
                      ),),
                  ],
                ),
                Column(
                  children: [
                    Checkbox(
                      value: tueSelected,
                      onChanged: (value) {
                        setState(() {
                          tueSelected = value!;
                        });
                      },
                    ),
                    const Text('Tue',style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF9C9CB4)
                    ),),
                  ],
                ),
                Column(
                  children: [
                    Checkbox(
                      value: wedSelected,
                      onChanged: (value) {
                        setState(() {
                          wedSelected = value!;
                        });
                      },
                    ),
                    const Text('Wed',style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF9C9CB4)
                    ),),
                  ],
                ),
                Column(
                  children: [
                    Checkbox(
                      value: thurSelected,
                      onChanged: (value) {
                        setState(() {
                          thurSelected = value!;
                        });
                      },
                    ),
                    const Text('Thu',style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF9C9CB4)
                    ),),
                  ],
                ),
                Column(
                  children: [
                    Checkbox(
                      value: friSelected,
                      onChanged: (value) {
                        setState(() {
                          friSelected = value!;
                        });
                      },
                    ),
                    const Text('Fri',style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF9C9CB4)
                    ),),
                  ],
                ),
                Column(
                  children: [
                    Checkbox(
                      value: satSelected,
                      onChanged: (value) {
                        setState(() {
                          satSelected = value!;
                        });
                      },
                    ),
                    const Text('Sat',style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF9C9CB4)
                    ),),
                  ],
                ),
                Column(
                  children: [
                    Checkbox(
                      value: sundaySelected,
                      onChanged: (value) {
                        setState(() {
                          sundaySelected = value!;
                        });
                      },
                    ),
                    const Text('Sun',style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF9C9CB4)
                    ),),
                  ],
                ),
              ],
            ),
            40.spaceY,
            const SizedBox(height: 40),
            20.spaceY,
            InkWell(
              onTap: (){
                // updateProfile();
                updateProfile();
                // Get.to(()=> const SetTimeScreenConsultation());
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
                // updateProfile();
                Get.to(()=> const OptionalDetailsSeminarScreen());
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
    );
  }
}
