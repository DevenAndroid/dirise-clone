import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dirise/addNewProduct/pickUpAddressScreen.dart';
import 'package:dirise/addNewProduct/rewardScreen.dart';
import 'package:dirise/utils/api_constant.dart';
import 'package:dirise/utils/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/profile_controller.dart';
import '../controller/vendor_controllers/add_product_controller.dart';
import '../model/common_modal.dart';
import '../model/product_details.dart';
import '../model/reviewAndPublishModel.dart';
import '../repository/repository.dart';
import '../tellaboutself/ExtraInformation.dart';
import '../widgets/common_button.dart';
import '../widgets/common_colour.dart';
import 'addProductFirstImageScreen.dart';
import 'deliverySizeScreen.dart';
import 'internationalshippingdetailsScreem.dart';
import 'itemdetailsScreen.dart';
import 'optionalScreen.dart';

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
      this.SerialNumber});

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
  RxBool isImageProvide = false.obs;
  RxBool isOtherImageProvide = false.obs;
  final Repositories repositories = Repositories();

  final addProductController = Get.put(AddProductController());
  final addProductControllerNew = Get.put(ProfileController());
  String productId = "";
  Rx<RxStatus> vendorCategoryStatus = RxStatus.empty().obs;
  completeApi() {
    Map<String, dynamic> map = {};

    map['is_complete'] = true;
    map['id'] = addProductController.idProduct.value.toString();
    map['in_stock'] = '1';
    FocusManager.instance.primaryFocus!.unfocus();
    repositories.postApi(url: ApiUrls.giveawayProductAddress, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      print('API Response Status Code: ${response.status}');
      showToast(response.message.toString());
      if (response.status == true) {
        Get.to(const RewardScreen());
      }});}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    log('dadadad${addProductController.idProduct.value.toString()}');
    addProductControllerNew.getVendorCategories(addProductController.idProduct.value.toString());

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
              return addProductControllerNew.productDetailsModel.value.productDetails != null
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
                                color: Colors.grey.shade200,
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
                                margin: const EdgeInsets.only(top: 10),
                                width: Get.width,
                                padding: const EdgeInsets.all(10),
                                decoration:
                                BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(11)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(addProductControllerNew.productDetailsModel.value.productDetails!.product!.featuredImage,height: 200,)
                                  ],
                                ),
                              ),
                              Positioned(
                                  right: 10,
                                  top: 20,
                                  child: GestureDetector(
                                      onTap: () {
                                        File imageFile = File(addProductControllerNew.productDetailsModel.value.productDetails!.product!.featuredImage);
                                        // File gallery = File(addProductControllerNew.productDetailsModel.value.productDetails!.product!.galleryImage![0]);

                                        Get.to(AddProductFirstImageScreen(
                                          id: addProductControllerNew.productDetailsModel.value.productDetails!.product!.id,
                                          image: imageFile,
                                          // galleryImg: gallery,

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
                                color: Colors.white,
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
                              children: [const Text('Item details'),
                                isItemDetailsVisible != true    ?
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

                              ],
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
                                      20.spaceY,
                                      Text(
                                          'product name: ${addProductControllerNew.productDetailsModel.value.productDetails!.product!.pname ?? ""}'),
                                      Text(
                                          'product Type: ${addProductControllerNew.productDetailsModel.value.productDetails!.product!.productType ?? ''}'),
                                      Text('product ID: ${addProductControllerNew.productDetailsModel.value.productDetails!.product!.id ?? ""}'),
                                      Text('vendor category: ${addProductControllerNew.productDetailsModel.value.productDetails!.product!.catName ?? ""}'),
                                      Text('my item is a : ${ addProductControllerNew.productDetailsModel.value.productDetails!.product!.giveawayItemCondition}'),
                                      // Text('my item is a : ${  addProductControllerNew.productDetailsModel.value.productDetails!.product!.catId != 'null' ?  addProductControllerNew.productDetailsModel.value.productDetails!.product!.catId : ''}'),
                                    ],
                                  ),
                                ),
                                Positioned(
                                    right: 10,
                                    top: 20,
                                    child: GestureDetector(
                                        onTap: (){
                                          Get.to(ItemDetailsScreens(id: addProductControllerNew.productDetailsModel.value.productDetails!.product!.id,
                                            name: addProductControllerNew.productDetailsModel.value.productDetails!.product!.pname,
                                            categoryName:  addProductControllerNew.productDetailsModel.value.productDetails!.product!.catName,
                                            catId:  addProductControllerNew.productDetailsModel.value.productDetails!.product!.catId2.toString(),
                                            categoryID:  addProductControllerNew.productDetailsModel.value.productDetails!.product!.catId != 'null' ?  addProductControllerNew.productDetailsModel.value.productDetails!.product!.catId : '',
                                          ));
                                        },
                                        child: const Text('Edit',style: TextStyle(color: Colors.red,fontSize: 13),)))
                              ],
                            )
                        ),
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
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [const Text('Pickup address'),
                                isItemDetailsVisible1 != true    ?
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
                              ],
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
                              child: Stack(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      20.spaceY,
                                      Text('Town: ${addProductControllerNew.productDetailsModel.value.productDetails!.address!.town ?? ""}'),
                                      Text('city: ${addProductControllerNew.productDetailsModel.value.productDetails!.address!.city ?? ""}'),
                                      Text('state: ${addProductControllerNew.productDetailsModel.value.productDetails!.address!.state ?? ""}'),
                                      Text('address: ${addProductControllerNew.productDetailsModel.value.productDetails!.address!.address ?? ""}'),
                                      Text('zip code: ${addProductControllerNew.productDetailsModel.value.productDetails!.address!.zipCode ?? ""}'),
                                    ],
                                  ),
                                  Positioned(
                                    right: 10,
                                      top: 10,
                                      child: GestureDetector(
                                        onTap: (){
                                          Get.to(AddProductPickUpAddressScreen(
                                            id: addProductControllerNew.productDetailsModel.value.productDetails!.address!.id ?? "",
                                            town: addProductControllerNew.productDetailsModel.value.productDetails!.address!.town ?? "",
                                            country: addProductControllerNew.productDetailsModel.value.productDetails!.address!.country ?? "",
                                            zipcode: addProductControllerNew.productDetailsModel.value.productDetails!.address!.zipCode ?? "",
                                            state: addProductControllerNew.productDetailsModel.value.productDetails!.address!.state ?? "",
                                            city: addProductControllerNew.productDetailsModel.value.productDetails!.address!.city ?? "",
                                            street: addProductControllerNew.productDetailsModel.value.productDetails!.address!.address ?? "",
                                          ));
                                        },
                                          child: const Text('Edit',style: TextStyle(color: Colors.red,fontSize: 13),)
                                      )
                                  )
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
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [const Text('Delivery Size'),
                                isItemDetailsVisible2 != true    ?
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
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Visibility(
                            visible: isItemDetailsVisible2,
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
                                      20.spaceY,
                                      Text(
                                          'delivery Size: ${addProductControllerNew.productDetailsModel.value.productDetails!.product!.deliverySize ?? ""}'),
                                    ],
                                  ),
                                ),
                                Positioned(
                                    right: 10,
                                    top: 20,
                                    child: GestureDetector(
                                        onTap: (){
                                          Get.to(DeliverySizeScreen(id: addProductControllerNew.productDetailsModel.value.productDetails!.product!.id,
                                            selectedRadio: addProductControllerNew.productDetailsModel.value.productDetails!.product!.deliverySize,));
                                        },
                                        child: const Text('Edit',style: TextStyle(color: Colors.red,fontSize: 13),)))

                              ],
                            )),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
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
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [const Text('Item Weight & Dimensions'),
                                isItemDetailsVisible3 != true    ?
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
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Visibility(
                            visible: isItemDetailsVisible3,
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
                                      20.spaceY,
                                      Text(
                                          'Unit of measure: ${addProductControllerNew.productDetailsModel.value.productDetails!.productDimentions!.units ?? ""}'),
                                      Text(
                                          'Weight Of the Item: ${addProductControllerNew.productDetailsModel.value.productDetails!.productDimentions!.weight ?? ""}'),
                                      Text(
                                          'Select Number Of Packages: ${addProductControllerNew.productDetailsModel.value.productDetails!.productDimentions!.numberOfPackage ?? ""}'),
                                      Text(
                                          'Select Type Material: ${addProductControllerNew.productDetailsModel.value.productDetails!.productDimentions!.material ?? ""}'),
                                      Text(
                                          'Select Type Of Packaging: ${addProductControllerNew.productDetailsModel.value.productDetails!.productDimentions!.typeOfPackages ?? ""}'),
                                      Text('Length X Width X Height: ${addProductControllerNew.productDetailsModel.value.productDetails!.productDimentions!.boxLength ?? ""}X' +
                                          "${addProductControllerNew.productDetailsModel.value.productDetails!.productDimentions!.boxWidth ?? ""}X"
                                              "${addProductControllerNew.productDetailsModel.value.productDetails!.productDimentions!.boxHeight ?? ""}"),
                                    ],
                                  ),
                                ),
                                Positioned(
                                    right: 10,
                                    top: 20,
                                    child: GestureDetector(
                                        onTap: (){
                                          Get.to(InternationalshippingdetailsScreen(
                                            id: addProductControllerNew.productDetailsModel.value.productDetails!.product!.id,
                                            WeightOftheItem: addProductControllerNew.productDetailsModel.value.productDetails!.productDimentions!.weightUnit,
                                            Unitofmeasure: addProductControllerNew.productDetailsModel.value.productDetails!.productDimentions!.weight!,
                                            SelectTypeOfPackaging: addProductControllerNew.productDetailsModel.value.productDetails!.productDimentions!.typeOfPackages,
                                            SelectTypeMaterial:addProductControllerNew.productDetailsModel.value.productDetails!.productDimentions!.material ,
                                            SelectNumberOfPackages:addProductControllerNew.productDetailsModel.value.productDetails!.productDimentions!.numberOfPackage ,
                                            Length: "${addProductControllerNew.productDetailsModel.value.productDetails!.productDimentions!.boxLength}" ,
                                            Width : "${addProductControllerNew.productDetailsModel.value.productDetails!.productDimentions!.boxWidth ?? ""}",
                                            Height : "${addProductControllerNew.productDetailsModel.value.productDetails!.productDimentions!.boxHeight ?? ""}",
                                            selectTypeMaterial:addProductControllerNew.productDetailsModel.value.productDetails!.productDimentions!.material.toString(),
                                            productType : addProductControllerNew.productDetailsModel.value.productDetails!.productDimentions!.typeOfPackages.toString(),
                                          )
                                              ,arguments: "txt"
                                          );

                                        },
                                        child: const Text('Edit',style: TextStyle(color: Colors.red,fontSize: 13),)))

                              ],
                            )),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
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
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [const Text('Optional'),
                                isItemDetailsVisible4 != true    ?
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
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Visibility(
                            visible: isItemDetailsVisible4,
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
                                      20.spaceY,
                                      Text(
                                          'Long Description: ${addProductControllerNew.productDetailsModel.value.productDetails!.product!.longDescription ?? ""}'),
                                      Text(
                                          'Meta Title: ${addProductControllerNew.productDetailsModel.value.productDetails!.product!.metaTitle ?? ""}'),
                                      Text(
                                          'Meta Description: ${addProductControllerNew.productDetailsModel.value.productDetails!.product!.metaDescription ?? ""}'),
                                      Text(
                                          'Serial Number: ${addProductControllerNew.productDetailsModel.value.productDetails!.product!.serialNumber ?? ""}'),
                                      Text(
                                          'Product number: ${addProductControllerNew.productDetailsModel.value.productDetails!.product!.productNumber ?? ""}'),
                                    ],
                                  ),
                                ),
                                Positioned(
                                    right: 10,
                                    top: 20,
                                    child: GestureDetector(
                                        onTap: (){
                                          Get.to(OptionalScreen(
                                            id: addProductControllerNew.productDetailsModel.value.productDetails!.product!.id,
                                            SerialNumber: addProductControllerNew.productDetailsModel.value.productDetails!.product!.serialNumber,
                                            Productnumber: addProductControllerNew.productDetailsModel.value.productDetails!.product!.productNumber,
                                            MetaTitle: addProductControllerNew.productDetailsModel.value.productDetails!.product!.metaTitle,
                                            MetaDescription: addProductControllerNew.productDetailsModel.value.productDetails!.product!.metaDescription,
                                            LongDescription: addProductControllerNew.productDetailsModel.value.productDetails!.product!.longDescription,
                                          )
                                          );
                                        },
                                        child: const Text('Edit',style: TextStyle(color: Colors.red,fontSize: 13),)))

                              ],
                            )
                        ),
                        const SizedBox(height: 20),
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
            })),
      ),
    );
  }
}
