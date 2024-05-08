import 'dart:convert';

import 'package:dirise/singleproductScreen/singleProductDiscriptionScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/vendor_controllers/add_product_controller.dart';
import '../language/app_strings.dart';
import '../model/vendor_models/add_product_model.dart';
import '../repository/repository.dart';
import '../utils/api_constant.dart';
import '../widgets/common_button.dart';
import '../widgets/common_textfield.dart';

class SingleProductPriceScreen extends StatefulWidget {
  const SingleProductPriceScreen({super.key});

  @override
  State<SingleProductPriceScreen> createState() => _SingleProductPriceScreenState();
}

class _SingleProductPriceScreenState extends State<SingleProductPriceScreen> {
  TextEditingController priceController = TextEditingController();
  TextEditingController discountPrecrnt = TextEditingController();
  TextEditingController fixedDiscount = TextEditingController();
  final addProductController = Get.put(AddProductController());
  deliverySizeApi() {
    Map<String, dynamic> map = {};
    map['discount_percent'] = discountPrecrnt.text.toString();
    map['fixed_discount_price'] = fixedDiscount.text.toString().trim();
    map['p_price'] = priceController.text.toString();
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
        Get.to(const SingleProductDiscriptionScreen());
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
              'Price'.tr,
              style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 20),
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
                'Price*'.tr,
                style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w400, fontSize: 14),
              ),
              CommonTextField(
                  controller: priceController,
                  obSecure: false,
                  // hintText: 'Name',
                  hintText: 'Price'.tr,
                  suffixIcon: const Text(
                    'KWD',
                  ),
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'Price is required'.tr),
                  ])),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'I want to show this item on sale'.tr,
                    style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  Radio(value: 1, groupValue: 1, onChanged: (value) {}),
                ],
              ),
              const SizedBox(height: 10,),
              Text(
                'Fixed Discounted Price'.tr,
                style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w400, fontSize: 14),
              ),
              CommonTextField(
                  controller: fixedDiscount,
                  obSecure: false,
                  // hintText: 'Name',
                  hintText: 'Discount Price'.tr,
                  // validator: MultiValidator([
                  //   RequiredValidator(errorText: 'Discount Price is required'.tr),
                  // ])
              ),
              const SizedBox(height: 10,),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'OR'.tr,
                  style: GoogleFonts.poppins(color: Colors.red, fontWeight: FontWeight.w400, fontSize: 14),
                ),
              ),
              const SizedBox(height: 10,),
              Text(
                'Discount Percentage'.tr,
                style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w400, fontSize: 14),
              ),
              CommonTextField(
                  controller: discountPrecrnt,
                  obSecure: false,
                  // hintText: 'Name',
                  hintText: 'Percentage'.tr,
                  // validator: MultiValidator([
                  //   RequiredValidator(errorText: 'Discount Price is required'.tr),
                  // ])
              ),
              const SizedBox(height: 10,),
              Text(
                'Calculated price'.tr,
                style: GoogleFonts.inter(color: const Color(0xff292F45), fontWeight: FontWeight.w500, fontSize: 14),
              ),
              const SizedBox(height: 10,),
              Text(
                'This is what your customer will see after DIRISE fees.'.tr,
                style: GoogleFonts.inter(color: const Color(0xff514949), fontWeight: FontWeight.w400, fontSize: 12),
              ),
              const SizedBox(height: 10,),
               Container(
                 padding: EdgeInsets.all(15),
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(11),
                   color: Colors.grey.shade200
                 ),
                 child: Row(
                   children: [
                     Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text(
                               'Real Price'.tr,
                               style: GoogleFonts.poppins(color: const Color(0xff014E70), fontWeight: FontWeight.w600, fontSize: 12),
                             ),
                             SizedBox(width: 20,),
                             Text(
                               'KD 12.700'.tr,
                               style: GoogleFonts.poppins(color: const Color(0xff014E70), fontWeight: FontWeight.w400, fontSize: 10),
                             ),
                           ],
                         ),
                         SizedBox(height: 20,),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text(
                               'Discounted'.tr,
                               style: GoogleFonts.poppins(color: const Color(0xff014E70), fontWeight: FontWeight.w600, fontSize: 12),
                             ),
                             SizedBox(width: 20,),
                             Text(
                               'KD 6.350 '.tr,
                               style: GoogleFonts.poppins(color: const Color(0xff014E70), fontWeight: FontWeight.w400, fontSize: 10),
                             ),
                           ],
                         ),
                         SizedBox(height: 20,),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text(
                               'Sale'.tr,
                               style: GoogleFonts.poppins(color: const Color(0xff014E70), fontWeight: FontWeight.w600, fontSize: 12),
                             ),
                             SizedBox(width: 20,),
                             Text(
                               '50% off'.tr,
                               style: GoogleFonts.poppins(color: const Color(0xff014E70), fontWeight: FontWeight.w400, fontSize: 10),
                             ),
                           ],
                         ),
                         SizedBox(height: 20,),
                       ],
                     ),
                     Column(
                       children: [
                         Stack(
                           children: [
                             Container(
                               margin: EdgeInsets.only(left: 15,right: 15,bottom: 15),
                               padding: EdgeInsets.all(15),
                               height: 150,
                               width: 130,
                               decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(11),
                                   color: Colors.white
                               ),
                               child: Image.asset('assets/images/newlogoo.png'),
                             ),
                             Positioned(
                               right: 20,
                                 top: 10,
                                 child: Icon(Icons.delete,color: Color(0xff014E70),))
                           ],
                         ),
                         Text(
                           'Product.'.tr,
                           style: GoogleFonts.inter(color: const Color(0xff014E70), fontWeight: FontWeight.w600, fontSize: 12),
                         ),
                       ],
                     )
                   ],
                 ),
               ),
              const SizedBox(height: 20,),
              CustomOutlineButton(
                title: 'Next',
                borderRadius: 11,
                onPressed: () {
                  deliverySizeApi();

                },
              ),
              const SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
