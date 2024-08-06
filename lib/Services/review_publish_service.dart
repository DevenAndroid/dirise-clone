import 'dart:convert';
import 'dart:io';
import 'package:dirise/Services/pick_up_address_service.dart';
import 'package:dirise/Services/service_discrptions_screen.dart';
import 'package:dirise/Services/service_international_shipping_details.dart';
import 'package:dirise/Services/servicesReturnPolicyScreen.dart';
import 'package:dirise/Services/tellUsscreen.dart';
import 'package:dirise/Services/whatServiceDoYouProvide.dart';
import 'package:dirise/addNewProduct/rewardScreen.dart';
import 'package:dirise/tellaboutself/ExtraInformation.dart';
import 'package:dirise/utils/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../addNewProduct/addProductFirstImageScreen.dart';
import '../controller/profile_controller.dart';
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
  RxBool isOtherImageProvide = false.obs;
  RxBool isServiceProvide = false.obs;
  RxBool isTellUs = false.obs;
  RxBool isReturnPolicy = false.obs;
  RxBool isLocationPolicy = false.obs;
  RxBool isInternationalPolicy = false.obs;
  RxBool optionalDescription = false.obs;
  RxBool optionalClassification = false.obs;
  RxBool isImageProvide = false.obs;
  final Repositories repositories = Repositories();
  RxInt returnPolicyLoaded = 0.obs;
  final addProductController = Get.put(AddProductController());
  String productId = "";
  final addProductControllerNew = Get.put(ProfileController());
  Rx<RxStatus> vendorCategoryStatus = RxStatus.empty().obs;
  ReturnPolicyModel? modelReturnPolicy;
  final controller = Get.put(ProfileController());
  getReturnPolicyData() {
    repositories.getApi(url: ApiUrls.returnPolicyUrl).then((value) {
      setState(() {
        modelReturnPolicy = ReturnPolicyModel.fromJson(jsonDecode(value));
      });
      print("Return Policy Data: $modelReturnPolicy"); // Print the fetched data
      returnPolicyLoaded.value = DateTime.now().millisecondsSinceEpoch;
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
  @override
  void initState() {
    super.initState();
    controller.getVendorCategories(addProductController.idProduct.value.toString());
    getReturnPolicyData();
  }
@override
  void dispose() {
    super.dispose();
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
                                'Featured Image'.tr,
                                style: GoogleFonts.poppins(
                                  color: AppTheme.primaryColor,
                                  fontSize: 15,
                                ),
                              ),
                              GestureDetector(
                                child: isImageProvide.value != true
                                    ?
                                Image.asset(
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
                              margin: const EdgeInsets.only(top: 10),
                              width: Get.width,
                              padding: const EdgeInsets.all(10),
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
                                    child:  Text(
                                      'Edit'.tr,
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
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppTheme.secondaryColor)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Other Image'.tr,
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
                                  :  Text('No images available'.tr),
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
                                child:  Text(
                                  'Edit'.tr,
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
                                'Price'.tr,
                                style: GoogleFonts.poppins(
                                  color: AppTheme.primaryColor,
                                  fontSize: 15,
                                ),
                              ),
                              GestureDetector(
                                child: isServiceProvide.value != true ? Image.asset(
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
                              margin: const EdgeInsets.only(top: 10),
                              width: Get.width,
                              padding: const EdgeInsets.all(10),
                              decoration:
                                  BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(11)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  20.spaceY,
                                  Text('${"Service Name:".tr} ${controller.productDetailsModel.value.productDetails!.product!.pname ?? ""}'),
                                  Text('${"Price:".tr} ${controller.productDetailsModel.value.productDetails!.product!.pPrice ?? ""} KWD'),
                                  // Text('Make it on sale: ${productDetailsModel.value.productDetails!.product!.discountPercent ?? ''}'),
                                  Text('${"Discount Price:".tr} ${controller.productDetailsModel.value.productDetails!.product!.discountPrice ?? ""} KWD'),
                                  Text('${"Percentage:".tr} ${controller.productDetailsModel.value.productDetails!.product!.discountPercent ?? ""}'),
                                  Text('${"Fixed after sale price:".tr} ${controller.productDetailsModel.value.productDetails!.product!.fixedDiscountPrice ?? ""} KWD'),

                                ],
                              ),
                            ),
                            Positioned(
                                right: 10,
                                top: 20,
                                child: GestureDetector(
                                    onTap: () {
                                      Get.to(whatServiceDoYouProvide(
                                        id: controller.productDetailsModel.value.productDetails!.product!.id,
                                        price: controller.productDetailsModel.value.productDetails!.product!.pPrice,
                                        percentage: controller.productDetailsModel.value.productDetails!.product!.discountPercent,
                                        fixedPrice:
                                        controller.productDetailsModel.value.productDetails!.product!.fixedDiscountPrice,
                                        name: controller.productDetailsModel.value.productDetails!.product!.pname,
                                        isDelivery: controller.productDetailsModel.value.productDetails!.product!.isOnsale,
                                      ));
                                    },
                                    child:  Text(
                                      'Edit'.tr,
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
                                'Tell us'.tr,
                                style: GoogleFonts.poppins(
                                  color: AppTheme.primaryColor,
                                  fontSize: 15,
                                ),
                              ),
                              GestureDetector(
                                child: isTellUs.value != true
                                    ?    Image.asset(
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
                              margin: const EdgeInsets.only(top: 10),
                              width: Get.width,
                              padding: const EdgeInsets.all(10),
                              decoration:
                                  BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(11)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  20.spaceY,
                                  Text('${"Short Description:".tr} ${controller.productDetailsModel.value.productDetails!.product!.shortDescription ?? ""}'),
                                  if(controller.productDetailsModel.value.productDetails!.product!.inStock == '-1' )
                                   Text('${"Stock quantity :".tr} ${'No need'.tr}'),
                                  if(controller.productDetailsModel.value.productDetails!.product!.inStock != '-1' )
                                  Text('${"Stock quantity :".tr} ${controller.productDetailsModel.value.productDetails!.product!.inStock ?? ""}'),
                                  Text('${"Set stock alert:".tr} ${controller.productDetailsModel.value.productDetails!.product!.stockAlert == null ? '0' : controller.productDetailsModel.value.productDetails!.product!.stockAlert.toString()}'),
                                  Text('${"SEO Tags:".tr} ${controller.productDetailsModel.value.productDetails!.product!.seoTags ?? ""}'),
                                ],
                              ),
                            ),
                            Positioned(
                                right: 10,
                                top: 20,
                                child: GestureDetector(
                                    onTap: () {
                                      Get.to(TellUsScreen(
                                        id: controller.productDetailsModel.value.productDetails!.product!.id,
                                        description:
                                        controller.productDetailsModel.value.productDetails!.product!.shortDescription,
                                        sEOTags: controller.productDetailsModel.value.productDetails!.product!.seoTags,
                                        setstock: controller.productDetailsModel.value.productDetails!.product!.stockAlert,
                                        stockquantity: controller.productDetailsModel.value.productDetails!.product!.inStock,
                                        noNeed:   controller.productDetailsModel.value.productDetails!.product!.noNeedStock,
                                      ));
                                    },
                                    child:  Text(
                                      'Edit'.tr,
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
                                'return policy'.tr,
                                style: GoogleFonts.poppins(
                                  color: AppTheme.primaryColor,
                                  fontSize: 15,
                                ),
                              ),
                              GestureDetector(
                                child: isReturnPolicy.value != true
                                    ?    Image.asset(
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
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  20.spaceY,
                                  Text('${"Policy Name:".tr} ${controller.productDetailsModel.value.productDetails!.product!.returnPolicyDesc!.title ?? ""}'),
                                  const SizedBox(height: 5,),
                                  Text('${"Policy Description:".tr} ${controller.productDetailsModel.value.productDetails!.product!.returnPolicyDesc!.policyDiscreption ?? ""}'),
                                  const SizedBox(height: 5,),
                                  Text('${"Return with In:".tr} ${controller.productDetailsModel.value.productDetails!.product!.returnPolicyDesc!.days ?? ""}'),
                                  const SizedBox(height: 5,),
                                  Text('${"Return Shipping Fees:".tr} ${controller.productDetailsModel.value.productDetails!.product!.returnPolicyDesc!.returnShippingFees ?? ""}'),

                                ],
                              ),
                            ),
                            Positioned(
                                right: 10,
                                top: 20,
                                child: GestureDetector(
                                    onTap: (){
                                      Get.to(ServicesReturnPolicy(
                                        id: controller.productDetailsModel.value.productDetails!.product!.id,
                                        policyName: controller.productDetailsModel.value.productDetails!.product!.returnPolicyDesc!.title,
                                        policyDescription: controller.productDetailsModel.value.productDetails!.product!.returnPolicyDesc!.policyDiscreption,
                                        returnShippingFees: controller.productDetailsModel.value.productDetails!.product!.returnPolicyDesc!.returnShippingFees,
                                        returnWithIn: controller.productDetailsModel.value.productDetails!.product!.returnPolicyDesc!.days,
                                      )
                                      );
                                    },
                                    child:  Text('Edit'.tr,
                                      style: TextStyle(color: Colors.red,fontSize: 13),)))
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
                              Text('Location where customer will join '.tr,
                                style: GoogleFonts.poppins(
                                  color: AppTheme.primaryColor,
                                  fontSize: 15,
                                ),
                              ),
                              GestureDetector(
                                child: isLocationPolicy.value != true
                                    ?    Image.asset(
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
                              margin: const EdgeInsets.only(top: 10),
                              width: Get.width,
                              padding: const EdgeInsets.all(10),
                              decoration:
                                  BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(11)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  20.spaceY,
                                  Text('${"Town:".tr} ${controller.productDetailsModel.value.productDetails!.address!.town ?? ""}'),
                                  Text('${"city:".tr} ${controller.productDetailsModel.value.productDetails!.address!.city ?? ""}'),
                                  Text('${"state:".tr} ${controller.productDetailsModel.value.productDetails!.address!.state ?? ""}'),
                                  Text('${"country:".tr} ${controller.productDetailsModel.value.productDetails!.address!.country ?? ""}'),
                                  Text('${"zip code:".tr} ${controller.productDetailsModel.value.productDetails!.address!.zipCode ?? ""}'),
                                ],
                              ),
                            ),
                            Positioned(
                                right: 10,
                                top: 20,
                                child: GestureDetector(
                                    onTap: () {
                                      Get.to(PickUpAddressService(
                                        id: controller.productDetailsModel.value.productDetails!.product!.id,
                                        street: controller.productDetailsModel.value.productDetails!.address!.address,
                                        city: controller.productDetailsModel.value.productDetails!.address!.city,
                                        state: controller.productDetailsModel.value.productDetails!.address!.state,
                                        zipcode: controller.productDetailsModel.value.productDetails!.address!.zipCode,
                                        country: controller.productDetailsModel.value.productDetails!.address!.country,
                                        town: controller.productDetailsModel.value.productDetails!.address!.town,
                                      ));
                                    },
                                    child:  Text(
                                      'Edit'.tr,
                                      style: TextStyle(color: Colors.red, fontSize: 13),
                                    )))
                          ],
                        ),

                      // const SizedBox(height: 20),
                      // GestureDetector(
                      //   onTap: () {
                      //     setState(() {
                      //       isInternationalPolicy.toggle();
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
                      //           'Item Weight & Dimensions',
                      //           style: GoogleFonts.poppins(
                      //             color: AppTheme.primaryColor,
                      //             fontSize: 15,
                      //           ),
                      //         ),
                      //         GestureDetector(
                      //           child: isInternationalPolicy.value != true
                      //               ?    Image.asset(
                      //             'assets/images/drop_icon.png',
                      //             height: 17,
                      //             width: 17,
                      //           )
                      //               : Image.asset(
                      //             'assets/images/up_icon.png',
                      //             height: 17,
                      //             width: 17,
                      //           ),
                      //           onTap: () {
                      //             setState(() {
                      //               isInternationalPolicy.toggle();
                      //             });
                      //           },
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(height: 20),
                      // if (isInternationalPolicy.value == true)
                      //   Stack(
                      //     children: [
                      //       Container(
                      //         margin: const EdgeInsets.only(top: 10),
                      //         width: Get.width,
                      //         padding: const EdgeInsets.all(10),
                      //         decoration:
                      //             BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(11)),
                      //         child: Column(
                      //           mainAxisAlignment: MainAxisAlignment.start,
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             20.spaceY,
                      //             Text(
                      //                 'Unit of measure: ${controller.productDetailsModel.value.productDetails!.productDimentions!.units ?? ""}'),
                      //             Text(
                      //                 'Weight Of the Item: ${controller.productDetailsModel.value.productDetails!.productDimentions!.weight ?? ""}'),
                      //             Text(
                      //                 'Select Number Of Packages: ${controller.productDetailsModel.value.productDetails!.productDimentions!.numberOfPackage ?? ""}'),
                      //             Text(
                      //                 'Select Type Material: ${controller.productDetailsModel.value.productDetails!.productDimentions!.material ?? ""}'),
                      //             Text(
                      //                 'Select Type Of Packaging: ${controller.productDetailsModel.value.productDetails!.productDimentions!.typeOfPackages ?? ""}'),
                      //             Text('Length X Width X Height: ${controller.productDetailsModel.value.productDetails!.productDimentions!.boxLength ?? ""}X' +
                      //                 "${controller.productDetailsModel.value.productDetails!.productDimentions!.boxWidth ?? ""}X"
                      //                     "${controller.productDetailsModel.value.productDetails!.productDimentions!.boxHeight ?? ""}"),
                      //           ],
                      //         ),
                      //       ),
                      //       Positioned(
                      //           right: 10,
                      //           top: 20,
                      //           child: GestureDetector(
                      //               onTap: () {
                      //                 Get.to(ServiceInternationalShippingService(
                      //                   unitOfMeasure: controller.productDetailsModel.value.productDetails!.productDimentions!.units,
                      //                   id: controller.productDetailsModel.value.productDetails!.product!.id,
                      //                   SelectNumberOfPackages: controller.productDetailsModel
                      //                       .value.productDetails!.productDimentions!.numberOfPackage,
                      //                   SelectTypeMaterial:
                      //                   controller.productDetailsModel.value.productDetails!.productDimentions!.material,
                      //                   SelectTypeOfPackaging:
                      //                   controller.productDetailsModel.value.productDetails!.productDimentions!.typeOfPackages == 'your_packaging' ? 'your packaging' : 'custom packaging',
                      //                   Unitofmeasure:
                      //                   controller.productDetailsModel.value.productDetails!.productDimentions!.units,
                      //                   WeightOftheItem:
                      //                   controller.productDetailsModel.value.productDetails!.productDimentions!.weight,
                      //                   Height: controller.productDetailsModel.value.productDetails!.productDimentions!.boxHeight,
                      //                   Length: controller.productDetailsModel.value.productDetails!.productDimentions!.boxLength,
                      //                   Width: controller.productDetailsModel.value.productDetails!.productDimentions!.boxWidth,
                      //                 ));
                      //               },
                      //               child: const Text(
                      //                 'Edit',
                      //                 style: TextStyle(color: Colors.red, fontSize: 13),
                      //               )))
                      //     ],
                      //   ),
                      //
                      // GestureDetector(
                      //   onTap: () {
                      //     setState(() {
                      //       optionalDescription.toggle();
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
                      //           'Optional Description',
                      //           style: GoogleFonts.poppins(
                      //             color: AppTheme.primaryColor,
                      //             fontSize: 15,
                      //           ),
                      //         ),
                      //         GestureDetector(
                      //           child: optionalDescription.value != true
                      //               ?    Image.asset(
                      //             'assets/images/drop_icon.png',
                      //             height: 17,
                      //             width: 17,
                      //           )
                      //               : Image.asset(
                      //             'assets/images/up_icon.png',
                      //             height: 17,
                      //             width: 17,
                      //           ),
                      //           onTap: () {
                      //             setState(() {
                      //               optionalDescription.toggle();
                      //             });
                      //           },
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // if (optionalDescription.value == true)
                      //   Stack(
                      //     children: [
                      //       Container(
                      //         margin: const EdgeInsets.only(top: 10),
                      //         width: Get.width,
                      //         padding: const EdgeInsets.all(10),
                      //         decoration:
                      //             BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(11)),
                      //         child: Column(
                      //           mainAxisAlignment: MainAxisAlignment.start,
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             20.spaceY,
                      //             Text(
                      //                 'Long Description: ${controller.productDetailsModel.value.productDetails!.product!.longDescription ?? ""}'),
                      //             Text(
                      //                 'Meta Title: ${controller.productDetailsModel.value.productDetails!.product!.metaTitle ?? ""}'),
                      //             Text(
                      //                 'Meta Description: ${controller.productDetailsModel.value.productDetails!.product!.metaDescription ?? ""}'),
                      //             Text(
                      //                 'Meta Tags: ${controller.productDetailsModel.value.productDetails!.product!.metaTags ?? ""}'),
                      //             Text('No Tax: ${controller.productDetailsModel.value.productDetails!.product!.taxApply ?? ""}'),
                      //           ],
                      //         ),
                      //       ),
                      //       Positioned(
                      //           right: 10,
                      //           top: 20,
                      //           child: GestureDetector(
                      //               onTap: () {
                      //                 Get.to(ServiceOptionalScreen(
                      //                   id: controller.productDetailsModel.value.productDetails!.product!.id,
                      //                   MetaDescription:
                      //                   controller.productDetailsModel.value.productDetails!.product!.metaDescription,
                      //                   MetaTitle: controller.productDetailsModel.value.productDetails!.product!.metaTitle,
                      //                   longDescription:
                      //                   controller.productDetailsModel.value.productDetails!.product!.longDescription,
                      //                   metaTags: controller.productDetailsModel.value.productDetails!.product!.metaTags,
                      //                   noTax: controller.productDetailsModel.value.productDetails!.product!.taxApply,
                      //                 ));
                      //               },
                      //               child: const Text(
                      //                 'Edit',
                      //                 style: TextStyle(color: Colors.red, fontSize: 13),
                      //               )))
                      //     ],
                      //   ),

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
                                'Optional Classification'.tr,
                                style: GoogleFonts.poppins(
                                  color: AppTheme.primaryColor,
                                  fontSize: 15,
                                ),
                              ),
                              GestureDetector(
                                child: optionalClassification.value != true
                                    ?    Image.asset(
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
                              margin: const EdgeInsets.only(top: 10),
                              width: Get.width,
                              padding: const EdgeInsets.all(10),
                              decoration:
                                  BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(11)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  20.spaceY,
                                  Text('${"Product Code:".tr} ${controller.productDetailsModel.value.productDetails!.product!.productCode ?? ""}'),
                                  Text('${"Promotion Code:".tr} ${controller.productDetailsModel.value.productDetails!.product!.promotionCode ?? ""}'),
                                  Text('${"Package details:".tr} ${controller.productDetailsModel.value.productDetails!.product!.packageDetail ?? ""}'),
                                  Text('${"Serial Number:".tr} ${controller.productDetailsModel.value.productDetails!.product!.serialNumber ?? ""}'),
                                  Text('${"Product number:".tr} ${controller.productDetailsModel.value.productDetails!.product!.productNumber ?? ""}'),
                                ],
                              ),
                            ),
                            Positioned(
                                right: 10,
                                top: 20,
                                child: GestureDetector(
                                    onTap: () {
                                      Get.to(OptionalColloectionScreen(
                                        id: controller.productDetailsModel.value.productDetails!.product!.id,
                                        Productnumber: controller.productDetailsModel.value.productDetails!.product!.productNumber,
                                        SerialNumber: controller.productDetailsModel.value.productDetails!.product!.serialNumber,
                                        Packagedetails:
                                        controller.productDetailsModel.value.productDetails!.product!.packageDetail,
                                        ProductCode: controller.productDetailsModel.value.productDetails!.product!.productCode,
                                        PromotionCode: controller.productDetailsModel.value.productDetails!.product!.promotionCode,
                                      ));
                                    },
                                    child:  Text(
                                      'Edit'.tr,
                                      style: TextStyle(color: Colors.red, fontSize: 13),
                                    )))
                          ],
                        ),

                      const SizedBox(
                        height: 20,
                      ),

                      CustomOutlineButton(
                        title: 'Confirm'.tr,
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
