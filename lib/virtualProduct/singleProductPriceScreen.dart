import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dirise/controller/profile_controller.dart';
import 'package:dirise/singleproductScreen/singleProductDiscriptionScreen.dart';
import 'package:dirise/virtualProduct/singleProductDiscriptionScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/vendor_controllers/add_product_controller.dart';
import '../language/app_strings.dart';
import '../model/product_details.dart';
import '../model/vendor_models/add_product_model.dart';
import '../repository/repository.dart';
import '../utils/api_constant.dart';
import '../widgets/common_button.dart';
import '../widgets/common_colour.dart';
import '../widgets/common_textfield.dart';
import 'ReviewandPublishScreen.dart';

class VirtualPriceScreen extends StatefulWidget {

  dynamic price;
  dynamic fixedPrice;
  dynamic percentage;
  dynamic id;
  dynamic onSale;


  VirtualPriceScreen({super.key,this.percentage,this.price,this.fixedPrice,this.onSale,this.id});

  @override
  State<VirtualPriceScreen> createState() => _VirtualPriceScreenState();
}

class _VirtualPriceScreenState extends State<VirtualPriceScreen> {
  TextEditingController priceController = TextEditingController();
  TextEditingController discountPrecrnt = TextEditingController();
  TextEditingController fixedDiscount = TextEditingController();
  final addProductController = Get.put(AddProductController());
  final profileController = Get.put(ProfileController());

  RxBool isShow = false.obs;
  String realPrice = "0.0";
  String discounted = "";
  String sale = "0.0";
  String productName = "";
  String discountedPrice = "0.0";
  bool isPercentageDiscount = true;
  bool isDelivery = false;
  double discountAmount12 =0.0;
  double afterCalculation = 0.0;
  double realPrice1 = 0.0;
  double discountDouble = 0.0;
  double discountedPriceValue = 0.0;
  double discountAmount = 0.0;

