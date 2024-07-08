import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dirise/model/common_modal.dart';
import 'package:dirise/model/customer_profile/model_country_list.dart';
import 'package:dirise/screens/my_account_screens/profile_screen.dart';
import 'package:dirise/utils/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../controller/profile_controller.dart';
import '../../language/app_strings.dart';
import '../../model/customer_profile/model_city_list.dart';
import '../../model/customer_profile/model_state_list.dart';
import '../../repository/repository.dart';
import '../../utils/api_constant.dart';
import '../../widgets/common_colour.dart';
import '../../widgets/common_textfield.dart';

class EditProfileScreen extends StatefulWidget {
  static String route = "/EditProfileScreen";
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final profileController = Get.put(ProfileController());
  final Repositories repositories = Repositories();
  File image = File("");
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController referralEmailController = TextEditingController();

  updateProfile() {
    if (_formKey.currentState!.validate()) {
      Map map = <String, String>{};
      map['first_name'] = firstNameController.text.trim();
      map['last_name'] = lastNameController.text.trim();
      map['name'] = "${firstNameController.text.trim()} ${lastNameController.text.trim()}".trim();
      map['phone'] = phoneController.text.trim();
      map['referral_email'] = referralEmailController.text.trim();
      map['country_id'] = profileController.selectedCountry!.id.toString();
      map['state_id'] = profileController.selectedState!.stateId.toString();
      map['phone_country_code'] = profileController.code.toString();
      if( profileController.selectedCity!= null) {
        map['city_id'] = profileController.selectedCity!.cityId.toString();
      }else{
        map['city_id'] = '';
      }
      map['street_name'] = addressController.text.trim();
      // log('dsgsfhdfgh${profileController.selectedCity!.cityId.toString()}');
      Map<String, File> gg = {};
      if (image.path.isNotEmpty) {
        gg["profile_image"] = image;
      }
      repositories
          .multiPartApi(mapData: map, images: gg, url: ApiUrls.updateProfile, context: context, onProgress: (gg, kk) {})
          .then((value) {
        ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
        showToast(response.message.toString());
        if (response.status == true) {
          profileController.getDataProfile();
          // log('dsgsfhdfgh${profileController.selectedCity!.cityId.toString()}');
          // Get.offNamed(ProfileScreen.route);
          Get.back();
        }else{
          Get.back();
        }
      });
    }
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

  void showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text(
          'Select Picture from',
          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () {
              Helpers.addImagePicker(imageSource: ImageSource.camera, imageQuality: 75).then((value) async {
                CroppedFile? croppedFile = await ImageCropper().cropImage(
                  sourcePath: value.path,
                  // aspectRatioPresets: [
                  //   // CropAspectRatioPreset.square,
                  //   // CropAspectRatioPreset.ratio3x2,
                  //   // CropAspectRatioPreset.original,
                  //   CropAspectRatioPreset.ratio4x3,
                  //   // CropAspectRatioPreset.ratio16x9
                  // ],
                  uiSettings: [
                    AndroidUiSettings(
                        toolbarTitle: 'Cropper',
                        toolbarColor: Colors.deepOrange,
                        toolbarWidgetColor: Colors.white,
                        initAspectRatio: CropAspectRatioPreset.ratio4x3,
                        lockAspectRatio: true),
                    IOSUiSettings(
                      title: 'Cropper',
                    ),
                    WebUiSettings(
                      context: context,
                    ),
                  ],
                );
                if (croppedFile != null) {
                  image = File(croppedFile.path);
                  setState(() {});
                }

                Get.back();
              });
            },
            child: const Text("Camera"),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Helpers.addImagePicker(imageSource: ImageSource.gallery, imageQuality: 75).then((value) async {
                CroppedFile? croppedFile = await ImageCropper().cropImage(
                  sourcePath: value.path,
                  // aspectRatioPresets: [
                  //   // CropAspectRatioPreset.square,
                  //   // CropAspectRatioPreset.ratio3x2,
                  //   // CropAspectRatioPreset.original,
                  //   CropAspectRatioPreset.ratio4x3,
                  //   // CropAspectRatioPreset.ratio16x9
                  // ],

                  uiSettings: [
                    AndroidUiSettings(
                        toolbarTitle: 'Cropper',
                        toolbarColor: Colors.deepOrange,
                        toolbarWidgetColor: Colors.white,
                        initAspectRatio: CropAspectRatioPreset.ratio4x3,
                        lockAspectRatio: true),
                    IOSUiSettings(
                      title: 'Cropper',
                    ),
                    WebUiSettings(
                      context: context,
                    ),
                  ],
                );
                if (croppedFile != null) {
                  image = File(croppedFile.path);
                  setState(() {});
                }

                Get.back();
              });
            },
            child: const Text('Gallery'),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Get.back();
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
    firstNameController.text = profileController.model.user!.firstName.toString();
    lastNameController.text = profileController.model.user!.lastName.toString();
    emailController.text = profileController.model.user!.email.toString();
    referralEmailController.text = profileController.model.user!.referralEmail ?? '';
    phoneController.text = profileController.model.user!.phone.toString();
    addressController.text = profileController.model.user!.street_name.toString();
    profileController.code = profileController.model.user!.phoneCountryCode.toString();
    if(profileController.model.user!.country_id != null){
      profileController.selectedCountry = Country(
        name: profileController.model.user!.country_name.toString(),
        id: profileController.model.user!.country_id.toString(),
      );
      profileController.getStateList(countryId: profileController.model.user!.country_id.toString()).then((value) {
        setState(() {});
      });
    }

    if(profileController.model.user!.state_id != null){
      profileController.selectedState = CountryState(
        stateName: profileController.model.user!.state_name.toString(),
        stateId: profileController.model.user!.state_id.toString(),
      );
      profileController.getCityList(stateId: profileController.model.user!.state_id.toString()).then((value) {
        setState(() {});
      });
    }

    if(profileController.model.user!.city != null){
      profileController.selectedCity = City(
        cityId: profileController.model.user!.city.toString(),
        cityName: profileController.model.user!.city_name.toString(),
      );
    }
    setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.editProfile.tr,
          style: GoogleFonts.poppins(color: Colors.black, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: AppTheme.newPrimaryColor,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: GestureDetector(
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
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      // NewHelper.showImagePickerSheet(
                      //     gotImage: (File gg) {
                      //       image = gg;
                      //       setState(() {});
                      //     },
                      //     context: context);
                      showActionSheet(context);
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, border: Border.all(color: profileCircleColor, width: 1.2)),
                          height: 140,
                          width: 140,
                        ).animate().scale(
                            duration: const Duration(seconds: 1),
                            begin: const Offset(0.6, 0.6),
                            end: const Offset(1, 1)),
                        // if(false)
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, border: Border.all(color: profileCircleColor, width: 1.2)),
                          height: 125,
                          width: 125,
                        ).animate(delay: const Duration(milliseconds: 1000)).fade(delay: 200.ms).then().scale(
                            duration: const Duration(milliseconds: 600),
                            begin: const Offset(1.12, 1.12),
                            end: const Offset(1, 1)),
                        // if(false)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10000),
                          child: SizedBox(
                            height: 110,
                            width: 110,
                            child: image.path != ""
                                ? ClipOval(
                                    child: Image.file(
                                      image,
                                      width: 120,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(100)),
                                      color: AppTheme.primaryColor,
                                    ),
                                    child: ClipOval(
                                      child: CachedNetworkImage(
                                        width: 120,
                                        height: 120,
                                        fit: BoxFit.cover,
                                        imageUrl: profileController.model.user!.profileImage.toString(),
                                        placeholder: (context, url) => const SizedBox(),
                                        errorWidget: (context, url, error) => const SizedBox(),
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(
                          width: 140,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SvgPicture.asset("assets/svgs/profile_edit.svg"),
                              const SizedBox(
                                width: 4,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              ...fieldWithName(
                title: AppStrings.firstName.tr,
                hintText: AppStrings.enterFirstName.tr,
                controller: firstNameController,
                validator: (v) {
                  if (v!.trim().isEmpty) {
                    return "Please enter your first name".tr;
                  }
                  return null;
                },
                keyboardType: TextInputType.name,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                ],
              ),
              ...fieldWithName(
                title: AppStrings.lastName.tr,
                hintText: AppStrings.lastName.tr,
                controller: lastNameController,
                keyboardType: TextInputType.name,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                ],
                validator: (v) {
                  if (v!.trim().isEmpty) {
                    return AppStrings.pleaseenteryourlastname.tr;
                  }
                  return null;
                },
              ),
              ...fieldWithName(
                title: AppStrings.email.tr,
                hintText: AppStrings.enterEmail.tr,
                readOnly: true,
                controller: emailController,
                validator: (v) {
                  if (v!.trim().isEmpty) {
                    return "Please enter your email address".tr;
                  }
                  if (v.trim().invalidEmail) {
                    return "Please enter valid email address".tr;
                  }
                  return null;
                },
              ),
              ...fieldWithName(
                title: AppStrings.referralEmail.tr,
                hintText: AppStrings.referralEmail.tr,
                readOnly: true,
                controller: referralEmailController,
                // validator: (v) {
                //   if (v!.trim().isEmpty) {
                //     return "Please enter your referral email";
                //   }
                //   if (v.trim().invalidEmail) {
                //     return "Please enter valid referral email";
                //   }
                //   return null;
                // },
              ),
              Text(
                AppStrings.phoneNumberr.tr,
                style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              5.spaceY,
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
                decoration:  InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    hintStyle: const TextStyle(color: AppTheme.textColor),
                    hintText: 'Phone Number'.tr,
                    labelStyle: const TextStyle(color: AppTheme.textColor),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                    enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppTheme.shadowColor)),
                    focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppTheme.shadowColor))),
                initialCountryCode: profileController.code.toString(),
                languageCode: '+91',
                onCountryChanged: (phone) {
                  profileController.code = phone.code;
                  print(phone.code);
                  print(profileController.code.toString());
                },
                validator: (value) {
                  if (value == null || phoneController.text.isEmpty) {
                    return AppStrings.pleaseenterphonenumber.tr;
                  }
                  return null;
                },
                onChanged: (phone) {
                  profileController.code = phone.countryISOCode.toString();
                  print(phone.countryCode);
                  print(profileController.code.toString());
                },
              ),
              // ...fieldWithName(
              //   title: AppStrings.phoneNumberr.tr,
              //   hintText: AppStrings.enterPhoneNumber,
              //   controller: phoneController,
              //   keyboardType: TextInputType.phone
              //   // validator: (v) {
              //   //   if (v!.trim().isEmpty) {
              //   //     return AppStrings.pleaseenterphonenumber;
              //   //   }
              //   //   if (v.trim().length < 10) {
              //   //     return AppStrings.pleaseentervalidphonenumber;
              //   //   }
              //   //   return null;
              //   // },
              // ),
               4.spaceY,
              ...fieldWithName(
                title: AppStrings.country.tr,
                hintText: AppStrings.selectCountry,
                readOnly: true,
                onTap: () {
                  showAddressSelectorDialog(
                      addressList: profileController.modelCountryList!.country!
                          .map((e) => CommonAddressRelatedClass(
                              title: e.name.toString(), addressId: e.id.toString(), flagUrl: e.icon.toString()))
                          .toList(),
                      selectedAddressIdPicked: (String gg) {
                        String previous = ((profileController.selectedCountry ?? Country()).id ?? "").toString();
                        profileController.selectedCountry = profileController.modelCountryList!.country!
                            .firstWhere((element) => element.id.toString() == gg);
                        if (previous != profileController.selectedCountry!.id.toString()) {
                          profileController.getStateList(countryId: gg, reset: true).then((value) {
                            setState(() {});
                          });
                          setState(() {});
                        }
                      },
                      selectedAddressId: ((profileController.selectedCountry ?? Country()).id ?? "").toString());
                },
                controller: TextEditingController(text: (profileController.selectedCountry ?? Country()).name ?? ""),
                validator: (v) {
                  if (v!.trim().isEmpty) {
                    return "Please select country".tr;
                  }
                  return null;
                },
              ),
              ...fieldWithName(
                title: AppStrings.state.tr,
                hintText: AppStrings.selectState.tr,
                controller:
                    TextEditingController(text: (profileController.selectedState ?? CountryState()).stateName ?? ""),
                readOnly: true,
                onTap: () {
                  if (profileController.modelStateList == null && profileController.stateRefresh.value > 0) {
                    showToast(AppStrings.selectCountryFirst);
                    return;
                  }
                  if(profileController.stateRefresh.value < 0){
                    return;
                  }
                  if(profileController.modelStateList!.state!.isEmpty)return;
                  showAddressSelectorDialog(
                      addressList: profileController.modelStateList!.state!
                          .map((e) =>
                              CommonAddressRelatedClass(title: e.stateName.toString(), addressId: e.stateId.toString()))
                          .toList(),
                      selectedAddressIdPicked: (String gg) {
                        String previous =
                            ((profileController.selectedState ?? CountryState()).stateId ?? "").toString();
                        profileController.selectedState = profileController.modelStateList!.state!
                            .firstWhere((element) => element.stateId.toString() == gg);
                        if (previous != profileController.selectedState!.stateId.toString()) {
                          profileController.getCityList(stateId: gg, reset: true).then((value) {
                            setState(() {});
                          });
                          setState(() {});
                        }
                      },
                      selectedAddressId:
                          ((profileController.selectedState ?? CountryState()).stateId ?? "").toString());
                },
                suffixIcon: Obx(() {
                  if (profileController.stateRefresh.value > 0) {
                    return const Icon(Icons.keyboard_arrow_down_rounded);
                  }
                  return const CupertinoActivityIndicator();
                }),
                validator: (v) {
                  if (v!.trim().isEmpty) {
                    return AppStrings.pleaseselectstate.tr;
                  }
                  return null;
                },
              ),
              if(profileController.modelCityList != null && profileController.modelCityList!.city!.isNotEmpty)
              ...fieldWithName(
                title: AppStrings.city.tr,
                hintText: AppStrings.selectCity.tr,
                controller: TextEditingController(text: (profileController.selectedCity ?? City()).cityName ?? ""),
                onTap: () {
                  if (profileController.modelCityList == null && profileController.cityRefresh.value > 0) {
                    showToast(AppStrings.selectCity.tr);
                    return;
                  }
                  if(profileController.cityRefresh.value < 0){
                    return;
                  }
                  if(profileController.modelCityList!.city!.isEmpty)return;
                  showAddressSelectorDialog(
                      addressList: profileController.modelCityList!.city!
                          .map((e) =>
                          CommonAddressRelatedClass(title: e.cityName.toString(), addressId: e.cityId.toString()))
                          .toList(),
                      selectedAddressIdPicked: (String gg) {
                        profileController.selectedCity = profileController.modelCityList!.city!
                            .firstWhere((element) => element.cityId.toString() == gg);
                        print(gg.toString());
                        setState(() {});
                      },
                      selectedAddressId:
                      ((profileController.selectedCity ?? City()).cityId ?? "").toString());
                },
                suffixIcon: Obx(() {
                  if (profileController.cityRefresh.value > 0) {
                    return const Icon(Icons.keyboard_arrow_down_rounded);
                  }
                  return const CupertinoActivityIndicator();
                }),
                validator: (v) {
                  if (v!.trim().isEmpty) {
                    return 'Please select city'.tr;
                  }
                  return null;
                },
              ),

              ...fieldWithName(
                title: AppStrings.streetAddress.tr,
                hintText: AppStrings.enterstreetAddress.tr,
                controller: addressController,
                // validator: (v) {
                //   if (v!.trim().isEmpty) {
                //     return AppStrings.pleaseenteraddress;
                //   }
                //   return null;
                // },
              ),
            ]),
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14).copyWith(bottom: 12),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.buttonColor,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                textStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                )),
            onPressed: () {
              if(_formKey.currentState!.validate()){
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title:  Text('Are you sure!'.tr),
                    content: Text('Do you want to edit your profile'.tr),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Get.back(),
                        child:  Text('Cancel'.tr),
                      ),
                      TextButton(
                        onPressed: ()  {
                          updateProfile();
                        },
                        child:  Text('OK'.tr),
                      ),
                    ],
                  ),
                );
              }
              else{
                updateProfile();
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                AppStrings.save.tr,
                style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

List<Widget> fieldWithName(
    {required String title,
      required String hintText,
      required TextEditingController controller,
      FormFieldValidator<String>? validator,
      final TextInputType? keyboardType,
      bool? readOnly,
      final List<TextInputFormatter>? inputFormatters,
      VoidCallback? onTap,
      Widget? suffixIcon}) {
  return [
    Text(
      title.tr,
      style: GoogleFonts.poppins(fontSize: 15 , fontWeight: FontWeight.w500),
    ),
    const SizedBox(
      height: 5,
    ),
    CommonTextField(
      onTap: onTap,
      hintText: hintText,
      inputFormatters: inputFormatters,
      controller: controller,
      validator: validator,
      readOnly: readOnly ?? false,
      suffixIcon: suffixIcon,
      keyboardType: keyboardType,
    ),
    const SizedBox(
      height: 12,
    ),
  ];
}
