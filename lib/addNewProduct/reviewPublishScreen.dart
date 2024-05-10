import 'dart:convert';
import 'dart:developer';

import 'package:dirise/addNewProduct/rewardScreen.dart';
import 'package:dirise/utils/api_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/vendor_controllers/add_product_controller.dart';
import '../model/product_details.dart';
import '../model/reviewAndPublishModel.dart';
import '../repository/repository.dart';
import '../widgets/common_button.dart';
import '../widgets/common_colour.dart';

class ReviewPublishScreen extends StatefulWidget {
  String? productID;
  String? productname;
  String? productPrice;
  String? productType;
  String? shortDes;

  String? town;
  String? city;
  String? state;
  String? address;
  String? zip_code;

  String? deliverySize;

  String? Unitofmeasure;
  String? WeightOftheItem;
  String? SelectNumberOfPackages;
  String? SelectTypeMaterial;
  String? LengthWidthHeight;
  String? SelectTypeOfPackaging;

  String? LongDescription;
  String? MetaTitle;
  String? MetaDescription;
  String? SerialNumber;
  String? Productnumber;

  ReviewPublishScreen(
      {super.key,
      this.productID,
      this.productname,
      this.productType,
      this.productPrice,
      this.shortDes,
      this.town,
      this.address,
      this.state,
      this.city,
      this.zip_code,
      this.deliverySize,
      this.LengthWidthHeight,
      this.SelectNumberOfPackages,
      this.SelectTypeMaterial,
      this.SelectTypeOfPackaging,
      this.Unitofmeasure,
      this.WeightOftheItem,
        this.LongDescription,
        this.MetaDescription,
        this.MetaTitle,
        this.Productnumber,
        this.SerialNumber
      });

  @override
  State<ReviewPublishScreen> createState() => _ReviewPublishScreenState();
}

class _ReviewPublishScreenState extends State<ReviewPublishScreen> {
  String selectedItem = 'Item 1'; // Default selected item

  List<String> itemList = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  bool isItemDetailsVisible = false;
  bool isItemDetailsVisible1 = false;
  bool isItemDetailsVisible2 = false;
  bool isItemDetailsVisible3 = false;
  bool isItemDetailsVisible4 = false;
  final Repositories repositories = Repositories();

  final addProductController = Get.put(AddProductController());
  String productId = "";
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
              return  productDetailsModel.value.productDetails!= null?
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
                        children: [Text('Item details'), Icon(Icons.arrow_drop_down_sharp)],
                      ),
                    ),
                  ),
                  Visibility(
                      visible: isItemDetailsVisible,
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        width: Get.width,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(11)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('product name: ${productDetailsModel.value.productDetails!.product!.pname??""}'),

                            Text('product Type: ${productDetailsModel.value.productDetails!.product!.productType ?? ''}'),
                            Text('product ID: ${productDetailsModel.value.productDetails!.product!.id??""}'),
                            Text('long Des: ${productDetailsModel.value.productDetails!.product!.longDescription ??""}'),
                          ],
                        ),
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
                        children: [Text('Pickup address'), Icon(Icons.arrow_drop_down_sharp)],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Visibility(
                      visible: isItemDetailsVisible1,
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        width: Get.width,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(11)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Town: ${productDetailsModel.value.productDetails!.address!.town??""}'),
                            Text('city: ${productDetailsModel.value.productDetails!.address!.city??""}'),
                            Text('state: ${productDetailsModel.value.productDetails!.address!.state??""}'),
                            Text('address: ${productDetailsModel.value.productDetails!.address!.address??""}'),
                            Text('zip code: ${productDetailsModel.value.productDetails!.address!.zipCode??""}'),
                          ],
                        ),
                      )),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      isItemDetailsVisible2 = !isItemDetailsVisible2;
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
                        children: [Text('Delivery Size'), Icon(Icons.arrow_drop_down_sharp)],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Visibility(
                      visible: isItemDetailsVisible2,
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        width: Get.width,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(11)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('delivery Size: ${productDetailsModel.value.productDetails!.product!.deliverySize??""}'),
                          ],
                        ),
                      )),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: (){
                      isItemDetailsVisible3 = !isItemDetailsVisible3;
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
                        children: [Text('International Shipping Details'), Icon(Icons.arrow_drop_down_sharp)],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  Visibility(
                      visible: isItemDetailsVisible3,
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        width: Get.width,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(11)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Unit of measure: ${productDetailsModel.value.productDetails!.productDimentions!.units??""}'),
                            Text('Weight Of the Item: ${productDetailsModel.value.productDetails!.productDimentions!.weight??""}'),
                            Text('Select Number Of Packages: ${productDetailsModel.value.productDetails!.productDimentions!.numberOfPackage??""}'),
                            Text('Select Type Material: ${productDetailsModel.value.productDetails!.productDimentions!.material??""}'),
                            Text('Select Type Of Packaging: ${productDetailsModel.value.productDetails!.productDimentions!.typeOfPackages??""}'),
                            Text('Length X Width X Height: ${productDetailsModel.value.productDetails!.productDimentions!.boxLength??""}X'+"${productDetailsModel.value.productDetails!.productDimentions!.boxWidth??""}X""${productDetailsModel.value.productDetails!.productDimentions!.boxHeight??""}"),
                          ],
                        ),
                      )),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: (){
                      isItemDetailsVisible4 = !isItemDetailsVisible4;
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
                        children: [Text('Optional'), Icon(Icons.arrow_drop_down_sharp)],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  Visibility(
                      visible: isItemDetailsVisible4,
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        width: Get.width,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(11)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Long Description: ${productDetailsModel.value.productDetails!.product!.longDescription??""}'),
                            Text('Meta Title: ${productDetailsModel.value.productDetails!.product!.metaTitle??""}'),
                            Text('Meta Description: ${productDetailsModel.value.productDetails!.product!.metaDescription??""}'),
                            Text('Serial Number: ${productDetailsModel.value.productDetails!.product!.serialNumber??""}'),
                            Text('Product number: ${productDetailsModel.value.productDetails!.product!.productNumber??""}'),
                          ],
                        ),
                      )),
                  const SizedBox(height: 20),
                  CustomOutlineButton(
                    title: 'Confirm',
                    borderRadius: 11,
                    onPressed: () {
                      Get.to(const RewardScreen());
                    },
                  ),
                ],
              ):Center(
          child: CircularProgressIndicator(
            color: Colors.grey,
          )
              );
            })

        ),
      ),
    );
  }
}
