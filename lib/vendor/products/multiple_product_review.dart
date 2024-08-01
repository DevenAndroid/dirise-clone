import 'dart:convert';

import 'package:dirise/addNewProduct/rewardScreen.dart';
import 'package:dirise/controller/vendor_controllers/add_product_controller.dart';
import 'package:dirise/vendor/products/review_screen_multiple.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/profile_controller.dart';
import '../../controller/service_controller.dart';
import '../../model/common_modal.dart';
import '../../model/getShippingModel.dart';
import '../../model/product_details.dart';
import '../../model/returnPolicyModel.dart';
import '../../repository/repository.dart';
import '../../utils/api_constant.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_colour.dart';




class MultipleReviewAndPublishScreen extends StatefulWidget {
  const MultipleReviewAndPublishScreen({super.key});

  @override
  State<MultipleReviewAndPublishScreen> createState() => _MultipleReviewAndPublishScreenState();
}

class _MultipleReviewAndPublishScreenState extends State<MultipleReviewAndPublishScreen> {
  String selectedItem = 'Item 1';
  final serviceController = Get.put(ServiceController());

  RxBool isServiceProvide = false.obs;
  RxBool isTellUs = false.obs;
  RxBool isReturnPolicy = false.obs;
  RxBool isLocationPolicy = false.obs;
  RxBool isInternationalPolicy = false.obs;
  RxBool optionalDescription = false.obs;
  RxBool optionalClassification = false.obs;
  RxBool isDeliverySize = false.obs;
  RxBool isShippingPolicy = false.obs;

  final Repositories repositories = Repositories();
  RxInt returnPolicyLoaded = 0.obs;

  final addProductController = Get.put(AddProductController());

  String productId = "";

  Rx<ModelProductDetails> productDetailsModel = ModelProductDetails().obs;

  Rx<RxStatus> vendorCategoryStatus = RxStatus.empty().obs;

  var  link = Get.arguments[0];
  //
  // ReturnPolicyModel? modelReturnPolicy;
  // getReturnPolicyData() {
  //   repositories.getApi(url: ApiUrls.returnPolicyUrl).then((value) {
  //     setState(() {
  //       modelReturnPolicy = ReturnPolicyModel.fromJson(jsonDecode(value));
  //     });
  //     print("Return Policy Data: $modelReturnPolicy"); // Print the fetched data
  //     returnPolicyLoaded.value = DateTime.now().millisecondsSinceEpoch;
  //   });
  // }
  //
  // GetShippingModel? modelShippingPolicy;
  // getShippingPolicyData() {
  //   repositories.getApi(url: ApiUrls.getShippingPolicy).then((value) {
  //     setState(() {
  //       modelShippingPolicy = GetShippingModel.fromJson(jsonDecode(value));
  //     });
  //   });
  // }
  //
  // getVendorCategories(id) {
  //   repositories.getApi(url: ApiUrls.getProductDetailsUrl + id).then((value) {
  //     productDetailsModel.value = ModelProductDetails.fromJson(jsonDecode(value));
  //     setState(() {});
  //   });
  // }
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
        Get.to(const RewardScreenMultiple());
      }});}
  @override
  void initState() {
    super.initState();
    // getVendorCategories(addProductController.idProduct.value.toString());
    // getReturnPolicyData();
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
          child:  Column(
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
                        'Multiple Products'.tr,
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Row(
                      children: [

                        Text('Link: '.tr),
                        Expanded(child: Text(link,style: TextStyle(
                          color: Colors.black,decoration: TextDecoration.underline
                        ),)),
                      ],
                    ),

                  ],
                ),

              const SizedBox(height: 20),
              // tell us


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
        ),
      ),
    );
  }
}
