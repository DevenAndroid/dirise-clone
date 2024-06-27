import 'dart:convert';

import 'package:dirise/addNewProduct/rewardScreen.dart';
import 'package:dirise/controller/vendor_controllers/add_product_controller.dart';
import 'package:dirise/tellaboutself/ExtraInformation.dart';
import 'package:dirise/virtualProduct/product_information_screen.dart';
import 'package:dirise/virtualProduct/singleProductPriceScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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

  RxBool isServiceProvide = false.obs;
  RxBool isTellUs = false.obs;
  RxBool isReturnPolicy = false.obs;
  RxBool optionalDescription = false.obs;
  RxBool optionalClassification = false.obs;

  final Repositories repositories = Repositories();
  RxInt returnPolicyLoaded = 0.obs;
  final addProductController = Get.put(AddProductController());
  String productId = "";
  Rx<ModelProductDetails> productDetailsModel = ModelProductDetails().obs;
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
  getVendorCategories(id) {
    repositories.getApi(url: ApiUrls.getProductDetailsUrl + id).then((value) {
      productDetailsModel.value = ModelProductDetails.fromJson(jsonDecode(value));
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    getVendorCategories(addProductController.idProduct.value.toString());
    getReturnPolicyData();
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
            return productDetailsModel.value.productDetails != null
                ? Column(
                    children: [
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
                                child: isServiceProvide.value == true
                                    ? const Icon(Icons.keyboard_arrow_up_rounded)
                                    : const Icon(Icons.keyboard_arrow_down_outlined),
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
                                  Text(
                                      'product name: ${productDetailsModel.value.productDetails!.product!.pname ?? ""}'),
                                  Text(
                                      'product Type: ${productDetailsModel.value.productDetails!.product!.productType ?? ''}'),
                                  Text('product ID: ${productDetailsModel.value.productDetails!.product!.id ?? ""}'),
                                ],
                              ),
                            ),
                            Positioned(
                                right: 10,
                                top: 20,
                                child: GestureDetector(
                                    onTap: () {
                                      Get.to(VirtualProductInformationScreens(
                                        id: productDetailsModel.value.productDetails!.product!.id,
                                        // name: productDetailsModel.value.productDetails!.product!.pname,
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
                                child: isTellUs.value == true
                                    ? const Icon(Icons.keyboard_arrow_up_rounded)
                                    : const Icon(Icons.keyboard_arrow_down_outlined),
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
                                  Text('Price: ${productDetailsModel.value.productDetails!.product!.pPrice ?? ""} KWD'),
                                  Text(
                                      'Fixed Discounted Price : ${productDetailsModel.value.productDetails!.product!.fixedDiscountPrice ?? ""} KWD'),
                                  Text(
                                      'Discount Percentage: ${productDetailsModel.value.productDetails!.product!.discountPrice ?? ''}'),
                                ],
                              ),
                            ),
                            Positioned(
                                right: 10,
                                top: 20,
                                child: GestureDetector(
                                    onTap: () {
                                      Get.to(VirtualPriceScreen(
                                        id: productDetailsModel.value.productDetails!.product!.id,
                                        price: productDetailsModel.value.productDetails!.product!.pPrice,
                                        percentage: productDetailsModel.value.productDetails!.product!.discountPercent,
                                        fixedPrice:
                                            productDetailsModel.value.productDetails!.product!.fixedDiscountPrice,
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
                                child: optionalDescription.value == true
                                    ? const Icon(Icons.keyboard_arrow_up_rounded)
                                    : const Icon(Icons.keyboard_arrow_down_outlined),
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
                                  Text(
                                      'Meta Tags: ${productDetailsModel.value.productDetails!.product!.metaTags ?? ""}'),
                                  Text(
                                      'Meta Title: ${productDetailsModel.value.productDetails!.product!.metaTitle ?? ""}'),
                                  Text(
                                      'Meta Description: ${productDetailsModel.value.productDetails!.product!.metaDescription ?? ""}'),
                                ],
                              ),
                            ),
                            Positioned(
                                right: 10,
                                top: 20,
                                child: GestureDetector(
                                    onTap: () {
                                      Get.to(VirtualOptionalDiscrptionsScreen(
                                        id: productDetailsModel.value.productDetails!.product!.id,
                                        metaTitle: productDetailsModel.value.productDetails!.product!.metaTitle,
                                        metaDescription:
                                            productDetailsModel.value.productDetails!.product!.metaDescription,
                                        metaTags: productDetailsModel.value.productDetails!.product!.metaTags,
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
                                child: optionalClassification.value == true
                                    ? const Icon(Icons.keyboard_arrow_up_rounded)
                                    : const Icon(Icons.keyboard_arrow_down_outlined),
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
                              margin: EdgeInsets.only(top: 10),
                              width: Get.width,
                              padding: EdgeInsets.all(10),
                              decoration:
                                  BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(11)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'Serial Number: ${productDetailsModel.value.productDetails!.product!.serialNumber ?? ""}'),
                                  Text(
                                      'Product Number: ${productDetailsModel.value.productDetails!.product!.productNumber ?? ""}'),
                                  Text(
                                      'Product Code: ${productDetailsModel.value.productDetails!.product!.productCode ?? ""}'),
                                  Text(
                                      'Promotion Code: ${productDetailsModel.value.productDetails!.product!.promotionCode ?? ""}'),
                                  Text(
                                      'Package details: ${productDetailsModel.value.productDetails!.product!.packageDetail ?? ""}'),
                                ],
                              ),
                            ),
                            Positioned(
                                right: 10,
                                top: 20,
                                child: GestureDetector(
                                    onTap: () {
                                      Get.to(VirtualOptionalClassificationScreen(
                                        id: productDetailsModel.value.productDetails!.product!.id,
                                        packageDetail: productDetailsModel.value.productDetails!.product!.packageDetail,
                                        productCode: productDetailsModel.value.productDetails!.product!.productCode,
                                        productNumber: productDetailsModel.value.productDetails!.product!.productNumber,
                                        promotionCode: productDetailsModel.value.productDetails!.product!.promotionCode,
                                        serialNumber: productDetailsModel.value.productDetails!.product!.serialNumber,
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
