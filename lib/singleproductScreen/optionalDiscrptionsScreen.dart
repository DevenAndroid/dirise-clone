import 'dart:convert';
import 'dart:developer';

import 'package:dirise/addNewProduct/reviewPublishScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/common_modal.dart';
import '../model/model_address_list.dart';
import '../repository/repository.dart';
import '../utils/api_constant.dart';
import '../widgets/common_button.dart';
import '../widgets/common_colour.dart';
import '../widgets/common_textfield.dart';
import 'optionalClassificationScreen.dart';

class OptionalDiscrptionsScreen extends StatefulWidget {
  const OptionalDiscrptionsScreen({super.key});

  @override
  State<OptionalDiscrptionsScreen> createState() => _OptionalDiscrptionsScreenState();
}

class _OptionalDiscrptionsScreenState extends State<OptionalDiscrptionsScreen> {
  String selectedTex = 'Item 1'; // Default selected item

  List<String> texList = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  editAddressApi(Map<String, dynamic> addressData) {
    FocusManager.instance.primaryFocus!.unfocus();
    repositories.postApi(url: ApiUrls.giveawayProductAddress, context: context, mapData: addressData).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      if (response.status == true) {
        Get.to(const OptionalClassificationScreen());
      }
    });
  }
  String city = "";
  String state = "";
  String zip_code = "";
  String country = "";
  String street = "";
  String town = "";
  String selectedRadio = '';

  ModelUserAddressList addressListModel = ModelUserAddressList();
  Future getAddressDetails() async {
    await repositories.getApi(url: ApiUrls.addressListUrl).then((value) {
      addressListModel = ModelUserAddressList.fromJson(jsonDecode(value));
      log('address iss....${addressListModel.address!.toJson()}');
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    getAddressDetails();
  }
  final TextEditingController metaTitleController = TextEditingController();
  final TextEditingController metaDescriptionController = TextEditingController();
  final TextEditingController metaTagsController = TextEditingController();
  RxBool hide = true.obs;
  RxBool hide1 = true.obs;
  bool showValidation = false;
  final Repositories repositories = Repositories();
  final formKey1 = GlobalKey<FormState>();
  String code = "+91";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xff0D5877),
            size: 16,
          ),
        ),
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Optional Discrptions'.tr,
              style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          child: Form(
            key: formKey1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Meta Title'.tr,
                  style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 13),
                ),
                CommonTextField(
                    controller: metaTitleController,
                    obSecure: false,
                    hintText: 'Meta Title'.tr,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Meta Title is required'),
                    ])),
                TextFormField(
                  maxLines: 3,
                  minLines: 3,
                  controller: metaDescriptionController,
                  decoration: InputDecoration(
                    counterStyle: GoogleFonts.poppins(
                      color: AppTheme.primaryColor,
                      fontSize: 25,
                    ),
                    counter: const Offstage(),
                    errorMaxLines: 2,
                    contentPadding: const EdgeInsets.all(15),
                    fillColor: Colors.grey.shade100,
                    hintText: 'Meta Description',
                    hintStyle: GoogleFonts.poppins(
                      color: AppTheme.primaryColor,
                      fontSize: 15,
                    ),
                    border: InputBorder.none,
                    focusedErrorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: AppTheme.secondaryColor)),
                    errorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: AppTheme.secondaryColor)),
                    focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: AppTheme.secondaryColor)),
                    disabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: AppTheme.secondaryColor),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: AppTheme.secondaryColor),
                    ),
                  ),
                ),
                TextFormField(
                  maxLines: 2,
                  minLines: 2,
                  controller: metaTagsController,
                  decoration: InputDecoration(
                    counterStyle: GoogleFonts.poppins(
                      color: AppTheme.primaryColor,
                      fontSize: 25,
                    ),
                    counter: const Offstage(),
                    errorMaxLines: 2,
                    contentPadding: const EdgeInsets.all(15),
                    fillColor: Colors.grey.shade100,
                    hintText: 'Meta Tags',
                    hintStyle: GoogleFonts.poppins(
                      color: AppTheme.primaryColor,
                      fontSize: 15,
                    ),
                    border: InputBorder.none,
                    focusedErrorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: AppTheme.secondaryColor)),
                    errorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: AppTheme.secondaryColor)),
                    focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: AppTheme.secondaryColor)),
                    disabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: AppTheme.secondaryColor),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: AppTheme.secondaryColor),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Pick up Adress location '.tr,
                  style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  height: 50,
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      border: Border.all(
                        color: Colors.grey.shade300,
                      ),
                      borderRadius: BorderRadius.circular(11)),
                  child: const Text(
                    'Add Address',
                    style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w300),
                  ),
                ),
                const SizedBox(height: 20),
                addressListModel.address?.shipping != null
                    ? ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: addressListModel.address!.shipping!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var addressList = addressListModel.address!.shipping![index];
                    city = addressList.city.toString();
                    state = addressList.state.toString();
                    zip_code = addressList.zipCode.toString();
                    country = addressList.country.toString();
                    street = addressList.address.toString();
                    town = addressList.town.toString();

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                                  border: Border.all(color: const Color(0xffE4E2E2))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(15),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('City - $city'),
                                        Text('State - $state'),
                                        Text('Country - $country'),
                                        Text('Zip code - $zip_code'),
                                        Text('Street - $street'),
                                        Text('Town - $town'),
                                        const SizedBox(
                                          height: 8,
                                        ),
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
                        ),
                        Radio<String>(
                          value: 'address_$index',
                          groupValue: selectedRadio,
                          onChanged: (value) {
                            setState(() {
                              selectedRadio = value!;
                            });
                          },
                        ),
                      ],
                    );
                  },
                )
                    : const Center(child: SizedBox()),
                const SizedBox(height: 20),
                Text(
                  'Select Tax :'.tr,
                  style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),
                ),
                DropdownButtonFormField<String>(
                  value: selectedTex,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedTex = newValue ?? "";
                    });
                  },
                  items: texList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    fillColor: const Color(0xffE2E2E2).withOpacity(.35),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10).copyWith(right: 8),
                    focusedErrorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: AppTheme.secondaryColor)),
                    errorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Color(0xffE2E2E2))),
                    focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: AppTheme.secondaryColor)),
                    disabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: AppTheme.secondaryColor),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: AppTheme.secondaryColor),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select an item';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomOutlineButton(
                  title: 'Next',
                  borderRadius: 11,
                  onPressed: () {
                  if (selectedRadio.startsWith('address_')) {
                      int index = int.parse(selectedRadio.split('_')[1]);
                      var selectedAddress = addressListModel.address!.shipping![index];
                      city = selectedAddress.city.toString();
                      state = selectedAddress.state.toString();
                      zip_code = selectedAddress.zipCode.toString();
                      country = selectedAddress.country.toString();
                      street = selectedAddress.address.toString();
                      town = selectedAddress.town.toString();


                      Map<String, dynamic> addressData = {
                        'city': city,
                        'state': state,
                        'zip_code': zip_code,
                        'country': country,
                        'street': street,
                        'town': town,
                        'meta_title':metaTitleController.text.trim(),
                        'meta_description':metaDescriptionController.text.trim(),
                        'meta_tags': metaTagsController.text.trim(),
                        'tax_type': selectedTex,
                      };
                      if(selectedAddress.id != null) {
                        addressData['address_id'] = selectedAddress.id!;
                      }
                      editAddressApi(addressData);
                    }  else {
                      showToast('Please select Address Type');
                    }
                  },
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Get.to(ReviewPublishScreen());
                  },
                  child: Container(
                    width: Get.width,
                    height: 55,
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
                        'Skip',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Text color
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
