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
import '../utils/api_constant.dart';
import '../vendor/authentication/image_widget.dart';
import '../widgets/common_button.dart';
import 'myItemIsScreen.dart';

class AddProductFirstImageScreen extends StatefulWidget {
  const AddProductFirstImageScreen({super.key});

  @override
  State<AddProductFirstImageScreen> createState() => _AddProductFirstImageScreenState();
}

class _AddProductFirstImageScreenState extends State<AddProductFirstImageScreen> {
  File featuredImage = File("");
  File galleryImage = File("");
  RxBool showValidation = false.obs;
  final profileController = Get.put(ProfileController());
  bool checkValidation(bool bool1, bool2) {
    if (bool1 == true && bool2 == true) {
      return true;
    } else {
      return false;
    }
  }
   int productID = 0;
  final addProductController = Get.put(AddProductController());
  Map<String, File> images = {};
  void addProduct() {
    Map<String, String> map = {};
    images["featured_image"] = featuredImage;
    images["gallery_image[0]"] = galleryImage;

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
      addProductController.idProduct.value = response.productDetails!.product!.id.toString();
       // profileController.productID = productID;
       Get.to(MyItemISScreen(featureImage: featuredImage,));
      showToast('Add Product Image successfully');
    });
  }
  final productController = Get.put(AddProductController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Add Product'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 30,right: 30,top: 30),
          child: Column(
            children: [
              ImageWidget(
                // key: paymentReceiptCertificateKey,
                title: "Click To Edit Uploaded  Image".tr,
                file: featuredImage,
                validation: checkValidation(showValidation.value, featuredImage.path.isEmpty),
                filePicked: (File g) {
                  featuredImage = g;
                },
              ),
              const SizedBox(height: 20,),
              ImageWidget(
                // key: paymentReceiptCertificateKey,
                title: "Click To Edit Uploaded  Image".tr,
                file: galleryImage,
                validation: checkValidation(showValidation.value, galleryImage.path.isEmpty),
                filePicked: (File g) {
                  galleryImage = g;
                },
              ),
              SizedBox(height: 50,),
              CustomOutlineButton(
                title: 'Next',
                onPressed: () {
                  if(featuredImage.path.isNotEmpty && galleryImage.path.isNotEmpty){
                    productController.getProductsCategoryList();
                    addProduct();
                  }else{
                    showToast('Please select Image');
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
