import 'dart:convert';
import 'package:dirise/widgets/loading_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/cart_controller.dart';
import '../../controller/home_controller.dart';
import '../../controller/location_controller.dart';
import '../../controller/profile_controller.dart';
import '../../model/common_modal.dart';
import '../../model/model_address_list.dart';
import '../../model/myDefaultAddressModel.dart';
import '../../repository/repository.dart';
import '../../utils/api_constant.dart';
import '../../widgets/common_colour.dart';
import '../../widgets/common_textfield.dart';
import '../check_out/address/edit_address.dart';
import 'find_my_location.dart';


class HomeAddEditAddressLogin extends StatefulWidget {


  const HomeAddEditAddressLogin({Key? key}) : super(key: key);

  @override
  State<HomeAddEditAddressLogin> createState() => _HomeAddEditAddressLoginState();
}

class _HomeAddEditAddressLoginState extends State<HomeAddEditAddressLogin> {

  final TextEditingController specialInstructionController = TextEditingController();
  RxBool hide = true.obs;
  RxBool hide1 = true.obs;
  final TextEditingController zipcodeController = TextEditingController();
  bool showValidation = false;
  final Repositories repositories = Repositories();
  final formKey1 = GlobalKey<FormState>();
  String code = "+91";
  RxBool isSelect = false.obs;


  Rx<MyDefaultAddressModel> addressListModel1 = MyDefaultAddressModel().obs;

  getAddress1() {
    repositories.getApi(url: ApiUrls.defaultAddressUrl).then((value) {
      addressListModel1.value = MyDefaultAddressModel.fromJson(jsonDecode(value));
    });
  }
  final locationController = Get.put(LocationController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAddress();

  }

  Rx<ModelUserAddressList> addressListModel = ModelUserAddressList().obs;

  getAddress() {
    repositories.getApi(url: ApiUrls.addressListUrl).then((value) {
      addressListModel.value = ModelUserAddressList.fromJson(jsonDecode(value));
    });
  }

  final homeController = Get.put(TrendingProductsController());
  defaultAddressApi() async {
    Map<String, dynamic> map = {};
    map['address_id'] = cartController.selectedAddress.id.toString();
    repositories.postApi(url: ApiUrls.defaultAddressStatus, context: context, mapData: map).then((value) async {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      if (response.status == true) {
        showToast(response.message.toString());
        locationController.getAddress();
        locationController.onTapLocation.value = false;
        Future.delayed(const Duration(seconds: 1), () {
          homeController.defaultAddressId = locationController.addressListModel.value.defaultAddress!.id.toString();
          cartController.countryId = locationController.addressListModel.value.defaultAddress!.countryId.toString();
          locationController.zipcode.value = locationController.addressListModel.value.defaultAddress!.zipCode.toString();
          locationController.state = locationController.addressListModel.value.defaultAddress!.state.toString();
          locationController.city.value = locationController.addressListModel.value.defaultAddress!.city.toString();
          homeController.trendingData();
          homeController.popularProductsData();
          Get.back();
        });
      }else{
        showToast(response.message.toString());
      }
    });
  }
  final cartController = Get.put(CartController());
  final profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
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
      body: Obx(() {
        return addressListModel.value.address != null ?
        SingleChildScrollView(
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
                      locationController.editAddressApi(context);
                     // Get.back();
                    // setState(() {});
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    width: Get.width,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppTheme.buttonColor,
                        width: 2.0, // Border width
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
                          color: AppTheme.buttonColor, // Text color
                        ),
                      ),
                    ),
                  ),
                ),
              SizedBox(
                height: size.height * .02,
              ),
              Text(
                "Default Address".tr,
                style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 16),
              ),
              SizedBox(
                height: size.height * .02,
              ),
              addressListModel.value.address!= null ?
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: addressListModel.value.address!.shipping!.length,
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    List<AddressData> shippingAddress = addressListModel.value.address!.shipping ?? [];
                    final address = shippingAddress[index];
                    return GestureDetector(
                      onTap: (){

                        locationController.city.value = address.getCity.toString();
                        locationController.zipcode.value = address.state.toString();
                        print('gvava ${locationController.zipcode.toString()}');
                        cartController.countryId =  address.countryId.toString();
                        locationController.onTapLocation.value = true;
                        cartController.getCart();
                        Get.back();
                      },
                      child: Container(
                        width: size.width,
                        margin: const EdgeInsets.only(bottom: 15),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xffDCDCDC))),
                        child: IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.location_on_rounded),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  address.getCompleteAddressInFormat,
                                  maxLines: 2,
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500, fontSize: 15, color: const Color(0xff585858)),
                                ),
                              ),
                              address.isDefault == true ?
                              Text(
                                "Default",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    color: Colors.grey),
                              ) : const SizedBox.shrink(),
                              SizedBox(
                                width: 30,
                                child: PopupMenuButton(
                                    color: Colors.white,
                                    iconSize: 20,
                                    icon: const Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.more_vert,
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                    padding: EdgeInsets.zero,
                                    onSelected: (value) {
                                      setState(() {

                                      });
                                      Navigator.pushNamed(context, value.toString());
                                    },
                                    itemBuilder: (ac) {
                                      return [
                                        PopupMenuItem(
                                          onTap: () {
                                            cartController.selectedAddress = address;
                                            cartController.completeAddress = address.getCompleteAddressInFormat;
                                            print("complete"+ cartController.completeAddress);
                                            defaultAddressApi();
                                            locationController.getAddress();
                                            setState(() {

                                            });
                                          },
                                          // value: '/slotViewScreen',
                                          child: Text("Default Address".tr),
                                        ),
                                        // PopupMenuItem(
                                        //   onTap: () {
                                        //     cartController
                                        //         .deleteAddress(
                                        //       context: context,
                                        //       id: address.id.toString(),
                                        //     )
                                        //         .then((value) {
                                        //       if (value == true) {
                                        //         cartController.addressListModel.address!.shipping!.removeWhere(
                                        //                 (element) =>
                                        //             element.id.toString() == address.id.toString());
                                        //         cartController.updateUI();
                                        //       }
                                        //     });
                                        //   },
                                        //   // value: '/deactivate',
                                        //   child: Text("Delete".tr),
                                        // )
                                      ];
                                    }),
                              ),


                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ) : const LoadingAnimation(),
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
          )
        )
            : const LoadingAnimation();
      }),
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
