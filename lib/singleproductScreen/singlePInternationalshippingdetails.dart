import 'dart:convert';

import 'package:dirise/utils/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/service_controller.dart';
import '../controller/vendor_controllers/add_product_controller.dart';
import '../model/common_modal.dart';
import '../repository/repository.dart';
import '../utils/api_constant.dart';
import '../widgets/common_button.dart';
import '../widgets/common_colour.dart';
import '../widgets/common_textfield.dart';
import 'ReviewandPublishScreen.dart';
import 'optionalDiscrptionsScreen.dart';

class SinglePInternationalshippingdetailsScreen extends StatefulWidget {
  int? id;
  String? Unitofmeasure;
  int? WeightOftheItem;
  int? SelectNumberOfPackages;
  String? SelectTypeMaterial;
  String? SelectTypeOfPackaging;
  String? Length;
  String? Width;
  String? Height;
  SinglePInternationalshippingdetailsScreen(
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
  State<SinglePInternationalshippingdetailsScreen> createState() => _SinglePInternationalshippingdetailsScreenState();
}

class _SinglePInternationalshippingdetailsScreenState extends State<SinglePInternationalshippingdetailsScreen> {
  String selectedItem = 'Item 1';
  TextEditingController dimensionController = TextEditingController();
  TextEditingController dimensionWidthController = TextEditingController();
  TextEditingController dimensionHeightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  List<String> itemList = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  final serviceController = Get.put(ServiceController());
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

  String selectTypeOfPackaging = 'fedex 10kg box';
  List<String> selectTypeOfPackagingList = [
    'fedex 10kg box',
    'fedex 25kg box',
    'fedex box',
    'fedex Envelop',
    'fedex pak',
    'fedex Tube',
  ];
  final formKey = GlobalKey<FormState>();
  RxBool hide = true.obs;
  RxBool hide1 = true.obs;
  bool showValidation = false;
  bool? _isValue = false;
  final Repositories repositories = Repositories();
  String code = "+91";
  final addProductController = Get.put(AddProductController());
  shippingDetailsApi() {
    Map<String, dynamic> map = {};
    map['weight_unit'] = unitOfMeasure;
    map['item_type'] = 'product';
    map['weight'] = weightController.text.trim();
    map['number_of_package'] = selectNumberOfPackages;
    map['material'] = selectTypeMaterial;
    map['box_length'] = dimensionController.text.trim();
    map['box_width'] = dimensionWidthController.text.trim();
    map['box_height'] = dimensionHeightController.text.trim();
    map['type_of_packages'] = selectTypeOfPackaging;
    map['number_of_package'] = selectedItem;
    map['id'] = addProductController.idProduct.value.toString();

    FocusManager.instance.primaryFocus!.unfocus();
    repositories.postApi(url: ApiUrls.giveawayProductAddress, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      if (response.status == true) {
        if(widget.id != null){
          Get.to(ProductReviewPublicScreen());
        }else{
          Get.to(() => OptionalDiscrptionsScreen());

        }
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
      // selectTypeMaterial = widget.SelectTypeMaterial.toString();
      dimensionController.text = widget.Length.toString();
      dimensionWidthController.text = widget.Width.toString();
      dimensionHeightController.text = widget.Height.toString();
      // selectTypeOfPackaging = widget.SelectTypeOfPackaging.toString();
    }
  }

  final formKey5 = GlobalKey<FormState>();
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
            key: formKey5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'We use this information to estimate your shipping prices. If you plan to ship internationally or your item is bigger than 5kg or 0.05 CBM then you must fill all the details below.'.tr,
                  style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w500, fontSize: 18),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Unit of measure'.tr,
                  style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w500, fontSize: 16),
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
                const SizedBox(height: 20),
                Text(
                  'Weight'.tr,
                  style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w500, fontSize: 16),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: weightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    counterStyle: GoogleFonts.poppins(
                      color: AppTheme.primaryColor,
                      fontSize: 25,
                    ),
                    counter: const Offstage(),
                    errorMaxLines: 2,
                    contentPadding: const EdgeInsets.all(15),
                    fillColor: Colors.grey.shade100,
                    hintText: 'Weight',
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
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Stock number is required'.tr;
                    }
                    return null; // Return null if validation passes
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  'Number of packages'.tr,
                  style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w500, fontSize: 16),
                ),
                const SizedBox(height: 5),
                DropdownButtonFormField<String>(
                  value: selectedItem,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedItem = newValue!;
                    });
                  },
                  items: itemList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text('Number of packages'),
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
                Text(
                  'Material'.tr,
                  style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w500, fontSize: 16),
                ),
              const SizedBox(height: 5),
                DropdownButtonFormField<String>(
                  value: selectNumberOfPackages,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectNumberOfPackages = newValue!;
                    });
                  },
                  items: selectNumberOfPackagesList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text('Material'),
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
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Box dimension L X W X H (Optional)'.tr,
                    style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                        child: Text(
                          'Length'.tr,
                          style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w500, fontSize: 16),
                        ),),
                    10.spaceX,
                    Expanded(
                      child: Text(
                        'Width'.tr,
                        style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w500, fontSize: 16),
                      ),),
                    10.spaceX,
                    Expanded(
                      child: Text(
                        'Height'.tr,
                        style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w500, fontSize: 16),
                      ),),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                        child: CommonTextField(
                      controller: dimensionController,
                      obSecure: false,
                      keyboardType: TextInputType.number,
                      hintText: 'Length X ',
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Product length is required'.tr;
                        }
                        return null; // Return null if validation passes
                      },
                    )),
                    10.spaceX,
                    Expanded(
                        child: CommonTextField(
                      controller: dimensionWidthController,
                      obSecure: false,
                      hintText: 'Width X',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Product Width is required'.tr;
                        }
                        return null; // Return null if validation passes
                      },
                    )
                    ),
                    10.spaceX,
                    Expanded(
                        child: CommonTextField(
                      controller: dimensionHeightController,
                      obSecure: false,
                      hintText: 'Height X',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Product Height is required'.tr;
                        }
                        return null; // Return null if validation passes
                      },
                    )),
                  ],
                ),
                const SizedBox(height: 20),
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
                      child: Text('Package type'),
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
                  title: 'Confirm',
                  borderRadius: 11,
                  onPressed: () {
                    if (formKey5.currentState!.validate()) {
                      shippingDetailsApi();
                    }
                  },
                ),
                const SizedBox(height: 20),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
