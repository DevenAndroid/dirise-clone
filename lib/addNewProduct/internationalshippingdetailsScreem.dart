import 'package:dirise/addNewProduct/optionalScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/common_button.dart';
import '../widgets/common_colour.dart';

class InternationalshippingdetailsScreen extends StatefulWidget {
  const InternationalshippingdetailsScreen({super.key});

  @override
  State<InternationalshippingdetailsScreen> createState() => _InternationalshippingdetailsScreenState();
}

class _InternationalshippingdetailsScreenState extends State<InternationalshippingdetailsScreen> {
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
              'International shipping details'.tr,
              style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              SizedBox(height: 40,),
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
                    child: Text('Weight'),
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
              const SizedBox(height: 20),
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
                    child: Text('Material'),
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
              const SizedBox(height: 20),
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
                    child: Text('Box dimension'),
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
              const SizedBox(height: 20),
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
                    child: Text('Type of packages'),
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
              const SizedBox(height: 20),
              TextFormField(
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
              const SizedBox(height: 20),
              CustomOutlineButton(
                title: 'Confirm',
                borderRadius: 11,
                onPressed: () {
                  Get.to(OptionalScreen());
                },
              ),
              const SizedBox(height: 20),
              Container(
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
                    'Skip',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Text color
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
