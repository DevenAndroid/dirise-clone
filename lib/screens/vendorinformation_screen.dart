import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../addNewProduct/pickUpAddressScreen.dart';
import '../language/app_strings.dart';
import '../widgets/common_colour.dart';
import '../widgets/dimension_screen.dart';

class VendorInformation extends StatefulWidget {
  const VendorInformation({super.key});

  static var route = "/Vendorinformation";
  @override
  State<VendorInformation> createState() => _VendorInformationState();
}

class _VendorInformationState extends State<VendorInformation> {
  final TextEditingController streetController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController zipcodeController = TextEditingController();
  final TextEditingController townController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.Vendorinformation.tr,
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
            ),
          ],
        ),
      ),
body: SingleChildScrollView(
  physics: ScrollPhysics(),
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...commonField(
            hintText: "Street",
             textController: streetController,
            title: 'Company Name',
            validator: (String? value) {},
            keyboardType: TextInputType.name),
        ...commonField(
            hintText: "City",
            textController: streetController,
            title: 'Company Number',
            validator: (String? value) {},
            keyboardType: TextInputType.name),
        ...commonField(
            hintText: "State",
            textController: streetController,
            title: 'Store URL',
            validator: (String? value) {},
            keyboardType: TextInputType.name),
        ...commonField(
            hintText: "Zip Code",
            textController: streetController,
            title: 'Work Email',
            validator: (String? value) {},
            keyboardType: TextInputType.name),
        ...commonField(
            hintText: "Town",
            textController: streetController,
            title: 'Work Address',
            validator: (String? value) {},
            keyboardType: TextInputType.name),
        SizedBox(height: 13,),
        Center(child: Text("Bank Details",   style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 16),)),
        SizedBox(height: 13,),
        ...commonField(
            textController: streetController,
            title: 'Bank Name',
            validator: (String? value) {},
            keyboardType: TextInputType.name, hintText: ''),
        ...commonField(
            hintText: "",
            textController: streetController,
            title: 'Bank Account Holder Name',
            validator: (String? value) {},
            keyboardType: TextInputType.name),
        ...commonField(
            hintText: "",
            textController: streetController,
            title: "Bank Account Number",
            validator: (String? value) {},
            keyboardType: TextInputType.name),
        ...commonField(
            hintText: "",
            textController: streetController,
            title: 'IBAN Number',
            validator: (String? value) {},
            keyboardType: TextInputType.name),
        SizedBox(height: 13,),
        Center(
          child: ElevatedButton(
              onPressed: () {

              },
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(320, 60),
                  backgroundColor: AppTheme.buttonColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AddSize.size5)),

                  textStyle: GoogleFonts.poppins(
                      fontSize: AddSize.font20, fontWeight: FontWeight.w600)),
              child: Text(
                "Update".tr,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: AddSize.font18),
              )),
        ),
      ],
    ),
  ),
),
    );
  }
}
