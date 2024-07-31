import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/profile_controller.dart';
import '../controller/vendor_controllers/add_product_controller.dart';
import '../model/common_modal.dart';
import '../model/jobResponceModel.dart';
import '../repository/repository.dart';
import '../singleproductScreen/ReviewandPublishScreen.dart';
import '../utils/api_constant.dart';
import '../vendor/authentication/image_widget.dart';
import '../widgets/common_button.dart';
import '../widgets/multiImagePicker.dart';
import 'myItemIsScreen.dart';

class AddProductFirstImageScreen extends StatefulWidget {
  int? id;
  File? image;
  File? galleryImg;
  AddProductFirstImageScreen({super.key,this.id,this.image,this.galleryImg});

  @override
  State<AddProductFirstImageScreen> createState() => _AddProductFirstImageScreenState();
}

class _AddProductFirstImageScreenState extends State<AddProductFirstImageScreen> {

  RxBool showValidation = false.obs;
  final profileController = Get.put(ProfileController());
  bool checkValidation(bool bool1, bool2) {
    if (bool1 == true && bool2 == true) {
      return true;
    } else {
      return false;
    }
  }
  File featuredImage = File("");
  List<File> selectedFiles = [];
  List<String> selectedFilesOld = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.id != null){
      profileController.getVendorCategories(addProductController.idProduct.value.toString());
      featuredImage = File(profileController.productDetailsModel.value.productDetails!.product!.featuredImage);
      if (profileController.productDetailsModel.value.productDetails != null &&
          profileController.productDetailsModel.value.productDetails!.product != null &&
          profileController.productDetailsModel.value.productDetails!.product!.galleryImage != null) {
        for (var i = 0; i < profileController.productDetailsModel.value.productDetails!.product!.galleryImage!.length; i++) {
          selectedFiles.add(File(profileController.productDetailsModel.value.productDetails!.product!.galleryImage![i]));
          selectedFilesOld.add(profileController.productDetailsModel.value.productDetails!.product!.galleryImage![i]);
        }
      }
      //
      //  featuredImage = widget.image!;
      //  log('new image is::::${featuredImage.toString()}');
      // if (! selectedFiles.contains(widget.galleryImg!)) {
      //    selectedFiles.add(widget.galleryImg!);
      // }
    }

  }
  int productID = 0;
  final addProductController = Get.put(AddProductController());
  Map<String, File> images = {};
  void addProduct() {
    Map<String, String> map = {};
    if(widget.id != null){
    map["id"] = addProductController.idProduct.value.toString();
    for (int i = 0; i <  selectedFilesOld.length; i++) {
      map["gallery_image_old[$i]"] =  selectedFilesOld[i].toString();
    }
    }
    images["featured_image"] =  featuredImage;
    for (int i = 0; i <  selectedFiles.length; i++) {
      images["gallery_image[$i]"] =  selectedFiles[i];
    }
    log('images: $images');
    final Repositories repositories = Repositories();
    repositories
        .multiPartApi(
        mapData: map,
        images: images,
        context: context,
        url: ApiUrls.giveawayProductAddress,
        onProgress: (int bytes, int totalBytes) {

        })
        .then((value) {
      JobResponceModel response = JobResponceModel.fromJson(jsonDecode(value));
      log('response${response.toJson()}');
       profileController.productImage = featuredImage;
      if(response.status == false){
        showToastCenter(response.message.toString());
      }
      addProductController.idProduct.value = response.productDetails!.product!.id.toString();
      if(widget.id != null){
        profileController.getVendorCategories(addProductController.idProduct.value.toString());
        Get.back();
      }
      else {
        Get.to(MyItemISScreen());
      }
      showToast('Add Product Image successfully'.tr);
    });
  }
  final productController = Get.put(AddProductController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:  Text('Add Product'.tr),
        centerTitle: true,
        leading: GestureDetector(
          onTap: (){
            if(widget.id != null){
              profileController.getVendorCategories(addProductController.idProduct.value.toString());
              Get.back();
            }
            else {
              Get.back();
            }
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
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 30,right: 30,top: 30),
          child: Column(
            children: [
              ProductImageWidget(
                // key: paymentReceiptCertificateKey,
                title: "Upload cover photo".tr,
                file: featuredImage,
                validation: checkValidation(showValidation.value, featuredImage.path.isEmpty),
                filePicked: (File g) {
                  featuredImage = g;
                },
              ),
              const SizedBox(height: 20,),
              MultiImageWidget(
                files: selectedFiles,
                title: 'Upload extra photos'.tr,
                validation: true,
                imageOnly: true,
                filesPicked: (List<File> pickedFiles) {
                  setState(() {
                    selectedFiles = pickedFiles;
                  });
                },
              ),

              SizedBox(height: 50,),

              CustomOutlineButton(
                title: 'Next'.tr,
                onPressed: () {
                  if(featuredImage.path.isNotEmpty && selectedFiles.isNotEmpty){
                    productController.getProductsCategoryList();
                    addProduct();
                  }
                  else{
                    showToast('Please select Image'.tr);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
