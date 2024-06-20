import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dirise/Services/review_publish_service.dart';
import 'package:dirise/Services/tellUsscreen.dart';
import 'package:dirise/controller/profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/service_controller.dart';
import '../controller/vendor_controllers/add_product_controller.dart';
import '../model/common_modal.dart';
import '../model/product_details.dart';
import '../repository/repository.dart';
import '../utils/api_constant.dart';
import '../widgets/common_button.dart';
import '../widgets/common_colour.dart';
import '../widgets/common_textfield.dart';

class whatServiceDoYouProvide extends StatefulWidget {
  int? price;
  int? fixedPrice;
  int? percentage;
  int? id;
  String? name;
  RxBool? isDelivery = false.obs;

  whatServiceDoYouProvide(
      {super.key, this.percentage, this.price, this.fixedPrice, this.id, this.name, this.isDelivery});

  @override
  State<whatServiceDoYouProvide> createState() => _whatServiceDoYouProvideState();
}

class _whatServiceDoYouProvideState extends State<whatServiceDoYouProvide> {
  String selectedItem = 'Item 1'; // Default selected item
  final profileController = Get.put(ProfileController());
  RxBool isShow = false.obs;
  String realPrice = "";
  String fees = "";
  String discounted = "";
  String sale = "";
  String productName = "";
  String discountedPrice = "";
  bool isPercentageDiscount = true;
  double discountAmount12 =0.0;
  double afterCalculation = 0.0;
  double discountDouble = 0.0;
  double discountedPriceValue = 0.0;
  void calculateDiscount() {
    double realPrice = double.tryParse(priceController.text) ?? 0.0;
    double sale = double.tryParse(discountPrecrnt.text) ?? 0.0;
    double fixedPrice = double.tryParse(fixedDiscount.text) ?? 0.0;

    // Check the current discount type and calculate discounted price accordingly
    if (isPercentageDiscount && realPrice > 0 && sale > 0) {
      log('this is call....');
      double discountAmount = (realPrice * sale) / 100;
      discountedPriceValue = realPrice - discountAmount;
      log('dirise fees${diriseFeesAsDouble.toString()}');
      log('dirise fees${discountedPriceValue.toString()}');
      double additionalDiscountAmount = (realPrice * diriseFeesAsDouble) / 100;
      // double finalPrice = realPrice - additionalDiscountAmount;
      double finalPrice1 = discountedPriceValue + additionalDiscountAmount;
      setState(() {
        discountedPrice = finalPrice1.toStringAsFixed(2);
      });
    } else if (!isPercentageDiscount && realPrice > 0 && fixedPrice > 0) {
      log('this is call....2');
      double discountedPriceValue = realPrice - fixedPrice;
      // double discountedPriceValue1 = discountedPriceValue + diriseFeesAsDouble;
      double discountedPriceValue1 = afterCalculation - discountDouble;
      setState(() {
        discountedPrice = discountedPriceValue1.toStringAsFixed(2);
      });
    } else {
      setState(() {
        discountedPrice = "0.0";
      });
    }
  }
  double diriseFeesAsDouble = 0.0 ;
  TextEditingController discountPrecrnt = TextEditingController();
  TextEditingController fixedDiscount = TextEditingController();

  List<String> itemList = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  TextEditingController serviceNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController fixedPriceController = TextEditingController();
  TextEditingController percentageController = TextEditingController();
  double realPrice1 = 0.0;
  final formKey = GlobalKey<FormState>();
  final addProductController = Get.put(AddProductController());

