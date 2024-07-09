import 'dart:convert';
import 'package:dirise/repository/repository.dart';
import 'package:dirise/utils/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../../controller/cart_controller.dart';
import '../../../controller/profile_controller.dart';
import '../../../model/customer_profile/model_city_list.dart';
import '../../../model/customer_profile/model_country_list.dart';
import '../../../model/customer_profile/model_state_list.dart';
import '../../../model/model_address_list.dart';
import '../../../utils/api_constant.dart';
import '../../../widgets/common_colour.dart';
import '../../my_account_screens/editprofile_screen.dart';
import 'address_screen.dart';

class EditAddressSheet extends StatefulWidget {
  const EditAddressSheet({super.key, required this.addressData});
  final AddressData addressData;

  @override
  State<EditAddressSheet> createState() => _EditAddressSheetState();
}

class _EditAddressSheetState extends State<EditAddressSheet> {
  final cartController = Get.put(CartController());

  AddressData get addressData => widget.addressData;

  ModelCountryList? modelCountryList;
  Country? selectedCountry;

  ModelStateList? modelStateList;
  CountryState? selectedState;

  ModelCityList? modelCityList;
  City? selectedCity;
  final Repositories repositories = Repositories();
  RxInt stateRefresh = 2.obs;
  Future getStateList({required String countryId, bool? reset}) async {
    if (reset == true) {
      modelStateList = null;
      selectedState = null;
      modelCityList = null;
      selectedCity = null;
    }
    stateRefresh.value = -5;
    final map = {'country_id': countryId};
    await repositories.postApi(url: ApiUrls.allStatesUrl, mapData: map).then((value) {
      modelStateList = ModelStateList.fromJson(jsonDecode(value));
      setState(() {

      });
      stateRefresh.value = DateTime.now().millisecondsSinceEpoch;
    }).catchError((e) {
      stateRefresh.value = DateTime.now().millisecondsSinceEpoch;
    });
  }

  RxInt cityRefresh = 2.obs;
  String stateIddd = '';
  Future getCityList({required String stateId, bool? reset}) async {
    if (reset == true) {
      modelCityList = null;
      selectedCity = null;
    }
    cityRefresh.value = -5;
    final map = {'state_id': stateId};
    await repositories.postApi(url: ApiUrls.allCityUrl, mapData: map).then((value) {
      modelCityList = ModelCityList.fromJson(jsonDecode(value));
      setState(() {

      });
      cityRefresh.value = DateTime.now().millisecondsSinceEpoch;
    }).catchError((e) {
      cityRefresh.value = DateTime.now().millisecondsSinceEpoch;
    });
  }

  Size get size => MediaQuery.of(context).size;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController alternatePhoneController;
  late TextEditingController addressController;
  late TextEditingController address2Controller;
  late TextEditingController zipCodeController;
  late TextEditingController landmarkController;
  late TextEditingController titleController;
  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  final formKeyAddress = GlobalKey<FormState>();

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

