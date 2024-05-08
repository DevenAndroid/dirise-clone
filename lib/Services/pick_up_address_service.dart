import 'dart:convert';
import 'package:dirise/Services/service_international_shipping_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../addNewProduct/locationScreen.dart';
import '../controller/service_controller.dart';
import '../model/common_modal.dart';
import '../newAddress/customeraccountcreatedsuccessfullyScreen.dart';
import '../repository/repository.dart';
import '../utils/api_constant.dart';
import '../widgets/common_textfield.dart';
import 'choose_map_service.dart';

class PickUpAddressService extends StatefulWidget {
  final String? street;
  final String? city;
  final String? state;
  final String? country;
  final String? zipcode;
  final String? town;
  static String route = "/PickUpAddressService";

  PickUpAddressService({
    Key? key,
    this.street,
    this.city,
    this.state,
    this.country,
    this.zipcode,
    this.town,
  }) : super(key: key);

  @override
  State<PickUpAddressService> createState() => _PickUpAddressServiceState();
}

class _PickUpAddressServiceState extends State<PickUpAddressService> {
  final serviceController = Get.put(ServiceController());
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
      map['address_type'] = 'Both';
      map['city'] = widget.city;
      map['country'] = widget.country;
      map['state'] = widget.state;
      map['zip_code'] = widget.zipcode;
      map['town'] = widget.town;
      map['street'] = widget.street;
      map['special_instruction'] = serviceController.specialInstructionController.text.trim();
    }else{
      map['address_type'] = 'Both';
      map['city'] = serviceController.cityController.text.trim();
      map['country'] = serviceController.countryController.text.trim();
      map['state'] = serviceController.stateController.text.trim();
      map['zip_code'] = serviceController.zipcodeController.text.trim();
      map['town'] = serviceController.townController.text.trim();
      map['street'] = serviceController.streetController.text.trim();
      map['special_instruction'] = serviceController.specialInstructionController.text.trim();
    }

    FocusManager.instance.primaryFocus!.unfocus();
    repositories.postApi(url: ApiUrls.editAddressUrl, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      if (response.status == true) {
        Get.to(const CustomerAccountCreatedSuccessfullyScreen());
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.street != null) {
      serviceController.streetController.text = widget.street!;
      serviceController.cityController.text = widget.city ?? '';
      serviceController.stateController.text = widget.state ?? '';
      serviceController.countryController.text = widget.country ?? '';
      serviceController.zipcodeController.text = widget.zipcode ?? '';
      serviceController.townController.text = widget.town ?? '';
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
              'Pick up address'.tr,
              style: GoogleFonts.poppins(color: Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 20),
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
                Text(
                  "Where do you want to receive your orders".tr,
                  style: GoogleFonts.poppins(color: Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 16),
                ),
                SizedBox(
                  height: size.height * .02,
                ),
                InkWell(
                  onTap: (){
                    Get.toNamed( ChooseAddressService.route);
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Select your location on the map".tr,
                      style: GoogleFonts.poppins(color: Color(0xff044484), fontWeight: FontWeight.w400, fontSize: 14),
                    ),
                  ),
                ),
                ...commonField(
                    hintText: "Street",
                    textController: serviceController.streetController,
                    title: 'Street*',
                    validator: (String? value) {},
                    keyboardType: TextInputType.name),
                ...commonField(
                    hintText: "city",
                    textController: serviceController.cityController,
                    title: 'City*',
                    validator: (String? value) {},
                    keyboardType: TextInputType.name),
                ...commonField(
                    hintText: "state",
                    textController: serviceController.stateController,
                    title: 'State*',
                    validator: (String? value) {},
                    keyboardType: TextInputType.name),
                ...commonField(
                    hintText: "Country",
                    textController: serviceController.countryController,
                    title: 'Country*',
                    validator: (String? value) {},
                    keyboardType: TextInputType.name),
                ...commonField(
                    hintText: "Zip Code",
                    textController: serviceController.zipcodeController,
                    title: 'Zip Code*',
                    validator: (String? value) {},
                    keyboardType: TextInputType.number),
                ...commonField(
                    hintText: "Town",
                    textController: serviceController.townController,
                    title: 'Town*',
                    validator: (String? value) {},
                    keyboardType: TextInputType.name),
                ...commonField(
                    hintText: "Special instruction",
                    textController: serviceController.specialInstructionController,
                    title: 'Special instruction*',
                    validator: (String? value) {},
                    keyboardType: TextInputType.name),
                SizedBox(
                  height: size.height * .02,
                ),
                GestureDetector(
                  onTap: (){

                    if (formKey1.currentState!.validate()) {
                      Get.to(()=> const ServiceInternationalShippingService());
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