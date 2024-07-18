import 'dart:convert';
import 'package:dirise/Services/review_publish_service.dart';
import 'package:dirise/addNewProduct/reviewPublishScreen.dart';
import 'package:dirise/controller/service_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/profile_controller.dart';
import '../controller/vendor_controllers/add_product_controller.dart';
import '../model/common_modal.dart';
import '../repository/repository.dart';
import '../utils/api_constant.dart';
import '../widgets/common_button.dart';
import '../widgets/common_colour.dart';
import '../widgets/common_textfield.dart';

class OptionalColloectionScreen extends StatefulWidget {
  dynamic id;
  dynamic Packagedetails;
  dynamic PromotionCode;
  dynamic ProductCode;
  dynamic SerialNumber;
  dynamic Productnumber;
  OptionalColloectionScreen(
      {super.key,
        this.id,
        this.Packagedetails,
        this.Productnumber,
        this.SerialNumber,
        this.PromotionCode,
        this.ProductCode});


  @override
  State<OptionalColloectionScreen> createState() => _OptionalColloectionScreenState();
}

class _OptionalColloectionScreenState extends State<OptionalColloectionScreen> {
  RxBool hide = true.obs;
  RxBool hide1 = true.obs;
  bool showValidation = false;
  final Repositories repositories = Repositories();
  final formKey1 = GlobalKey<FormState>();
  String code = "+91";
  final addProductController = Get.put(AddProductController());
  TextEditingController serialNumberController = TextEditingController();
  TextEditingController productNumberController = TextEditingController();
  TextEditingController productCodeController = TextEditingController();
  TextEditingController promotionCodeController = TextEditingController();
  TextEditingController packageDetailsController = TextEditingController();
  optionalApi() {
    Map<String, dynamic> map = {};
    map['item_type'] = 'service';
    map['id'] = addProductController.idProduct.value.toString();
    map['serial_number'] = serialNumberController.text.trim();
    map['product_number'] = productNumberController.text.trim();
    map['product_code'] = productCodeController.text.trim();
    map['promotion_code'] = promotionCodeController.text.trim();
    map['package_detail'] = packageDetailsController.text.trim();
    FocusManager.instance.primaryFocus!.unfocus();
    repositories.postApi(url: ApiUrls.giveawayProductAddress, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      print('API Response Status Code: ${response.status}');
      showToast(response.message.toString());
      if (response.status == true) {
        if(widget.id != null){
          Get.to(ReviewPublishServiceScreen());
        }
        Get.to(ReviewPublishServiceScreen());

      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.id != null) {
     serialNumberController.text = widget.SerialNumber.toString();
     productNumberController.text = widget.Productnumber.toString();
     productCodeController.text = widget.ProductCode.toString();
     promotionCodeController.text = widget.SerialNumber.toString();
     packageDetailsController.text = widget.Productnumber.toString();
    }
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
              'Optional Classification'.tr,
              style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey1,
          child: Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: [
                CommonTextField(
                  controller: serialNumberController,
                  obSecure: false,
                  hintText: 'Serial Number'.tr,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Meta Title is required".tr;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10,),
                CommonTextField(
                  controller: productNumberController,
                  obSecure: false,
                  hintText: 'Product number'.tr,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Serial Number is required".tr;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10,),
                CommonTextField(
                  controller: productCodeController,
                  obSecure: false,
                  hintText: 'Product Code'.tr,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Product number is required".tr;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10,),
                CommonTextField(
                  controller: promotionCodeController,
                  obSecure: false,
                  hintText: 'Promotion Code'.tr,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Product number is required".tr;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  controller: packageDetailsController,
                  maxLines: 5,
                  minLines: 5,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Package details is required".tr;
                    }
                    return null;
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
                    hintText: 'Package details',
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
                const SizedBox(height: 100),
                CustomOutlineButton(
                  title: 'Next',
                  borderRadius: 11,
                  onPressed: () {
                    if (formKey1.currentState!.validate()) {
                      optionalApi();
                    }

                  },
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {},
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
