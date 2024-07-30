import 'dart:convert';
import 'dart:io';

import 'package:dirise/addNewProduct/rewardScreen.dart';
import 'package:dirise/controller/vendor_controllers/add_product_controller.dart';
import 'package:dirise/tellaboutself/ExtraInformation.dart';
import 'package:dirise/utils/helper.dart';
import 'package:dirise/virtualProduct/product_information_screen.dart';
import 'package:dirise/virtualProduct/singleProductDiscriptionScreen.dart';
import 'package:dirise/virtualProduct/singleProductPriceScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../addNewProduct/addProductFirstImageScreen.dart';
import '../controller/profile_controller.dart';
import '../controller/service_controller.dart';
import '../model/common_modal.dart';
import '../model/getShippingModel.dart';
import '../model/product_details.dart';
import '../model/returnPolicyModel.dart';
import '../repository/repository.dart';
import '../utils/api_constant.dart';
import '../widgets/common_button.dart';
import '../widgets/common_colour.dart';
import 'optionalClassificationScreen.dart';
import 'optionalDiscrptionsScreen.dart';

class VirtualReviewandPublishScreen extends StatefulWidget {
  const VirtualReviewandPublishScreen({super.key});

  @override
  State<VirtualReviewandPublishScreen> createState() => _VirtualReviewandPublishScreenState();
}

class _VirtualReviewandPublishScreenState extends State<VirtualReviewandPublishScreen> {
  String selectedItem = 'Item 1';
  final serviceController = Get.put(ServiceController());
  final addProductControllerNew = Get.put(ProfileController());
  RxBool isServiceProvide = false.obs;
  RxBool isTellUs = false.obs;
  RxBool isReturnPolicy = false.obs;
  RxBool optionalDescription = false.obs;
  RxBool optionalClassification = false.obs;
  RxBool isDiscrptionPolicy = false.obs;
  RxBool isImageProvide = false.obs;
  final Repositories repositories = Repositories();
  RxInt returnPolicyLoaded = 0.obs;
  RxBool isOtherImageProvide = false.obs;
  final addProductController = Get.put(AddProductController());
  String productId = "";
  Rx<RxStatus> vendorCategoryStatus = RxStatus.empty().obs;

  ReturnPolicyModel? modelReturnPolicy;
  getReturnPolicyData() {
    repositories.getApi(url: ApiUrls.returnPolicyUrl).then((value) {
      setState(() {
        modelReturnPolicy = ReturnPolicyModel.fromJson(jsonDecode(value));
      });
      print("Return Policy Data: $modelReturnPolicy"); // Print the fetched data
      returnPolicyLoaded.value = DateTime.now().millisecondsSinceEpoch;
    });
  }

