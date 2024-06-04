import 'dart:convert';

import 'package:dirise/addNewProduct/optionalScreen.dart';
import 'package:dirise/utils/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/vendor_controllers/add_product_controller.dart';
import '../iAmHereToSell/personalizeyourstoreScreen.dart';
import '../model/common_modal.dart';
import '../repository/repository.dart';
import '../utils/api_constant.dart';
import '../widgets/common_button.dart';
import '../widgets/common_colour.dart';
import '../widgets/common_textfield.dart';

class InternationalshippingdetailsScreen extends StatefulWidget {
  int? id;
  int? Unitofmeasure;
  String? WeightOftheItem;
  int? SelectNumberOfPackages;
  String? SelectTypeMaterial;
  String? SelectTypeOfPackaging;
  String? Length;
  String? Width;
  String? Height;
  InternationalshippingdetailsScreen(
      {super.key,
      this.id,
      this.WeightOftheItem,
      this.Unitofmeasure,
      this.SelectTypeOfPackaging,
      this.SelectTypeMaterial,
      this.SelectNumberOfPackages,
      this.Length,
      this.Height,
      this.Width});

  @override
  State<InternationalshippingdetailsScreen> createState() => _InternationalshippingdetailsScreenState();
}

class _InternationalshippingdetailsScreenState extends State<InternationalshippingdetailsScreen> {
  // Default selected item\
  TextEditingController weightController = TextEditingController();
  TextEditingController numberOfPackageController = TextEditingController();

  TextEditingController dimensionController = TextEditingController();
  TextEditingController dimensionWidthController = TextEditingController();
  TextEditingController dimensionHeightController = TextEditingController();
  String unitOfMeasure = 'cm/kg';
  List<String> unitOfMeasureList = [
    'cm/kg',
    'lb/inch',
  ];

  String selectNumberOfPackages = '1';
  List<String> selectNumberOfPackagesList = List.generate(30, (index) => (index + 1).toString());

