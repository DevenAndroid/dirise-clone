import 'dart:convert';

import 'package:dirise/singleproductScreen/singleProductReturnPolicy.dart';
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

class SingleProductDiscriptionScreen extends StatefulWidget {
  const SingleProductDiscriptionScreen({super.key});

  @override
  State<SingleProductDiscriptionScreen> createState() => _SingleProductDiscriptionScreenState();
}

class _SingleProductDiscriptionScreenState extends State<SingleProductDiscriptionScreen> {
  final addProductController = Get.put(AddProductController());
  TextEditingController inStockController = TextEditingController();
  TextEditingController shortController = TextEditingController();
  TextEditingController alertDiscount = TextEditingController();
  TextEditingController tagDiscount = TextEditingController();
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
        Get.to(const SingleProductReturnPolicy());
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
        leading: const Icon(
          Icons.arrow_back_ios_new,
          color: Color(0xff0D5877),
          size: 16,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Short Description*'.tr,
                style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
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
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 40,
                width: Get.width,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(11), color: Colors.grey.shade200),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Stock quantity *'.tr,
                    style:
                        GoogleFonts.poppins(color: const Color(0xff514949), fontWeight: FontWeight.w400, fontSize: 13),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Stock quantity *'.tr,
                style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 14),
              ),
              CommonTextField(
              controller: inStockController,
                  obSecure: false,
                  // hintText: 'Name',
                  hintText: 'Stock number'.tr,
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'Stock number is required'.tr),
                  ])),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Set stock alert *'.tr,
                style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 14),
              ),
              CommonTextField(
                controller: alertDiscount,
                  // controller: priceController,
                  obSecure: false,
                  // hintText: 'Name',
                  hintText: 'Get notification on your stock quantity'.tr,
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'Set stock alert is required'.tr),
                  ])),
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
                  // hintText: 'Name',
                  hintText: 'Write Tags'.tr,
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'Write Tags is required'.tr),
                  ])),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(11), color: Colors.grey.shade200),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          height: 40,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                          child: const Row(
                            children: [
                              Text('Books'),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.cancel_outlined)
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          height: 40,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                          child: const Row(
                            children: [
                              Text('Electronics'),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.cancel_outlined)
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          height: 40,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                          child: const Row(
                            children: [
                              Text('Writer'),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.cancel_outlined)
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          height: 40,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                          child: const Row(
                            children: [
                              Text('Teachers'),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.cancel_outlined)
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: (){
               deliverySizeApi();
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
    );
  }
}
