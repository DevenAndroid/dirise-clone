import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../language/app_strings.dart';
import '../widgets/common_colour.dart';
import '../widgets/common_textfield.dart';

class ShippingPolicyScreen extends StatefulWidget {
  const ShippingPolicyScreen({super.key});
  static var route = "/shippingPolicyScreen";
  @override
  State<ShippingPolicyScreen> createState() => _ShippingPolicyScreenState();
}

class _ShippingPolicyScreenState extends State<ShippingPolicyScreen> {
  TextEditingController weightController = TextEditingController();
  TextEditingController freeController = TextEditingController();
  String selectHandlingTime = 'Select your handling time';
  List<String> selectHandlingTimeList = [
    'Select your handling time',
    'lb/inch',
  ];
  String selectZone = 'Select Zones';
  List<String> selectZoneList = [
    'Select Zones',
    'lb/inch',
  ];
  String unitSShipping = 'Shipping';
  List<String> unitSShippingList = [
    'Shipping',
    'lb/inch',
  ];
  int _radioValue1 = 1;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
appBar: AppBar(
  title: Text("Shipping Policy",style: GoogleFonts.poppins(fontSize:20,fontWeight:FontWeight.w600),),
  automaticallyImplyLeading: false,
  centerTitle: true,
  backgroundColor: Colors.white,
),
       body: SingleChildScrollView(
         child: Column(crossAxisAlignment: CrossAxisAlignment.start,
           children: [
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 16),
             child: Text("Select Your Shipping Policy",style: GoogleFonts.poppins(fontSize:18,fontWeight:FontWeight.w600)),
           ),
             Hero(
               tag: "search_tag",
               child: Material(
                 color: Colors.transparent,
                 surfaceTintColor: Colors.transparent,
                 child: TextField(
                   maxLines: 1,
                   style: GoogleFonts.poppins(fontSize: 16),
                   textInputAction: TextInputAction.search,
                   onSubmitted: (vb) {
                     // Get.to(() => SearchProductsScreen(
                     //   searchText: vb,
                     // ));
                   },
                   decoration: InputDecoration(
                       filled: true,
                       prefixIcon: Padding(
                         padding: const EdgeInsets.all(10),
                         child: Image.asset(
                           'assets/icons/search.png',
                           height: 5,
                           color: Colors.black,
                         ),
                       ),
                       border: InputBorder.none,
                       enabledBorder: const OutlineInputBorder(
                           borderRadius: BorderRadius.all(Radius.circular(8)),
                           borderSide: BorderSide(color: Color(0xffACACAC))),
                       disabledBorder: const OutlineInputBorder(
                           borderRadius: BorderRadius.all(Radius.circular(8)),
                           borderSide: BorderSide(color: Color(0xffACACAC))),
                       focusedBorder: const OutlineInputBorder(
                           borderRadius: BorderRadius.all(Radius.circular(8)),
                           borderSide: BorderSide(color: Color(0xffACACAC))),
                       fillColor: Colors.white,
                       contentPadding: const EdgeInsets.all(8),
                       hintText: AppStrings.searchVendorFieldText.tr,
                       hintStyle:
                       GoogleFonts.poppins(color: Color(0xff525252), fontSize:16,fontWeight: FontWeight.w400)),
                 ),
               ),
             ),
             SizedBox(height: 18,),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 16),
               child: Text("Policy Name",style: GoogleFonts.poppins(fontSize:18,fontWeight:FontWeight.w600)),
             ),
             SizedBox(height: 8,),
             CommonTextField(
               contentPadding: EdgeInsets.all(5),
                 controller: weightController,
                 obSecure: false,
                 hintText: 'Weight Of the Item ',
                 validator: MultiValidator([
                   RequiredValidator(errorText: 'Weight Of the Item is required'.tr),
                 ])),
             SizedBox(height: 18,),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 16),
               child: Text("Policy Description (Optional)",style: GoogleFonts.poppins(fontSize:18,fontWeight:FontWeight.w600)),
             ),
             SizedBox(height: 8,),
             CommonTextField(
                 contentPadding: EdgeInsets.all(5),
                 controller: weightController,
                 isMulti: true,
                 obSecure: false,
                 hintText: '',
                 ),
             SizedBox(height: 8,),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 16),
               child: Text("Handling time",style: GoogleFonts.poppins(fontSize:18,fontWeight:FontWeight.w600)),
             ),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 16),
               child: Text("The time that you need to process the order and get it ready to be shipped or dropped off to the shipping company.",style: GoogleFonts.poppins(fontSize:14,)),
             ),
             SizedBox(height: 5,),
             DropdownButtonFormField<String>(
               value: selectHandlingTime,
               onChanged: (String? newValue) {
                 setState(() {
                   selectHandlingTime = newValue!;
                 });
               },
               items: selectHandlingTimeList.map<DropdownMenuItem<String>>((String value) {
                 return DropdownMenuItem<String>(
                   value: value,
                   child: Text(value),
                 );
               }).toList(),
               decoration: InputDecoration(
                 border: InputBorder.none,
                 filled: true,
                 fillColor: const Color(0xffE2E2E2).withOpacity(.35),
                 contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8).copyWith(right: 8),
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
SizedBox(height: 5,),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 16),
               child: Text("Shipping Discounts & Charges",style: GoogleFonts.poppins(fontSize:18,fontWeight:FontWeight.w600)),
             ),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 16),
               child: Text("The amount you want to charge or offer your customers.",style: GoogleFonts.poppins(fontSize:14)),
             ),
             Row(
               children: [
                 Radio(
                   value: 0,
                   groupValue: _radioValue1,
                   onChanged: (value) {
                     setState(() {
                       _radioValue1 = value!;
                     });
                   },
                 ),
                 Text('I want to offer free shipping',
                     style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
               ],
             ),
             Row(
               children: [
                 Radio(
                   value: 0,
                   groupValue: _radioValue1,
                   onChanged: (value) {
                     setState(() {
                       _radioValue1 = value!;
                     });
                   },
                 ),
                 Text('Pay partial of the shipping',
                     style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
               ],
             ),
             Row(
               children: [
                 Radio(
                   value: 0,
                   groupValue: _radioValue1,
                   onChanged: (value) {
                     setState(() {
                       _radioValue1 = value!;
                     });
                   },
                 ),
                 Text('Charge my customer for shipping',
                     style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
               ],
             ),
             Row(crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Expanded(
                   child: CommonTextField(
                       contentPadding: EdgeInsets.symmetric(horizontal: 20),
                       controller: freeController,
                       obSecure: false,
                       hintText: 'Free for',),
                 ),
                  SizedBox(width: 10,),
                 Expanded(
                   child: DropdownButtonFormField<String>(
                     value: selectZone,
                     onChanged: (String? newValue) {
                       setState(() {
                         selectZone = newValue!;
                       });
                     },
                     items: selectZoneList.map<DropdownMenuItem<String>>((String value) {
                       return DropdownMenuItem<String>(
                         value: value,
                         child: Text(value, style:GoogleFonts.poppins(fontSize:13),),
                       );
                     }).toList(),
                     decoration: InputDecoration(
                       border: InputBorder.none,
                       filled: true,
                       fillColor: const Color(0xffE2E2E2).withOpacity(.35),
                       contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8).copyWith(right: 3),
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
                 ),
             
               ],
             ),
             Row(
               children: [
                 Expanded(
                   child: DropdownButtonFormField<String>(
                     value: unitSShipping,
                     onChanged: (String? newValue) {
                       setState(() {
                         unitSShipping = newValue!;
                       });
                     },
                     items: unitSShippingList.map<DropdownMenuItem<String>>((String value) {
                       return DropdownMenuItem<String>(
                         value: value,
                         child: Text(value,style: GoogleFonts.poppins(fontSize:13),),
                       );
                     }).toList(),
                     decoration: InputDecoration(
                       border: InputBorder.none,
                       filled: true,
                       fillColor: const Color(0xffE2E2E2).withOpacity(.35),
                       contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
                 ),
                 SizedBox(width: 10,),
                 Expanded(
                   child: CommonTextField(
                     contentPadding: EdgeInsets.symmetric(horizontal: 15),
                     controller: freeController,
                     obSecure: false,
                     hintText: 'Enter Price limit', ),

                 ),
         
         
               ],
             ),
             SizedBox(height: 20,)
           ],
         ),
       ),
    );
  }
}

