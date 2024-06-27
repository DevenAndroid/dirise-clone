import 'dart:convert';
import 'package:dirise/screens/Seminars%20&%20%20Attendable%20Course/seminars_sponsors_screen.dart';
import 'package:dirise/screens/Seminars%20&%20%20Attendable%20Course/webinarScreen.dart';
import 'package:dirise/screens/tour_travel/dateRangemodel.dart';
import 'package:dirise/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../controller/profile_controller.dart';
import '../../controller/vendor_controllers/add_product_controller.dart';
import '../../model/jobResponceModel.dart';
import '../../repository/repository.dart';
import '../../utils/api_constant.dart';
import '../../widgets/common_colour.dart';
import 'optional_details_academic.dart';


class DateRangeSeminarsScreen extends StatefulWidget {
  int? id;
  String? from_date;
  String? to_date;


  DateRangeSeminarsScreen(
      {super.key,
        this.id,
        this.from_date,
        this.to_date,
      });


  @override
  State<DateRangeSeminarsScreen> createState() => _DateRangeSeminarsScreenState();
}

class _DateRangeSeminarsScreenState extends State<DateRangeSeminarsScreen> {
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  final addProductController = Get.put(AddProductController());
  String? formattedStartDate1;
  bool sundaySelected = false;
  bool mondaySelected = false;
  bool tueSelected = false;
  bool wedSelected = false;
  bool thurSelected = false;
  bool friSelected = false;
  bool satSelected = false;
  final profileController = Get.put(ProfileController());
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
    map["off_days"] = offDaysSelected;
    map['booking_product_type'] = 'webinar';


    repositories.postApi(url: ApiUrls.giveawayProductAddress, context: context, mapData: map).then((value) {
      print('object${value.toString()}');
      DateRangeInTravelModel response = DateRangeInTravelModel.fromJson(jsonDecode(value));
      if (response.status == true) {
        showToast(response.message.toString());
        profileController.productAvailabilityId = response.productDetails!.productAvailabilityId!.id!;
        // Get.to(WebinarScreen());
         Get.to(()=> WebinarScreen());
        print('value isssss${response.toJson()}');
      }else{
        showToast(response.message.toString());
      }
    });
  }
  List<bool> offDaysSelected = [false, false, false, false, false, false, false];

  @override
  void initState() {
    super.initState();
    addProductController.startDate.text  = '';
    if (widget.id != null) {
      addProductController.formattedStartDate = widget.from_date;
      formattedStartDate1 = widget.to_date;
    }
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/back_icon_new.png',
                height: 19,
                width: 19,
              ),
            ],
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

                dayCheckBox('Mon', 1),
                dayCheckBox('Tue', 2),
                dayCheckBox('Wed', 3),
                dayCheckBox('Thu', 4),
                dayCheckBox('Fri', 5),
                dayCheckBox('Sat', 6),
                dayCheckBox('Sun', 7),

              ],
            ),
            40.spaceY,
            const SizedBox(height: 40),
            20.spaceY,
            InkWell(
              onTap: (){
                updateProfile();
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
                Get.to(()=>  SponsorsSeminarScreen());
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
  Widget dayCheckBox(String label, int index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: offDaysSelected[index - 1],
          onChanged: (bool? value) {
            setState(() {
              offDaysSelected[index - 1] = value!;
            });
          },
        ),
        Text(label),
      ],
    );
  }

}
