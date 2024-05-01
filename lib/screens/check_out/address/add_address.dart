import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../iAmHereToSell/PersonalizeAddAddressScreen.dart';
import '../../../iAmHereToSell/personalizeyourstoreScreen.dart';
import '../../../language/app_strings.dart';
import '../../../model/common_modal.dart';
import '../../../model/model_address_list.dart';
import '../../../personalizeyourstore/personalizeAddressScreen.dart';
import '../../../repository/repository.dart';
import '../../../utils/api_constant.dart';
import '../../../widgets/common_colour.dart';
import '../../../widgets/dimension_screen.dart';
import '../../return_policy.dart';
import 'edit_address_screen.dart';

class AddAddressScreen extends StatefulWidget {
  final String? street;
  final String? city;
  final String? state;
  final String? country;
  final String? zipcode;
  final String? town;
  const AddAddressScreen({super.key,
    this.street,
    this.city,
    this.state,
    this.country,
    this.zipcode,
    this.town,

  });

  static var route = "/addAddressScreen";

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {

  final TextEditingController streetController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController zipcodeController = TextEditingController();
  final TextEditingController townController = TextEditingController();
  final TextEditingController specialInstructionController = TextEditingController();
  RxBool hide = true.obs;
  RxBool hide1 = true.obs;
  bool showValidation = false;
  bool check = false;
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
      map['special_instruction'] = specialInstructionController.text.trim();
    }else{
      map['address_type'] = 'Both';
      map['city'] = cityController.text.trim();
      map['country'] = countryController.text.trim();
      map['state'] = stateController.text.trim();
      map['zip_code'] = zipcodeController.text.trim();
      map['town'] = townController.text.trim();
      map['street'] = streetController.text.trim();
      map['special_instruction'] = specialInstructionController.text.trim();
    }

    FocusManager.instance.primaryFocus!.unfocus();
    repositories.postApi(url: ApiUrls.editAddressUrl, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      if (response.status == true) {
        Get.to( PersonalizeAddressScreen());
      }
    });
  }

  ModelUserAddressList addressListModel = ModelUserAddressList();

  Future getAddressDetails() async {
    await repositories.getApi(url: ApiUrls.addressListUrl).then((value) {
      addressListModel = ModelUserAddressList.fromJson(jsonDecode(value));
      setState(() {
      });
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.street != null) {
      streetController.text = widget.street!;
      cityController.text = widget.city ?? '';
      stateController.text = widget.state ?? '';
      countryController.text = widget.country ?? '';
      zipcodeController.text = widget.zipcode ?? '';
      townController.text = widget.town ?? '';
    }
    getAddressDetails();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
              AppStrings.yourAddress.tr,
              style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            children: [
              GestureDetector(
                onTap: (){
                  Get.to(PersonalizeAddAddressScreen());
                },
                child: Container(
                  width: size.width,
                  height: 130,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      border: Border.all(color: const Color(0xffE4E2E2))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.add,
                        size: 35,
                        color: Color(0xffE4E2E2),
                      ),
                      Text("Address",
                          style: GoogleFonts.poppins(
                              fontSize: 32, fontWeight: FontWeight.w400, color: const Color(0xffACACAC)))
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              addressListModel.address?.billing != null ?
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: addressListModel.address!.billing!.length,
                shrinkWrap: true,
                itemBuilder: (context,index){
                  var addressList = addressListModel.address!.billing![index];
                  return Column(
                    children: [
                      Container(
                        width: size.width,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                            border: Border.all(color: const Color(0xffE4E2E2))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 13),
                              child: Row(
                                children: [
                                  Text("Default:",
                                      style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500)),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  const Image(image: AssetImage("assets/icons/tempImageYRVRjh 1.png"))
                                ],
                              ),
                            ),
                            const Divider(
                              thickness: 1,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 13),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('first name - ${addressList.firstName.toString()}' ?? ""),
                                  Text('last name - ${addressList.lastName.toString()}' ?? ""),
                                  Text('City - ${addressList.city.toString()}'),
                                  Text('state - ${addressList.state.toString()}'),
                                  Text('country - ${addressList.country.toString()}'),
                                  Text('zip code - ${addressList.zipCode.toString()}'),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "Add delivery instructions",
                                    style: GoogleFonts.poppins(
                                        fontSize: 18, fontWeight: FontWeight.w500, color: const Color(0xff014E70)),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    children: [
                                      Text("Edit",
                                          style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w300,
                                              color: const Color(0xff014E70))),
                                      Text("|Remove",
                                          style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w300,
                                              color: const Color(0xff014E70))),
                                      Text("|Set as default",
                                          style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w300,
                                              color: const Color(0xff014E70))),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  );
                },
              ) : const Center(child: CircularProgressIndicator()),
              addressListModel.address?.shipping != null ?
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: addressListModel.address!.shipping!.length,
                shrinkWrap: true,
                itemBuilder: (context,index){
                  var shippingAddressList = addressListModel.address!.shipping![index];
                  return Column(
                    children: [
                      Container(
                        width: size.width,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                            border: Border.all(color: const Color(0xffE4E2E2))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 13),
                              child: Row(
                                children: [
                                  Text("Default:",
                                      style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500)),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  const Image(image: AssetImage("assets/icons/tempImageYRVRjh 1.png"))
                                ],
                              ),
                            ),
                            const Divider(
                              thickness: 1,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 13),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('first name - ${shippingAddressList.firstName.toString()}' ?? ""),
                                  Text('last name - ${shippingAddressList.lastName.toString()}' ?? ""),
                                  Text('City - ${shippingAddressList.city.toString()}'),
                                  Text('state - ${shippingAddressList.state.toString()}'),
                                  Text('country - ${shippingAddressList.country.toString()}'),
                                  Text('zip code - ${shippingAddressList.zipCode.toString()}'),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "Add delivery instructions",
                                    style: GoogleFonts.poppins(
                                        fontSize: 18, fontWeight: FontWeight.w500, color: const Color(0xff014E70)),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    children: [
                                      Text("Edit",
                                          style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w300,
                                              color: const Color(0xff014E70))),
                                      Text("|Remove",
                                          style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w300,
                                              color: const Color(0xff014E70))),
                                      Text("|Set as default",
                                          style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w300,
                                              color: const Color(0xff014E70))),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  );
                },
              ) : const Center(child: CircularProgressIndicator()),

              ElevatedButton(
                  onPressed: () {
                   Get.to(const PersonalizeyourstoreScreen());
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.maxFinite, 60),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AddSize.size5),
                      ),
                      side: const BorderSide(color: Color(0xff014E70)),
                      textStyle: GoogleFonts.poppins(fontSize: AddSize.font20, fontWeight: FontWeight.w600)),
                  child: Text(
                    "Save".tr,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: const Color(0xff014E70), fontWeight: FontWeight.w500, fontSize: AddSize.font18),
                  )),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    Get.to(const PersonalizeyourstoreScreen());
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.maxFinite, 60),
                      backgroundColor: AppTheme.buttonColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AddSize.size5)),
                      textStyle: GoogleFonts.poppins(fontSize: AddSize.font20, fontWeight: FontWeight.w600)),
                  child: Text(
                    "Skip".tr,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(color: Colors.white, fontWeight: FontWeight.w500, fontSize: AddSize.font18),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
