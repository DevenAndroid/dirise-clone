import 'dart:convert';

import 'package:dirise/singleproductScreen/singlePInternationalshippingdetails.dart';
import 'package:dirise/singleproductScreen/singleProductShippingPolicy.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../addNewProduct/internationalshippingdetailsScreem.dart';
import '../controller/profile_controller.dart';
import '../controller/vendor_controllers/add_product_controller.dart';
import '../model/common_modal.dart';
import '../repository/repository.dart';
import '../utils/api_constant.dart';
import '../vendor/shipping_policy.dart';
import '../widgets/common_button.dart';
import 'ReviewandPublishScreen.dart';

class SingleProductDeliverySize extends StatefulWidget {
  String? whowillpay;
  String? packagSize;
  int? id;
  SingleProductDeliverySize({super.key,this.packagSize,this.whowillpay,this.id});

  @override
  State<SingleProductDeliverySize> createState() => _SingleProductDeliverySizeState();
}

class _SingleProductDeliverySizeState extends State<SingleProductDeliverySize> {
  int? selectedRadio; // Variable to track the selected radio button
  int? selectedRadio1; // Variable to track the selected radio button
  final addProductController = Get.put(AddProductController());

  deliverySizeApi({required String shippingPay, required String deliverySize}) {
    Map<String, dynamic> map = {};
    map['delivery_size'] = deliverySize;
    map['shipping_pay'] = shippingPay; // Use the shippingPay parameter
    map['item_type'] = 'product';
    map['id'] = addProductController.idProduct.value.toString();

    final Repositories repositories = Repositories();
    FocusManager.instance.primaryFocus!.unfocus();
    repositories.postApi(url: ApiUrls.giveawayProductAddress, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      print('API Response Status Code: ${response.status}');
      showToast(response.message.toString());
      if (response.status == true) {
        if(widget.id != null){
          Get.to(ProductReviewPublicScreen());
        }else{
          Get.to(SingleProductShippingPolicyScreen());

        }
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.whowillpay != null) {
      if (widget.whowillpay == 'vendor_pay') {
        selectedRadio = 1;
      } else if (widget.whowillpay == 'customer_pay') {
        selectedRadio = 2;
      }
    }

    if (widget.packagSize != null) {
      if (widget.packagSize == 'small_car') {
        selectedRadio1 = 3;
      } else if (widget.packagSize == 'need_truck') {
        selectedRadio1 = 4;
      } else if (widget.packagSize == 'freight_cargo') {
        selectedRadio1 = 5;
      }
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
              'Delivery Size'.tr,
              style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Who will pay the shipping'.tr,
                style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 13),
              ),
              const SizedBox(
                height: 15,
              ),
              buildRadioTile('I will pay the shipping '.tr, 1), // Radio button for small car
              const SizedBox(
                height: 15,
              ),
              buildRadioTile('Customer'.tr, 2), // Radio button for need truck
              const SizedBox(
                height: 15,
              ),
              Text(
                'Choose Delivery According To Package Size'.tr,
                style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 13),
              ),
              buildRadioTile1('Fits in small car'.tr, 3), // Radio button for freight cargo
              const SizedBox(
                height: 15,
              ),
              buildRadioTile1('Need Truck'.tr, 4), // Radio button for need truck
              const SizedBox(
                height: 15,
              ),
              buildRadioTile1('Freight & Cargo'.tr, 5), //
              const SizedBox(
                height: 15,
              ), // Radio button for freight cargo
              // Align(
              //   alignment: Alignment.bottomCenter,
              //   child: Text(
              //     'Shipping prices'.tr,
              //     style: GoogleFonts.poppins(color: const Color(0xff044484), fontWeight: FontWeight.w600, fontSize: 13),
              //   ),
              // ),
              const SizedBox(
                height: 20,
              ),
              CustomOutlineButton(
                title: 'Next'.tr,
                borderRadius: 11,
                onPressed: () {
                  if (selectedRadio != null && selectedRadio1 != null) {
                    String shippingPay;
                    if (selectedRadio == 1) {
                      shippingPay = 'vendor_pay';
                    } else if (selectedRadio == 2) {
                      shippingPay = 'customer_pay';
                    } else {
                      showToast('Select who will pay the shipping'.tr);
                      return;
                    }

                    String deliverySize;
                    if (selectedRadio1 == 3) {
                      deliverySize = 'small_car';
                    } else if (selectedRadio1 == 4) {
                      deliverySize = 'need_truck';
                    } else if (selectedRadio1 == 5) {
                      deliverySize = 'freight_cargo';
                    } else {
                      showToast('Select delivery according to package size'.tr);
                      return;
                    }

                    deliverySizeApi(shippingPay: shippingPay, deliverySize: deliverySize);
                  } else {
                    showToast('Select both shipping and package size'.tr);
                  }
                },

              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRadioTile(String title, int value) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(11), color: Colors.grey.shade100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 18),
          ),
          Radio(
            value: value,
            groupValue: selectedRadio,
            onChanged: (int? newValue) {
              setState(() {
                selectedRadio = newValue;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget buildRadioTile1(String title, int value) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(11), color: Colors.grey.shade100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 18),
          ),
          Radio(
            value: value,
            groupValue: selectedRadio1,
            onChanged: (int? newValue) {
              setState(() {
                selectedRadio1 = newValue;
              });
            },
          ),
        ],
      ),
    );
  }
}
