import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../addNewProduct/internationalshippingdetailsScreem.dart';
import '../model/common_modal.dart';
import '../repository/repository.dart';
import '../utils/api_constant.dart';
import '../widgets/common_button.dart';

class DeliverySizeScreen extends StatefulWidget {
  const DeliverySizeScreen({Key? key});

  @override
  State<DeliverySizeScreen> createState() => _DeliverySizeScreenState();
}

class _DeliverySizeScreenState extends State<DeliverySizeScreen> {
  int? selectedRadio; // Variable to track the selected radio button

  deliverySizeApi(String deliverySize) {
    Map<String, dynamic> map = {};
    map['delivery_size'] = deliverySize;
    map['item_type'] = 'giveaway';

    final Repositories repositories = Repositories();
    FocusManager.instance.primaryFocus!.unfocus();
    repositories.postApi(url: ApiUrls.giveawayProductAddress, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      print('API Response Status Code: ${response.status}');
      showToast(response.message.toString());
      if (response.status == true) {
        Get.to(const InternationalshippingdetailsScreen());
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
                'Choose According to Size'.tr,
                style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 13),
              ),
              const SizedBox(
                height: 15,
              ),
              buildRadioTile('Fits in small car'.tr, 1), // Radio button for small car
              const SizedBox(
                height: 15,
              ),
              buildRadioTile('Need Truck'.tr, 2), // Radio button for need truck
              const SizedBox(
                height: 15,
              ),
              buildRadioTile('Freight & Cargo'.tr, 3), // Radio button for freight cargo
              SizedBox(
                height: 100,
              ),
              CustomOutlineButton(
                title: 'Next',
                borderRadius: 11,
                onPressed: () {
                  if (selectedRadio == 1) {
                    deliverySizeApi('small_car');
                  } else if (selectedRadio == 2) {
                    deliverySizeApi('need_truck');
                  } else if (selectedRadio == 3) {
                    deliverySizeApi('freight_cargo');
                  }else{
                    showToast('Select delivery size');
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
}