  String selectTypeMaterial = 'plastic';
  List<String> selectTypeMaterialList = [
    'plastic',
    'glass',
    'iron',
  ];
  final formKey2 = GlobalKey<FormState>();
  String selectTypeOfPackaging = 'fedex 10kg box';
  List<String> selectTypeOfPackagingList = [
    'fedex 10kg box',
    'fedex 25kg box',
    'fedex box',
    'fedex Envelop',
    'fedex pak',
    'fedex Tube',
    'your packaging',
    'custom packaging',
  ];
  final addProductController = Get.put(AddProductController());
  RxBool hide = true.obs;
  RxBool hide1 = true.obs;
  bool showValidation = false;
  bool? _isValue = false;
  final Repositories repositories = Repositories();
  String code = "+91";
  shippingDetailsApi() {
    Map<String, dynamic> map = {};
    map['weight_unit'] = unitOfMeasure;
    map['weight'] = weightController.text.trim();
    map['number_of_package'] = numberOfPackageController.text.trim();
    map['material'] = selectTypeMaterial;
    map['box_dimension'] = dimensionController.text.trim();
    map['box_length'] = dimensionController.text.trim();
    map['box_width'] = dimensionWidthController.text.trim();
    map['box_height'] = dimensionHeightController.text.trim();
    map['type_of_packages'] = selectTypeOfPackaging;
    map['item_type'] = 'giveaway';
    map['id'] = addProductController.idProduct.value.toString();

    FocusManager.instance.primaryFocus!.unfocus();
    repositories.postApi(url: ApiUrls.giveawayProductAddress, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      if (response.status == true) {
        Get.to(OptionalScreen());
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.id != null){
      // unitOfMeasure = widget.Unitofmeasure.toString();
      weightController.text = widget.WeightOftheItem.toString();
      numberOfPackageController.text = widget.SelectNumberOfPackages.toString();
      // selectTypeMaterial = widget.SelectTypeMaterial.toString();
      dimensionController.text = widget.Length.toString();
      dimensionWidthController.text = widget.Width.toString();
      dimensionHeightController.text = widget.Height.toString();
      // selectTypeOfPackaging = widget.SelectTypeOfPackaging.toString();
    }
  }
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
              'Item Weight & Dimensions'.tr,
              style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          child: Form(
            key: formKey2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                ),
                Text(
                  'Int. Shipping details (Optional)'.tr,
                  style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w500, fontSize: 18),
                ),
                const SizedBox(height: 5),
                Text(
                  'This information will be used to calculate your shipment shipping price. You can skip it, however your shipment will be limited to local shipping.'
                      .tr,
                  style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w400, fontSize: 13),
                ),
                const SizedBox(height: 5),
                Text(
                  'Unit of measure'.tr,
                  style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w500, fontSize: 18),
                ),
                const SizedBox(height: 5),
                DropdownButtonFormField<String>(
                  value: unitOfMeasure,
                  onChanged: (String? newValue) {
                    setState(() {
                      unitOfMeasure = newValue!;
                    });
                  },
                  items: unitOfMeasureList.map<DropdownMenuItem<String>>((String value) {
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
                const SizedBox(height: 15),
                Text(
                  'Size & Weight'.tr,
                  style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w500, fontSize: 18),
                ),
                const SizedBox(height: 5),
                Text(
                  'Be as accurate as you can and always round up. Your shipping courier will always round up and charges you based on their weight.',
                  style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w400, fontSize: 13),
                ),
                const SizedBox(height: 10),
                Text(
                  'Weight of the item'.tr,
                  style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w500, fontSize: 18),
                ),
                const SizedBox(height: 5),
                CommonTextField(
                    controller: weightController,
                    obSecure: false,
                    hintText: 'Weight Of the Item ',
                    keyboardType: TextInputType.number,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Weight Of the Itemis required'.tr),
                    ])),
                Text(
                  'Select Number Of Packages '.tr,
                  style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w500, fontSize: 18),
                ),
                const SizedBox(height: 5),
                CommonTextField(
                    controller: numberOfPackageController,
                    keyboardType: TextInputType.number,
                    obSecure: false,
                    hintText: 'Number Of Package',
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Number Of Package is required'.tr),
                    ])),
                const SizedBox(height: 10),
                Text(
                  'Select Type Material   '.tr,
                  style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w500, fontSize: 18),
                ),
                const SizedBox(height: 5),
                DropdownButtonFormField<String>(
                  value: selectTypeMaterial,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectTypeMaterial = newValue!;
                    });
                  },
                  items: selectTypeMaterialList.map<DropdownMenuItem<String>>((String value) {
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
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Length'.tr,
                          style: GoogleFonts.poppins(
                              color: const Color(0xff292F45), fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CommonTextField(
                            controller: dimensionController,
                            obSecure: false,
                            keyboardType: TextInputType.number,
                            hintText: 'Length X ',
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'Product length is required'.tr),
                            ])),
                      ],
                    )),
                    10.spaceX,
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Width'.tr,
                          style: GoogleFonts.poppins(
                              color: const Color(0xff292F45), fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CommonTextField(
                            controller: dimensionWidthController,
                            obSecure: false,
                            hintText: 'Width X',
                            keyboardType: TextInputType.number,
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'Product Width is required'.tr),
                            ])),
                      ],
                    )),
                    10.spaceX,
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Height'.tr,
                          style: GoogleFonts.poppins(
                              color: const Color(0xff292F45), fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CommonTextField(
                            controller: dimensionHeightController,
                            obSecure: false,
                            hintText: 'Height X',
                            keyboardType: TextInputType.number,
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'Product Height is required'.tr),
                            ])),
                      ],
                    )),
                  ],
                ),
                Text(
                  'Package type '.tr,
                  style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w500, fontSize: 18),
                ),
                const SizedBox(height: 5),
                DropdownButtonFormField<String>(
                  value: selectTypeOfPackaging,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectTypeOfPackaging = newValue!;
                    });
                  },
                  items: selectTypeOfPackagingList.map<DropdownMenuItem<String>>((String value) {
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
                const SizedBox(height: 10),
                CustomOutlineButton(
                  title: 'Confirm',
                  borderRadius: 11,
                  onPressed: () {
                    if (formKey2.currentState!.validate()) {
                      shippingDetailsApi();
                    }
                  },
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Get.to( OptionalScreen());
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
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
