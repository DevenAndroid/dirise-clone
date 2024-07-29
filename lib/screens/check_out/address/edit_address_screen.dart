import 'dart:convert';

import 'package:dirise/widgets/vendor_common_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../addNewProduct/pickUpAddressScreen.dart';
import '../../../controller/cart_controller.dart';
import '../../../controller/profile_controller.dart';
import '../../../language/app_strings.dart';
import '../../../model/customer_profile/model_city_list.dart';
import '../../../model/customer_profile/model_country_list.dart';
import '../../../model/customer_profile/model_state_list.dart';
import '../../../repository/repository.dart';
import '../../../utils/api_constant.dart';
import '../../../widgets/common_colour.dart';
import '../../../widgets/common_textfield.dart';
import '../../my_account_screens/editprofile_screen.dart';

class EditAddresss extends StatefulWidget {
  const EditAddresss({super.key});
  static var route = "/editAddressScreen";
  @override
  State<EditAddresss> createState() => _EditAddresssState();
}

class _EditAddresssState extends State<EditAddresss> {
  final cartController = Get.put(CartController());

  final profileController = Get.put(ProfileController());
  ModelCountryList? modelCountryList;
  Country? selectedCountry;
  ModelStateList? modelStateList;
  CountryState? selectedState;
  ModelCityList? modelCityList;
  City? selectedCity;
  final Repositories repositories = Repositories();
  RxInt stateRefresh = 2.obs;
  RxInt cityRefresh = 2.obs;
  Future getCityList({required String stateId, bool? reset}) async {
    if (reset == true) {
      modelCityList = null;
      selectedCity = null;
    }
    cityRefresh.value = -5;
    final map = {'state_id': stateId};
    await repositories.postApi(url: ApiUrls.allCityUrl, mapData: map).then((value) {
      modelCityList = ModelCityList.fromJson(jsonDecode(value));
      cityRefresh.value = DateTime.now().millisecondsSinceEpoch;
    }).catchError((e) {
      cityRefresh.value = DateTime.now().millisecondsSinceEpoch;
    });
  }
  Future getStateList({required String countryId, bool? reset}) async {
    if (reset == true) {
      modelStateList = null;
      selectedState = null;
      modelCityList = null;
      selectedCity = null;
    }
    stateRefresh.value = -5;

    RxInt cityRefresh = 2.obs;
    final map = {'country_id': countryId};
    await repositories.postApi(url: ApiUrls.allStatesUrl, mapData: map).then((value) {
      modelStateList = ModelStateList.fromJson(jsonDecode(value));
      stateRefresh.value = DateTime.now().millisecondsSinceEpoch;
    }).catchError((e) {
      stateRefresh.value = DateTime.now().millisecondsSinceEpoch;
    });
  }
  // Country? selectedCountry;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
              AppStrings.editAddress.tr,
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text("Save time by choosing your current location.",style: GoogleFonts.poppins(fontSize:13,fontWeight:FontWeight.w600),),
            Column(crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Add location",style: TextStyle(color: Color(0xff0D5877),decoration: TextDecoration.underline,fontWeight: FontWeight.w600,fontSize: 10),),
                  ],
                ),
              ],
            ),
              ...fieldWithName(
                title: 'Country/Region',
                hintText: 'Select Country',
                readOnly: true,


                validator: (v) {
                  if (v!.trim().isEmpty) {
                    return "Please select country";
                  }
                  return null;
                },             onTap: () {
                showAddressSelectorDialog(
                    addressList: modelCountryList!.country!
                        .map((e) => CommonAddressRelatedClass(
                        title: e.name.toString(),
                        addressId: e.id.toString(),
                        flagUrl: e.icon.toString()))
                        .toList(),
                    selectedAddressIdPicked: (String gg) {
                      String previous = ((selectedCountry ?? Country()).id ?? "").toString();
                      selectedCountry =
                          modelCountryList!.country!.firstWhere((element) => element.id.toString() == gg);
                      cartController.countryCode = gg.toString();
                      cartController.countryName.value = selectedCountry!.name.toString();
                      print('countrrtr ${cartController.countryName.toString()}');
                      print('countrrtr ${cartController.countryCode.toString()}');
                      if (previous != selectedCountry!.id.toString()) {
                        getStateList(countryId: gg, reset: true).then((value) {
                          setState(() {});
                        });
                        setState(() {});
                      }
                    },
                    selectedAddressId: ((selectedCountry ?? Country()).id ?? "").toString());
              },
                controller: TextEditingController(
                    text: (selectedCountry ?? Country()).name ??
                        cartController.addressCountryController.text),
              ),
              ...fieldWithName(
                title: 'Name',
                hintText: 'fahad',
                readOnly: true,


                validator: (v) {
                  if (v!.trim().isEmpty) {
                    return "Please select country";
                  }
                  return null;
                }, controller: TextEditingController(),
              ),
              ...fieldWithName(
                title: 'Phone',
                hintText: '109 Lukens Drive #212122 Unit E',
                readOnly: true,


                validator: (v) {
                  if (v!.trim().isEmpty) {
                    return "Please select country";
                  }
                  return null;
                }, controller: TextEditingController(),
              ),
              Text("May be used to assist delivery"),
              SizedBox(height: 8,),
              ...fieldWithName(
                title: 'Address',
                hintText: '109 Lukens Drive #212122 Unit E',
                readOnly: true,


                validator: (v) {
                  if (v!.trim().isEmpty) {
                    return "Please select country";
                  }
                  return null;
                }, controller: TextEditingController(),
              ),
              CommonTextField(
                // controller: ProductNameController,
                  obSecure: false,
                  hintText: 'Apt, suite, unit, building, floor, etc.',
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'Policy name is required'.tr),
                  ])),
              // Flexible(flex: 1,
              //   child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       ...fieldWithName(
              //         title: 'State',
              //         hintText: 'Select State',
              //         controller: TextEditingController(
              //             text: (selectedState ?? CountryState()).stateName ??
              //                 cartController.addressStateController.text),
              //         readOnly: true,
              //         onTap: () {
              //           if (modelStateList == null && stateRefresh.value > 0) {
              //             showToast("Select Country First");
              //             return;
              //           }
              //           if (stateRefresh.value < 0) {
              //             return;
              //           }
              //           if (modelStateList!.state!.isEmpty) return;
              //           showAddressSelectorDialog(
              //               addressList: profileController.selectedLAnguage.value == 'English'
              //                   ? modelStateList!.state!
              //                   .map((e) => CommonAddressRelatedClass(
              //                   title: e.stateName.toString(), addressId: e.stateId.toString()))
              //                   .toList()
              //                   : modelStateList!.state!
              //                   .map((e) => CommonAddressRelatedClass(
              //                   title: e.arabStateName.toString(), addressId: e.stateId.toString()))
              //                   .toList(),
              //               selectedAddressIdPicked: (String gg) {
              //                 String previous = ((selectedState ?? CountryState()).stateId ?? "").toString();
              //                 selectedState = modelStateList!.state!
              //                     .firstWhere((element) => element.stateId.toString() == gg);
              //                 if (previous != selectedState!.stateId.toString()) {
              //                   getCityList(stateId: gg, reset: true).then((value) {
              //                     setState(() {});
              //                   });
              //                   setState(() {});
              //                 }
              //               },
              //               selectedAddressId: ((selectedState ?? CountryState()).stateId ?? "").toString());
              //         },
              //         suffixIcon: Obx(() {
              //           if (stateRefresh.value > 0) {
              //             return const Icon(Icons.keyboard_arrow_down_rounded);
              //           }
              //           return const CupertinoActivityIndicator();
              //         }),
              //         validator: (v) {
              //           if (v!.trim().isEmpty) {
              //             return "Please select state";
              //           }
              //           return null;
              //         },
              //       ),
              //       // if (modelCityList != null && modelCityList!.city!.isNotEmpty)
              //       // ...fieldWithName(
              //       //   readOnly: true,
              //       //   title: 'City',
              //       //   hintText: 'Select City',
              //       //   controller: TextEditingController(
              //       //       text: (selectedCity ?? City()).cityName ?? cartController.addressCityController.text),
              //       //   onTap: () {
              //       //     if (modelCityList == null && cityRefresh.value > 0) {
              //       //       showToast("Select State First");
              //       //       return;
              //       //     }
              //       //     if (cityRefresh.value < 0) {
              //       //       return;
              //       //     }
              //       //     if (modelCityList!.city!.isEmpty) return;
              //       //     showAddressSelectorDialog(
              //       //         addressList: profileController.selectedLAnguage.value == 'English'
              //       //             ? modelCityList!.city!
              //       //             .map((e) => CommonAddressRelatedClass(
              //       //             title: e.cityName.toString(), addressId: e.cityId.toString()))
              //       //             .toList()
              //       //             : modelCityList!.city!
              //       //             .map((e) => CommonAddressRelatedClass(
              //       //             title: e.arabCityName.toString(), addressId: e.cityId.toString()))
              //       //             .toList(),
              //       //         selectedAddressIdPicked: (String gg) {
              //       //           selectedCity =
              //       //               modelCityList!.city!.firstWhere((element) => element.cityId.toString() == gg);
              //       //           cartController.cityCode = gg.toString();
              //       //           cartController.cityName.value = selectedCity!.cityName.toString();
              //       //           setState(() {});
              //       //         },
              //       //         selectedAddressId: ((selectedCity ?? City()).cityId ?? "").toString());
              //       //   },
              //       //   suffixIcon: Obx(() {
              //       //     if (cityRefresh.value > 0) {
              //       //       return const Icon(Icons.keyboard_arrow_down_rounded);
              //       //     }
              //       //     return const CupertinoActivityIndicator();
              //       //   }),
              //       //   validator: (v) {
              //       //     if (v!.trim().isEmpty) {
              //       //       return "Please select state";
              //       //     }
              //       //     return null;
              //       //   },
              //       // ),
              //       // ...commonField(
              //       //     textController: cartController.addressDeliZipCode,
              //       //     title: "Zip Code *",
              //       //     hintText: "Enter location Zip-Code",
              //       //     keyboardType: TextInputType.phone,
              //       //     validator: (value) {
              //       //       // if (value!.trim().isEmpty) {
              //       //       //   return "Please enter phone number";
              //       //       // }
              //       //       return null;
              //       //     }),
              //     ],
              //   ),
              // )


          ],),
        ),
      ),
    );

  }
  showAddressSelectorDialog({
    required List<CommonAddressRelatedClass> addressList,
    required String selectedAddressId,
    required Function(String selectedId) selectedAddressIdPicked,
  }) {
    FocusManager.instance.primaryFocus!.unfocus();
    final TextEditingController searchController = TextEditingController();
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            insetPadding: const EdgeInsets.all(18),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: StatefulBuilder(builder: (context, newState) {
                String gg = searchController.text.trim().toLowerCase();
                List<CommonAddressRelatedClass> filteredList =
                addressList.where((element) => element.title.toString().toLowerCase().contains(gg)).toList();
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: searchController,
                      onChanged: (gg) {
                        newState(() {});
                      },
                      autofocus: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: AppTheme.buttonColor, width: 1.2)),
                          enabled: true,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: AppTheme.buttonColor, width: 1.2)),
                          suffixIcon: const Icon(Icons.search),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12)),
                    ),
                    Flexible(
                        child: ListView.builder(
                            itemCount: filteredList.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return ListTile(
                                // dense: true,
                                onTap: () {
                                  selectedAddressIdPicked(filteredList[index].addressId);
                                  FocusManager.instance.primaryFocus!.unfocus();
                                  Get.back();
                                },
                                leading: filteredList[index].flagUrl != null
                                    ? SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: filteredList[index].flagUrl.toString().contains("svg")
                                        ? SvgPicture.network(
                                      filteredList[index].flagUrl.toString(),
                                    )
                                        : Image.network(
                                      filteredList[index].flagUrl.toString(),
                                      errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                                    ))
                                    : null,
                                visualDensity: VisualDensity.compact,
                                title: Text(filteredList[index].title),
                                trailing: selectedAddressId == filteredList[index].addressId
                                    ? const Icon(
                                  Icons.check,
                                  color: Colors.purple,
                                )
                                    : Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 18,
                                  color: Colors.grey.shade800,
                                ),
                              );
                            }))
                  ],
                );
              }),
            ),
          );
        });
  }
}
