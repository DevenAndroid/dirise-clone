import 'package:dirise/addNewProduct/rewardScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/common_button.dart';
import '../widgets/common_colour.dart';
import 'congratulationScreen.dart';

class JobReviewPublishScreen extends StatefulWidget {
  String? jobcat;
  String? jobtype;
  String? jobmodel;
  String? jobdesc;
  String? linkedIN;
  String? experince;
  String? salery;

  JobReviewPublishScreen({super.key,this.jobcat,this.salery,this.experince,this.linkedIN,this.jobdesc,this.jobmodel,this.jobtype});

  @override
  State<JobReviewPublishScreen> createState() => _JobReviewPublishScreenState();
}

class _JobReviewPublishScreenState extends State<JobReviewPublishScreen> {
  bool isItemDetailsVisible = false;
  bool isItemDetailsVisible1 = false;

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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text('Skip',style: GoogleFonts.poppins(color: Color(0xff0D5877),fontWeight: FontWeight.w400,fontSize: 18),),
          )
        ],
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Review & Publish'.tr,
              style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 15,right: 15),
          child: Column(
            children: [
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  isItemDetailsVisible = !isItemDetailsVisible;
                  setState(() {});
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade400, width: 1)),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Job Details'), Icon(Icons.arrow_drop_down_sharp)],
                  ),
                ),
              ),

              Visibility(
                  visible: isItemDetailsVisible,
                  child:Container(
                    margin: EdgeInsets.only(top: 10),
                    width: Get.width,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(11)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('product name: ${widget.jobcat.toString()}'),
                        Text('product Price: ${widget.jobtype.toString()}'),
                        Text('product Type: ${widget.jobmodel.toString()}'),
                        Text('product ID: ${widget.experince.toString()}'),
                        Text('Salary: ${widget.salery.toString()}'),
                        Text('linkedIN: ${widget.linkedIN.toString()}'),
                        Text('Experience: ${widget.experince.toString()}'),

                      ],
                    ),
                  )


              ),

              const SizedBox(height: 20),
              GestureDetector(
                onTap: (){
                  isItemDetailsVisible1 = !isItemDetailsVisible1;
                  setState(() {});
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade400, width: 1)),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Tell us about yourself'), Icon(Icons.arrow_drop_down_sharp)],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Visibility(
                  visible: isItemDetailsVisible1,
                  child:Container(
                    margin: EdgeInsets.only(top: 10),
                    width: Get.width,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(11)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Tell us about yourself: ${widget.jobdesc.toString()}'),


                      ],
                    ),
                  )


              ),
              const SizedBox(height: 10),
              CustomOutlineButton(
                title: 'Confirm',
                borderRadius: 11,
                onPressed: () {
                  Get.to(CongratulationScreen());
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
