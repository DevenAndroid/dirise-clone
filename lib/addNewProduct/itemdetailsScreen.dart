import 'dart:convert';

import 'package:dirise/addNewProduct/pickUpAddressScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/vendor_controllers/vendor_profile_controller.dart';
import '../model/common_modal.dart';
import '../model/productCategoryModel.dart';
import '../model/vendor_models/model_vendor_details.dart';
import '../model/vendor_models/vendor_category_model.dart';
import '../repository/repository.dart';
import '../utils/api_constant.dart';
import '../widgets/common_button.dart';
import '../widgets/common_colour.dart';
import '../widgets/common_textfield.dart';
import 'package:http/http.dart' as http;

class ItemDetailsScreens extends StatefulWidget {
  const ItemDetailsScreens({super.key});

  @override
  State<ItemDetailsScreens> createState() => _ItemDetailsScreensState();
}

class _ItemDetailsScreensState extends State<ItemDetailsScreens> {
  ProductCategoryData? selectedSubcategory;


  final TextEditingController ProductNameController = TextEditingController();


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

  ModelVendorCategory modelVendorCategory = ModelVendorCategory(usphone: []);
  Rx<RxStatus> vendorCategoryStatus = RxStatus.empty().obs;
  final GlobalKey categoryKey = GlobalKey();
  final GlobalKey subcategoryKey = GlobalKey();
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

  void fetchDataBasedOnId(int id) async {
    String apiUrl = 'https://dirise.eoxyslive.com/api/product-category?id=$id';
    await repositories.getApi(url: apiUrl).then((value) {
      ProductCategoryModel productCategoryModel = ProductCategoryModel.fromJson(jsonDecode(value));
      setState(() {
        fetchedDropdownItems = productCategoryModel.data ?? [];
      });
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVendorCategories();
    fetchDataBasedOnId(1);
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
              'Item Details'.tr,
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
                  controller: ProductNameController,
                  obSecure: false,
                  hintText: 'Name',
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'Product Name is required'.tr),
                  ])),
              const SizedBox(
                height: 10,
              ),
              Obx(() {
                if (kDebugMode) {
                  print(modelVendorCategory.usphone!
                      .map((e) => DropdownMenuItem(value: e, child: Text(e.name.toString().capitalize!)))
                      .toList());
                }
                return DropdownButtonFormField<VendorCategoriesData>(
                  key: categoryKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  icon: vendorCategoryStatus.value.isLoading
                      ? const CupertinoActivityIndicator()
                      : const Icon(Icons.keyboard_arrow_down_rounded),
                  iconSize: 30,
                  iconDisabledColor: const Color(0xff97949A),
                  iconEnabledColor: const Color(0xff97949A),
                  value: null,
                  style: GoogleFonts.poppins(color: Colors.black, fontSize: 16),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    fillColor: const Color(0xffE2E2E2).withOpacity(.35),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10).copyWith(right: 8),
                    focusedErrorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: AppTheme.secondaryColor)),
                    errorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Color(0xffE2E2E2))),
                    focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: AppTheme.secondaryColor)),
                    disabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: AppTheme.secondaryColor),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: AppTheme.secondaryColor),
                    ),
                  ),
                  items: modelVendorCategory.usphone!
                      .map((e) => DropdownMenuItem(value: e, child: Text(e.name.toString().capitalize!)))
                      .toList(),
                  hint: Text('Search category to choose'.tr),
                  onChanged: (value) {
                    // selectedCategory = value;
                    if (value != null) {
                      fetchDataBasedOnId(value.id); // Fetch data based on selected ID
                    }
                    if (value == null) return;
                    if (allSelectedCategory.isNotEmpty) return;
                    allSelectedCategory[value.id.toString()] = value;
                    setState(() {});
                  },
                  validator: (value) {
                    if (allSelectedCategory.isEmpty) {
                      return "Please select Category".tr;
                    }
                    return null;
                  },
                );
              }),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Select Subcategory',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              DropdownButtonFormField<ProductCategoryData>(
                key: subcategoryKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                iconSize: 30,
                iconDisabledColor: const Color(0xff97949A),
                iconEnabledColor: const Color(0xff97949A),
                value: null,
                style: GoogleFonts.poppins(color: Colors.black, fontSize: 16),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: const Color(0xffE2E2E2).withOpacity(.35),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10).copyWith(right: 8),
                  focusedErrorBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: AppTheme.secondaryColor)),
                  errorBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: Color(0xffE2E2E2))),
                  focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: AppTheme.secondaryColor)),
                  disabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: AppTheme.secondaryColor),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: AppTheme.secondaryColor),
                  ),
                ),
                items: fetchedDropdownItems
                    .map((e) => DropdownMenuItem(value: e, child: Text(e.title.toString())))
                    .toList(),
                hint: Text('Search category to choose'.tr),
                onChanged: (value) {
                  selectedSubcategory = value;
                },
                validator: (value) {
                  return null;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              CustomOutlineButton(
                title: 'Confirm',
                borderRadius: 11,
                onPressed: () {
                  editAddressApi();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