  void calculateDiscount() {
    double realPrice = double.tryParse(priceController.text) ?? 0.0;
    double sale = double.tryParse(discountPrecrnt.text) ?? 0.0;
    double fixedPrice = double.tryParse(fixedDiscount.text) ?? 0.0;

    // Check the current discount type and calculate discounted price accordingly
    if (isPercentageDiscount && realPrice > 0 && sale > 0) {
      log('this is call....');
      discountAmount = (realPrice * sale) / 100;
      log('discount isss${discountAmount.toString()}');
      discountedPriceValue = realPrice - discountAmount;
      log('dirise fees${diriseFeesAsDouble.toString()}');
      log('dirise fees${discountedPriceValue.toString()}');
      double additionalDiscountAmount = (realPrice * diriseFeesAsDouble) / 100;
      double fees = (discountedPriceValue * diriseFeesAsDouble) / 100 ;
      log('dirise fees neww ${fees.toString()}');
      // double finalPrice = realPrice - additionalDiscountAmount;
      double finalPrice1 = discountedPriceValue + fees;
      setState(() {
        discountedPrice = finalPrice1.toStringAsFixed(3);
      });
    } else if (!isPercentageDiscount && realPrice > 0 && fixedPrice > 0) {
      log('this is call....2');
      double discountedPriceValue = realPrice - fixedPrice;
      log('discount price ${discountedPriceValue.toString()}');
      double fees = (discountedPriceValue * diriseFeesAsDouble) / 100 ;
      log('discount fees ${fees.toString()}');
      // double discountedPriceValue1 = discountedPriceValue + diriseFeesAsDouble;
      // double discountedPriceValue1 = afterCalculation - discountDouble;
      double discountedPriceValue1 = discountedPriceValue + fees;
      setState(() {
        discountedPrice = discountedPriceValue1.toStringAsFixed(3);
      });
    } else {
      setState(() {
        discountedPrice = "";
      });
    }
  }
  double diriseFeesAsDouble = 0.0 ;
  deliverySizeApi() {
    Map<String, dynamic> map = {};
    map['discount_percent'] = discountPrecrnt.text.toString();
    map['fixed_discount_price'] = fixedDiscount.text.toString().trim();
    map['p_price'] = priceController.text.toString();
    map['item_type'] = 'virtual_product';
    map['id'] = addProductController.idProduct.value.toString();
    map['is_onsale'] = isDelivery.toString();

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
         Get.to( VirtualReviewandPublishScreen());
       // Get.back();
       }else{
         Get.to( VirtualDiscriptionScreen());
       }
      }
    });
  }
  final Repositories repositories = Repositories();
  Rx<ModelProductDetails> productDetailsModel = ModelProductDetails().obs;
  getVendorCategories(id) {
    repositories.getApi(url: ApiUrls.getProductDetailsUrl + id).then((value) {
      productDetailsModel.value = ModelProductDetails.fromJson(jsonDecode(value));
      setState(() {});
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.onSale);
    if(widget.id != null){
      priceController.text = widget.price.toString();
      isDelivery = widget.onSale!;
      discountPrecrnt.text = widget.percentage.toString() ?? "";
      fixedDiscount.text = widget.fixedPrice.toString() ?? "";
    }
    getVendorCategories(addProductController.idProduct.value.toString());
  }
  final formKey1 = GlobalKey<FormState>();
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
              'Price'.tr,
              style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 20),
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
                  'Price*'.tr,
                  style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w400, fontSize: 16),
                ),
                CommonTextField(
                  controller: priceController,
                  obSecure: false,
                  keyboardType: TextInputType.number,
                  hintText: 'Price'.tr,
                  suffixIcon: const Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      'KWD',
                    ),
                  ),
                  onChanged: (value) {
                    isPercentageDiscount = true;
                    calculateDiscount();
                    fixedDiscount.text = '';
                    realPrice = value;
                    realPrice1 = double.tryParse(value) ?? 0.0;
                    String? diriseFeesAsString = productDetailsModel.value.productDetails!.diriseFess;
                    diriseFeesAsDouble = double.parse(productDetailsModel.value.productDetails!.diriseFess.toString());
                    double fees = diriseFeesAsString != null ? double.parse(diriseFeesAsString) : 0.0;
                    if(fixedDiscount.text.isEmpty || discountPrecrnt.text.isEmpty){
                      double additionalDiscountAmount = (realPrice1 * diriseFeesAsDouble) / 100;
                      double withoutDiscount = realPrice1 + additionalDiscountAmount;

                      discountedPrice = withoutDiscount.toString();
                    }
                    if(priceController.text.isEmpty){
                      discountedPrice = '';
                      fixedDiscount.text = "";
                      discountPrecrnt.text = '';
                      sale = '0.0';
                      // discount = '';
                    }
                    discountAmount12 = (realPrice1 * fees) / 100;
                    afterCalculation = realPrice1 + discountAmount12;
                    log('value${realPrice1.toString()}');
                    setState(() {

                    });
                  },
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Price is required'.tr;
                    }
                    double? price = double.tryParse(value);
                    if (price == null || price < 0) {
                      return 'Price must be a non-negative number'.tr;
                    }
                    return null; // Return null if validation passes
                  },
                ),
                // Text(
                //   'Dirise Fee'.tr,
                //   style: GoogleFonts.inter(color: const Color(0xff292F45), fontWeight: FontWeight.w500, fontSize: 14),
                // ),
                // Container(
                //   height: 50,
                //   width: Get.width,
                //   padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                //   decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(8),
                //       border: Border.all(color: AppTheme.secondaryColor)),
                //   child: Text(discountAmount12.toString()),
                // ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'I want to show this item on sale'.tr,
                      style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                    Transform.translate(
                      offset: const Offset(-6, 0),
                      child: Checkbox(
                          visualDensity: const VisualDensity(horizontal: -1, vertical: -3),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          value: isDelivery

                          ,side: const BorderSide(
                            color: AppTheme.buttonColor,
                          ),
                          onChanged: (bool? value) {
                            setState(() {
                              isDelivery = value!;
                              fixedDiscount.text = "";
                              discountPrecrnt.text = '';
                              sale = '0.0';
                              discountAmount = 0.0;
                              if(fixedDiscount.text.isEmpty || discountPrecrnt.text.isEmpty){
                                double additionalDiscountAmount = (realPrice1 * diriseFeesAsDouble) / 100;
                                double withoutDiscount = realPrice1 + additionalDiscountAmount;
                                discountedPrice = withoutDiscount.toString();
                              }
                              if (widget.id != null){
                                priceController.text = '';
                              }
                            });
                          }),
                    ),
                  ],
                ),
                if(isDelivery ==  true)
                Column(
                  children: [
                    const SizedBox(height: 10,),
                    Text(
                      'Discount amount'.tr,
                      style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w400, fontSize: 14),
                    ),
                    CommonTextField(
                      controller: fixedDiscount,
                      obSecure: false,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        discountDouble =  double.tryParse(value) ?? 0.0;
                        discountPrecrnt.text = "";
                        isPercentageDiscount = false;
                        if(discountPrecrnt.text.isEmpty){
                          discountedPriceValue = 0.0;
                        }
                        calculateDiscount();
                        sale = value;
                        if(fixedDiscount.text.isEmpty){
                          discountedPrice = '';
                          // discount = '';
                        }
                        setState(() {});
                      },
                      validator: (value) {
                        if (discountPrecrnt.text.isEmpty) {
                          if (value!.trim().isEmpty) {
                            return 'Discount amount is required'.tr;
                          }
                          double? price = double.tryParse(value);
                          if (price == null || price < 0) {
                            return 'Discount amount must be a non-negative number'.tr;
                          }
                          double? discountValue = double.tryParse(value);
                          double? priceValue = double.tryParse(priceController.text);
                          if (discountValue != null && priceValue != null && discountValue > priceValue) {
                            return 'Discount amount cannot be greater than Price'.tr;
                          }
                        }
                        return null; // Return null if validation passes
                      },
                      hintText: 'Discount amount'.tr,
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
                      keyboardType: TextInputType.number,
                      hintText: 'Discount Percentage'.tr,
                      onChanged: (value) {
                        fixedDiscount.text = "";
                        isPercentageDiscount = true;
                        calculateDiscount();
                        sale = value;
                        setState(() {});
                      },
                      validator: (value) {
                        if (fixedDiscount.text.isEmpty) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Discount Percentage is required'.tr;
                          }
                          double? price = double.tryParse(value);
                          if (price == null || price < 0) {
                            return 'Discount Percentage must be a non-negative number'.tr;
                          }
                          else {
                            double? percentage = double.tryParse(value);
                            if (percentage == null || percentage > 100) {
                              return 'Discount Percentage must be between 0 and 100'.tr;
                            }
                          }
                        }
                        return null; // Return null if validation passes
                      },
                    ),
                    const SizedBox(height: 10,),
                  ],
                ),

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
                  padding: const EdgeInsets.only(left: 10, right: 15, top: 15, bottom: 15),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(11), color: Colors.grey.shade200),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Price'.tr,
                                  style: GoogleFonts.poppins(
                                      color: const Color(0xff014E70), fontWeight: FontWeight.w600, fontSize: 12),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Text(
                                    "${realPrice} KWD".tr,
                                    style: GoogleFonts.poppins(
                                        color: const Color(0xff014E70), fontWeight: FontWeight.w400, fontSize: 10),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Discount amount'.tr,
                                  style: GoogleFonts.poppins(
                                      color: const Color(0xff014E70), fontWeight: FontWeight.w600, fontSize: 12),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                discountedPriceValue == 0.0 ?
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    ' $sale KWD '.tr,
                                    style: GoogleFonts.poppins(
                                        color: const Color(0xff014E70), fontWeight: FontWeight.w400, fontSize: 8),
                                  ),
                                ): Expanded(
                                  flex: 2,
                                  child: Text(
                                    ' $discountAmount KWD '.tr,
                                    style: GoogleFonts.poppins(
                                        color: const Color(0xff014E70), fontWeight: FontWeight.w400, fontSize: 8),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Final price'.tr,
                                  style: GoogleFonts.poppins(
                                      color: const Color(0xff014E70), fontWeight: FontWeight.w600, fontSize: 12),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Text(
                                    "${discountedPrice} KWD".tr,
                                    style: GoogleFonts.poppins(
                                        color: const Color(0xff014E70), fontWeight: FontWeight.w400, fontSize: 8),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10,),
                      Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 2, right: 2, bottom: 2),
                                padding: const EdgeInsets.all(15),
                                height: 150,
                                width: 130,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(11), color: Colors.white),
                                child: Image.file(profileController.productImage!),
                              ),
                              // const Positioned(
                              //     right: 20,
                              //     top: 10,
                              //     child: Icon(
                              //       Icons.delete,
                              //       color: Color(0xff014E70),
                              //     ))
                            ],
                          ),
                          // Text(
                          //   widget.name.toString().tr,
                          //   style: GoogleFonts.inter(
                          //       color: const Color(0xff014E70), fontWeight: FontWeight.w600, fontSize: 12),
                          // ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                CustomOutlineButton(
                  title: 'Next'.tr,
                  borderRadius: 11,
                  onPressed: () {
    if (formKey1.currentState!.validate()) {
      deliverySizeApi();
    }
                  },
                ),
                const SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
