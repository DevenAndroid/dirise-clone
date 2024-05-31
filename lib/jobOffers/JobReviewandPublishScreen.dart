import 'dart:convert';
import 'package:dirise/widgets/loading_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/vendor_controllers/add_product_controller.dart';
import '../model/product_details.dart';
import '../repository/repository.dart';
import '../utils/api_constant.dart';
import '../widgets/common_button.dart';
import 'congratulationScreen.dart';
import 'jobDetailsScreen.dart';

class JobReviewPublishScreen extends StatefulWidget {
  String? category;
  String? subCategory;

  JobReviewPublishScreen({super.key, this.category, this.subCategory});

  @override
  State<JobReviewPublishScreen> createState() => _JobReviewPublishScreenState();
}

class _JobReviewPublishScreenState extends State<JobReviewPublishScreen> {
  bool isItemDetailsVisible = false;
  bool isItemDetailsVisible1 = false;
  final Repositories repositories = Repositories();

  final addProductController = Get.put(AddProductController());
  Rx<ModelProductDetails> productDetailsModel = ModelProductDetails().obs;
  Rx<RxStatus> vendorCategoryStatus = RxStatus.empty().obs;

  getVendorCategories(id) {
    repositories.getApi(url: ApiUrls.getProductDetailsUrl + id).then((value) {
      productDetailsModel.value = ModelProductDetails.fromJson(jsonDecode(value));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVendorCategories(addProductController.idProduct.value.toString());
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
              'Review & Publish'.tr,
              style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            child: Obx(() {
              return productDetailsModel.value.productDetails != null
                  ? Column(
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
                            child: Stack(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  width: Get.width,
                                  padding: const EdgeInsets.all(10),
                                  decoration:
                                  BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(11)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Job title: ${productDetailsModel.value.productDetails!.product!.pname ?? ""}'),
                                      Text('Job Category: ${productDetailsModel.value.productDetails!.product!.jobParentCat ?? ""}'),
                                      Text(
                                          'Job Sub Category: ${productDetailsModel.value.productDetails!.product!.jobCat ?? ""}'),
                                      Text(
                                          'Job Country: ${productDetailsModel.value.productDetails!.product!.jobCountry ?? ""}'),
                                      Text(
                                          'Job State: ${productDetailsModel.value.productDetails!.product!.jobState ?? ""}'),
                                      Text('Job City: ${productDetailsModel.value.productDetails!.product!.jobCity ?? ""}'),
                                      Text('Job Type: ${productDetailsModel.value.productDetails!.product!.jobType ?? ""}'),
                                      Text(
                                          'Job Model: ${productDetailsModel.value.productDetails!.product!.jobModel ?? ""}'),
                                      Text(
                                          'Experience: ${productDetailsModel.value.productDetails!.product!.experience ?? ""}'),
                                      Text('Salary: ${productDetailsModel.value.productDetails!.product!.salary ?? ""}'),
                                      Text('LinkedIn Url: ${productDetailsModel.value.productDetails!.product!.linkdinUrl ?? ""}'),
                                    ],
                                  ),
                                ),
                                Positioned(
                                    right: 10,
                                    top: 20,
                                    child: GestureDetector(
                                        onTap: (){
                                          Get.to(JobDetailsScreen(
                                            id: productDetailsModel.value.productDetails!.product!.id,
                                            experience: productDetailsModel.value.productDetails!.product!.experience,
                                            jobCategory: productDetailsModel.value.productDetails!.product!.jobParentCat,
                                            jobCity: productDetailsModel.value.productDetails!.product!.jobCity,
                                            jobCountry: productDetailsModel.value.productDetails!.product!.jobCountry,
                                            jobModel:productDetailsModel.value.productDetails!.product!.jobModel ,
                                            jobState: productDetailsModel.value.productDetails!.product!.jobState,
                                            jobSubCategory: productDetailsModel.value.productDetails!.product!.jobCat,
                                            jobTitle: productDetailsModel.value.productDetails!.product!.pname,
                                            jobType: productDetailsModel.value.productDetails!.product!.jobType,
                                            linkedIn: productDetailsModel.value.productDetails!.product!.linkdinUrl,
                                            salary:productDetailsModel.value.productDetails!.product!.salary ,
                                            tellUsAboutYourSelf: productDetailsModel.value.productDetails!.product!.describeJobRole,

                                          ));
                                        },
                                        child: const Text('Edit',style: TextStyle(color: Colors.red,fontSize: 13),)))
                              ],

                            )),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
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
                            child: Container(
                              margin: const EdgeInsets.only(top: 10),
                              width: Get.width,
                              padding: const EdgeInsets.all(10),
                              decoration:
                                  BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(11)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'Tell us about yourself: ${productDetailsModel.value.productDetails!.product!.describeJobRole ?? ""}'),
                                ],
                              ),
                            )),
                        const SizedBox(height: 10),
                        CustomOutlineButton(
                          title: 'Confirm',
                          borderRadius: 11,
                          onPressed: () {
                            Get.to(const CongratulationScreen());
                          },
                        ),
                      ],
                    )
                  : const LoadingAnimation();
            })),
      ),
    );
  }
}
