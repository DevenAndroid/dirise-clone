import 'dart:convert';
import 'dart:developer';

import 'package:dirise/Services/pick_up_address_service.dart';
import 'package:dirise/Services/service_international_shipping_details.dart';
import 'package:dirise/singleproductScreen/singleProductReturnPolicy.dart';
import 'package:dirise/utils/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/vendor_controllers/add_product_controller.dart';
import '../model/common_modal.dart';
import '../model/model_address_list.dart';
import '../repository/repository.dart';
import '../utils/api_constant.dart';
import '../widgets/common_button.dart';
import '../widgets/common_colour.dart';
import '../widgets/common_textfield.dart';

class Locationwherecustomerwilljoin extends StatefulWidget {
  const Locationwherecustomerwilljoin({super.key});

  @override
  State<Locationwherecustomerwilljoin> createState() => _LocationwherecustomerwilljoinState();
}

class _LocationwherecustomerwilljoinState extends State<Locationwherecustomerwilljoin> {
  String selectedItem = 'Item 1'; // Default selected item
  RxBool isServiceProvide = false.obs;
  String selectedRadio = '';
  int selectedAddressIndex = -1;
  List<String> itemList = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  RxBool hide = true.obs;
  RxBool hide1 = true.obs;
  bool showValidation = false;
  final Repositories repositories = Repositories();
  final formKey1 = GlobalKey<FormState>();
  String code = "+91";
  String city = "";
  String state = "";
  String zip_code = "";
  String country = "";

  final addProductController = Get.put(AddProductController());
  editAddressApi() {
    Map<String, dynamic> map = {};

    map['address_type'] = 'Both';
    map['city'] = city.toString();
    map['state'] = state.toString();
    map['zip_code'] = zip_code.toString();
    map['country'] = country.toString();
    map['item_type'] = 'service';
    map['id'] = addProductController.idProduct.value.toString();
    FocusManager.instance.primaryFocus!.unfocus();
    repositories.postApi(url: ApiUrls.giveawayProductAddress, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      if (response.status == true) {
        Get.to(const ServiceInternationalShippingService());
      }
    });
  }

  bool writeAddress = false;
  bool online = false;

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
    // TODO: implement initState
    super.initState();
    getAddressDetails();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
              'Location where customer will join'.tr,
              style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.spaceY,
                Text(
                  'Write address or choose*'.tr,
                  style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
                ),
                20.spaceY,
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedRadio = 'write';
                      selectedAddressIndex = -1;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppTheme.secondaryColor)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Write Address',
                          style: GoogleFonts.poppins(
                            color: AppTheme.primaryColor,
                            fontSize: 15,
                          ),
                        ),
                        Radio<String>(
                          value: 'write',
                          groupValue: selectedRadio,
                          onChanged: (value) {
                            setState(() {
                              selectedRadio = value.toString();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: TextButton(
                    onPressed: () {
                      Get.toNamed(PickUpAddressService.route);
                    },
                    child: Text(
                      'Choose my default shipping address',
                      style: GoogleFonts.poppins(
                        color: AppTheme.primaryColor,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),

                addressListModel.address?.shipping != null
                    ? ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: addressListModel.address!.shipping!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var addressList = addressListModel.address!.shipping![index];
                          city = addressList.city;
                          state = addressList.state;
                          zip_code = addressList.zipCode;
                          country = addressList.country.toString();
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
                                              Text('City - ${addressList.city.toString()}'),
                                              Text('state - ${addressList.state.toString()}'),
                                              Text('country - ${addressList.country.toString()}'),
                                              Text('zip code - ${addressList.zipCode.toString()}'),
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

                InkWell(
                  onTap: () {
                    setState(() {
                      selectedRadio = 'online';
                      selectedAddressIndex = -1;

                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppTheme.secondaryColor)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Not Needed - Online Product',
                          style: GoogleFonts.poppins(
                            color: AppTheme.primaryColor,
                            fontSize: 15,
                          ),
                        ),
                        Radio<String>(
                          value: 'online',
                          groupValue: selectedRadio,
                          onChanged: (value) {
                            setState(() {
                              selectedRadio = value.toString();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomOutlineButton(
                  title: 'Next',
                  borderRadius: 11,
                  onPressed: () {
                    if (selectedRadio == 'write') {
                      Get.to(PickUpAddressService());
                    } else if (selectedRadio.startsWith('address_')) {
                      int index = int.parse(selectedRadio.split('_')[1]);
                      editAddressApi();
                    } else if (selectedRadio == 'online') {
                      Get.to(const ServiceInternationalShippingService());
                    } else {
                      showToast('Please select Address Type');
                    }
                  },
                ),
              ]),
        ),
      ),
    );
  }
}
