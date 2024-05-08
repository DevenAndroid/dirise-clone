import 'dart:convert';
import 'package:dirise/addNewProduct/pickUpAddressScreen.dart';
import 'package:dirise/controller/vendor_controllers/add_product_controller.dart';
import 'package:dirise/singleproductScreen/singleProductPriceScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/vendor_controllers/vendor_profile_controller.dart';
import '../model/common_modal.dart';
import '../model/getSubCategoryModel.dart';
import '../model/productCategoryModel.dart';
import '../model/vendor_models/add_product_model.dart';
import '../model/vendor_models/model_add_product_category.dart';
import '../model/vendor_models/model_vendor_details.dart';
import '../model/vendor_models/vendor_category_model.dart';
import '../repository/repository.dart';
import '../utils/api_constant.dart';
import '../widgets/common_button.dart';
import '../widgets/common_colour.dart';
import '../widgets/common_textfield.dart';

class ItemDetailsScreens extends StatefulWidget {
  const ItemDetailsScreens({super.key});

  @override
  State<ItemDetailsScreens> createState() => _ItemDetailsScreensState();
}

class _ItemDetailsScreensState extends State<ItemDetailsScreens> {
  ProductCategoryData? selectedSubcategory;
  SubProductData? selectedProductSubcategory;
  final addProductController = Get.put(AddProductController());
  final TextEditingController ProductNameController = TextEditingController();

  int vendorID = 0;
  int ProductID = 0;

