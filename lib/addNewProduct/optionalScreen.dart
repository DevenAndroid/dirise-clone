import 'dart:convert';
import 'dart:developer';

import 'package:dirise/addNewProduct/reviewPublishScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/vendor_controllers/add_product_controller.dart';
import '../model/common_modal.dart';
import '../model/reviewAndPublishResponseodel.dart';
import '../repository/repository.dart';
import '../utils/api_constant.dart';
import '../widgets/common_button.dart';
import '../widgets/common_colour.dart';
import '../widgets/common_textfield.dart';

class OptionalScreen extends StatefulWidget {
  const OptionalScreen({super.key});

  @override
  State<OptionalScreen> createState() => _OptionalScreenState();
}

class _OptionalScreenState extends State<OptionalScreen> {
  final TextEditingController metaTitleController = TextEditingController();
  final TextEditingController metaDescriptionController = TextEditingController();
  final TextEditingController longDescriptionController = TextEditingController();
  final TextEditingController serialNumberController = TextEditingController();
  final TextEditingController productNumberController = TextEditingController();
  RxBool hide = true.obs;
  RxBool hide1 = true.obs;
  bool showValidation = false;
  final Repositories repositories = Repositories();
  final formKey1 = GlobalKey<FormState>();
  String code = "+91";
  String? productID;
  String? productName;
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

  final addProductController = Get.put(AddProductController());

  optionalApi() {
    Map<String, dynamic> map = {};

    map['meta_title'] = metaTitleController.text.trim();
    map['item_type'] = 'giveaway';
    map['meta_description'] = metaDescriptionController.text.trim();
    map['long_description'] = longDescriptionController.text.trim();
    map['serial_number'] = serialNumberController.text.trim();
    map['product_number'] = productNumberController.text.trim();
    map['id'] = addProductController.idProduct.value.toString();

    FocusManager.instance.primaryFocus!.unfocus();
    repositories.postApi(url: ApiUrls.giveawayProductAddress, context: context, mapData: map).then((value) {
      ReviewAndPublishResponseModel response = ReviewAndPublishResponseModel.fromJson(jsonDecode(value));
      print('API Response Status Code: ${response.status}');

      if (response.status == true) {
        productName = response.productDetails!.product!.pname.toString();
        productID = response.productDetails!.product!.id.toString();
        productPrice = response.productDetails!.product!.pPrice.toString();
        productType = response.productDetails!.product!.productType.toString();
        shortDes = response.productDetails!.product!.shortDescription.toString();

        town =     response.productDetails!.address!.town.toString();
        city =     response.productDetails!.address!.city.toString();
        state =    response.productDetails!.address!.state.toString();
        address =  response.productDetails!.address!.address.toString();
        zip_code = response.productDetails!.address!.zipCode.toString();

        Unitofmeasure = response.productDetails!.internaionalShipping!.units.toString();
        WeightOftheItem = response.productDetails!.internaionalShipping!.weight.toString();
        SelectNumberOfPackages = response.productDetails!.internaionalShipping!.numberOfPackage.toString();
        SelectTypeMaterial = response.productDetails!.internaionalShipping!.material.toString();
        LengthWidthHeight = response.productDetails!.internaionalShipping!.boxDimension.toString();
        SelectTypeOfPackaging = response.productDetails!.internaionalShipping!.typeOfPackages.toString();

        LongDescription =response.productDetails!.product!.longDescription.toString();
        MetaTitle = response.productDetails!.product!.metaTitle.toString();
        MetaDescription = response.productDetails!.product!.metaDescription.toString();
        SerialNumber = response.productDetails!.product!.serialNumber.toString();
        Productnumber = response.productDetails!.product!.productNumber.toString();

        deliverySize = response.productDetails!.product!.deliverySize.toString();
        log('ddddddd' + response.productDetails!.product!.vendorId.toString());
        if (formKey1.currentState!.validate()) {
          Get.to(ReviewPublishScreen(
            productID: productID,
            productname: productName,
            productPrice: productPrice,
            productType: productType,
            shortDes: shortDes,
            town: town,
            state: state,
            city: city,
            address: address,
            deliverySize: deliverySize,
             LengthWidthHeight: LengthWidthHeight,
            LongDescription: LongDescription,
            MetaDescription: MetaDescription,
            MetaTitle: MetaTitle,
            Productnumber: Productnumber,
            SelectNumberOfPackages: SelectNumberOfPackages,
            SelectTypeMaterial: SelectTypeMaterial,
            SelectTypeOfPackaging: SelectTypeOfPackaging,
            SerialNumber: SerialNumber,
            Unitofmeasure: Unitofmeasure,
             WeightOftheItem: WeightOftheItem,
            zip_code: zip_code,
          ));
        }
      }
    });
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
              'Optional'.tr,
              style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          child: Form(
            key: formKey1,
            child: Column(
              children: [
                TextFormField(
                  maxLines: 2,
                  minLines: 2,
                  decoration: InputDecoration(
                    counterStyle: GoogleFonts.poppins(
                      color: AppTheme.primaryColor,
                      fontSize: 25,
                    ),
                    counter: const Offstage(),
                    errorMaxLines: 2,
                    contentPadding: const EdgeInsets.all(15),
                    fillColor: Colors.grey.shade100,
                    hintText: 'Long Description(optional)',
                    hintStyle: GoogleFonts.poppins(
                      color: AppTheme.primaryColor,
                      fontSize: 15,
                    ),
                    border: InputBorder.none,
                    focusedErrorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: AppTheme.secondaryColor)),
                    errorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: AppTheme.secondaryColor)),
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
                ),
                CommonTextField(
                    // controller: _referralEmailController,
                    obSecure: false,
                    hintText: 'Meta Title'.tr,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Meta Title is required'.tr;
                      }
                      return null; // Return null if validation passes
                    },
                    ),
                TextFormField(
                  maxLines: 2,
                  minLines: 2,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Meta description is required'.tr;
                    }
                    return null; // Return null if validation passes
                  },
                  decoration: InputDecoration(
                    counterStyle: GoogleFonts.poppins(
                      color: AppTheme.primaryColor,
                      fontSize: 25,
                    ),
                    counter: const Offstage(),
                    errorMaxLines: 2,
                    contentPadding: const EdgeInsets.all(15),
                    fillColor: Colors.grey.shade100,
                    hintText: 'Meta Description',
                    hintStyle: GoogleFonts.poppins(
                      color: AppTheme.primaryColor,
                      fontSize: 15,
                    ),
                    border: InputBorder.none,
                    focusedErrorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: AppTheme.secondaryColor)),
                    errorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: AppTheme.secondaryColor)),
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
                ),
                CommonTextField(
                    // controller: _referralEmailController,
                    obSecure: false,
                    hintText: 'Serial Number'.tr,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Serial Number is required'.tr;
                      }
                      return null; // Return null if validation passes
                    },
                    ),
                CommonTextField(
                    // controller: _referralEmailController,
                    obSecure: false,
                    hintText: 'Product number'.tr,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Product number is required'.tr;
                      }
                      return null; // Return null if validation passes
                    },
                    ),
                const SizedBox(height: 20),
                CustomOutlineButton(
                  title: 'Next',
                  borderRadius: 11,
                  onPressed: () {
                    optionalApi();
                  },
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {

                    Get.to(ReviewPublishScreen());
                  },
                  child: Container(
                    width: Get.width,
                    height: 55,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black, // Border color
                        width: 1.0, // Border width
                      ),
                      borderRadius: BorderRadius.circular(10), // Border radius
                    ),
                    padding: const EdgeInsets.all(10), // Padding inside the container
                    child: const Center(
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Text color
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
