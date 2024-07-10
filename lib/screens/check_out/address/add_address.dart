import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controller/cart_controller.dart';
import '../../../controller/profile_controller.dart';
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

  const AddAddressScreen({super.key,


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
  final cartController = Get.put(CartController());
  defaultAddressApi(String id) async {
    Map<String, dynamic> map = {};
    map['address_id'] = id;
    repositories.postApi(url: ApiUrls.defaultAddressStatus, context: context, mapData: map).then((value) async {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      if (response.status == true) {
        showToast(response.message.toString());
      }else{
        showToast(response.message.toString());
      }
    });
  }


  ModelUserAddressList addressListModel = ModelUserAddressList();

  Future getAddressDetails() async {
    await repositories.getApi(url: ApiUrls.addressListUrl).then((value) {
      addressListModel = ModelUserAddressList.fromJson(jsonDecode(value));
      log('address iss....${addressListModel.address!.toJson()}');
      setState(() {
      });
    });
  }

  Future<bool> deleteAddress({required BuildContext context, required String id}) async {
    Map<String, dynamic> map = {};
    map["id"] = id;

    await repositories.postApi(url: ApiUrls.deleteAddressUrl, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      if (response.status == true) {
        getAddressDetails();
        return true;
        // Get.back();
      }
    }).catchError((e) {
      return false;
    });
    return false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAddressDetails();
  }
  final profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
                      Text("Address".tr,
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
                physics: const NeverScrollableScrollPhysics(),
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
                            const SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 13),
                              child:
                                  addressList.isDefault == true ?
                              Row(
                                children: [
                                  Text("Default:",
                                      style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500)),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  const Image(image: AssetImage("assets/icons/tempImageYRVRjh 1.png"))
                                ],
                              ) : const SizedBox()
                            ),
                            const Divider(
                              thickness: 1,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 13),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${'City'.tr} - ${addressList.city.toString()}'),
                                  Text('${'state'.tr} - ${addressList.state.toString()}'),
                                  Text('${'country'.tr} - ${addressList.country.toString()}'),
                                  Text('${'zip code'.tr} - ${addressList.zipCode ?? ''}'),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "Add delivery instructions".tr,
                                    style: GoogleFonts.poppins(
                                        fontSize: 18, fontWeight: FontWeight.w500, color: const Color(0xff014E70)),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    children: [

                                      InkWell(
                                        onTap:(){
                                          Get.to(PersonalizeAddAddressScreen(
                                            id: addressList.id,
                                            street: addressList.address,
                                            city: addressList.city,
                                            state: addressList.state,
                                            zipcode: addressList.zipCode,
                                            country: addressList.country,
                                            town: addressList.town,
                                          ));
                                        },
                                        child: Text("Edit ".tr,
                                            style: GoogleFonts.poppins(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w300,
                                                color: const Color(0xff014E70))),
                                      ),

                                      InkWell(
                                        onTap:(){
                                          deleteAddress(context: context, id: addressList.id.toString());
                                        },
                                        child: Text("| Remove ".tr,
                                            style: GoogleFonts.poppins(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w300,
                                                color: const Color(0xff014E70))),
                                      ),
                                      InkWell(
                                        onTap:(){
                                          defaultAddressApi(addressList.id.toString());
                                        },
                                        child: Text("| Set as default".tr,
                                            style: GoogleFonts.poppins(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w300,
                                                color: const Color(0xff014E70))),
                                      ),
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
              ) : const Center(child: SizedBox()),

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
