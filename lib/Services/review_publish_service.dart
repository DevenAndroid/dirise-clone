import 'dart:convert';
import 'package:dirise/Services/pick_up_address_service.dart';
import 'package:dirise/Services/service_discrptions_screen.dart';
import 'package:dirise/Services/service_international_shipping_details.dart';
import 'package:dirise/Services/servicesReturnPolicyScreen.dart';
import 'package:dirise/Services/tellUsscreen.dart';
import 'package:dirise/Services/whatServiceDoYouProvide.dart';
import 'package:dirise/addNewProduct/rewardScreen.dart';
import 'package:dirise/tellaboutself/ExtraInformation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/service_controller.dart';
import '../controller/vendor_controllers/add_product_controller.dart';
import '../model/common_modal.dart';
import '../model/product_details.dart';
import '../model/returnPolicyModel.dart';
import '../repository/repository.dart';
import '../utils/api_constant.dart';
import '../widgets/common_button.dart';
import '../widgets/common_colour.dart';
import 'doneSeriveseScreen.dart';
import 'optional_collection.dart';

class ReviewPublishServiceScreen extends StatefulWidget {
  const ReviewPublishServiceScreen({super.key});

  @override
  State<ReviewPublishServiceScreen> createState() => _ReviewPublishServiceScreenState();
}

class _ReviewPublishServiceScreenState extends State<ReviewPublishServiceScreen> {
  String selectedItem = 'Item 1';
  final serviceController = Get.put(ServiceController());

  RxBool isServiceProvide = false.obs;
  RxBool isTellUs = false.obs;
  RxBool isReturnPolicy = false.obs;
  RxBool isLocationPolicy = false.obs;
  RxBool isInternationalPolicy = false.obs;
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

  getVendorCategories(id) {
    repositories.getApi(url: ApiUrls.getProductDetailsUrl + id).then((value) {
      productDetailsModel.value = ModelProductDetails.fromJson(jsonDecode(value));
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
        Get.to(ExtraInformation());
      }});}
  @override
  void initState() {
    super.initState();
    getVendorCategories(addProductController.idProduct.value.toString());
    getReturnPolicyData();
  }
