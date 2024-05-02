import 'package:flutter/material.dart';
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
  String selectTypeOfPackaging   = 'Select your handling time';
  List<String> selectTypeOfPackagingList = [
    'Select your handling time ',
    'Select your handling time ',
    'Select your handling time ',
    'Select your handling time ',
    'Select your handling time ',
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
appBar: AppBar(
  title: Text("Shipping Policy",style: GoogleFonts.poppins(fontSize:20,fontWeight:FontWeight.w600),),
  automaticallyImplyLeading: false,
  centerTitle: true,
  backgroundColor: Colors.white,
),
       body: Column(crossAxisAlignment: CrossAxisAlignment.start,
         children: [
         Text("Select Your Shipping Policy",style: GoogleFonts.poppins(fontSize:18,fontWeight:FontWeight.w600)),
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
           Text("Policy Name",style: GoogleFonts.poppins(fontSize:18,fontWeight:FontWeight.w600)),
           CommonTextField(
             contentPadding: EdgeInsets.all(5),
               controller: weightController,
               obSecure: false,
               hintText: 'Weight Of the Item ',
               validator: MultiValidator([
                 RequiredValidator(errorText: 'Weight Of the Item is required'.tr),
               ])),
           Text("Policy Description (Optional)",style: GoogleFonts.poppins(fontSize:18,fontWeight:FontWeight.w600)),
           CommonTextField(
               contentPadding: EdgeInsets.all(5),
               controller: weightController,
               isMulti: true,
               obSecure: false,
               hintText: '',
               ),
           Text("Handling time",style: GoogleFonts.poppins(fontSize:18,fontWeight:FontWeight.w600)),
           Text("The time that you need to process the order and get it ready to be shipped or dropped off to the shipping company.",style: GoogleFonts.poppins(fontSize:14,)),
           DropdownButtonFormField<String>(
             value: selectTypeOfPackaging,
             onChanged: (String? newValue) {
               setState(() {
                 selectTypeOfPackaging = newValue!;
               });
             },
             items: selectTypeOfPackagingList.map<DropdownMenuItem<String>>((String value) {
               return DropdownMenuItem<String>(
                 value: value,
                 child: Text('Select your handling time '),
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
           Text("Shipping Discounts & Charges",style: GoogleFonts.poppins(fontSize:18,fontWeight:FontWeight.w600)),
           Text("The amount you want to charge or offer your customers.",style: GoogleFonts.poppins(fontSize:14)),
           // Row(
           //   children: [
           //     Radio(value: 1, groupValue: 1, onChanged: (value) {}),
           //     Text(
           //       'I want to offer free shipping'.tr,
           //       style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 13),
           //     ),
           //   ],
           // ),
           // Row(
           //   children: [
           //     Radio(value: 1, groupValue: 1, onChanged: (value) {}),
           //     Text(
           //       'Pay partial of the shipping'.tr,
           //       style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 13),
           //     ),
           //   ],
           // ),
           // Row(
           //   children: [
           //     Radio(value: 1, groupValue: 1, onChanged: (value) {}),
           //     Text(
           //       'Charge my customer for shipping'.tr,
           //       style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 13),
           //     ),
           //   ],
           // )
         ],
       ),
    );
  }
}

