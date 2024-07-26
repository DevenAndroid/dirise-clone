import 'dart:convert';
import 'package:dirise/utils/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../addNewProduct/addProductStartScreen.dart';
import '../../controller/profile_controller.dart';
import '../auth_screens/login_screen.dart';
import '../get_hire_job.dart';
import 'get_look_job.dart';


class GetJobTypeScreen extends StatefulWidget {
  static String route = "/TellUsAboutYourSelf";
  const GetJobTypeScreen({Key? key}) : super(key: key);

  @override
  State<GetJobTypeScreen> createState() => _GetJobTypeScreenState();
}

class _GetJobTypeScreenState extends State<GetJobTypeScreen> {
  String selectedRadio = '';
  final profileController = Get.put(ProfileController());
  // jobTypeApi(String jobType) {
  //   Map<String, dynamic> map = {};
  //   map['jobseeking_or_offering'] = jobType;
  //   map['item_type'] = 'job';
  //   map['id'] = addProductController.idProduct.value.toString();
  //
  //   final Repositories repositories = Repositories();
  //   FocusManager.instance.primaryFocus!.unfocus();
  //   repositories.postApi(url: ApiUrls.giveawayProductAddress, context: context, mapData: map).then((value) {
  //     ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
  //
  //     if (response.status == true) {
  //       navigateNext();
  //     }
  //   });
  // }

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
          margin: const EdgeInsets.only(left: 20,right: 20),
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
                    Get.to(()=> const GetLookJob());
                    setState(() {

                    });
                  },
                  child:  profileController.selectedLAnguage.value == 'English' ?
                  Image.asset('assets/images/job_seeking.png'):Image.asset('assets/images/job_seeking_arab.png')),
              20.spaceY,
              GestureDetector(
                  onTap: (){
                    // if (  profileController.userLoggedIn == true) {
                    //   Get.to(const GetHireJob());
                    // } else {
                    //   Get.to(const LoginScreen());
                    // }
                    Get.to(const GetHireJob()); 
                    setState(() {

                    });
                  },
                  child: profileController.selectedLAnguage.value == 'English' ?
                  Image.asset('assets/images/job_offer.png'):
                  Image.asset('assets/images/job_offer_arab.png')),
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
