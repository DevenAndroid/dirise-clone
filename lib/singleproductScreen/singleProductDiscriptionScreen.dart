import 'dart:convert';

import 'package:dirise/singleproductScreen/singleProductReturnPolicy.dart';
import 'package:dirise/singleproductScreen/virtualProductScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/vendor_controllers/add_product_controller.dart';
import '../model/vendor_models/add_product_model.dart';
import '../repository/repository.dart';
import '../utils/api_constant.dart';
import '../widgets/common_colour.dart';
import '../widgets/common_textfield.dart';
import 'ReviewandPublishScreen.dart';

class SingleProductDiscriptionScreen extends StatefulWidget {

  String? description;
  String? stockquantity;
  String? setstock;
  String? sEOTags;
  int? id;

  SingleProductDiscriptionScreen({super.key,this.description,this.sEOTags,this.setstock,this.stockquantity,this.id});

  @override
  State<SingleProductDiscriptionScreen> createState() => _SingleProductDiscriptionScreenState();
}

class _SingleProductDiscriptionScreenState extends State<SingleProductDiscriptionScreen> {
  final addProductController = Get.put(AddProductController());
  final formKey1 = GlobalKey<FormState>();
  TextEditingController inStockController = TextEditingController();
  TextEditingController shortController   = TextEditingController();
  TextEditingController alertDiscount    = TextEditingController();
  TextEditingController tagDiscount      = TextEditingController();
  RxBool isDelivery = false.obs;
  deliverySizeApi() {
    Map<String, dynamic> map = {};
    map['in_stock'] = inStockController.text.toString();
    map['short_description'] = shortController.text.toString();
    map['stock_alert'] = alertDiscount.text.toString().trim();
    map['seo_tags'] = tagDiscount.text.toString();
    map['item_type'] = 'product';
    map['id'] = addProductController.idProduct.value.toString();

    final Repositories repositories = Repositories();
    FocusManager.instance.primaryFocus!.unfocus();
    repositories.postApi(url: ApiUrls.giveawayProductAddress, context: context, mapData: map).then((value) {
      AddProductModel response = AddProductModel.fromJson(jsonDecode(value));
      print('API Response Status Code: ${response.status}');
      showToast(response.message.toString());
      if (response.status == true) {
        // addProductController.idProduct.value = response.productDetails!.product!.id.toString();
        print(addProductController.idProduct.value.toString());
        if(widget.id != null){
          Get.to( ProductReviewPublicScreen());
        }
        Get.to( SingleProductReturnPolicy());
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.id != null){
      inStockController.text=widget.stockquantity.toString();
      shortController.text=widget.description.toString();
      alertDiscount.text=widget.setstock.toString();
      tagDiscount.text=widget.sEOTags.toString();
    }
  }
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
              'Discription'.tr,
              style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          child: Form(
            key: formKey1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'short description '.tr,
                  style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'short description is required'.tr;
                    }
                    return null;
                  },
                  controller: shortController,
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
                    hintText: 'short description',
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
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 40,
                  width: Get.width,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(11), color: Colors.grey.shade200),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 5,),
                        Text(
                          'Item doesn’t need stock number'.tr,
                          style:
                          GoogleFonts.poppins(color: const Color(0xff514949), fontWeight: FontWeight.w400, fontSize: 13),
                        ),
                        Transform.translate(
                          offset: const Offset(-6, 0),
                          child: Checkbox(
                              visualDensity: const VisualDensity(horizontal: -1, vertical: -3),
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              value: isDelivery.value,

                              side: const BorderSide(
                                color: AppTheme.buttonColor,
                              ),
                              onChanged: (bool? value) {
                                setState(() {
                                  isDelivery.value = value!;
                                });
                              }),
                        ),
                        SizedBox(width: 5,),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                if(isDelivery.value == false)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        'Stock quantity *'.tr,
                        style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                      CommonTextField(
                        controller: inStockController,
                        obSecure: false,
                        keyboardType: TextInputType.number,
                        hintText: 'Stock quantity'.tr,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Stock number is required'.tr;
                          }
                          return null; // Return null if validation passes
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Set stock alert *'.tr,
                        style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                      CommonTextField(
                        controller: alertDiscount,
                        obSecure: false,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          double stockQuantity = double.tryParse(inStockController.text) ?? 0.0;
                          double stockAlert = double.tryParse(value) ?? 0.0;
                          if (inStockController.text.isEmpty) {
                            FocusManager.instance.primaryFocus!.unfocus();
                            alertDiscount.clear();
                            showToastCenter('Enter stock quantity first');
                            return;
                          }
                          if (stockAlert > stockQuantity) {
                            FocusManager.instance.primaryFocus!.unfocus();
                            alertDiscount.clear();
                            showToastCenter('Stock alert cannot be higher than stock quantity');
                          }
                        },
                        hintText: 'Get notification on your stock quantity'.tr,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Set stock alert is required'.tr;
                          }
                          double stockQuantity = double.tryParse(inStockController.text) ?? 0.0;
                          double stockAlert = double.tryParse(value) ?? 0.0;
                          if (stockAlert > stockQuantity) {
                            return 'Stock alert cannot be higher than stock quantity'.tr;
                          }
                          return null; // Return null if validation passes
                        },
                      ),
                    ],
                  ),

                const SizedBox(
                  height: 20,
                ),
                Text(
                  'SEO Tags*'.tr,
                  style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 14),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Add Tags separated by commas”,”'.tr,
                  style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w400, fontSize: 13),
                ),
                const SizedBox(
                  height: 5,
                ),
                CommonTextField(
                  controller: tagDiscount,
                    // controller: priceController,
                    obSecure: false,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Write Tags is required'.tr;
                      }
                      return null; // Return null if validation passes
                    },
                    // hintText: 'Name',
                    hintText: 'Write Tags'.tr,
                   ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: (){
                if (formKey1.currentState!.validate()) {
                 deliverySizeApi();}
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
                        'Continue',
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
