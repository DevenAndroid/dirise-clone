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
  final Repositories repositories = Repositories();

  final addProductController = Get.put(AddProductController());
  Rx<ModelProductDetails> productDetailsModel = ModelProductDetails().obs;
  Rx<RxStatus> vendorCategoryStatus = RxStatus.empty().obs;

  getVendorCategories(id) {
    // vendorCategoryStatus.value = RxStatus.loading();
    print('callllllll......');
    repositories.getApi(url: ApiUrls.getProductDetailsUrl + id).then((value) {
      productDetailsModel.value = ModelProductDetails.fromJson(jsonDecode(value));
      // vendorCategoryStatus.value = RxStatus.success();
      log('callllllll......${productDetailsModel.value.toJson()}');
      setState(() {});
    });
  }
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
    getVendorCategories(addProductController.idProduct.value.toString());
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
    return productDetailsModel.value.productDetails != null
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
                        'Features Image',
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
                          Image.network(productDetailsModel.value.productDetails!.product!.featuredImage,height: 200,)
                        ],
                      ),
                    ),
                    Positioned(
                        right: 10,
                        top: 20,
                        child: GestureDetector(
                            onTap: () {
                              File imageFile = File(productDetailsModel.value.productDetails!.product!.featuredImage);
                              File gallery = File(productDetailsModel.value.productDetails!.product!.galleryImage![0]);

                              Get.to(AddProductFirstImageScreen(
                                id: productDetailsModel.value.productDetails!.product!.id,
                                image: imageFile,
                                galleryImg: gallery,
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
                            Text('Job title: ${productDetailsModel.value.productDetails!.product!.pname ?? ""}'),
                            Text('Job Category: ${productDetailsModel.value.productDetails!.product!.jobParentCat ?? ""}'),
                            Text('Job Category: ${productDetailsModel.value.productDetails!.product!.jobCat ?? ""}'),
                            Text('Job Country: ${productDetailsModel.value.productDetails!.product!.jobCountry ?? ""}'),
                            Text('Job State: ${productDetailsModel.value.productDetails!.product!.jobState ?? ""}'),
                            Text('Job City: ${productDetailsModel.value.productDetails!.product!.jobCity ?? ""}'),
                            Text('product Price: ${productDetailsModel.value.productDetails!.product!.pPrice ?? ""}'),
                            Text('product Type: ${productDetailsModel.value.productDetails!.product!.productType ?? ""}'),
                            Text('product ID: ${productDetailsModel.value.productDetails!.product!.id ?? ""}'),
                            Text('Salary: ${productDetailsModel.value.productDetails!.product!.salary ?? ""}'),
                            Text('linkedIN : ${productDetailsModel.value.productDetails!.product!.linkdinUrl ?? ""}'),
                            Text('Experience : ${productDetailsModel.value.productDetails!.product!.experience ?? ""}'),
                            Text('Hours Per Week :${productDetailsModel.value.productDetails!.product!.jobHours ?? ""}'),

                          ],
                        ),
                      ),
                      Positioned(
                          right: 10,
                          top: 20,
                          child: GestureDetector(
                              onTap: (){
                                Get.to(HiringJobDetailsScreen(
                                  id: productDetailsModel.value.productDetails!.product!.id,
                                  experience: productDetailsModel.value.productDetails!.product!.experience,
                                  countryId: productDetailsModel.value.productDetails!.product!.jobCountryId.toString(),
                                  jobCategory: productDetailsModel.value.productDetails!.product!.jobParentCat,
                                  jobCity: productDetailsModel.value.productDetails!.product!.jobCity,
                                  jobCountry: productDetailsModel.value.productDetails!.product!.jobCountry.toString(),
                                  jobModel:productDetailsModel.value.productDetails!.product!.jobModel ,
                                  jobState: productDetailsModel.value.productDetails!.product!.jobState,
                                  jobSubCategory: productDetailsModel.value.productDetails!.product!.jobCat,
                                  jobTitle: productDetailsModel.value.productDetails!.product!.pname,
                                  jobType: productDetailsModel.value.productDetails!.product!.jobType,
                                  linkedIn: productDetailsModel.value.productDetails!.product!.linkdinUrl,
                                  salary:productDetailsModel.value.productDetails!.product!.salary ,
                                  tellUsAboutYourSelf: productDetailsModel.value.productDetails!.product!.describeJobRole,
                                  hoursPerWeek: productDetailsModel.value.productDetails!.product!.jobHours,

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
                        Text('Tell us about yourself: ${productDetailsModel.value.productDetails!.product!.describeJobRole}'),


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
