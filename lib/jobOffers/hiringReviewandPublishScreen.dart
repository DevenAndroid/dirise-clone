import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dirise/addNewProduct/rewardScreen.dart';
import 'package:dirise/utils/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../addNewProduct/addProductFirstImageScreen.dart';
import '../controller/profile_controller.dart';
import '../controller/vendor_controllers/add_product_controller.dart';
import '../model/common_modal.dart';
import '../model/product_details.dart';
import '../repository/repository.dart';
import '../utils/api_constant.dart';
import '../widgets/common_button.dart';
import '../widgets/common_colour.dart';
import 'congratulationScreen.dart';
import 'hiringJobDetailsScreen.dart';

class HiringReviewPublishScreen extends StatefulWidget {
  String? jobcat;
  String? jobtype;
  String? jobmodel;
  String? jobdesc;
  String? linkedIN;
  String? experince;
  String? salery;
  String? category;
  String? subCategory;

  HiringReviewPublishScreen({super.key,this.category,this.subCategory,this.jobcat,this.salery,this.experince,this.linkedIN,this.jobdesc,this.jobmodel,this.jobtype});

  @override
  State<HiringReviewPublishScreen> createState() => _HiringReviewPublishScreenState();
}

class _HiringReviewPublishScreenState extends State<HiringReviewPublishScreen> {
  bool isItemDetailsVisible = false;
  bool isItemDetailsVisible1 = false;
  RxBool isImageProvide = false.obs;
  final addProductControllerNew = Get.put(ProfileController());
  RxBool isOtherImageProvide = false.obs;
  final Repositories repositories = Repositories();
  final addProductController = Get.put(AddProductController());
  Rx<RxStatus> vendorCategoryStatus = RxStatus.empty().obs;
  completeApi() {
    Map<String, dynamic> map = {};

    map['is_complete'] = true;
    map['id'] = addProductController.idProduct.value.toString();
    FocusManager.instance.primaryFocus!.unfocus();
    repositories.postApi(url: ApiUrls.giveawayProductAddress, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      print('API Response Status Code: ${response.status}');
      showToast(response.message.toString());
      if (response.status == true) {
        Get.to(CongratulationScreen());
      }});}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addProductControllerNew.getVendorCategories(addProductController.idProduct.value.toString());
  }
  final profileController = Get.put(ProfileController());
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
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 10),
        //     child: Text('Skip',style: GoogleFonts.poppins(color: Color(0xff0D5877),fontWeight: FontWeight.w400,fontSize: 18),),
        //   )
        // ],
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
          child: Obx(() {
    return addProductControllerNew.productDetailsModel.value.productDetails != null
    ?
          Column(
            children: [
              const SizedBox(height: 20),

              GestureDetector(
                onTap: () {
                  setState(() {
                    isImageProvide.toggle();
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppTheme.secondaryColor)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Featured Image',
                        style: GoogleFonts.poppins(
                          color: AppTheme.primaryColor,
                          fontSize: 15,
                        ),
                      ),
                      GestureDetector(
                        child: isImageProvide.value != true
                            ?  Image.asset(
                          'assets/images/drop_icon.png',
                          height: 17,
                          width: 17,
                        )
                            : Image.asset(
                          'assets/images/up_icon.png',
                          height: 17,
                          width: 17,
                        ),
                        onTap: () {
                          setState(() {
                            isImageProvide.toggle();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),

              if (isImageProvide.value == true)
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      width: Get.width,
                      padding: EdgeInsets.all(10),
                      decoration:
                      BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(11)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(addProductControllerNew.productDetailsModel.value.productDetails!.product!.featuredImage,height: 200,)
                        ],
                      ),
                    ),
                    Positioned(
                        right: 10,
                        top: 20,
                        child: GestureDetector(
                            onTap: () {
                              File imageFile = File(addProductControllerNew.productDetailsModel.value.productDetails!.product!.featuredImage);
                              // File gallery = File(productDetailsModel.value.productDetails!.product!.galleryImage![0]);

                              Get.to(AddProductFirstImageScreen(
                                id: addProductControllerNew.productDetailsModel.value.productDetails!.product!.id,
                                image: imageFile,
                                // galleryImg: gallery,
                              ));
                            },
                            child: const Text(
                              'Edit',
                              style: TextStyle(color: Colors.red, fontSize: 13),
                            )))
                  ],
                ),

              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isOtherImageProvide.toggle();
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppTheme.secondaryColor)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Other Image',
                        style: GoogleFonts.poppins(
                          color: AppTheme.primaryColor,
                          fontSize: 15,
                        ),
                      ),
                      GestureDetector(
                        child: isImageProvide.value != true
                            ? Image.asset(
                          'assets/images/drop_icon.png',
                          height: 17,
                          width: 17,
                        )
                            : Image.asset(
                          'assets/images/up_icon.png',
                          height: 17,
                          width: 17,
                        ),
                        onTap: () {
                          setState(() {
                            isOtherImageProvide.toggle();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),

              if (isOtherImageProvide.value == true)
                Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: Get.width,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: addProductControllerNew.productDetailsModel.value.productDetails != null &&
                          addProductControllerNew.productDetailsModel.value.productDetails!.product != null &&
                          addProductControllerNew.productDetailsModel.value.productDetails!.product!.galleryImage != null &&
                          addProductControllerNew.productDetailsModel.value.productDetails!.product!.galleryImage!.isNotEmpty
                          ? GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(), // Prevent scrolling in the grid
                        itemCount: addProductControllerNew.productDetailsModel.value.productDetails!.product!.galleryImage!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // 2 images per row
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1, // Adjust aspect ratio as needed
                        ),
                        itemBuilder: (context, index) {
                          String imageUrl = addProductControllerNew.productDetailsModel.value.productDetails!.product!.galleryImage![index];
                          return Image.network(
                            imageUrl,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          );
                        },
                      )
                          : const Text('No images available'),
                    ),
                    Positioned(
                      right: 10,
                      top: 20,
                      child: GestureDetector(
                        onTap: () {
                          if (addProductControllerNew.productDetailsModel.value.productDetails != null &&
                              addProductControllerNew.productDetailsModel.value.productDetails!.product != null &&
                              addProductControllerNew.productDetailsModel.value.productDetails!.product!.galleryImage != null &&
                              addProductControllerNew.productDetailsModel.value.productDetails!.product!.galleryImage!.isNotEmpty) {
                            // Assuming you want to edit the first image for simplicity
                            File imageFile = File(addProductControllerNew.productDetailsModel.value.productDetails!.product!.galleryImage![0]);
                            Get.to(AddProductFirstImageScreen(
                              id: addProductControllerNew.productDetailsModel.value.productDetails!.product!.id,
                              image: imageFile,
                            ));
                          }
                        },
                        child: const Text(
                          'Edit',
                          style: TextStyle(color: Colors.red, fontSize: 13),
                        ),
                      ),
                    ),
                  ],
                ),
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
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Job Details'),
                      isItemDetailsVisible != true
                      ? Image.asset(
                        'assets/images/drop_icon.png',
                        height: 17,
                        width: 17,
                      )
                          : Image.asset(
                        'assets/images/up_icon.png',
                        height: 17,
                        width: 17,
                      ),
                    ],
                  ),
                ),
              ),

              Visibility(
                  visible: isItemDetailsVisible,
                  child:Stack(
                    children: [
                      Container(
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
                            20.spaceY,
                            Text('Job title: ${addProductControllerNew.productDetailsModel.value.productDetails!.product!.pname ?? ""}'),
                            Text('Job Category: ${addProductControllerNew.productDetailsModel.value.productDetails!.product!.jobParentCat ?? ""}'),
                            Text('Job Category: ${addProductControllerNew.productDetailsModel.value.productDetails!.product!.jobCat ?? ""}'),
                            Text('Job Country: ${addProductControllerNew.productDetailsModel.value.productDetails!.product!.jobCountryName ?? ""}'),
                            Text('Job State: ${addProductControllerNew.productDetailsModel.value.productDetails!.product!.jobStateName ?? ""}'),
                            Text('Job City: ${addProductControllerNew.productDetailsModel.value.productDetails!.product!.jobCityName ?? ""}'),
                            Text('product Price: ${addProductControllerNew.productDetailsModel.value.productDetails!.product!.pPrice ?? ""}'),
                            Text('product Type: ${addProductControllerNew.productDetailsModel.value.productDetails!.product!.productType ?? ""}'),
                            Text('product ID: ${addProductControllerNew.productDetailsModel.value.productDetails!.product!.id ?? ""}'),
                            Text('Salary: ${addProductControllerNew.productDetailsModel.value.productDetails!.product!.salary ?? ""}'),
                            Text('linkedIN : ${addProductControllerNew.productDetailsModel.value.productDetails!.product!.linkdinUrl ?? ""}'),
                            Text('Experience : ${addProductControllerNew.productDetailsModel.value.productDetails!.product!.experience ?? ""}'),
                            Text('Hours Per Week :${addProductControllerNew.productDetailsModel.value.productDetails!.product!.jobHours ?? ""}'),

                          ],
                        ),
                      ),
                      Positioned(
                          right: 10,
                          top: 20,
                          child: GestureDetector(
                              onTap: (){
                                Get.to(HiringJobDetailsScreen(
                                  id: addProductControllerNew.productDetailsModel.value.productDetails!.product!.id,
                                  jobCatIds: addProductControllerNew.productDetailsModel.value.productDetails!.product!.jobCategory!= null ? addProductControllerNew.productDetailsModel.value.productDetails!.product!.jobCategory!.id : '',
                                  experience: addProductControllerNew.productDetailsModel.value.productDetails!.product!.experience,
                                  catName: addProductControllerNew.productDetailsModel.value.productDetails!.product!.jobCat,
                                  countryId: addProductControllerNew.productDetailsModel.value.productDetails!.product!.jobCountryId.toString(),
                                  stateId: addProductControllerNew.productDetailsModel.value.productDetails!.product!.jobStateId.toString(),
                                  cityId: addProductControllerNew.productDetailsModel.value.productDetails!.product!.jobCityId.toString(),
                                  jobCategory: addProductControllerNew.productDetailsModel.value.productDetails!.product!.jobParentCat,
                                  jobCity: addProductControllerNew.productDetailsModel.value.productDetails!.product!.jobCityName.toString(),
                                  jobCountry: addProductControllerNew.productDetailsModel.value.productDetails!.product!.jobCountryName.toString(),
                                  jobModel:addProductControllerNew.productDetailsModel.value.productDetails!.product!.jobModel ,
                                  jobState: addProductControllerNew.productDetailsModel.value.productDetails!.product!.jobStateName.toString(),
                                  jobSubCategory: addProductControllerNew.productDetailsModel.value.productDetails!.product!.jobCat,
                                  jobTitle: addProductControllerNew.productDetailsModel.value.productDetails!.product!.pname,
                                  jobType: addProductControllerNew.productDetailsModel.value.productDetails!.product!.jobType,
                                  linkedIn: addProductControllerNew.productDetailsModel.value.productDetails!.product!.linkdinUrl,
                                  salary:addProductControllerNew.productDetailsModel.value.productDetails!.product!.salary ,
                                  tellUsAboutYourSelf: addProductControllerNew.productDetailsModel.value.productDetails!.product!.describeJobRole,
                                  hoursPerWeek: addProductControllerNew.productDetailsModel.value.productDetails!.product!.jobHours,

                                ));
                              },
                              child: const Text('Edit',style: TextStyle(color: Colors.red,fontSize: 13),)))
                    ],
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
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [const Text('Tell us about yourself'),
                      isItemDetailsVisible1 != true
                          ? Image.asset(
                        'assets/images/drop_icon.png',
                        height: 17,
                        width: 17,
                      )
                          : Image.asset(
                        'assets/images/up_icon.png',
                        height: 17,
                        width: 17,
                      ),
                    ],
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
                        20.spaceY,
                        Text('Tell us about yourself: ${addProductControllerNew.productDetailsModel.value.productDetails!.product!.describeJobRole}'),


                      ],
                    ),
                  )


              ),
              const SizedBox(height: 10),
              CustomOutlineButton(
                title: 'Confirm',
                borderRadius: 11,
                onPressed: () {
                  completeApi();

                },
              ),

            ],
          ) : Center(
            child: CircularProgressIndicator(
            color: Colors.grey,
            ));
          })
        ),
      ),
    );
  }
}