@override
  void dispose() {
    super.dispose();
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
                                'Make it on sale',
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
                                      'Service Name: ${productDetailsModel.value.productDetails!.product!.pname ?? ""}'),
                                  Text('Price: ${productDetailsModel.value.productDetails!.product!.pPrice ?? ""} KWD'),
                                  // Text(
                                  //     'Make it on sale: ${productDetailsModel.value.productDetails!.product!.discountPercent ?? ''}'),
                                  Text(
                                      'Discount Price: ${productDetailsModel.value.productDetails!.product!.discountPrice ?? ""} KWD'),
                                  Text(
                                      'Percentage: ${productDetailsModel.value.productDetails!.product!.discountPercent ?? ""}'),
                                  Text(
                                      'Fixed after sale price: ${productDetailsModel.value.productDetails!.product!.fixedDiscountPrice ?? ""} KWD'),
                                ],
                              ),
                            ),
                            Positioned(
                                right: 10,
                                top: 20,
                                child: GestureDetector(
                                    onTap: () {
                                      Get.to(whatServiceDoYouProvide(
                                        id: productDetailsModel.value.productDetails!.product!.id,
                                        price: productDetailsModel.value.productDetails!.product!.pPrice,
                                        percentage: productDetailsModel.value.productDetails!.product!.discountPercent,
                                        fixedPrice:
                                            productDetailsModel.value.productDetails!.product!.fixedDiscountPrice,
                                        name: productDetailsModel.value.productDetails!.product!.pname,
                                        isDelivery: true.obs,
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
                                'Tell us',
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
                                  Text(
                                      'Short Description: ${productDetailsModel.value.productDetails!.product!.shortDescription ?? ""}'),
                                  Text(
                                      'Stock quantity : ${productDetailsModel.value.productDetails!.product!.inStock ?? ""}'),
                                  Text(
                                      'Set stock alert: ${productDetailsModel.value.productDetails!.product!.stockAlert ?? ''}'),
                                  Text('SEO Tags: ${productDetailsModel.value.productDetails!.product!.seoTags ?? ""}'),
                                ],
                              ),
                            ),
                            Positioned(
                                right: 10,
                                top: 20,
                                child: GestureDetector(
                                    onTap: () {
                                      Get.to(TellUsScreen(
                                        id: productDetailsModel.value.productDetails!.product!.id,
                                        description:
                                            productDetailsModel.value.productDetails!.product!.shortDescription,
                                        sEOTags: productDetailsModel.value.productDetails!.product!.seoTags,
                                        setstock: productDetailsModel.value.productDetails!.product!.stockAlert,
                                        stockquantity: productDetailsModel.value.productDetails!.product!.inStock,
                                      ));
                                    },
                                    child: const Text(
                                      'Edit',
                                      style: TextStyle(color: Colors.red, fontSize: 13),
                                    )))
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
                                      Get.to(ServicesReturnPolicy(
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
                            isLocationPolicy.toggle();
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
                                'Location where customer will join ',
                                style: GoogleFonts.poppins(
                                  color: AppTheme.primaryColor,
                                  fontSize: 15,
                                ),
                              ),
                              GestureDetector(
                                child: isLocationPolicy.value == true
                                    ? const Icon(Icons.keyboard_arrow_up_rounded)
                                    : const Icon(Icons.keyboard_arrow_down_outlined),
                                onTap: () {
                                  setState(() {
                                    isLocationPolicy.toggle();
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (isLocationPolicy.value == true)
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
                                  Text('Town: ${productDetailsModel.value.productDetails!.address!.town ?? ""}'),
                                  Text('city: ${productDetailsModel.value.productDetails!.address!.city ?? ""}'),
                                  Text('state: ${productDetailsModel.value.productDetails!.address!.state ?? ""}'),
                                  Text('address: ${productDetailsModel.value.productDetails!.address!.address ?? ""}'),
                                  Text('zip code: ${productDetailsModel.value.productDetails!.address!.zipCode ?? ""}'),
                                ],
                              ),
                            ),
                            Positioned(
                                right: 10,
                                top: 20,
                                child: GestureDetector(
                                    onTap: () {
                                      Get.to(PickUpAddressService(
                                        id: productDetailsModel.value.productDetails!.product!.id,
                                        street: productDetailsModel.value.productDetails!.address!.address,
                                        city: productDetailsModel.value.productDetails!.address!.city,
                                        state: productDetailsModel.value.productDetails!.address!.state,
                                        zipcode: productDetailsModel.value.productDetails!.address!.country,
                                        country: productDetailsModel.value.productDetails!.address!.zipCode,
                                        town: productDetailsModel.value.productDetails!.address!.town,
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
                                'Item Weight & Dimensions',
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
                                    onTap: () {
                                      Get.to(ServiceInternationalShippingService(
                                        id: productDetailsModel.value.productDetails!.product!.id,
                                        SelectNumberOfPackages: productDetailsModel
                                            .value.productDetails!.productDimentions!.numberOfPackage,
                                        SelectTypeMaterial:
                                            productDetailsModel.value.productDetails!.productDimentions!.material,
                                        SelectTypeOfPackaging:
                                            productDetailsModel.value.productDetails!.productDimentions!.typeOfPackages,
                                        Unitofmeasure:
                                            productDetailsModel.value.productDetails!.productDimentions!.units,
                                        WeightOftheItem:
                                            productDetailsModel.value.productDetails!.productDimentions!.weight,
                                        Height: productDetailsModel.value.productDetails!.productDimentions!.boxHeight,
                                        Length: productDetailsModel.value.productDetails!.productDimentions!.boxLength,
                                        Width: productDetailsModel.value.productDetails!.productDimentions!.boxWidth,
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
                                      'Long Description: ${productDetailsModel.value.productDetails!.product!.longDescription ?? ""}'),
                                  Text(
                                      'Meta Title: ${productDetailsModel.value.productDetails!.product!.metaTitle ?? ""}'),
                                  Text(
                                      'Meta Description: ${productDetailsModel.value.productDetails!.product!.metaDescription ?? ""}'),
                                  Text(
                                      'Meta Tags: ${productDetailsModel.value.productDetails!.product!.metaTags ?? ""}'),
                                  Text('No Tax: ${productDetailsModel.value.productDetails!.product!.taxApply ?? ""}'),
                                ],
                              ),
                            ),
                            Positioned(
                                right: 10,
                                top: 20,
                                child: GestureDetector(
                                    onTap: () {
                                      Get.to(ServiceOptionalScreen(
                                        id: productDetailsModel.value.productDetails!.product!.id,
                                        MetaDescription:
                                            productDetailsModel.value.productDetails!.product!.metaDescription,
                                        MetaTitle: productDetailsModel.value.productDetails!.product!.metaTitle,
                                        longDescription:
                                            productDetailsModel.value.productDetails!.product!.longDescription,
                                        metaTags: productDetailsModel.value.productDetails!.product!.metaTags,
                                        noTax: productDetailsModel.value.productDetails!.product!.taxApply,
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
                                top: 20,
                                child: GestureDetector(
                                    onTap: () {
                                      Get.to(OptionalColloectionScreen(
                                        id: productDetailsModel.value.productDetails!.product!.id,
                                        Productnumber: productDetailsModel.value.productDetails!.product!.productNumber,
                                        SerialNumber: productDetailsModel.value.productDetails!.product!.serialNumber,
                                        Packagedetails:
                                            productDetailsModel.value.productDetails!.product!.packageDetail,
                                        ProductCode: productDetailsModel.value.productDetails!.product!.productCode,
                                        PromotionCode: productDetailsModel.value.productDetails!.product!.promotionCode,
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