  GetShippingModel? modelShippingPolicy;
  getShippingPolicyData() {
    repositories.getApi(url: ApiUrls.getShippingPolicy).then((value) {
      setState(() {
        modelShippingPolicy = GetShippingModel.fromJson(jsonDecode(value));
      });
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
        Get.to(const ExtraInformation());
      }});}
  final controller = Get.put(ProfileController());
  @override
  void initState() {
    super.initState();
    controller.getVendorCategories(addProductController.idProduct.value.toString());
    getReturnPolicyData();
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
        //     child: GestureDetector(
        //         onTap: () {
        //           Get.to(RewardScreen());
        //         },
        //         child: Text(
        //           'Skip',
        //           style: GoogleFonts.poppins(color: Color(0xff0D5877), fontWeight: FontWeight.w400, fontSize: 18),
        //         )),
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
          margin: const EdgeInsets.only(left: 15, right: 15),
          child: Obx(() {
            return controller.productDetailsModel.value.productDetails != null
                ? Column(
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
                              color: Colors.white,
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
                                  Image.network(controller.productDetailsModel.value.productDetails!.product!.featuredImage,height: 200,)
                                ],
                              ),
                            ),
                            Positioned(
                                right: 10,
                                top: 20,
                                child: GestureDetector(
                                    onTap: () {
                                      File imageFile = File(controller.productDetailsModel.value.productDetails!.product!.featuredImage);
                                      File gallery = File(controller.productDetailsModel.value.productDetails!.product!.galleryImage![0]);
                                      Get.to(AddProductFirstImageScreen(
                                        id: controller.productDetailsModel.value.productDetails!.product!.id,
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
                          setState(() {
                            isServiceProvide.toggle();
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppTheme.secondaryColor)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Item Details',
                                style: GoogleFonts.poppins(
                                  color: AppTheme.primaryColor,
                                  fontSize: 15,
                                ),
                              ),
                              GestureDetector(
                                child: isServiceProvide.value != true
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
                                    isServiceProvide.toggle();
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),

                      if (isServiceProvide.value == true)
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
                                  20.spaceY,
                                  Text(
                                      'product name: ${controller.productDetailsModel.value.productDetails!.product!.pname ?? ""}'),
                                  Text(
                                      'product Type: ${controller.productDetailsModel.value.productDetails!.product!.productType ?? ''}'),
                                  Text('product ID: ${controller.productDetailsModel.value.productDetails!.product!.id ?? ""}'),
                                ],
                              ),
                            ),
                            Positioned(
                                right: 10,
                                top: 20,
                                child: GestureDetector(
                                    onTap: () {
                                      Get.to(VirtualProductInformationScreens(
                                        id: controller.productDetailsModel.value.productDetails!.product!.id,
                                        name: controller.productDetailsModel.value.productDetails!.product!.pname,
                                      ));
                                    },
                                    child: const Text(
                                      'Edit',
                                      style: TextStyle(color: Colors.red, fontSize: 13),
                                    )))
                          ],
                        ),

                      const SizedBox(height: 20),
                      // tell us

                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isTellUs.toggle();
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppTheme.secondaryColor)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Price',
                                style: GoogleFonts.poppins(
                                  color: AppTheme.primaryColor,
                                  fontSize: 15,
                                ),
                              ),
                              GestureDetector(
                                child: isTellUs.value != true
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
                                    isTellUs.toggle();
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (isTellUs.value == true)
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
                                  20.spaceY,
                                  Text('Price: ${controller.productDetailsModel.value.productDetails!.product!.pPrice ?? ""} KWD'),
                                  Text(
                                      'Fixed Discounted Price : ${controller.productDetailsModel.value.productDetails!.product!.fixedDiscountPrice ?? ""} KWD'),
                                  Text(
                                      'Discount Percentage: ${controller.productDetailsModel.value.productDetails!.product!.discountPrice ?? ''}'),
                                ],
                              ),
                            ),
                            Positioned(
                                right: 10,
                                top: 20,
                                child: GestureDetector(
                                    onTap: () {
                                      Get.to(VirtualPriceScreen(
                                        id: controller.productDetailsModel.value.productDetails!.product!.id,
                                        price: controller.productDetailsModel.value.productDetails!.product!.pPrice,
                                        percentage: controller.productDetailsModel.value.productDetails!.product!.discountPercent,
                                        fixedPrice: controller.productDetailsModel.value.productDetails!.product!.fixedDiscountPrice,
                                        onSale:controller.productDetailsModel.value.productDetails!.product!.isOnsale ,
                                      ));
                                    },
                                    child: const Text(
                                      'Edit',
                                      style: TextStyle(color: Colors.red, fontSize: 13),
                                    )))
                          ],
                        ),

                      // return policy

                      // GestureDetector(
                      //   onTap: () {
                      //     setState(() {
                      //       isReturnPolicy.toggle();
                      //     });
                      //   },
                      //   child: Container(
                      //     padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      //     decoration: BoxDecoration(
                      //         color: Colors.white,
                      //         borderRadius: BorderRadius.circular(8),
                      //         border: Border.all(color: AppTheme.secondaryColor)),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         Text(
                      //           'return policy',
                      //           style: GoogleFonts.poppins(
                      //             color: AppTheme.primaryColor,
                      //             fontSize: 15,
                      //           ),
                      //         ),
                      //         GestureDetector(
                      //           child: isReturnPolicy.value == true
                      //               ? const Icon(Icons.keyboard_arrow_up_rounded)
                      //               : const Icon(Icons.keyboard_arrow_down_outlined),
                      //           onTap: () {
                      //             setState(() {
                      //               isReturnPolicy.toggle();
                      //             });
                      //           },
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(height: 20),
                      // if (isReturnPolicy.value == true)
                      //   modelReturnPolicy != null
                      //       ? ListView.builder(
                      //           shrinkWrap: true,
                      //           physics: const AlwaysScrollableScrollPhysics(),
                      //           itemCount: modelReturnPolicy!.returnPolicy!.length,
                      //           itemBuilder: (context, index) {
                      //             var returnPolicy = modelReturnPolicy!.returnPolicy![index];
                      //             return Container(
                      //               padding: const EdgeInsets.all(10),
                      //               decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                      //               child: Column(
                      //                 mainAxisAlignment: MainAxisAlignment.start,
                      //                 crossAxisAlignment: CrossAxisAlignment.start,
                      //                 children: [
                      //                   Text('Policy Name: ${returnPolicy.title ?? ""}'),
                      //                   Text('Return Policy Description : ${returnPolicy.policyDiscreption ?? ""}'),
                      //                   Text('Return Within: ${returnPolicy.days ?? ""}'),
                      //                   Text('Return Shipping Fees: ${returnPolicy.returnShippingFees ?? ""}'),
                      //                 ],
                      //               ),
                      //             );
                      //           })
                      //       : const CircularProgressIndicator(),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isDiscrptionPolicy.toggle();
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppTheme.secondaryColor)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Description',
                                style: GoogleFonts.poppins(
                                  color: AppTheme.primaryColor,
                                  fontSize: 15,
                                ),
                              ),
                              GestureDetector(
                                child: isDiscrptionPolicy.value != true
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
                                    isDiscrptionPolicy.toggle();
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (isDiscrptionPolicy.value == true)
                        Stack(
                          children: [
                            Container(
                              width: Get.width,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(color: Colors.grey.shade200),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  20.spaceY,
                                  Text(
                                      'Short Description: ${controller.productDetailsModel.value.productDetails!.product!.shortDescription ?? ""}'),
                                  if(controller.productDetailsModel.value.productDetails!.product!.inStock == '-1' )
                                    const Text(
                                        'Stock quantity : ${'No need'}'),
                                  if(controller.productDetailsModel.value.productDetails!.product!.inStock != '-1' )
                                    Text(
                                        'Stock quantity : ${controller.productDetailsModel.value.productDetails!.product!.inStock ?? ""}'),
                                  Text(
                                      'Set stock/spot alert: ${controller.productDetailsModel.value.productDetails!.product!.stockAlert ?? ''}'),
                                  Text('SEO Tags: ${controller.productDetailsModel.value.productDetails!.product!.seoTags ?? ''}'),
                                ],
                              ),
                            ),
                            Positioned(
                                right: 10,
                                top: 20,
                                child: GestureDetector(
                                    onTap: () {
                                      Get.to(VirtualDiscriptionScreen(
                                        id: controller.productDetailsModel.value.productDetails!.product!.id,
                                        description:
                                        controller.productDetailsModel.value.productDetails!.product!.shortDescription,
                                        stockquantity: controller.productDetailsModel.value.productDetails!.product!.inStock,
                                        setstock: controller.productDetailsModel.value.productDetails!.product!.stockAlert,
                                        sEOTags: controller.productDetailsModel.value.productDetails!.product!.seoTags,
                                        noNeed:   controller.productDetailsModel.value.productDetails!.product!.noNeedStock,
                                        longDesc:  controller.productDetailsModel.value.productDetails!.product!.longDescription,
                                      ));
                                    },
                                    child: const Text(
                                      'Edit',
                                      style: TextStyle(color: Colors.red, fontSize: 13),
                                    )))
                          ],
                        ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            optionalDescription.toggle();
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppTheme.secondaryColor)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Optional Description',
                                style: GoogleFonts.poppins(
                                  color: AppTheme.primaryColor,
                                  fontSize: 15,
                                ),
                              ),
                              GestureDetector(
                                child: optionalDescription.value != true
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
                                    optionalDescription.toggle();
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (optionalDescription.value == true)
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
                                  20.spaceY,
                                  Text(
                                      'Meta Tags: ${controller.productDetailsModel.value.productDetails!.product!.metaTags ?? ""}'),
                                  Text(
                                      'Meta Title: ${controller.productDetailsModel.value.productDetails!.product!.metaTitle ?? ""}'),
                                  Text(
                                      'Meta Description: ${controller.productDetailsModel.value.productDetails!.product!.metaDescription ?? ""}'),
                                ],
                              ),
                            ),
                            Positioned(
                                right: 10,
                                top: 20,
                                child: GestureDetector(
                                    onTap: () {
                                      Get.to(VirtualOptionalDiscrptionsScreen(
                                        id: controller.productDetailsModel.value.productDetails!.product!.id,
                                        metaTitle: controller.productDetailsModel.value.productDetails!.product!.metaTitle,
                                        metaDescription:
                                        controller.productDetailsModel.value.productDetails!.product!.metaDescription,
                                        metaTags: controller.productDetailsModel.value.productDetails!.product!.metaTags,
                                      ));
                                    },
                                    child: const Text(
                                      'Edit',
                                      style: TextStyle(color: Colors.red, fontSize: 13),
                                    )))
                          ],
                        ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            optionalClassification.toggle();
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppTheme.secondaryColor)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Optional Classification',
                                style: GoogleFonts.poppins(
                                  color: AppTheme.primaryColor,
                                  fontSize: 15,
                                ),
                              ),
                              GestureDetector(
                                child: optionalClassification.value != true
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
                                    optionalClassification.toggle();
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (optionalClassification.value == true)
                        Stack(
                          children: [
                            Container(
                              width: Get.width,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(color: Colors.grey.shade200),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  20.spaceY,
                                  Text(
                                      'Product Code: ${controller.productDetailsModel.value.productDetails!.product!.productCode ?? ""}'),
                                  Text(
                                      'Promotion Code: ${controller.productDetailsModel.value.productDetails!.product!.promotionCode ?? ""}'),
                                  Text(
                                      'Package details: ${controller.productDetailsModel.value.productDetails!.product!.packageDetail ?? ""}'),
                                  Text(
                                      'Serial Number: ${controller.productDetailsModel.value.productDetails!.product!.serialNumber ?? ""}'),
                                  Text(
                                      'Product number: ${controller.productDetailsModel.value.productDetails!.product!.productNumber ?? ""}'),
                                ],
                              ),
                            ),
                            Positioned(
                                right: 10,
                                top: 10,
                                child: GestureDetector(
                                    onTap: () {
                                      Get.to(VirtualOptionalClassificationScreen(
                                        id: controller.productDetailsModel.value.productDetails!.product!.id ?? "",
                                        productNumber:
                                        controller.productDetailsModel.value.productDetails!.product!.productNumber ?? "",
                                        productCode:
                                        controller.productDetailsModel.value.productDetails!.product!.productCode ?? "",
                                        promotionCode:
                                        controller.productDetailsModel.value.productDetails!.product!.promotionCode ?? "",
                                        serialNumber:
                                        controller.productDetailsModel.value.productDetails!.product!.serialNumber ?? "",
                                        packageDetail:
                                        controller.productDetailsModel.value.productDetails!.product!.packageDetail ?? "",
                                      ));
                                    },
                                    child: const Text(
                                      'Edit',
                                      style: TextStyle(color: Colors.red, fontSize: 13),
                                    )))
                          ],
                        ),
                      const SizedBox(
                        height: 20,
                      ),

                      // GestureDetector(
                      //   onTap: () {
                      //     setState(() {
                      //       optionalClassification.toggle();
                      //     });
                      //   },
                      //   child: Container(
                      //     padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      //     decoration: BoxDecoration(
                      //         color: Colors.white,
                      //         borderRadius: BorderRadius.circular(8),
                      //         border: Border.all(color: AppTheme.secondaryColor)),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         Text(
                      //           'Optional Classification',
                      //           style: GoogleFonts.poppins(
                      //             color: AppTheme.primaryColor,
                      //             fontSize: 15,
                      //           ),
                      //         ),
                      //         GestureDetector(
                      //           child: optionalClassification.value == true
                      //               ? const Icon(Icons.keyboard_arrow_up_rounded)
                      //               : const Icon(Icons.keyboard_arrow_down_outlined),
                      //           onTap: () {
                      //             setState(() {
                      //               optionalClassification.toggle();
                      //             });
                      //           },
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // if (optionalClassification.value == true)
                      //   Stack(
                      //     children: [
                      //       Container(
                      //         margin: EdgeInsets.only(top: 10),
                      //         width: Get.width,
                      //         padding: EdgeInsets.all(10),
                      //         decoration:
                      //             BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(11)),
                      //         child: Column(
                      //           mainAxisAlignment: MainAxisAlignment.start,
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Text(
                      //                 'Serial Number: ${productDetailsModel.value.productDetails!.product!.serialNumber ?? ""}'),
                      //             Text(
                      //                 'Product Number: ${productDetailsModel.value.productDetails!.product!.productNumber ?? ""}'),
                      //             Text(
                      //                 'Product Code: ${productDetailsModel.value.productDetails!.product!.productCode ?? ""}'),
                      //             Text(
                      //                 'Promotion Code: ${productDetailsModel.value.productDetails!.product!.promotionCode ?? ""}'),
                      //             Text(
                      //                 'Package details: ${productDetailsModel.value.productDetails!.product!.packageDetail ?? ""}'),
                      //           ],
                      //         ),
                      //       ),
                      //       Positioned(
                      //           right: 10,
                      //           top: 20,
                      //           child: GestureDetector(
                      //               onTap: () {
                      //                 Get.to(VirtualOptionalClassificationScreen(
                      //                   id: productDetailsModel.value.productDetails!.product!.id,
                      //                   packageDetail: productDetailsModel.value.productDetails!.product!.packageDetail,
                      //                   productCode: productDetailsModel.value.productDetails!.product!.productCode,
                      //                   productNumber: productDetailsModel.value.productDetails!.product!.productNumber,
                      //                   promotionCode: productDetailsModel.value.productDetails!.product!.promotionCode,
                      //                   serialNumber: productDetailsModel.value.productDetails!.product!.serialNumber,
                      //                 ));
                      //               },
                      //               child: const Text(
                      //                 'Edit',
                      //                 style: TextStyle(color: Colors.red, fontSize: 13),
                      //               )))
                      //     ],
                      //   ),
                      // const SizedBox(
                      //   height: 20,
                      // ),

                      CustomOutlineButton(
                        title: 'Confirm',
                        borderRadius: 11,
                        onPressed: () {
                          completeApi();

                        },
                      ),
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(
                    color: Colors.grey,
                  ));
          }),
        ),
      ),
    );
  }
}
