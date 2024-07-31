import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/profile_controller.dart';
import '../model/job_single_model.dart';
import '../repository/repository.dart';
import '../utils/api_constant.dart';
import '../widgets/common_button.dart';

class JobDetailsSingleScreen extends StatefulWidget {
  const JobDetailsSingleScreen({super.key});

  @override
  State<JobDetailsSingleScreen> createState() => _JobDetailsSingleScreenState();
}

class _JobDetailsSingleScreenState extends State<JobDetailsSingleScreen> {
  final profileController = Get.put(ProfileController());
  Rx<JobProductModel> getJobModel = JobProductModel().obs;
  final Repositories repositories = Repositories();
  var id = Get.arguments;

  void launchDialer(String phoneNumber) async {
    final Uri url = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  void launchLinkedIn(String profileUrl) async {
    final Uri url = Uri.parse(profileUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  jobTypeApi(id) {
    repositories.getApi(url: ApiUrls.singleJobList + id, ).then((value) {
      getJobModel.value = JobProductModel.fromJson(jsonDecode(value));
      log('dada${getJobModel.value.toJson()}');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jobTypeApi(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.newPrimaryColor,
      appBar: customAppBar(title: "Job Details".tr),

      body: SingleChildScrollView(
        child: Obx(() {
          return  getJobModel.value.singleJobProduct != null
              ? Column(
            children: [
              SizedBox(height: 30,),
              Container(
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30),)
                ),

                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: getJobModel.value.singleJobProduct!.featuredImage.toString(),
                              height: 50,
                              width: 50,
                              fit: BoxFit.contain,
                              errorWidget: (_, __, ___) => Image.asset("assets/images/eoxy.png"),),
                          ),
                  
                          SizedBox(width: 20,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(getJobModel.value.singleJobProduct!.pname.toString(),
                                style: GoogleFonts.poppins(
                                    color: Color(0xFF1F1F1F), fontWeight: FontWeight.w500, fontSize: 15),),
                  
                              Row(
                                children: [
                                  Icon(Icons.location_on_outlined, color: Color(0xFF545454), size: 15,),
                                  Text(getJobModel.value.singleJobProduct!.jobCityId.toString(),
                                    style: GoogleFonts.poppins(
                                        color: Color(0xFF545454), fontWeight: FontWeight.w500, fontSize: 15),),
                                ],
                              ),
                  
                            ],
                          ),
                          // Spacer(),
                          // Icon(Icons.star, color: Color(0xFF545454), size: 15,),
                        ],
                      ),
                  
                      SizedBox(height: 25,),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Color(0xFFE5E9EE),
                              borderRadius: BorderRadius.circular(30),
                  
                            ),
                            child: Text(
                              getJobModel.value.singleJobProduct!.experience.toString(), style: GoogleFonts.poppins(
                                color: Color(0xFF545454), fontWeight: FontWeight.w400, fontSize: 11),),
                  
                  
                          ),
                          SizedBox(width: 20,),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Color(0xFFE5E9EE),
                              borderRadius: BorderRadius.circular(30),
                  
                            ),
                            child: Text(
                              getJobModel.value.singleJobProduct!.jobModel.toString(), style: GoogleFonts.poppins(
                                color: Color(0xFF545454), fontWeight: FontWeight.w400, fontSize: 11),),
                  
                  
                          ),
                          SizedBox(width: 20,),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Color(0xFFE5E9EE),
                              borderRadius: BorderRadius.circular(30),
                  
                            ),
                            child: Text(
                              getJobModel.value.singleJobProduct!.jobType.toString(), style: GoogleFonts.poppins(
                                color: Color(0xFF545454), fontWeight: FontWeight.w400, fontSize: 11),),
                  
                  
                          ),
                          Spacer(),
                          Text(
                            getJobModel.value.singleJobProduct!.salary.toString(), style: GoogleFonts.poppins(
                              color: Color(0xFF014E70), fontWeight: FontWeight.w600, fontSize: 12),),
                  
                  
                        ],
                      ),
                      SizedBox(height: 20,),
                      Divider(
                        color: Colors.grey.shade200,
                        thickness: 1,
                      ),
                      SizedBox(height: 20,),
                  
                      Text("Job Description".tr,
                        style: GoogleFonts.poppins(color: Color(0xFF1F1F1F), fontWeight: FontWeight.w500, fontSize: 14),),
                      SizedBox(height: 20,),
                  
                  
                          SizedBox(
                            height: 35,
                            child: ListView.builder(
                              physics: AlwaysScrollableScrollPhysics(),
                              itemCount: getJobModel.value.singleJobProduct!.jobCat!.length ,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                  
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFE5E9EE),
                                    borderRadius: BorderRadius.circular(30),
                  
                                  ),
                                  child: Text(
                                    getJobModel.value.singleJobProduct!.jobCat![index].title.toString(), style: GoogleFonts.poppins(
                                      color: Color(0xFF545454), fontWeight: FontWeight.w400, fontSize: 11),),
                  
                  
                                );
                              },
                  
                            ),
                          ),
                  
                      SizedBox(height: 20,),
                      InkWell(
                        onTap: (){
                          launchLinkedIn( getJobModel.value.singleJobProduct!.linkdinUrl.toString(),);
                        },
                        child: Text(
                          getJobModel.value.singleJobProduct!.linkdinUrl.toString(),
                          style: GoogleFonts.poppins(color: Color(0xFF014E70), fontWeight: FontWeight.w300, fontSize: 13,decoration: TextDecoration.underline),),
                      ),
                      SizedBox(height: 20,),
                      Text(
                     getJobModel.value.singleJobProduct!.describeJobRole.toString(),
                        style: GoogleFonts.poppins(color: Color(0xFF545454), fontWeight: FontWeight.w300, fontSize: 13),),
                      SizedBox(height: 20,),
                      Divider(
                        color: Colors.grey.shade200,
                        thickness: 1,
                      ),
                      SizedBox(height: 20,),
                      Center(
                        child: Container(
                         padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(1,1),
                                color: Colors.grey,
                                blurRadius: 2
                              )
                            ],
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  Text(
                                    getJobModel.value.singleJobProduct!.storeName.toString(),
                                    style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),),
                                  Spacer(),
                  
                                  InkWell(
                                      onTap: (){
                                        launchDialer(       getJobModel.value.singleJobProduct!.storePhone.toString(),);
                                      },
                                      child: SvgPicture.asset("assets/svgs/telephone.svg")),
                                  SizedBox(width: 12,),
                                  InkWell(
                                      onTap: (){
                                        launchLinkedIn( getJobModel.value.singleJobProduct!.storeLinkedIn.toString(),);
                                      },
                                      child: SvgPicture.asset("assets/svgs/linkin.svg")),
                                ],
                              ),
                              if(getJobModel.value.singleJobProduct!.stoerAddress != null)
                              Text(
                                "${getJobModel.value.singleJobProduct!.stoerAddress!.city.toString()} ,"+   " ${getJobModel.value.singleJobProduct!.stoerAddress!.state.toString()}",
                                style: GoogleFonts.poppins(color: Color(0xFF545454), fontWeight: FontWeight.w400, fontSize: 12),),
                              SizedBox(height: 10,),
                            ],
                          ),
                  
                        ),
                      ),
                      SizedBox(height: 30,)
                    ],
                  ),
                ),
              )
            ],
          ):Center(child: CircularProgressIndicator());
        }),
      ),
    );
  }

  AppBar customAppBar({required String title}) {
    return AppBar(
      backgroundColor: AppTheme.newPrimaryColor,
      surfaceTintColor: Colors.white,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
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
      titleSpacing: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title.tr,
            style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 22),
          ),
        ],
      ),
    );
  }
}
