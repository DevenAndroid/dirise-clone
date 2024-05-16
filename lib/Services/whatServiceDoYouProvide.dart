import 'dart:convert';
import 'dart:io';

import 'package:dirise/Services/tellUsscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/service_controller.dart';
import '../controller/vendor_controllers/add_product_controller.dart';
import '../model/common_modal.dart';
import '../repository/repository.dart';
import '../utils/api_constant.dart';
import '../widgets/common_button.dart';
import '../widgets/common_colour.dart';
import '../widgets/common_textfield.dart';

class whatServiceDoYouProvide extends StatefulWidget {
  File? fetaureImage;
   whatServiceDoYouProvide({super.key,this.fetaureImage});

  @override
  State<whatServiceDoYouProvide> createState() => _whatServiceDoYouProvideState();
}

class _whatServiceDoYouProvideState extends State<whatServiceDoYouProvide> {
  String selectedItem = 'Item 1'; // Default selected item
  final serviceController = Get.put(ServiceController());
  RxBool isShow = false.obs;
  String realPrice = "";
  String discounted = "";
  String sale = "";
  String productName = "";
  String discountedPrice = "";
  bool isPercentageDiscount = true;

  void calculateDiscount() {
    double realPrice = double.tryParse(serviceController.priceController.text) ?? 0.0;
    double sale = double.tryParse(serviceController.percentageController.text) ?? 0.0;
    double fixedPrice = double.tryParse(serviceController.fixedPriceController.text) ?? 0.0;

    // Check the current discount type and calculate discounted price accordingly
    if (isPercentageDiscount && realPrice > 0 && sale > 0) {
      double discountAmount = (realPrice * sale) / 100;
      double discountedPriceValue = realPrice - discountAmount;
      setState(() {
        discountedPrice = discountedPriceValue.toStringAsFixed(2);
      });
    } else if (!isPercentageDiscount && realPrice > 0 && fixedPrice > 0) {
      double discountedPriceValue = realPrice - fixedPrice;
      setState(() {
        discountedPrice = discountedPriceValue.toStringAsFixed(2);
      });
    } else {
      setState(() {
        discountedPrice = "";
      });
    }
  }

  TextEditingController discountPrecrnt = TextEditingController();
  TextEditingController fixedDiscount = TextEditingController();

