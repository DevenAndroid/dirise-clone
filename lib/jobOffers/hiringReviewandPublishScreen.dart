import 'dart:convert';
import 'dart:developer';

import 'package:dirise/addNewProduct/rewardScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/vendor_controllers/add_product_controller.dart';
import '../model/product_details.dart';
import '../repository/repository.dart';
import '../utils/api_constant.dart';
import '../widgets/common_button.dart';
import '../widgets/common_colour.dart';
import 'congratulationScreen.dart';

class HiringReviewPublishScreen extends StatefulWidget {
  String? jobcat;
  String? jobtype;
  String? jobmodel;
  String? jobdesc;
  String? linkedIN;
  String? experince;
  String? salery;

  HiringReviewPublishScreen({super.key,this.jobcat,this.salery,this.experince,this.linkedIN,this.jobdesc,this.jobmodel,this.jobtype});

  @override
  State<HiringReviewPublishScreen> createState() => _HiringReviewPublishScreenState();
}

class _HiringReviewPublishScreenState extends State<HiringReviewPublishScreen> {
  bool isItemDetailsVisible = false;
  bool isItemDetailsVisible1 = false;
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text('Skip',style: GoogleFonts.poppins(color: Color(0xff0D5877),fontWeight: FontWeight.w400,fontSize: 18),),
          )
        ],
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
                        Text('Job title: ${productDetailsModel.value.productDetails!.product!.pname ?? ""}'),
                        Text('product Price: ${widget.jobtype.toString()}'),
                        Text('product Type: ${widget.jobmodel.toString()}'),
                        Text('product ID: ${widget.experince.toString()}'),
                        Text('short Des: ${widget.salery.toString()}'),
                        Text('short Des: ${widget.linkedIN.toString()}'),

                      ],
                    ),
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
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Tell us about yourself'), Icon(Icons.arrow_drop_down_sharp)],
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
                        Text('Tell us about yourself: ${widget.jobdesc.toString()}'),


                      ],
                    ),
                  )


              ),
              const SizedBox(height: 10),
              CustomOutlineButton(
                title: 'Confirm',
                borderRadius: 11,
                onPressed: () {
                  Get.to(CongratulationScreen());
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