  serviceApi() {
    Map<String, dynamic> map = {};
    map['product_name'] = serviceNameController.text.trim();
    map['item_type'] = 'service';
    map['p_price'] = priceController.text.trim();
    map['fixed_discount_price'] = isDelivery.value == false ? "0" : fixedPriceController.text.trim();
    map['discount_percent'] = percentageController.text.trim();
    map['id'] = addProductController.idProduct.value.toString();

    // map['discount_percent'] = fixedPriceAfterSaleController.text.trim();

    final Repositories repositories = Repositories();
    FocusManager.instance.primaryFocus!.unfocus();
    repositories.postApi(url: ApiUrls.giveawayProductAddress, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      print('API Response Status Code: ${response.status}');
      // showToast(response.message.toString());
      if (response.status == true) {
        if (widget.id != null) {
          Get.to(const ReviewPublishServiceScreen());
        } else {
          Get.to(TellUsScreen());
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
    if (widget.id != null) {
      serviceNameController.text = widget.name.toString();
      priceController.text = widget.price.toString();
      discountPrecrnt.text = widget.percentage.toString();
      fixedDiscount.text = widget.fixedPrice.toString();
      isDelivery = widget.isDelivery!;
    }
    getVendorCategories(addProductController.idProduct.value.toString());
  }

  RxBool isDelivery = false.obs;
  RxBool isPercantage = false.obs;
  String discount = '0.0';
  String diriseFeesAsString = '' ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xff0D5877),
            size: 16,
          ),
          onPressed: () {
            Get.back();
            // Handle back button press
          },
        ),
        titleSpacing: 0,
        title: Text(
          'What Service Do You Provide?'.tr,
          style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Service Name'.tr,
                  style: GoogleFonts.inter(color: const Color(0xff292F45), fontWeight: FontWeight.w500, fontSize: 14),
                ),
                CommonTextField(
                  controller: serviceNameController,
                  obSecure: false,
                  hintText: 'Service Name'.tr,
                  onChanged: (value) {
                    productName = value;
                    setState(() {});
                  },
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Service Name is required';
                    }
                    return null; // Return null if validation passes
                  },
                ),
                Text(
                  'Price'.tr,
                  style: GoogleFonts.inter(color: const Color(0xff292F45), fontWeight: FontWeight.w500, fontSize: 14),
                ),
                CommonTextField(
                  controller: priceController,
                  obSecure: false,
                  keyboardType: TextInputType.number,
                  hintText: 'Price'.tr,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: const Text(
                      'KWD',
                    ),
                  ),
                  onChanged: (value) {
                    isPercentageDiscount = true;
                    calculateDiscount();
                    fixedDiscount.text = '';
                    realPrice = value;
                    realPrice1 = double.tryParse(value) ?? 0.0;
                    diriseFeesAsString = productDetailsModel.value.productDetails!.diriseFess;
                    diriseFeesAsDouble = double.parse(productDetailsModel.value.productDetails!.diriseFess.toString());

                    double fees = diriseFeesAsString != null ? double.parse(diriseFeesAsString) : 0.0;
                    if(fixedDiscount.text.isEmpty || discountPrecrnt.text.isEmpty){
                      double additionalDiscountAmount = (realPrice1 * diriseFeesAsDouble) / 100;
                      double withoutDiscount = realPrice1 + additionalDiscountAmount;
                      discountedPrice = withoutDiscount.toString();
                    }
                    if(priceController.text.isEmpty){
                      discountedPrice = '';
                      discount = '';
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
                    return null; // Return null if validation passes
                  },
                ),
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
                          value: isDelivery.value,
                          side: const BorderSide(
                            color: AppTheme.buttonColor,
                          ),
                          onChanged: (bool? value) {
                            setState(() {
                              isDelivery.value = value!;
                              fixedDiscount.text = "";
                              discountPrecrnt.text = '';
                              discount = '0.0';
                              sale = '0.0';
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
                if (isDelivery.value == true)
                  Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Discount amount'.tr,
                        style: GoogleFonts.poppins(
                            color: const Color(0xff292F45), fontWeight: FontWeight.w400, fontSize: 14),
                      ),
                      CommonTextField(
                        controller: fixedDiscount,
                        obSecure: false,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          discount = value;
                          discountDouble = double.tryParse(value) ?? 0.0;
                          discountPrecrnt.text = "";
                          isPercentageDiscount = false;
                          if(discountPrecrnt.text.isEmpty){
                            discountedPriceValue = 0.0;
                          }
                          calculateDiscount();
                          sale = value;
                          if(fixedDiscount.text.isEmpty){
                            discountedPrice = '';
                            discount = '';
                          }
                          setState(() {});
                        },
                        validator: (value) {
                          if (discountPrecrnt.text.isEmpty) {
                            if (value!.trim().isEmpty) {
                              return 'Discount Price is required'.tr;
                            }
                            double? discountValue = double.tryParse(value);
                            double? priceValue = double.tryParse(priceController.text);
                            if (discountValue != null && priceValue != null && discountValue > priceValue) {
                              return 'Discount Price cannot be greater than Price'.tr;
                            }
                          }
                          return null; // Return null if validation passes
                        },
                        hintText: 'Discount Price'.tr,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'OR'.tr,
                          style: GoogleFonts.poppins(color: Colors.red, fontWeight: FontWeight.w400, fontSize: 14),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Discount Percentage'.tr,
                        style: GoogleFonts.poppins(
                            color: const Color(0xff292F45), fontWeight: FontWeight.w400, fontSize: 14),
                      ),
                      CommonTextField(
                        controller: discountPrecrnt,
                        obSecure: false,
                        // hintText: 'Name',
                        keyboardType: TextInputType.number,
                        hintText: 'Percentage'.tr,
                        onChanged: (value) {
                          discountDouble = double.tryParse(value.toString()) ?? 0.0;
                          fixedDiscount.text = "";
                          isPercentageDiscount = true;
                          calculateDiscount();
                          sale = value;
                          setState(() {});
                        },
                        validator: (value) {
                          if (fixedDiscount.text.isEmpty) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Percentage is required'.tr;
                            } else {
                              double? percentage = double.tryParse(value);
                              if (percentage == null || percentage > 100) {
                                return 'Percentage must be between 0 and 100'.tr;
                              }
                            }
                          }
                          return null; // Return null if validation passes
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
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
                // const SizedBox(height: 10,),
                // Container(
                //   padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                //   decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(8),
                //       border: Border.all(color: AppTheme.secondaryColor)),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(
                //         'Make it on sale',
                //         style: GoogleFonts.poppins(
                //           color: AppTheme.primaryColor,
                //           fontSize: 15,
                //         ),
                //       ),
                //       Transform.translate(
                //         offset: const Offset(-6, 0),
                //         child: Checkbox(
                //             visualDensity: const VisualDensity(horizontal: -1, vertical: -3),
                //             materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                //             shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(4),
                //             ),
                //             value: isDelivery.value,
                //             // side: BorderSide(
                //             //   color: showValidation.value == false ? AppTheme.buttonColor : Colors.red,
                //             // ),
                //             side: const BorderSide(
                //               color: AppTheme.buttonColor,
                //             ),
                //             onChanged: (bool? value) {
                //               setState(() {
                //                 isDelivery.value = value!;
                //                 isPercantage.value = true;
                //               });
                //             }),
                //       ),
                //     ],
                //   ),
                // ),
                // if (isDelivery.value == true)
                //   Column(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text(
                //         'Percentage'.tr,
                //         style: GoogleFonts.inter(
                //             color: const Color(0xff292F45), fontWeight: FontWeight.w500, fontSize: 14),
                //       ),
                //       CommonTextField(
                //         controller: fixedDiscount,
                //         obSecure: false,
                //         keyboardType: TextInputType.number,
                //         onChanged: (value) {
                //           discount = value;
                //           discountDouble = double.parse(value.toString());
                //           discountPrecrnt.text = "";
                //           isPercentageDiscount = false;
                //           calculateDiscount();
                //           sale = value;
                //           setState(() {});
                //         },
                //         validator: (value) {
                //           if (discountPrecrnt.text.isEmpty) {
                //             if (value!.trim().isEmpty) {
                //               return 'Discount Price is required'.tr;
                //             }
                //             double? discountValue = double.tryParse(value);
                //             double? priceValue = double.tryParse(priceController.text);
                //             if (discountValue != null && priceValue != null && discountValue > priceValue) {
                //               return 'Discount Price cannot be greater than Price'.tr;
                //             }
                //           }
                //           return null; // Return null if validation passes
                //         },
                //         hintText: 'Discount Price'.tr,
                //       ),
                //       // CommonTextField(
                //       //   controller: percentageController,
                //       //   obSecure: false,
                //       //   onChanged: (value) {
                //       //     discount = value;
                //       //     discountDouble = double.parse(value.toString());
                //       //     discountPrecrnt.text = "";
                //       //     isPercentageDiscount = false;
                //       //     calculateDiscount();
                //       //     sale = value;
                //       //     setState(() {});
                //       //   },
                //       //   keyboardType: TextInputType.number,
                //       //   hintText: 'Percentage'.tr,
                //       //   validator: (value) {
                //       //     if (percentageController.text.isEmpty) if (value!.trim().isEmpty &&
                //       //         isPercantage.value == true) {
                //       //       return 'Discount Price is required'.tr;
                //       //     }
                //       //     return null; // Return null if validation passes
                //       //   },
                //       // ),
                //     ],
                //   ),
                // const SizedBox(
                //   height: 10,
                // ),
                // if (isDelivery.value == true)
                //   Column(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Center(
                //         child: Text(
                //           'Or'.tr,
                //           style: GoogleFonts.inter(
                //               color: const Color(0xff292F45), fontWeight: FontWeight.w500, fontSize: 14),
                //         ),
                //       ),
                //       Text(
                //         'Fixed after sale price'.tr,
                //         style: GoogleFonts.inter(
                //             color: const Color(0xff292F45), fontWeight: FontWeight.w500, fontSize: 14),
                //       ),
                //       CommonTextField(
                //         controller: fixedPriceController,
                //         obSecure: false,
                //         keyboardType: TextInputType.number,
                //         hintText: 'Fixed after sale price'.tr,
                //         onChanged: (value) {
                //           percentageController.text = '';
                //           isPercantage.value = false;
                //           isPercentageDiscount = false;
                //           calculateDiscount();
                //           sale = value;
                //           setState(() {});
                //           double sellingPrice = double.tryParse(value) ?? 0.0;
                //           double purchasePrice = double.tryParse(priceController.text) ?? 0.0;
                //           if (priceController.text.isEmpty) {
                //             FocusManager.instance.primaryFocus!.unfocus();
                //             fixedPriceController.clear();
                //             showToastCenter('Enter normal price first');
                //             return;
                //           }
                //           if (sellingPrice > purchasePrice) {
                //             FocusManager.instance.primaryFocus!.unfocus();
                //             fixedPriceController.clear();
                //             showToastCenter('After sell price cannot be higher than normal price');
                //           }
                //         },
                //         validator: (value) {
                //           if (fixedPriceController.text.isEmpty) if (value!.trim().isEmpty &&
                //               isPercantage.value == false) {
                //             return 'Fixed after sale price'.tr;
                //           }
                //           return null; // Return null if validation passes
                //         },
                //       ),
                //     ],
                //   ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Calculated price'.tr,
                  style: GoogleFonts.inter(color: const Color(0xff292F45), fontWeight: FontWeight.w500, fontSize: 14),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'This is what your customer will see after DIRISE fees.'.tr,
                  style: GoogleFonts.inter(color: const Color(0xff514949), fontWeight: FontWeight.w400, fontSize: 12),
                ),
                const SizedBox(
                  height: 10,
                ),
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
                                  'Real Price'.tr,
                                  style: GoogleFonts.poppins(
                                      color: const Color(0xff014E70), fontWeight: FontWeight.w600, fontSize: 12),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Text(
                                    "${realPrice} KWD".tr,
                                    // "${afterCalculation} KWD".tr,
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
                                    ' $discount KWD '.tr,
                                    style: GoogleFonts.poppins(
                                        color: const Color(0xff014E70), fontWeight: FontWeight.w400, fontSize: 10),
                                  ),
                                ): Expanded(
                                  flex: 2,
                                  child: Text(
                                    ' $discountedPriceValue % '.tr,
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
                                        color: const Color(0xff014E70), fontWeight: FontWeight.w400, fontSize: 10),
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
                                child: Image.file(profileController.productImage),
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
                          Text(
                            serviceNameController.text
                                .toString()
                                .tr,
                            style: GoogleFonts.inter(
                                color: const Color(0xff014E70), fontWeight: FontWeight.w600, fontSize: 12),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomOutlineButton(
                  title: 'Next',
                  borderRadius: 11,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      serviceApi();
                      profileController.thankYouValue = 'Service';
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
