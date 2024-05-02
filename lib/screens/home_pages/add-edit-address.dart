import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../addNewProduct/locationScreen.dart';
import '../../controller/location_controller.dart';
import '../../model/common_modal.dart';
import '../../newAddress/customeraccountcreatedsuccessfullyScreen.dart';
import '../../repository/repository.dart';
import '../../utils/api_constant.dart';
import '../../widgets/common_textfield.dart';
import 'choose_map_home.dart';


class HomeAddEditAddress extends StatefulWidget {
  final String? street;
  final String? city;
  final String? state;
  final String? country;
  final String? zipcode;
  final String? town;


  HomeAddEditAddress({
    Key? key,
    this.street,
    this.city,
    this.state,
    this.country,
    this.zipcode,
    this.town,
  }) : super(key: key);

  @override
  State<HomeAddEditAddress> createState() => _HomeAddEditAddressState();
}

class _HomeAddEditAddressState extends State<HomeAddEditAddress> {

  final TextEditingController specialInstructionController = TextEditingController();
  RxBool hide = true.obs;
  RxBool hide1 = true.obs;
  bool showValidation = false;
  final Repositories repositories = Repositories();
  final formKey1 = GlobalKey<FormState>();
  String code = "+91";
  editAddressApi() {
    Map<String, dynamic> map = {};
    if (widget.street != null &&
        widget.city != null &&
        widget.state != null &&
        widget.country != null &&
        widget.zipcode != null &&
        widget.town != null) {
      map['city'] = widget.city;
      map['country'] = widget.country;
      map['state'] = widget.state;
      map['zip_code'] = widget.zipcode;
      map['town'] = widget.town;
      map['street'] = widget.street;
    }else{
      map['city'] = locationController.cityController.text.trim();
      map['country'] = locationController.countryController.text.trim();
      map['state'] = locationController.stateController.text.trim();
      map['zip_code'] = locationController.zipcodeController.text.trim();
      map['town'] = locationController.townController.text.trim();
      map['street'] = locationController.streetController.text.trim();
    }
    print(map.toString());
    FocusManager.instance.primaryFocus!.unfocus();
    repositories.postApi(url: ApiUrls.addCurrentAddress, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
    });
  }
  final locationController = Get.put(LocationController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.city != null) {
      locationController.streetController.text = widget.street ?? '';
      locationController.cityController.text = widget.city ?? '';
      locationController.stateController.text = widget.state ?? '';
      locationController.countryController.text = widget.country ?? '';
      locationController.zipcodeController.text = widget.zipcode ?? '';
      locationController.townController.text = widget.town ?? '';
    }else if(widget.street == null ){
      locationController.streetController.text = locationController.street!;
      locationController.cityController.text = locationController.city ?? '';
      locationController.stateController.text = locationController.state ?? '';
      locationController.countryController.text = locationController.countryName ?? '';
      locationController.zipcodeController.text = locationController.zipcode ?? '';
      locationController.townController.text = locationController.town ?? '';
    }
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
              'Address'.tr,
              style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ],
        ),
      ),
      body: Form(
        key: formKey1,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * .02,
                ),
                // Text(
                //   "Where do you want to receive your orders".tr,
                //   style: GoogleFonts.poppins(color: Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 16),
                // ),
                // SizedBox(
                //   height: size.height * .02,
                // ),
                // InkWell(
                //   onTap: (){
                //     Get.to(ChooseAddressHome());
                //   },
                //   child: Align(
                //     alignment: Alignment.center,
                //     child: Text(
                //       "Select your location on the map".tr,
                //       style: GoogleFonts.poppins(color: Color(0xff044484), fontWeight: FontWeight.w400, fontSize: 14),
                //     ),
                //   ),
                // ),
                ...commonField(
                    hintText: "Street",
                    textController: locationController.streetController,
                    title: 'Street*',
                    validator: (String? value) {},
                    keyboardType: TextInputType.name),
                ...commonField(
                    hintText: "city",
                    textController: locationController.cityController,
                    title: 'City*',
                    validator: (String? value) {},
                    keyboardType: TextInputType.name),
                ...commonField(
                    hintText: "state",
                    textController: locationController.stateController,
                    title: 'State*',
                    validator: (String? value) {},
                    keyboardType: TextInputType.name),
                ...commonField(
                    hintText: "Country",
                    textController: locationController.countryController,
                    title: 'Country*',
                    validator: (String? value) {},
                    keyboardType: TextInputType.name),
                ...commonField(
                    hintText: "Zip Code",
                    textController: locationController.zipcodeController,
                    title: 'Zip Code*',
                    validator: (String? value) {},
                    keyboardType: TextInputType.number),
                ...commonField(
                    hintText: "Town",
                    textController: locationController.townController,
                    title: 'Town*',
                    validator: (String? value) {},
                    keyboardType: TextInputType.name),
                SizedBox(
                  height: size.height * .02,
                ),
                GestureDetector(
                  onTap: (){

                    if (formKey1.currentState!.validate()) {
                      editAddressApi();
                    }
                    setState(() {});
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    width: Get.width,
                    height: 50,
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
                        'Confirm Your Location',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Text color
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * .02,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<Widget> commonField({
  required TextEditingController textController,
  required String title,
  required String hintText,
  required FormFieldValidator<String>? validator,
  required TextInputType keyboardType,
}) {
  return [
    const SizedBox(
      height: 5,
    ),
    Text(
      title.tr,
      style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16, color: const Color(0xff0D5877)),
    ),
    const SizedBox(
      height: 8,
    ),
    CommonTextField(
      controller: textController,
      obSecure: false,
      hintText: hintText.tr,
      validator: validator,
      keyboardType: keyboardType,
    ),
  ];
}
