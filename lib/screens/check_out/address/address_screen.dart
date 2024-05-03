import 'dart:convert';
import 'dart:developer';

import 'package:dirise/model/common_modal.dart';
import 'package:dirise/utils/helper.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controller/cart_controller.dart';
import '../../../controller/profile_controller.dart';
import '../../../model/customer_profile/model_city_list.dart';
import '../../../model/customer_profile/model_country_list.dart';
import '../../../model/customer_profile/model_state_list.dart';
import '../../../model/login_model.dart';
import '../../../model/model_address_list.dart';
import '../../../repository/repository.dart';
import '../../../utils/api_constant.dart';
import '../../../widgets/common_colour.dart';
import '../../../widgets/common_textfield.dart';
import '../../../widgets/loading_animation.dart';
import '../../auth_screens/login_screen.dart';
import '../../my_account_screens/editprofile_screen.dart';
import 'edit_address.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final cartController = Get.put(CartController());
  final profileController = Get.put(ProfileController());

  bool get userLoggedIn => profileController.userLoggedIn;
  ModelCountryList? modelCountryList;
  Country? selectedCountry;

  ModelStateList? modelStateList;
  CountryState? selectedState;

  ModelCityList? modelCityList;
  City? selectedCity;
  RxInt stateRefresh = 2.obs;
  final Repositories repositories = Repositories();
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
      setState(() {});
      stateRefresh.value = DateTime.now().millisecondsSinceEpoch;
    }).catchError((e) {
      stateRefresh.value = DateTime.now().millisecondsSinceEpoch;
    });
  }

  defaultAddressApi() async {
    Map<String, dynamic> map = {};
    map['address_id'] = cartController.selectedAddress.id.toString();
    repositories.postApi(url: ApiUrls.defaultAddressStatus, context: context, mapData: map).then((value) async {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      if (response.status == true) {
        showToast(response.message.toString());
        Get.back();
      } else {
        showToast(response.message.toString());
      }
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
      setState(() {});
      cityRefresh.value = DateTime.now().millisecondsSinceEpoch;
    }).catchError((e) {
      cityRefresh.value = DateTime.now().millisecondsSinceEpoch;
    });
  }

  getCountryList() {
    if (modelCountryList != null) return;
    repositories.getApi(url: ApiUrls.allCountriesUrl).then((value) {
      modelCountryList = ModelCountryList.fromString(value);
    });
  }

  String countryIddd = '';
  @override
  void initState() {
    super.initState();
    getCountryList();
    cartController.myDefaultAddressData();
    getStateList(countryId: countryIddd.toString());
    getCityList(stateId: stateIddd.toString());
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          // key: addressKey,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Obx(() {
            if (cartController.refreshInt.value > 0) {}
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Material(
                  child: InkWell(
                      onTap: () {
                        if (userLoggedIn) {
                          if (cartController.selectedAddress.id == null) {
                            bottomSheetChangeAddress();
                          } else {
                            showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: Text('Change Address'.tr),
                                      content: Text('Do You Want To Changed Your Address.'.tr),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () => Get.back(),
                                          child: Text('Cancel'.tr),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            Get.back();
                                            bottomSheetChangeAddress();
                                          },
                                          child: Text('OK'.tr),
                                        ),
                                      ],
                                    ));
                          }
                        } else {
                          addAddressWithoutLogin(addressData: cartController.selectedAddress);
                        }
                      },
                      child: DottedBorder(
                        color: const Color(0xff014E70),
                        strokeWidth: 1.2,
                        dashPattern: const [6, 3, 0, 3],
                        child:  profileController.userLoggedIn ? Container(
                          // height: 50,
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                          width: context.getSize.width,
                          alignment: Alignment.center,
                          child: cartController.selectedAddress.id != null
                              ? Text(cartController.selectedAddress.getShortAddress,
                                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16))
                              : cartController.myDefaultAddressModel.value.defaultAddress?.isDefault == true
                                  ? Text(cartController.myDefaultAddressModel.value.defaultAddress!.getShortAddress,
                                      style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16))
                                  : Text("Choose Address".tr,
                                      style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16)),
                        ) :
                        Container(
                          // height: 50,
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                          width: context.getSize.width,
                          alignment: Alignment.center,
                          child: cartController.selectedAddress.id != null
                              ? Text(cartController.selectedAddress.getShortAddress,
                              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16))
                              : Text("Choose Address".tr,
                              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16)),
                        ),
                      )),
                ),
                const SizedBox(
                  height: 5,
                ),
                if (cartController.selectedAddress.id != null)
                  InkWell(
                      onTap: () {
                        if (userLoggedIn) {
                          bottomSheetChangeAddress();
                        } else {
                          // addAddressWithoutLogin(addressData: cartController.selectedAddress);
                          Get.toNamed(
                            LoginScreen.route,
                          );
                        }
                      },
                      child: Align(
                          alignment: Alignment.topRight,
                          child: Text("Change Address",
                              style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)))),
                const SizedBox(
                  height: 10,
                ),
              ],
            );
          }),
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

  Future addAddressWithoutLogin({required AddressData addressData}) {
    Size size = MediaQuery.of(context).size;
    final TextEditingController firstNameController = TextEditingController(text: addressData.firstName ?? "");
    final TextEditingController emailController = TextEditingController(text: addressData.email ?? "");
    final TextEditingController lastNameController = TextEditingController(text: addressData.lastName ?? "");
    final TextEditingController phoneController = TextEditingController(text: addressData.phone ?? "");
    final TextEditingController alternatePhoneController =
        TextEditingController(text: addressData.alternatePhone ?? "");
    final TextEditingController addressController = TextEditingController(text: addressData.address ?? "");
    final TextEditingController address2Controller = TextEditingController(text: addressData.address2 ?? "");
    final TextEditingController cityController = TextEditingController(text: addressData.city ?? "");
    final TextEditingController countryController = TextEditingController(text: addressData.country ?? "");
    final TextEditingController stateController = TextEditingController(text: addressData.state ?? "");
    final TextEditingController zipCodeController = TextEditingController(text: addressData.zipCode ?? "");
    final TextEditingController landmarkController = TextEditingController(text: addressData.landmark ?? "");
    final TextEditingController titleController = TextEditingController(text: addressData.type ?? "");

    final formKey = GlobalKey<FormState>();

    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: size.width,
              height: size.height * .8,
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
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
                          textController: emailController,
                          title: "Email Address*",
                          hintText: "Email Address",
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter email address";
                            }
                            if (value.trim().invalidEmail) {
                              return "Please enter valid email address";
                            }
                            return null;
                          }),
                      ...commonField(
                          textController: firstNameController,
                          title: "First Name*",
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
                          title: "Last Name*",
                          hintText: "Last Name",
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter Last name";
                            }
                            return null;
                          }),
                      ...commonField(
                          textController: phoneController,
                          title: "Phone*",
                          hintText: "Enter your phone number",
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter phone number";
                            }
                            if (value.trim().length > 15) {
                              return "Please enter valid phone number";
                            }
                            if (value.trim().length < 8) {
                              return "Please enter valid phone number";
                            }
                            return null;
                          }),
                      ...commonField(
                          textController: alternatePhoneController,
                          title: "Alternate Phone*",
                          hintText: "Enter your alternate phone number",
                          keyboardType: TextInputType.number,
                          validator: (value) {
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
                                selectedCountry =
                                    modelCountryList!.country!.firstWhere((element) => element.id.toString() == gg);
                                cartController.countryCode = gg.toString();
                                cartController.countryName.value = selectedCountry!.name.toString();
                                print('countrrtr ${cartController.countryName.toString()}');
                                print('countrrtr ${cartController.countryCode.toString()}');
                                if (previous != selectedCountry!.id.toString()) {
                                  countryIddd = gg.toString();
                                  getStateList(countryId: countryIddd.toString(), reset: true).then((value) {
                                    setState(() {});
                                  });
                                  setState(() {});
                                }
                              },
                              selectedAddressId: ((selectedCountry ?? Country()).id ?? "").toString());
                        },
                        controller:
                            TextEditingController(text: (selectedCountry ?? Country()).name ?? countryController.text),
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
                        controller: TextEditingController(
                            text: (selectedState ?? CountryState()).stateName ?? stateController.text),
                        readOnly: true,
                        onTap: () {
                          if (countryIddd == 'null') {
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
                              addressList: profileController.selectedLAnguage.value == 'English'
                                  ? modelStateList!.state!
                                      .map((e) => CommonAddressRelatedClass(
                                          title: e.stateName.toString(), addressId: e.stateId.toString()))
                                      .toList()
                                  : modelStateList!.state!
                                      .map((e) => CommonAddressRelatedClass(
                                          title: e.arabStateName.toString(), addressId: e.stateId.toString()))
                                      .toList(),
                              selectedAddressIdPicked: (String gg) {
                                String previous = ((selectedState ?? CountryState()).stateId ?? "").toString();
                                selectedState =
                                    modelStateList!.state!.firstWhere((element) => element.stateId.toString() == gg);
                                cartController.stateCode = gg.toString();
                                cartController.stateName.value = selectedState!.stateName.toString();
                                print('state ${cartController.stateCode.toString()}');
                                print('stateNameee ${cartController.stateName.toString()}');
                                if (previous != selectedState!.stateId.toString()) {
                                  stateIddd = gg.toString();
                                  getCityList(stateId: stateIddd.toString(), reset: true).then((value) {
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
                      // if (modelCityList != null && modelCityList!.city!.isNotEmpty)
                      ...fieldWithName(
                        readOnly: true,
                        title: 'City',
                        hintText: 'Select City',
                        controller:
                            TextEditingController(text: (selectedCity ?? City()).cityName ?? cityController.text),
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
                              addressList: profileController.selectedLAnguage.value == 'English'
                                  ? modelCityList!.city!
                                      .map((e) => CommonAddressRelatedClass(
                                          title: e.cityName.toString(), addressId: e.cityId.toString()))
                                      .toList()
                                  : modelCityList!.city!
                                      .map((e) => CommonAddressRelatedClass(
                                          title: e.arabCityName.toString(), addressId: e.cityId.toString()))
                                      .toList(),
                              selectedAddressIdPicked: (String gg) {
                                selectedCity =
                                    modelCityList!.city!.firstWhere((element) => element.cityId.toString() == gg);
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
                      if (cartController.countryName.value != 'Kuwait')
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
                      if (cartController.countryName.value != 'Kuwait')
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
                      const SizedBox(
                        height: 16,
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            cartController.selectedAddress = AddressData(
                              id: "",
                              type: titleController.text.trim(),
                              firstName: firstNameController.text.trim(),
                              lastName: lastNameController.text.trim(),
                              state: stateController.text.trim(),
                              country: countryController.text.trim(),
                              city: cityController.text.trim(),
                              address2: address2Controller.text.trim(),
                              address: addressController.text.trim(),
                              alternatePhone: alternatePhoneController.text.trim(),
                              landmark: landmarkController.text.trim(),
                              phone: phoneController.text.trim(),
                              zipCode: zipCodeController.text.trim(),
                              email: emailController.text.trim(),
                            );
                            setState(() {});
                            Get.back();
                          }
                        },
                        child: Container(
                          decoration: const BoxDecoration(color: Color(0xff014E70)),
                          height: 56,
                          alignment: Alignment.bottomCenter,
                          child: Align(
                              alignment: Alignment.center,
                              child: Text("Save",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500, fontSize: 19, color: Colors.white))),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Future bottomSheetChangeAddress() {
    Size size = MediaQuery.of(context).size;
    cartController.getAddress();
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(20).copyWith(top: 10),
            child: SizedBox(
              width: size.width,
              height: size.height * .88,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 6,
                        decoration:
                            BoxDecoration(color: Colors.grey.shade400, borderRadius: BorderRadius.circular(100)),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CommonTextField(
                    onTap: () {
                      // bottomSheet();
                    },
                    obSecure: false,
                    hintText: '+ Add Address',
                  ),
                  Expanded(
                    child: Obx(() {
                      if (cartController.refreshInt11.value > 0) {}
                      List<AddressData> shippingAddress = cartController.addressListModel.address!.shipping ?? [];

                      return CustomScrollView(
                        shrinkWrap: true,
                        slivers: [
                          SliverToBoxAdapter(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Shipping Address",
                                    style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16),
                                  ),
                                ),
                                TextButton.icon(
                                    onPressed: () {
                                      bottomSheet(addressData: AddressData());
                                    },
                                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                                    icon: const Icon(
                                      Icons.add,
                                      size: 20,
                                    ),
                                    label: Text(
                                      "Add New",
                                      style: GoogleFonts.poppins(fontSize: 15),
                                    ))
                              ],
                            ),
                          ),
                          const SliverPadding(padding: EdgeInsets.only(top: 4)),
                          shippingAddress.isNotEmpty
                              ? SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                  childCount: shippingAddress.length,
                                  (context, index) {
                                    final address = shippingAddress[index];
                                    return GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () {
                                        cartController.selectedAddress = address;
                                        cartController.countryId = address.getCountryId.toString();
                                        cartController.getCart();
                                        cartController.countryName.value = address.country.toString();
                                        print('onTap is....${cartController.countryName.value}');
                                        if (cartController.isDelivery.value == true) {
                                          cartController.addressDeliFirstName.text =
                                              cartController.selectedAddress.getFirstName;
                                          cartController.addressDeliLastName.text =
                                              cartController.selectedAddress.getLastName;
                                          cartController.addressDeliEmail.text =
                                              cartController.selectedAddress.getEmail;
                                          cartController.addressDeliPhone.text =
                                              cartController.selectedAddress.getPhone;
                                          cartController.addressDeliAlternate.text =
                                              cartController.selectedAddress.getAlternate;
                                          cartController.addressDeliAddress.text =
                                              cartController.selectedAddress.getAddress;
                                          cartController.addressDeliZipCode.text =
                                              cartController.selectedAddress.getZipCode;
                                          cartController.addressCountryController.text =
                                              cartController.selectedAddress.getCountry;
                                          cartController.addressStateController.text =
                                              cartController.selectedAddress.getState;
                                          cartController.addressCityController.text =
                                              cartController.selectedAddress.getCity;
                                        }


                                        print('codeee isss${cartController.countryName.toString()}');
                                        print('codeee isss${cartController.countryId.toString()}');
                                        Get.back();
                                        setState(() {});
                                      },
                                      child: Container(
                                        width: size.width,
                                        margin: const EdgeInsets.only(bottom: 15),
                                        padding: const EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(color: const Color(0xffDCDCDC))),
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
                                                  style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 15,
                                                      color: const Color(0xff585858)),
                                                ),
                                              ),
                                              Column(
                                                children: [
                                                  PopupMenuButton(
                                                      color: Colors.white,
                                                      iconSize: 20,
                                                      icon: const Icon(
                                                        Icons.more_vert,
                                                        color: Colors.black,
                                                      ),
                                                      padding: EdgeInsets.zero,
                                                      onSelected: (value) {
                                                        setState(() {});
                                                        Navigator.pushNamed(context, value.toString());
                                                      },
                                                      itemBuilder: (ac) {
                                                        return [
                                                          PopupMenuItem(
                                                            onTap: () {
                                                              bottomSheet(addressData: address);
                                                            },
                                                            // value: '/Edit',
                                                            child: Text("Edit".tr),
                                                          ),
                                                          PopupMenuItem(
                                                            onTap: () {
                                                              cartController.selectedAddress = address;
                                                              cartController.countryName.value =
                                                                  address.country.toString();
                                                              cartController.countryId = address.getCountryId.toString();
                                                              cartController.getCart();
                                                              print('onTap is....${cartController.countryName.value}');
                                                              print(
                                                                  'onTap is....${cartController.selectedAddress.id.toString()}');
                                                              if (cartController.isDelivery.value == true) {
                                                                cartController.addressDeliFirstName.text =
                                                                    cartController.selectedAddress.getFirstName;
                                                                cartController.addressDeliLastName.text =
                                                                    cartController.selectedAddress.getLastName;
                                                                cartController.addressDeliEmail.text =
                                                                    cartController.selectedAddress.getEmail;
                                                                cartController.addressDeliPhone.text =
                                                                    cartController.selectedAddress.getPhone;
                                                                cartController.addressDeliAlternate.text =
                                                                    cartController.selectedAddress.getAlternate;
                                                                cartController.addressDeliAddress.text =
                                                                    cartController.selectedAddress.getAddress;
                                                                cartController.addressDeliZipCode.text =
                                                                    cartController.selectedAddress.getZipCode;
                                                                cartController.addressCountryController.text =
                                                                    cartController.selectedAddress.getCountry;
                                                                cartController.addressStateController.text =
                                                                    cartController.selectedAddress.getState;
                                                                cartController.addressCityController.text =
                                                                    cartController.selectedAddress.getCity;
                                                              }

                                                              defaultAddressApi();
                                                              setState(() {});
                                                            },
                                                            // value: '/slotViewScreen',
                                                            child: Text("Default Address".tr),
                                                          ),
                                                          PopupMenuItem(
                                                            onTap: () {
                                                              cartController
                                                                  .deleteAddress(
                                                                context: context,
                                                                id: address.id.toString(),
                                                              )
                                                                  .then((value) {
                                                                if (value == true) {
                                                                  cartController.addressListModel.address!.shipping!
                                                                      .removeWhere((element) =>
                                                                          element.id.toString() ==
                                                                          address.id.toString());
                                                                  cartController.updateUI();
                                                                }
                                                              });
                                                            },
                                                            // value: '/deactivate',
                                                            child: Text("Delete".tr),
                                                          )
                                                        ];
                                                      }),
                                                  address.isDefault == true
                                                      ? Text(
                                                          "Default",
                                                          style: GoogleFonts.poppins(
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 15,
                                                              color: const Color(0xff585858)),
                                                        )
                                                      : SizedBox(),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ))
                              : SliverToBoxAdapter(
                                  child: Text(
                                    "No Shipping Address Added!",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16),
                                  ),
                                ),
                          SliverToBoxAdapter(
                            child: SizedBox(
                              height: MediaQuery.of(context).viewInsets.bottom,
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),
          );
        });
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
      style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16, color: const Color(0xff585858)),
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
