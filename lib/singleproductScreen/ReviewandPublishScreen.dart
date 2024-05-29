import 'dart:convert';
import 'dart:io';

import 'package:dirise/addNewProduct/rewardScreen.dart';
import 'package:dirise/controller/vendor_controllers/add_product_controller.dart';
import 'package:dirise/singleproductScreen/product_information_screen.dart';
import 'package:dirise/singleproductScreen/singlePInternationalshippingdetails.dart';
import 'package:dirise/singleproductScreen/singleProductDiscriptionScreen.dart';
import 'package:dirise/singleproductScreen/singleProductPriceScreen.dart';
import 'package:dirise/singleproductScreen/singleProductReturnPolicy.dart';
import 'package:dirise/singleproductScreen/singleproductDeliverySize.dart';
import 'package:dirise/tellaboutself/ExtraInformation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/service_controller.dart';
import '../model/getShippingModel.dart';
import '../model/product_details.dart';
import '../model/returnPolicyModel.dart';
import '../repository/repository.dart';
import '../utils/api_constant.dart';
import '../widgets/common_button.dart';
import '../widgets/common_colour.dart';
import 'optionalClassificationScreen.dart';
import 'optionalDiscrptionsScreen.dart';

class ProductReviewPublicScreen extends StatefulWidget {
  const ProductReviewPublicScreen({super.key});

  @override
  State<ProductReviewPublicScreen> createState() => _ProductReviewPublicScreenState();
}

class _ProductReviewPublicScreenState extends State<ProductReviewPublicScreen> {
  String selectedItem = 'Item 1';
  final serviceController = Get.put(ServiceController());

