import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/common_button.dart';
import '../widgets/common_colour.dart';
import '../widgets/common_textfield.dart';

class whatServiceDoYouProvide extends StatefulWidget {
  const whatServiceDoYouProvide({super.key});

  @override
  State<whatServiceDoYouProvide> createState() => _whatServiceDoYouProvideState();
}

class _whatServiceDoYouProvideState extends State<whatServiceDoYouProvide> {
  String selectedItem = 'Item 1'; // Default selected item

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
        elevation: 0,
        leading: GestureDetector(
          onTap: (){
            Get.back();
          },
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Color(0xff0D5877),
              size: 16,
            ),
            onPressed: () {
              // Handle back button press
            },
          ),
        ),
        titleSpacing: 0,
        title: Text(
          'Job Details'.tr,
          style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 15,right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonTextField(
                // controller: _referralEmailController,
                  obSecure: false,
                  hintText: 'Service Name'.tr,
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'Service Name is required'),
                  ])),
              CommonTextField(
                // controller: _referralEmailController,
                  obSecure: false,
                  hintText: 'Price'.tr,
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'Price is required'),
                  ])),
              DropdownButtonFormField<String>(
                value: selectedItem,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedItem = newValue!;
                  });
                },
                items: itemList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text('Make it on sale',style: TextStyle(fontSize: 15,color: Colors.grey),),
                  );
                }).toList(),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    fillColor: const Color(0xffE2E2E2).withOpacity(.35),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10).copyWith(right: 8),
                    focusedErrorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: AppTheme.secondaryColor)),
                    errorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Color(0xffE2E2E2))),
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an item';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10,),
              DropdownButtonFormField<String>(
                value: selectedItem,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedItem = newValue!;
                  });
                },
                items: itemList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text('Percentage',style: TextStyle(fontSize: 15,color: Colors.grey),),
                  );
                }).toList(),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    fillColor: const Color(0xffE2E2E2).withOpacity(.35),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10).copyWith(right: 8),
                    focusedErrorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: AppTheme.secondaryColor)),
                    errorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Color(0xffE2E2E2))),
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an item';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10,),
              CommonTextField(
                // controller: _referralEmailController,
                  obSecure: false,
                  hintText: 'Fixed after sale price'.tr,
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'Fixed after sale price'),
                  ])),
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
