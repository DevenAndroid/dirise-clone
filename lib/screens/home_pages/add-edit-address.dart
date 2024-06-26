import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Services/choose_map_service.dart';
import '../../addNewProduct/locationScreen.dart';
import '../../controller/location_controller.dart';
import '../../controller/profile_controller.dart';
import '../../model/common_modal.dart';
import '../../model/model_address_list.dart';
import '../../newAddress/customeraccountcreatedsuccessfullyScreen.dart';
import '../../repository/repository.dart';
import '../../utils/api_constant.dart';
import '../../widgets/common_textfield.dart';
import '../check_out/address/edit_address.dart';
import 'choose_map_home.dart';
import 'find_my_location.dart';


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
    map['zip_code'] = zipcodeController.text.trim();
    print(map.toString());
    FocusManager.instance.primaryFocus!.unfocus();
    repositories.postApi(url: ApiUrls.addCurrentAddress, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
    });
  }
  final locationController = Get.put(LocationController());
  RxBool isSelect = false.obs;
  final TextEditingController zipcodeController = TextEditingController();

  Position? _currentPosition;
  String? _currentAddress;
  bool isLoading = false;

  Future<Position> _getPosition() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.deniedForever){
      return Future.error('Location not available');
    }else{
      print('Location not available');
    }
    return await Geolocator.getCurrentPosition();
  }
  final profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                Text(
                  "Where do you want to receive your orders".tr,
                  style: GoogleFonts.poppins(color: Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 16),
                ),
                SizedBox(
                  height: size.height * .02,
                ),

                InkWell(
                 onTap: (){
                   Get.to(()=>FindMyLocation());
                 },
                  child: Text(
                    "Find my location".tr,
                    style: GoogleFonts.poppins(color: const Color(0xff044484), fontWeight: FontWeight.w400, fontSize: 14),
                  ),
                ),
                SizedBox(
                  height: size.height * .02,
                ),
                InkWell(
                 onTap: (){
                   bottomSheet(addressData: AddressData());
                 },
                  child: Text(
                    "Add new location".tr,
                    style: GoogleFonts.poppins(color: const Color(0xff044484), fontWeight: FontWeight.w400, fontSize: 14),
                  ),
                ),
                SizedBox(
                  height: size.height * .02,
                ),

                InkWell(
                  onTap: () {
                    setState(() {
                      isSelect.value = !isSelect.value;
                    });
                  },
                  child: Text(
                    "Enter your zip code".tr,
                    style: GoogleFonts.poppins(color: const Color(0xff044484), fontWeight: FontWeight.w400, fontSize: 14),
                  ),
                ),
                isSelect.value == true ?
                SizedBox(
                  height: size.height * .02,
                ) : const SizedBox.shrink(),
                if( isSelect.value == true )
                  ...commonField(
                      hintText: "Zip Code",
                      textController: locationController.zipcodeController,
                      title: 'Zip Code*',
                      validator: (String? value) {},
                      keyboardType: TextInputType.number),
                isSelect.value == true ?
                SizedBox(
                  height: size.height * .02,
                ) : const SizedBox.shrink(),
                if( isSelect.value == true)
                  GestureDetector(
                    onTap: () {
                      if (formKey1.currentState!.validate()) {
                        locationController.editAddressApi(context);
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
                      padding: const EdgeInsets.all(10),
                      // Padding inside the container
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
                // SizedBox(
                //   height: size.height * .02,
                // ),
                // ...commonField(
                //     hintText: "Street",
                //     textController: locationController.streetController,
                //     title: 'Street*',
                //     validator: (String? value) {},
                //     keyboardType: TextInputType.name),
                // ...commonField(
                //     hintText: "city",
                //     textController: locationController.cityController,
                //     title: 'City*',
                //     validator: (String? value) {},
                //     keyboardType: TextInputType.name),
                // ...commonField(
                //     hintText: "state",
                //     textController: locationController.stateController,
                //     title: 'State*',
                //     validator: (String? value) {},
                //     keyboardType: TextInputType.name),
                // ...commonField(
                //     hintText: "Country",
                //     textController: locationController.countryController,
                //     title: 'Country*',
                //     validator: (String? value) {},
                //     keyboardType: TextInputType.name),
                // ...commonField(
                //     hintText: "Zip Code",
                //     textController: locationController.zipcodeController,
                //     title: 'Zip Code*',
                //     validator: (String? value) {},
                //     keyboardType: TextInputType.number),
                // ...commonField(
                //     hintText: "Town",
                //     textController: locationController.townController,
                //     title: 'Town*',
                //     validator: (String? value) {},
                //     keyboardType: TextInputType.name),
                // SizedBox(
                //   height: size.height * .02,
                // ),
                // GestureDetector(
                //   onTap: (){
                //
                //     if (formKey1.currentState!.validate()) {
                //       editAddressApi();
                //     }
                //     setState(() {});
                //   },
                //   child: Container(
                //     margin: const EdgeInsets.only(left: 20, right: 20),
                //     width: Get.width,
                //     height: 50,
                //     decoration: BoxDecoration(
                //       border: Border.all(
                //         color: Colors.black, // Border color
                //         width: 1.0, // Border width
                //       ),
                //       borderRadius: BorderRadius.circular(10), // Border radius
                //     ),
                //     padding: const EdgeInsets.all(10), // Padding inside the container
                //     child: const Center(
                //       child: Text(
                //         'Confirm Your Location',
                //         style: TextStyle(
                //           fontSize: 16,
                //           fontWeight: FontWeight.bold,
                //           color: Colors.black, // Text color
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: size.height * .02,
                // ),
              ],
            ),
          ),
        ),
      ),
    );

  }
  Future bottomSheet({required AddressData addressData}) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        builder: (context12) {
          return EditAddressSheet(
            addressData: addressData,
          );
        });
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
