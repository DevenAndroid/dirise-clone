import 'package:dirise/Services/pick_up_address_service.dart';
import 'package:dirise/Services/service_international_shipping_details.dart';
import 'package:dirise/singleproductScreen/singleProductReturnPolicy.dart';
import 'package:dirise/utils/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/common_button.dart';
import '../widgets/common_colour.dart';
import '../widgets/common_textfield.dart';

class Locationwherecustomerwilljoin extends StatefulWidget {
  const Locationwherecustomerwilljoin({super.key});

  @override
  State<Locationwherecustomerwilljoin> createState() => _LocationwherecustomerwilljoinState();
}

class _LocationwherecustomerwilljoinState extends State<Locationwherecustomerwilljoin> {
  String selectedItem = 'Item 1'; // Default selected item
  RxBool isServiceProvide = false.obs;
  List<String> itemList = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
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
              'Location where customer will join'.tr,
              style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
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
            children:[
              20.spaceY,
              Text(
                'Write address or choose*'.tr,
                style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
              ),
              20.spaceY,
              GestureDetector(
                onTap: (){
                  setState(() {
                    isServiceProvide.toggle();
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppTheme.secondaryColor)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Write Address',style: GoogleFonts.poppins(
                        color: AppTheme.primaryColor,
                        fontSize: 15,
                      ),),
                      GestureDetector(
                        child: isServiceProvide.value == true ? const Icon(Icons.keyboard_arrow_up_rounded) : const Icon(Icons.keyboard_arrow_down_outlined),
                        onTap: (){
                          setState(() {
                            isServiceProvide.toggle();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              20.spaceY,
              isServiceProvide.value == true ?  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: TextButton(
                  onPressed: (){
                    Get.toNamed(PickUpAddressService.route);
                  },
                  child: Text('Choose my default shipping address',style: GoogleFonts.poppins(
                    color: AppTheme.primaryColor,
                    fontSize: 15,
                  ),),
                ),
              ): const SizedBox.shrink(),
              60.spaceY,
              CustomOutlineButton(
                title: 'Next',
                borderRadius: 11,
                onPressed: () {
                  Get.to(()=> const ServiceInternationalShippingService());
                },
              ),
            ]
          ),
        ),
      ),
    );
  }
}
