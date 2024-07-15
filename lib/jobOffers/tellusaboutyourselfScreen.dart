import 'dart:convert';
import 'dart:io';

import 'package:dirise/addNewProduct/addImagesProductScreen.dart';
import 'package:dirise/iAmHereToSell/whichplantypedescribeyouScreen.dart';
import 'package:dirise/utils/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/profile_controller.dart';
import '../controller/vendor_controllers/add_product_controller.dart';
import '../language/app_strings.dart';
import '../model/common_modal.dart';
import '../newAddress/pickUpAddressScreen.dart';
import '../repository/repository.dart';
import '../utils/api_constant.dart';
import '../widgets/common_button.dart';
import 'hiringJobDetailsScreen.dart';
import 'jobDetailsScreen.dart';

class JobTellusaboutyourselfScreen extends StatefulWidget {
  static String route = "/TellUsAboutYourSelf";
  const JobTellusaboutyourselfScreen({Key? key}) : super(key: key);

  @override
  State<JobTellusaboutyourselfScreen> createState() => _JobTellusaboutyourselfScreenState();
}

class _JobTellusaboutyourselfScreenState extends State<JobTellusaboutyourselfScreen> {
  String selectedRadio = '';
  final addProductController = Get.put(AddProductController());
  void navigateNext() {
    if (selectedRadio == 'job_seeking') {
      Get.to( JobDetailsScreen());
    } else if (selectedRadio == 'job_hiring') {
      Get.to(  HiringJobDetailsScreen());
    }
  }
  jobTypeApi(String jobType) {
    Map<String, dynamic> map = {};
    map['jobseeking_or_offering'] = jobType;
    map['item_type'] = 'job';
    map['id'] = addProductController.idProduct.value.toString();

    final Repositories repositories = Repositories();
    FocusManager.instance.primaryFocus!.unfocus();
    repositories.postApi(url: ApiUrls.giveawayProductAddress, context: context, mapData: map,showResponse: true).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));

      if (response.status == true) {
        // navigateNext();
      }
    });
  }

  final profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: (){
            Get.back();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              profileController.selectedLAnguage.value != 'English' ?
              Image.asset(
                'assets/images/forward_icon.png',
                height: 19,
                width: 19,
              ) :
              Image.asset(
                'assets/images/back_icon_new.png',
                height: 19,
                width: 19,
              ),
            ],
          ),
        ),
        centerTitle: true,
        titleSpacing: 0,
        title: Text(
          'Job Category'.tr,
          style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20,right: 20),
          child: Column(
            children: [
              20.spaceY,
              Text(
                'What desicribes best this job?'.tr,
                style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),
              ),
              30.spaceY,
              GestureDetector(
                  onTap: (){
                    jobTypeApi("job_seeking");
                Get.to( JobDetailsScreen());
                    setState(() {

                    });
                  },
                  child: Image.asset('assets/images/job_seeking.png')),
              20.spaceY,
              GestureDetector(
                  onTap: (){
                    jobTypeApi("job_hiring");
                    Get.to(  HiringJobDetailsScreen());
                    setState(() {

                    });
                  },
                  child: Image.asset('assets/images/job_offer.png')),
              40.spaceY,
              // Stack(
              //   children: [
              //     Container(
              //       height: 250,
              //       margin: const EdgeInsets.only(top: 20,bottom: 20),
              //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(11), color: Colors.grey.shade100),
              //       child: Column(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         crossAxisAlignment: CrossAxisAlignment.center,
              //         children: [
              //
              //           Padding(
              //             padding: const EdgeInsets.only(left: 60, right: 60),
              //             child: Text(
              //               'I want a job'.tr,
              //               style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 36),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //     Positioned(
              //       top: 25,
              //       right: 30,
              //       child: Radio(
              //         value: 'job_seeking',
              //         groupValue: selectedRadio,
              //         onChanged: (value) {
              //           setState(() {
              //             selectedRadio = value.toString();
              //           });
              //         },
              //       ),
              //     ),
              //   ],
              // ),
              // Stack(
              //   children: [
              //     Container(
              //       height: 250,
              //       margin: const EdgeInsets.only(top: 20,bottom: 20),
              //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(11), color: Colors.grey.shade100),
              //       child: Column(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         crossAxisAlignment: CrossAxisAlignment.center,
              //         children: [
              //
              //           Padding(
              //             padding: const EdgeInsets.only(left: 60, right: 60),
              //             child: Text(
              //               'I am hiring'.tr,
              //               style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 36),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //     Positioned(
              //       top: 25,
              //       right: 30,
              //       child: Radio(
              //         value: 'job_hiring',
              //         groupValue: selectedRadio,
              //         onChanged: (value) {
              //           setState(() {
              //             selectedRadio = value.toString();
              //           });
              //         },
              //       ),
              //     ),
              //   ],
              // ),

              // CustomOutlineButton(
              //   title: 'Next',
              //   borderRadius: 11,
              //   onPressed: () {
              //     if (selectedRadio == 'job_seeking') {
              //       jobTypeApi('job_seeking');
              //     } else if (selectedRadio == 'job_hiring') {
              //       jobTypeApi('job_hiring');
              //     }else{
              //       showToast('Select Job Type');
              //     }
              //
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