  List<String> itemList = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  final formKey = GlobalKey<FormState>();
  final addProductController = Get.put(AddProductController());
  serviceApi() {
    Map<String, dynamic> map = {};
    map['product_name'] = serviceController.serviceNameController.text.trim();
    map['item_type'] = 'service';
    map['p_price'] = serviceController.priceController.text.trim();
    map['fixed_discount_price'] = isDelivery.value == false ? "0" : serviceController.fixedPriceController.text.trim();
    map['discount_percent'] = serviceController.percentageController.text.trim();
    map['id'] = addProductController.idProduct.value.toString();

    // map['discount_percent'] = fixedPriceAfterSaleController.text.trim();

    final Repositories repositories = Repositories();
    FocusManager.instance.primaryFocus!.unfocus();
    repositories.postApi(url: ApiUrls.giveawayProductAddress, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      print('API Response Status Code: ${response.status}');
      // showToast(response.message.toString());
      if (response.status == true) {
        Get.to(const TellUsScreen());
      }
    });
  }

  RxBool isDelivery = false.obs;
  RxBool isPercantage = false.obs;
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
                  controller: serviceController.serviceNameController,
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
                  controller: serviceController.priceController,
                  obSecure: false,
                  hintText: 'Price'.tr,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    calculateDiscount();
                    realPrice = value;
                    setState(() {});
                  },
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Price is required';
                    }
                    return null; // Return null if validation passes
                  },
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppTheme.secondaryColor)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Make it on sale',
                        style: GoogleFonts.poppins(
                          color: AppTheme.primaryColor,
                          fontSize: 15,
                        ),
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
                            // side: BorderSide(
                            //   color: showValidation.value == false ? AppTheme.buttonColor : Colors.red,
                            // ),
                            side: const BorderSide(
                              color: AppTheme.buttonColor,
                            ),
                            onChanged: (bool? value) {
                              setState(() {
                                isDelivery.value = value!;
                                isPercantage.value = true;
                              });
                            }),
                      ),
                    ],
                  ),
                ),

                if (isDelivery.value == true)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Percentage'.tr,
                        style: GoogleFonts.inter(
                            color: const Color(0xff292F45), fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                      CommonTextField(
                        controller: serviceController.percentageController,
                        obSecure: false,
                        onChanged: (value) {
                          serviceController.fixedPriceController.text = '';
                          isPercantage.value = true;
                          isPercentageDiscount = true;
                          calculateDiscount();
                          sale = value;
                          setState(() {});
                        },
                        keyboardType: TextInputType.number,
                        hintText: 'Percentage'.tr,
                        validator: (value) {
                          if(serviceController.percentageController.text.isEmpty)
                            if (value!.trim().isEmpty && isPercantage.value == true) {
                              return 'Discount Price is required'.tr;
                            }
                          return null; // Return null if validation passes
                        },
                      ),
                    ],
                  ),

                const SizedBox(
                  height: 10,
                ),

                if (isDelivery.value == true)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Or'.tr,
                          style: GoogleFonts.inter(
                              color: const Color(0xff292F45), fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                      ),
                      Text(
                        'Fixed after sale price'.tr,
                        style: GoogleFonts.inter(
                            color: const Color(0xff292F45), fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                      CommonTextField(
                        controller: serviceController.fixedPriceController,
                        obSecure: false,
                        keyboardType: TextInputType.number,
                        hintText: 'Fixed after sale price'.tr,
                        onChanged: (value) {
                          serviceController.percentageController.text = '';
                          isPercantage.value = false;
                          isPercentageDiscount = false;
                          calculateDiscount();
                          sale = value;
                          setState(() {});
                          double sellingPrice = double.tryParse(value) ?? 0.0;
                          double purchasePrice = double.tryParse(serviceController.priceController.text) ?? 0.0;
                          if (serviceController.priceController.text.isEmpty) {
                            FocusManager.instance.primaryFocus!.unfocus();
                            serviceController.fixedPriceController.clear();
                            showToastCenter('Enter normal price first');
                            return;
                          }
                          if (sellingPrice > purchasePrice) {
                            FocusManager.instance.primaryFocus!.unfocus();
                            serviceController.fixedPriceController.clear();
                            showToastCenter('After sell price cannot be higher than normal price');
                          }
                        },
                        validator: (value) {
                          if(serviceController.fixedPriceController.text.isEmpty)
                            if (value!.trim().isEmpty && isPercantage.value == false) {
                              return 'Fixed after sale price'.tr;
                            }
                          return null; // Return null if validation passes
                        },
                      ),
                    ],
                  ),
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
                      Column(
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
                              Text(
                                "${realPrice} KWD".tr,
                                style: GoogleFonts.poppins(
                                    color: const Color(0xff014E70), fontWeight: FontWeight.w400, fontSize: 10),
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
                                'Discounted'.tr,
                                style: GoogleFonts.poppins(
                                    color: const Color(0xff014E70), fontWeight: FontWeight.w600, fontSize: 12),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                ' ${discountedPrice}KWD '.tr,
                                style: GoogleFonts.poppins(
                                    color: const Color(0xff014E70), fontWeight: FontWeight.w400, fontSize: 10),
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
                                'Sale'.tr,
                                style: GoogleFonts.poppins(
                                    color: const Color(0xff014E70), fontWeight: FontWeight.w600, fontSize: 12),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              isPercantage.value == true
                                  ? Text(
                                      "${sale} %".tr,
                                      style: GoogleFonts.poppins(
                                          color: const Color(0xff014E70), fontWeight: FontWeight.w400, fontSize: 10),
                                    )
                                  : Text(
                                "${sale} KWD".tr,
                                      style: GoogleFonts.poppins(
                                          color: const Color(0xff014E70), fontWeight: FontWeight.w400, fontSize: 10),
                                    )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
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
                                child: Image.file(widget.fetaureImage!),
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
                            serviceController.serviceNameController.text.toString().tr,
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