  getCountryList() {
    if (modelCountryList != null) return;
    repositories.getApi(url: ApiUrls.allCountriesUrl).then((value) {
      modelCountryList = ModelCountryList.fromString(value);
    });
  }
   String countryIddd = '';
  String code = 'KW';
  @override
  void initState() {
    super.initState();
    getCountryList();
    firstNameController = TextEditingController(text: addressData.firstName ?? "");
    lastNameController = TextEditingController(text: addressData.lastName ?? "");
    phoneController = TextEditingController(text: addressData.phone ?? "");
    emailController = TextEditingController(text: addressData.email ?? "");
    alternatePhoneController = TextEditingController(text: addressData.alternatePhone ?? "");
    addressController = TextEditingController(text: addressData.address ?? "");
    address2Controller = TextEditingController(text: addressData.address2 ?? "");
    zipCodeController = TextEditingController(text: addressData.zipCode ?? "");
    landmarkController = TextEditingController(text: addressData.landmark ?? "");
    titleController = TextEditingController(text: addressData.type ?? "");
    countryController = TextEditingController(text: addressData.country ?? "");
    stateController = TextEditingController(text: addressData.state ?? "");
    cityController = TextEditingController(text: addressData.city ?? "");
    countryIddd = addressData.countryId.toString();
    cartController.countryCode = addressData.countryId.toString();
    getStateList(countryId: countryIddd.toString());
    stateIddd = addressData.stateId.toString();
    getCityList(stateId: stateIddd.toString()).then((value) {
      setState(() {

      });
    });
  }
  final profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    print('data........${addressData.toJson().toString()}');
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        width: size.width,
        height: size.height * .8,
        child: SingleChildScrollView(
          child: Form(
            key: formKeyAddress,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...commonField(
                    textController: titleController,
                    title: "Title*",
                    hintText: "Title",
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Please enter address title";
                      }
                      return null;
                    }),
                ...commonField(
                    textController: firstNameController,
                    title: "First Name *",
                    hintText: "First Name",
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Please enter first name";
                      }
                      return null;
                    }),
                ...commonField(
                    textController: lastNameController,
                    title: "Last Name *",
                    hintText: "Last Name",
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Please enter Last name";
                      }
                      return null;
                    }),
                ...commonField(
                    textController: emailController,
                    title: "Email *",
                    hintText: "Enter your email",
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Please enter your email".tr;
                    } else if (value.trim().contains('+') || value.trim().contains(' ')) {
                      return "Email is invalid";
                    } else if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value.trim())) {
                      return null;
                    } else {
                      return 'Please type a valid email address'.tr;
                    }
                  },
                    ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                 'Phone *'.tr,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16, color: const Color(0xff585858)),
                ),
                const SizedBox(
                  height: 8,
                ),

                IntlPhoneField(
                  key: ValueKey(profileController.code),
                  flagsButtonPadding: const EdgeInsets.all(8),
                  dropdownIconPosition: IconPosition.trailing,
                  showDropdownIcon: true,
                  cursorColor: Colors.black,
                  textInputAction: TextInputAction.next,
                  dropdownTextStyle: const TextStyle(color: Colors.black),
                  style: const TextStyle(
                      color: AppTheme.textColor
                  ),

                  controller: phoneController,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      hintStyle: TextStyle(color: AppTheme.textColor),
                      hintText: 'Enter your phone number',
                      labelStyle: TextStyle(color: AppTheme.textColor),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppTheme.shadowColor)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppTheme.shadowColor))),
                  initialCountryCode: profileController.code.toString(),
                  languageCode: '+91',
                  onCountryChanged: (phone) {
                    profileController.code = phone.code;
                    print(phone.code);
                    print(profileController.code.toString());
                  },
                  onChanged: (phone) {
                    profileController.code = phone.countryISOCode.toString();
                    print(phone.countryCode);
                    print(profileController.code.toString());
                  },
                ),

                const SizedBox(
                  height: 5,
                ),
                // Text(
                //   'Alternate Phone *'.tr,
                //   style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16, color: const Color(0xff585858)),
                // ),
                // const SizedBox(
                //   height: 8,
                // ),
                // IntlPhoneField(
                //   // key: ValueKey(code),
                //   flagsButtonPadding: const EdgeInsets.all(8),
                //   dropdownIconPosition: IconPosition.trailing,
                //   showDropdownIcon: true,
                //   cursorColor: Colors.black,
                //   textInputAction: TextInputAction.next,
                //   dropdownTextStyle: const TextStyle(color: Colors.black),
                //   style: const TextStyle(
                //       color: AppTheme.textColor
                //   ),
                //
                //   controller: alternatePhoneController,
                //   decoration: const InputDecoration(
                //       contentPadding: EdgeInsets.zero,
                //       hintStyle: TextStyle(color: AppTheme.textColor),
                //       hintText: 'Enter your phone number',
                //       labelStyle: TextStyle(color: AppTheme.textColor),
                //       border: OutlineInputBorder(
                //         borderSide: BorderSide(),
                //       ),
                //       enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppTheme.shadowColor)),
                //       focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppTheme.shadowColor))),
                //   initialCountryCode: code.toString(),
                //   languageCode: '+91',
                //   onCountryChanged: (phone) {
                //     code = phone.code;
                //     print(phone.code);
                //     print(code.toString());
                //   },
                //   onChanged: (phone) {
                //     code = phone.countryISOCode.toString();
                //     print(phone.countryCode);
                //     print(code.toString());
                //   },
                // ),
                // ...commonField(
                //     textController: phoneController,
                //     title: "Phone *",
                //     hintText: "Enter your phone number",
                //     keyboardType: TextInputType.number,
                //     validator: (value) {
                //       if (value!.trim().isEmpty) {
                //         return "Please enter phone number";
                //       }
                //       if (value.trim().length > 15) {
                //         return "Please enter valid phone number";
                //       }
                //       if (value.trim().length < 8) {
                //         return "Please enter valid phone number";
                //       }
                //       return null;
                //     }),

                ...commonField(
                    textController: alternatePhoneController,
                    title: "Alternate Phone *",
                    hintText: "Enter your alternate phone number",
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      // if(value!.trim().isEmpty){
                      //   return "Please enter phone number";
                      // }
                      // if(value.trim().length > 15){
                      //   return "Please enter valid phone number";
                      // }
                      // if(value.trim().length < 8){
                      //   return "Please enter valid phone number";
                      // }
                      return null;
                    }),
                ...commonField(
                    textController: addressController,
                    title: "Address*",
                    hintText: "Enter your delivery address",
                    keyboardType: TextInputType.streetAddress,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Please enter delivery address";
                      }
                      return null;
                    }),
                ...commonField(
                    textController: address2Controller,
                    title: "Address 2",
                    hintText: "Enter your delivery address",
                    keyboardType: TextInputType.streetAddress,
                    validator: (value) {
                      // if(value!.trim().isEmpty){
                      //   return "Please enter delivery address";
                      // }
                      return null;
                    }),

                // ...commonField(
                //     textController: cityController,
                //     title: "City*",
                //     hintText: "Enter your city",
                //     keyboardType: TextInputType.streetAddress,
                //     validator: (value) {
                //       if (value!.trim().isEmpty) {
                //         return "Please enter City*";
                //       }
                //       return null;
                //     }),
                10.spaceY,
                ...fieldWithName(
                  title: 'Country/Region',
                  hintText: 'Select Country',
                  readOnly: true,
                  onTap: () {
                    showAddressSelectorDialog(
                        addressList: modelCountryList!.country!
                            .map((e) => CommonAddressRelatedClass(
                                title: e.name.toString(), addressId: e.id.toString(), flagUrl: e.icon.toString()))
                            .toList(),
                        selectedAddressIdPicked: (String gg) {
                          String previous = ((selectedCountry ?? Country()).id ?? "").toString();
                          selectedCountry = modelCountryList!.country!.firstWhere((element) => element.id.toString() == gg);
                          cartController.countryCode = gg.toString();
                          cartController.countryName.value = selectedCountry!.name.toString();
                          print('countrrtr ${cartController.countryName.toString()}');
                          print('countrrtr ${cartController.countryCode.toString()}');
                          if (previous != selectedCountry!.id.toString()) {
                            countryIddd = gg.toString();
                            cartController.countryId = gg.toString();
                            print('country idd changed...${cartController.countryId.toString()}');
                            getStateList(countryId: countryIddd.toString(), reset: true).then((value) {
                              setState(() {});
                            });
                            setState(() {});
                          }
                        },
                        selectedAddressId: ((selectedCountry ?? Country()).id ?? "").toString());
                  },
                  controller: TextEditingController(text: (selectedCountry ?? Country()).name ?? countryController.text),
                  validator: (v) {
                    if (v!.trim().isEmpty) {
                      return "Please select country";
                    }
                    return null;
                  },
                ),
                ...fieldWithName(
                  title: 'State',
                  hintText: 'Select State',
                  controller: TextEditingController(text: (selectedState ?? CountryState()).stateName ??  stateController.text),
                  readOnly: true,
                  onTap: () {
                    if(countryIddd == 'null'){
                      showToast("Select Country First");
                      return;
                    }
                    if (modelStateList == null && stateRefresh.value > 0) {
                      showToast("Select Country First");
                      return;
                    }
                    if (stateRefresh.value < 0) {
                      return;
                    }
                    if (modelStateList!.state!.isEmpty) return;
                    showAddressSelectorDialog(
                        addressList: profileController.selectedLAnguage.value == 'English' ?
                        modelStateList!.state!.map((e) => CommonAddressRelatedClass(title: e.stateName.toString(), addressId: e.stateId.toString())).toList() :
                        modelStateList!.state!.map((e) => CommonAddressRelatedClass(title: e.arabStateName.toString(), addressId: e.stateId.toString())).toList(),
                        selectedAddressIdPicked: (String gg) {
                          String previous = ((selectedState ?? CountryState()).stateId ?? "").toString();
                          selectedState = modelStateList!.state!.firstWhere((element) => element.stateId.toString() == gg);
                          cartController.stateCode = gg.toString();
                          cartController.stateName.value = selectedState!.stateName.toString();
                          print('state ${cartController.stateCode.toString()}');
                          print('stateNameee ${cartController.stateName.toString()}');
                          if (previous != selectedState!.stateId.toString()) {
                            stateIddd = gg.toString();
                            getCityList(stateId: gg, reset: true).then((value) {
                              cityController.text= '';
                              setState(() {});
                            });
                            setState(() {});
                          }
                        },
                        selectedAddressId: ((selectedState ?? CountryState()).stateId ?? "").toString());
                  },
                  suffixIcon: Obx(() {
                    if (stateRefresh.value > 0) {
                      return const Icon(Icons.keyboard_arrow_down_rounded);
                    }
                    return const CupertinoActivityIndicator();
                  }),
                  validator: (v) {
                    if (v!.trim().isEmpty) {
                      return "Please select state";
                    }
                    return null;
                  },
                ),
                if (modelCityList != null && modelCityList!.city!.isNotEmpty)
                  ...fieldWithName(
                    readOnly: true,
                    title: 'City',
                    hintText: 'Select City',
                    controller: TextEditingController(text: (selectedCity ?? City()).cityName ?? cityController.text),
                    onTap: () {
                      if (modelCityList == null && cityRefresh.value > 0) {
                        showToast("Select State First");
                        return;
                      }
                      if (cityRefresh.value < 0) {
                        return;
                      }
                      if (modelCityList!.city!.isEmpty) return;
                      showAddressSelectorDialog(
                          addressList:  profileController.selectedLAnguage.value == 'English' ? modelCityList!.city!.map((e) => CommonAddressRelatedClass(title: e.cityName.toString(), addressId: e.cityId.toString())).toList() :
                          modelCityList!.city!.map((e) => CommonAddressRelatedClass(title: e.arabCityName.toString(), addressId: e.cityId.toString())).toList(),
                          selectedAddressIdPicked: (String gg) {
                            selectedCity = modelCityList!.city!.firstWhere((element) => element.cityId.toString() == gg);
                            cartController.cityCode = gg.toString();
                            cartController.cityName.value = selectedCity!.cityName.toString();
                            print('state ${cartController.cityName.toString()}');
                            print('state Nameee ${cartController.cityCode.toString()}');
                            setState(() {});
                          },
                          selectedAddressId: ((selectedCity ?? City()).cityId ?? "").toString());
                    },
                    suffixIcon: Obx(() {
                      if (cityRefresh.value > 0) {
                        return const Icon(Icons.keyboard_arrow_down_rounded);
                      }
                      return const CupertinoActivityIndicator();
                    }),
                    validator: (v) {
                      if (v!.trim().isEmpty) {
                        return "Please select state";
                      }
                      return null;
                    },
                  ),
                if(cartController.countryName.value != 'Kuwait')
                  ...commonField(
                      textController: landmarkController,
                      title: "Landmark",
                      hintText: "Enter your nearby landmark",
                      keyboardType: TextInputType.streetAddress,
                      validator: (value) {
                        // if(value!.trim().isEmpty){
                        //   return "Please enter delivery address";
                        // }
                        return null;
                      }),
                if(cartController.countryName.value != 'Kuwait')
                ...commonField(
                    textController: zipCodeController,
                    title: "Zip-Code*",
                    hintText: "Enter location Zip-Code",
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Please enter Zip-Code*";
                      }
                      return null;
                    }),
                // ...commonField(
                //     textController: stateController,
                //     title: "State*",
                //     hintText: "Enter your state",
                //     keyboardType: TextInputType.
                //     streetAddress,
                //     validator: (value) {
                //       if (value!.trim().isEmpty) {
                //         return "Please enter state*";
                //       }
                //       return null;
                //     }),
                // ...commonField(
                //     textController: countryController,
                //     title: "Country*",
                //     hintText: "Enter your country",
                //     keyboardType: TextInputType.streetAddress,
                //     validator: (value) {
                //       if (value!.trim().isEmpty) {
                //         return "Please enter country*";
                //       }
                //       return null;
                //     }),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    if (formKeyAddress.currentState!.validate()) {
                      cartController.updateAddressApi(
                          context: context,
                          firstName: firstNameController.text.trim(),
                          title: titleController.text.trim(),
                          lastName: lastNameController.text.trim(),
                          countryName: cartController.countryName.toString(),
                          state: cartController.stateName.toString(),
                          country: cartController.countryCode.toString(),
                          city: cartController.cityName.toString(),
                          address2: address2Controller.text.trim(),
                          address: addressController.text.trim(),
                          alternatePhone: alternatePhoneController.text.trim(),
                          landmark: landmarkController.text.trim(),
                          phone: phoneController.text.trim(),
                          zipCode: zipCodeController.text.trim(),
                          email: emailController.text.trim(),
                          cityId: cartController.cityCode.toString(),
                          stateId: cartController.stateCode.toString(),
                          phoneCountryCode: profileController.code.toString(),
                          id: addressData.id);
                    }
                    cartController.getCart();
                  },
                  child: Container(
                    decoration: const BoxDecoration(color: Color(0xff014E70)),
                    height: 56,
                    alignment: Alignment.bottomCenter,
                    child: Align(
                        alignment: Alignment.center,
                        child: Text("Save",
                            style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 19, color: Colors.white))),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