  editAddressApi() {
    Map<String, dynamic> map = {};

    map['product_name'] = ProductNameController.text.trim();

    FocusManager.instance.primaryFocus!.unfocus();
    repositories.postApi(url: ApiUrls.giveawayProductAddress, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      print('API Response Status Code: ${response.status}');
      showToast(response.message.toString());
      if (response.status == true) {
        Get.to(AddProductPickUpAddressScreen());
      }
    });
  }
  deliverySizeApi() {
    Map<String, dynamic> map = {};
    map['category_id'] = id.value.toString();
    map['product_name'] = ProductNameController.text.toString();
    map['item_type'] = 'product';
    map['id'] = 'giveaway';
    /////please change this when image ui is done

    final Repositories repositories = Repositories();
    FocusManager.instance.primaryFocus!.unfocus();
    repositories.postApi(url: ApiUrls.giveawayProductAddress, context: context, mapData: map).then((value) {
      AddProductModel response = AddProductModel.fromJson(jsonDecode(value));
      print('API Response Status Code: ${response.status}');
      showToast(response.message.toString());
      if (response.status == true) {
        addProductController.idProduct.value = response.productDetails!.product!.id.toString();
        print(addProductController.idProduct.value.toString());
        Get.to(AddProductPickUpAddressScreen());
      }
    });
  }
  ModelVendorCategory modelVendorCategory = ModelVendorCategory(usphone: []);
  ProductCategoryModel productCategoryModel = ProductCategoryModel();
  Rx<RxStatus> vendorCategoryStatus = RxStatus.empty().obs;
  final GlobalKey categoryKey = GlobalKey();
  final GlobalKey subcategoryKey = GlobalKey();
  final GlobalKey productsubcategoryKey = GlobalKey();
  Map<String, VendorCategoriesData> allSelectedCategory = {};

  final Repositories repositories = Repositories();
  VendorUser get vendorInfo => vendorProfileController.model.user!;
  final vendorProfileController = Get.put(VendorProfileController());
  void getVendorCategories() {
    vendorCategoryStatus.value = RxStatus.loading();
    repositories.getApi(url: ApiUrls.vendorCategoryListUrl, showResponse: false).then((value) {
      modelVendorCategory = ModelVendorCategory.fromJson(jsonDecode(value));
      vendorCategoryStatus.value = RxStatus.success();

      for (var element in vendorInfo.vendorCategory!) {
        allSelectedCategory[element.id.toString()] = VendorCategoriesData.fromJson(element.toJson());
      }
      setState(() {});
    }).catchError((e) {
      vendorCategoryStatus.value = RxStatus.error();
    });
  }

  List<ProductCategoryData> fetchedDropdownItems = [];
  List<SubProductData> subProductData = [];

  void fetchDataBasedOnId(int id) async {
    String apiUrl = 'https://dirise.eoxyslive.com/api/product-category?id=$id';
    await repositories.getApi(url: apiUrl).then((value) {
      productCategoryModel = ProductCategoryModel.fromJson(jsonDecode(value));
      setState(() {
        fetchedDropdownItems = productCategoryModel.productdata ?? [];
      });
    });
  }
  SubCategoryModel subProductCategoryModel = SubCategoryModel();

  void fetchSubCategoryBasedOnId(int id1) async {
    String apiUrl1 = 'https://dirise.eoxyslive.com/api/product-subcategory?category_id=$id1';
    await repositories.getApi(url: apiUrl1).then((value) {
      subProductCategoryModel = SubCategoryModel.fromJson(jsonDecode(value));
      setState(() {
        subProductData = subProductCategoryModel.data ?? [];
      });
    });
  }
  RxString categoryName = "".obs;
  RxString productName = "".obs;
  RxString subName = "".obs;
  RxString id = "".obs;
  bool isItemDetailsVisible = false;
  bool isItemDetailsVisible1 = false;
  bool isItemDetailsVisible2 = false;
  bool isItemDetailsVisible3 = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVendorCategories();
    fetchDataBasedOnId(vendorID);
    fetchSubCategoryBasedOnId(ProductID);
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
              'Product Information'.tr,
              style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Product name'.tr,
                style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
              ),
              CommonTextField(
                  controller:  ProductNameController,
                  obSecure: false,
                  hintText: 'Name',
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'Product Name is required'.tr),
                  ])),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Select Vendor Category',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
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
                    children: [Text(
                        categoryName.value == ""?
                        'Select category to choose':categoryName.value), Icon(Icons.arrow_drop_down_sharp)],
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Visibility(
                visible: isItemDetailsVisible,
                child: ListView.builder(
                    itemCount: modelVendorCategory.usphone!.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      var data = modelVendorCategory.usphone![index];
                      return GestureDetector(
                        onTap: (){
                          fetchDataBasedOnId(data.id);
                          isItemDetailsVisible = !isItemDetailsVisible;
                          categoryName.value = data.name.toString();
                          setState(() {});
                        },
                        child: Container(
                            margin: EdgeInsets.only(bottom: 5),
                            padding: const EdgeInsets.all(10),
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey.shade400, width: 1)),
                            child: Text(data.name)),
                      );
                    }),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Select Product Category',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  isItemDetailsVisible1 = !isItemDetailsVisible1;
                  // fetchSubCategoryBasedOnId(ProductID);
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

                    children: [Text(
                        productName.value == ""?
                        'Select category to choose':productName.value), Icon(Icons.arrow_drop_down_sharp)],
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Visibility(
                  visible: isItemDetailsVisible1,
                  child: productCategoryModel.productdata != null
                      ? ListView.builder(
                      itemCount: productCategoryModel.productdata!.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var products = productCategoryModel.productdata![index];
                        return GestureDetector(
                          onTap: (){
                            fetchSubCategoryBasedOnId(products.id);
                            isItemDetailsVisible1 = !isItemDetailsVisible1;
                            productName.value = products.title.toString();
                            setState(() {});
                          },
                          child: Container(
                              margin: EdgeInsets.only(bottom: 5),
                              padding: const EdgeInsets.all(10),
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.grey.shade400, width: 1)),
                              child: Text(products.title)),
                        );
                      })
                      : SizedBox()),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Select Sub Product Category',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
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
                    children: [Text(
                        subName.value ==""?
                        'Select Sub category to choose':subName.value), Icon(Icons.arrow_drop_down_sharp)],
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Visibility(
                  visible: isItemDetailsVisible2,
                  child:  subProductCategoryModel.data!= null
                      ? ListView.builder(
                      itemCount: subProductCategoryModel.data!.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var products = subProductCategoryModel.data![index];
                        return GestureDetector(
                          onTap: (){
                            isItemDetailsVisible2 = !isItemDetailsVisible2;
                            subName.value = products.title.toString();
                            id.value = products.id.toString();
                            setState(() {});
                          },
                          child: Container(
                              margin: EdgeInsets.only(bottom: 5),
                              padding: const EdgeInsets.all(10),
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.grey.shade400, width: 1)),
                              child: Text(products.title)),
                        );
                      })
                      : SizedBox()),
              // Visibility(
              //     visible: isItemDetailsVisible2,
              //     child: subProductData. != null
              //         ? ListView.builder(
              //         itemCount: productCategoryModel.productdata!.length,
              //         shrinkWrap: true,
              //         physics: const NeverScrollableScrollPhysics(),
              //         itemBuilder: (context, index) {
              //           var products = productCategoryModel.productdata![index];
              //           return Container(
              //               margin: EdgeInsets.only(bottom: 5),
              //               padding: const EdgeInsets.all(10),
              //               height: 50,
              //               decoration: BoxDecoration(
              //                   color: Colors.grey.shade200,
              //                   borderRadius: BorderRadius.circular(10),
              //                   border: Border.all(color: Colors.grey.shade400, width: 1)),
              //               child: Text(products.title));
              //         })
              //         : SizedBox()),
              const SizedBox(
                height: 20,
              ),
              CustomOutlineButton(
                title: 'Confirm',
                borderRadius: 11,
                onPressed: () {

                  if( ProductNameController.text.trim().isEmpty){
                    showToast("Please enter product name");
                  }
                  else if(  categoryName.value == ""){
                    showToast("Please Select Vendor Category");
                  }
                  else if(  productName.value == ""){
                    showToast("Please Select  Product Category");
                  }
                  else if(  subName.value == ""){
                    showToast("Please Select Sub Product Category");
                  }
else {
                    deliverySizeApi();
                  } },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