  RxBool isServiceProvide = false.obs;
  RxBool isTellUs = false.obs;
  RxBool isReturnPolicy = false.obs;
  RxBool isInternationalPolicy = false.obs;
  RxBool optionalDescription = false.obs;
  RxBool optionalClassification = false.obs;
  RxBool isDeliverySize = false.obs;
  RxBool isShippingPolicy = false.obs;
  RxBool isDiscrptionPolicy = false.obs;

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
                              width: Get.width,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('product name: ${productDetailsModel.value.productDetails!.product!.pname ?? ""}'),
                                  Text('product Type: ${productDetailsModel.value.productDetails!.product!.productType ?? ''}'),
                                  Text('Category ID: ${productDetailsModel.value.productDetails!.product!.catId ?? ''}'),
                                  Text('product ID: ${productDetailsModel.value.productDetails!.product!.id ?? ""}'),
                                ],
                              ),
                            ),
                            Positioned(
                                right: 10,
                                top: 20,
                                child: GestureDetector(
                                    onTap: (){
                                      Get.to(ProductInformationScreens(
                                        id: productDetailsModel.value.productDetails!.product!.id,
                                         name: productDetailsModel.value.productDetails!.product!.pname,
                                         catid: productDetailsModel.value.productDetails!.product!.pname,

                                      ));
                                    },
                                    child: const Text('Edit',style: TextStyle(color: Colors.red,fontSize: 13),)))
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
                              width: Get.width,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200
                              ),
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
                                    onTap: (){
                                      Get.to(SingleProductPriceScreen(
                                        id: productDetailsModel.value.productDetails!.product!.id,
                                        price: productDetailsModel.value.productDetails!.product!.pPrice,
                                        fixDiscount: productDetailsModel.value.productDetails!.product!.fixedDiscountPrice,
                                        percentage: productDetailsModel.value.productDetails!.product!.discountPrice,



                                      ));
                                    },
                                    child: const Text('Edit',style: TextStyle(color: Colors.red,fontSize: 13),)))

                          ],
                        ),

                      // tell us

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
                                child: isDiscrptionPolicy.value == true
                                    ? const Icon(Icons.keyboard_arrow_up_rounded)
                                    : const Icon(Icons.keyboard_arrow_down_outlined),
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
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Short Description: ${productDetailsModel.value.productDetails!.product!.shortDescription ?? ""}'),
                                  Text('Stock/spot quantity : ${productDetailsModel.value.productDetails!.product!.inStock ?? ""}'),
                                  Text('Set stock/spot alert: ${productDetailsModel.value.productDetails!.product!.stockAlert ?? ''}'),
                                  Text('SEO Tags: ${productDetailsModel.value.productDetails!.product!.seoTags ?? ''}'),
                                ],
                              ),

                            ),
                            Positioned(
                                right: 10,
                                top: 20,
                                child: GestureDetector(
                                    onTap: (){
                                      Get.to(SingleProductDiscriptionScreen(
                                        id: productDetailsModel.value.productDetails!.product!.id,
                                        description: productDetailsModel.value.productDetails!.product!.shortDescription,
                                        stockquantity: productDetailsModel.value.productDetails!.product!.inStock,
                                        setstock: productDetailsModel.value.productDetails!.product!.stockAlert,
                                        sEOTags:  productDetailsModel.value.productDetails!.product!.seoTags,



                                      ));
                                    },
                                    child: const Text('Edit',style: TextStyle(color: Colors.red,fontSize: 13),)))

                          ],
                        ),

                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isDeliverySize.toggle();
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
                                'Delivery Size',
                                style: GoogleFonts.poppins(
                                  color: AppTheme.primaryColor,
                                  fontSize: 15,
                                ),
                              ),
                              GestureDetector(
                                child: isDeliverySize.value == true
                                    ? const Icon(Icons.keyboard_arrow_up_rounded)
                                    : const Icon(Icons.keyboard_arrow_down_outlined),
                                onTap: () {
                                  setState(() {
                                    isDeliverySize.toggle();
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (isDeliverySize.value == true)
                        Stack(
                         children: [
                           Container(
                             width: Get.width,
                             padding: EdgeInsets.all(10),
                             decoration: BoxDecoration(
                                 color: Colors.grey.shade200
                             ),
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text(
                                     'Who will pay the shipping: ${productDetailsModel.value.productDetails!.product!.shippingPay}'),
                                 SizedBox(
                                   height: 5,
                                 ),
                                 Text(
                                     'Choose Delivery According To Package Size : ${productDetailsModel.value.productDetails!.product!.deliverySize}'),
                               ],
                             ),
                           ),
                           Positioned(
                               right: 10,
                               top: 20,
                               child: GestureDetector(
                                   onTap: (){
                                     Get.to(SingleProductDeliverySize(
                                       id: productDetailsModel.value.productDetails!.product!.id,
                                         whowillpay: productDetailsModel.value.productDetails!.product!.shippingPay,
                                         packagSize :productDetailsModel.value.productDetails!.product!.deliverySize
                                     )
                                     );
                                   },
                                   child: const Text('Edit',style: TextStyle(color: Colors.red,fontSize: 13),)))
                         ],
                        ),

                      // return policy

                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isReturnPolicy.toggle();
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
                                'return policy',
                                style: GoogleFonts.poppins(
                                  color: AppTheme.primaryColor,
                                  fontSize: 15,
                                ),
                              ),
                              GestureDetector(
                                child: isReturnPolicy.value == true
                                    ? const Icon(Icons.keyboard_arrow_up_rounded)
                                    : const Icon(Icons.keyboard_arrow_down_outlined),
                                onTap: () {
                                  setState(() {
                                    isReturnPolicy.toggle();
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (isReturnPolicy.value == true)
                        Stack(
                          children: [
                            Container(
                              width: Get.width,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'Policy Name: ${productDetailsModel.value.productDetails!.product!.returnPolicyDesc!.title ?? ""}'),
                                  const SizedBox(height: 5,),
                                  Text(
                                      'Policy Description: ${productDetailsModel.value.productDetails!.product!.returnPolicyDesc!.policyDiscreption ?? ""}'),
                                  const SizedBox(height: 5,),
                                  Text(
                                      'Return with In: ${productDetailsModel.value.productDetails!.product!.returnPolicyDesc!.days ?? ""}'),
                                  const SizedBox(height: 5,),
                                  Text(
                                      'Return Shipping Fees: ${productDetailsModel.value.productDetails!.product!.returnPolicyDesc!.returnShippingFees ?? ""}'),

                                ],
                              ),
                            ),
                            Positioned(
                                right: 10,
                                top: 20,
                                child: GestureDetector(
                                    onTap: (){
                                      Get.to(SingleProductReturnPolicy(
                                        id: productDetailsModel.value.productDetails!.product!.id,
                                        policyName: productDetailsModel.value.productDetails!.product!.returnPolicyDesc!.title,
                                        policyDescription: productDetailsModel.value.productDetails!.product!.returnPolicyDesc!.policyDiscreption,
                                        returnShippingFees: productDetailsModel.value.productDetails!.product!.returnPolicyDesc!.returnShippingFees,
                                        returnWithIn: productDetailsModel.value.productDetails!.product!.returnPolicyDesc!.days,
                                      )
                                      );
                                    },
                                    child: const Text('Edit',style: TextStyle(color: Colors.red,fontSize: 13),)))
                          ],
                        ),
                        // modelReturnPolicy != null
                        //     ? ListView.builder(
                        //         shrinkWrap: true,
                        //         physics: AlwaysScrollableScrollPhysics(),
                        //         itemCount: modelReturnPolicy!.returnPolicy!.length,
                        //         itemBuilder: (context, index) {
                        //           var returnPolicy = modelReturnPolicy!.returnPolicy![index];
                        //           return Container(
                        //             padding: EdgeInsets.all(10),
                        //             decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                        //             child: Column(
                        //               mainAxisAlignment: MainAxisAlignment.start,
                        //               crossAxisAlignment: CrossAxisAlignment.start,
                        //               children: [
                        //                 Text('Policy Name: ${returnPolicy.title ?? ""}'),
                        //                 Text('Return Policy Description : ${returnPolicy.policyDiscreption ?? ""}'),
                        //                 Text('Return Within: ${returnPolicy.days ?? ""}'),
                        //                 Text('Return Shipping Fees: ${returnPolicy.returnShippingFees ?? ""}'),
                        //               ],
                        //             ),
                        //           );
                        //         })
                        //     : const CircularProgressIndicator(),



                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isInternationalPolicy.toggle();
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
                                'International Shipping Details',
                                style: GoogleFonts.poppins(
                                  color: AppTheme.primaryColor,
                                  fontSize: 15,
                                ),
                              ),
                              GestureDetector(
                                child: isInternationalPolicy.value == true
                                    ? const Icon(Icons.keyboard_arrow_up_rounded)
                                    : const Icon(Icons.keyboard_arrow_down_outlined),
                                onTap: () {
                                  setState(() {
                                    isInternationalPolicy.toggle();
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (isInternationalPolicy.value == true)
                        Stack(
                          children: [
                            Container(
                              width: Get.width,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'Unit of measure: ${productDetailsModel.value.productDetails!.productDimentions!.units ?? ""}'),
                                  Text(
                                      'Weight Of the Item: ${productDetailsModel.value.productDetails!.productDimentions!.weight ?? ""}'),
                                  Text(
                                      'Select Number Of Packages: ${productDetailsModel.value.productDetails!.productDimentions!.numberOfPackage ?? ""}'),
                                  Text(
                                      'Select Type Material: ${productDetailsModel.value.productDetails!.productDimentions!.material ?? ""}'),
                                  Text(
                                      'Select Type Of Packaging: ${productDetailsModel.value.productDetails!.productDimentions!.typeOfPackages ?? ""}'),
                                  Text('Length X Width X Height: ${productDetailsModel.value.productDetails!.productDimentions!.boxLength ?? ""}X' +
                                      "${productDetailsModel.value.productDetails!.productDimentions!.boxWidth ?? ""}X"
                                          "${productDetailsModel.value.productDetails!.productDimentions!.boxHeight ?? ""}"),
                                ],
                              ),
                            ),
                            Positioned(
                                right: 10,
                                top: 20,
                                child: GestureDetector(
                                    onTap: (){
                                      Get.to(SinglePInternationalshippingdetailsScreen(
                                        id: productDetailsModel.value.productDetails!.product!.id,
                                        WeightOftheItem: productDetailsModel.value.productDetails!.productDimentions!.weight,
                                        Unitofmeasure: productDetailsModel.value.productDetails!.productDimentions!.units,
                                        SelectTypeOfPackaging: productDetailsModel.value.productDetails!.productDimentions!.typeOfPackages,
                                        SelectTypeMaterial:productDetailsModel.value.productDetails!.productDimentions!.material ,
                                        SelectNumberOfPackages:productDetailsModel.value.productDetails!.productDimentions!.numberOfPackage ,
                                        Length: "${productDetailsModel.value.productDetails!.productDimentions!.boxLength}X" ,
                                        Width : "${productDetailsModel.value.productDetails!.productDimentions!.boxWidth ?? ""}X",
                                        Height : "${productDetailsModel.value.productDetails!.productDimentions!.boxHeight ?? ""}X",
                                      )
                                      );
                                    },
                                    child: const Text('Edit',style: TextStyle(color: Colors.red,fontSize: 13),)))
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
                              width: Get.width,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Meta Title: ${productDetailsModel.value.productDetails!.product!.metaTitle ?? ""}'),
                                  Text(
                                      'Meta Description: ${productDetailsModel.value.productDetails!.product!.metaDescription ?? ""}'),
                                  Text('Meta Tags: ${productDetailsModel.value.productDetails!.product!.metaTags ?? ""}'),
                                ],
                              ),
                            ),
                            Positioned(
                                right: 10,
                                top: 10,
                                child: GestureDetector(
                                    onTap: (){
                                      Get.to(OptionalDiscrptionsScreen(

                                        id: productDetailsModel.value.productDetails!.product!.id ?? "",
                                        MetaTitle: productDetailsModel.value.productDetails!.product!.metaTitle ?? "",
                                        MetaDescription: productDetailsModel.value.productDetails!.product!.metaDescription ?? "",
                                        metaTags: productDetailsModel.value.productDetails!.product!.metaTags ?? "",

                                      ));
                                    },
                                    child: const Text('Edit',style: TextStyle(color: Colors.red,fontSize: 13),)
                                )
                            )
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
                              width: Get.width,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'Product Code: ${productDetailsModel.value.productDetails!.product!.productCode ?? ""}'),
                                  Text(
                                      'Promotion Code: ${productDetailsModel.value.productDetails!.product!.promotionCode ?? ""}'),
                                  Text(
                                      'Package details: ${productDetailsModel.value.productDetails!.product!.packageDetail ?? ""}'),
                                  Text(
                                      'Serial Number: ${productDetailsModel.value.productDetails!.product!.serialNumber ?? ""}'),
                                  Text(
                                      'Product number: ${productDetailsModel.value.productDetails!.product!.productNumber ?? ""}'),
                                ],
                              ),
                            ),
                            Positioned(
                                right: 10,
                                top: 10,
                                child: GestureDetector(
                                    onTap: (){
                                      Get.to(OptionalClassificationScreen(

                                        id: productDetailsModel.value.productDetails!.product!.id ?? "",
                                        Productnumber: productDetailsModel.value.productDetails!.product!.productNumber ?? "",
                                        ProductCode: productDetailsModel.value.productDetails!.product!.productCode ?? "",
                                        PromotionCode: productDetailsModel.value.productDetails!.product!.promotionCode ?? "",
                                        SerialNumber: productDetailsModel.value.productDetails!.product!.serialNumber ?? "",
                                        Packagedetails: productDetailsModel.value.productDetails!.product!.packageDetail ?? "",
                                      ));
                                    },
                                    child: const Text('Edit',style: TextStyle(color: Colors.red,fontSize: 13),)
                                )
                            )
                          ],

                        ),
                      const SizedBox(
                        height: 20,
                      ),

                      CustomOutlineButton(
                        title: 'Confirm',
                        borderRadius: 11,
                        onPressed: () {
                          Get.to(ExtraInformation());
                          // Get.to(RewardScreen());
                        },
                      ),
                    ],
                  )
                : Center(
                    child: CircularProgressIndicator(
                    color: Colors.grey,
                  ));
          }),
        ),
      ),
    );
  }
}
