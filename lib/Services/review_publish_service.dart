import 'package:dirise/addNewProduct/rewardScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/service_controller.dart';
import '../widgets/common_button.dart';
import '../widgets/common_colour.dart';
import '../widgets/common_textfield.dart';
import '../widgets/vendor_common_textfield.dart';

class ReviewPublishServiceScreen extends StatefulWidget {
  const ReviewPublishServiceScreen({super.key});

  @override
  State<ReviewPublishServiceScreen> createState() => _ReviewPublishServiceScreenState();
}

class _ReviewPublishServiceScreenState extends State<ReviewPublishServiceScreen> {
  String selectedItem = 'Item 1';
  final serviceController = Get.put(ServiceController());

  RxBool isServiceProvide = false.obs;
  RxBool isTellUs = false.obs;
  RxBool isReturnPolicy = false.obs;
  RxBool isLocationPolicy = false.obs;
  RxBool isInternationalPolicy = false.obs;
  RxBool optionalDescription = false.obs;
  RxBool optionalClassification = false.obs;
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text('Skip',style: GoogleFonts.poppins(color: Color(0xff0D5877),fontWeight: FontWeight.w400,fontSize: 18),),
          )
        ],
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Review & Publish'.tr,
              style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 15,right: 15),
          child: Column(
            children: [
              const SizedBox(height: 20),
              GestureDetector(
                onTap: (){
                  setState(() {
                    isServiceProvide.toggle();
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppTheme.secondaryColor)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Make it on sale',style: GoogleFonts.poppins(
                        color: AppTheme.primaryColor,
                        fontSize: 15,
                      ),),
                      GestureDetector(
                        child: isServiceProvide.value == true ? const Icon(Icons.keyboard_arrow_up_rounded) : const Icon(Icons.keyboard_arrow_down_outlined),
                        onTap: (){
                        setState(() {
                          isServiceProvide.toggle();
                        });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if(isServiceProvide.value == true)
                CommonTextField(
                    controller: serviceController.serviceNameController,
                    obSecure: false,
                    hintText: 'Service Name'.tr,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Service Name is required'),
                    ])),
              if(isServiceProvide.value == true)
                CommonTextField(
                    controller: serviceController.priceController,
                    obSecure: false,
                    hintText: 'Price'.tr,
                    keyboardType: TextInputType.number,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Price is required'),
                    ])),
              if(isServiceProvide.value == true)
                CommonTextField(
                    controller: serviceController.percentageController,
                    obSecure: false,
                    keyboardType: TextInputType.number,
                    hintText: 'Percentage'.tr,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Enter percentage here.'),
                    ])),
              if(isServiceProvide.value == true)
                CommonTextField(
                    controller: serviceController.fixedPriceController,
                    obSecure: false,
                    keyboardType: TextInputType.number,
                    hintText: 'Fixed after sale price'.tr,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Fixed after sale price'),
                    ])),
              if(isServiceProvide.value == true)
                const SizedBox(height: 20),
              // tell us

              GestureDetector(
                onTap: (){
                  setState(() {
                    isTellUs.toggle();
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppTheme.secondaryColor)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tell us',style: GoogleFonts.poppins(
                        color: AppTheme.primaryColor,
                        fontSize: 15,
                      ),),
                      GestureDetector(
                        child: isTellUs.value == true ? const Icon(Icons.keyboard_arrow_up_rounded) : const Icon(Icons.keyboard_arrow_down_outlined),
                        onTap: (){
                          setState(() {
                            isTellUs.toggle();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if(isTellUs.value == true)
                TextFormField(
                  maxLines: 2,
                  minLines: 2,
                  controller: serviceController.shortDescriptionController,
                  decoration: InputDecoration(
                    counterStyle: GoogleFonts.poppins(
                      color: AppTheme.primaryColor,
                      fontSize: 25,
                    ),
                    counter: const Offstage(),
                    errorMaxLines: 2,
                    contentPadding: const EdgeInsets.all(15),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    hintText: 'Description',
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
              if(isTellUs.value == true)
              const SizedBox(height: 10),
              if(isTellUs.value == true)
                CommonTextField(
                  controller: serviceController.inStockController,
                  obSecure: false,
                  // hintText: 'Name',
                  keyboardType: TextInputType.number,
                  hintText: 'Stock number'.tr,
                  // validator: MultiValidator([
                  //   RequiredValidator(errorText: 'Stock number is required'.tr),
                  // ])
                ),
              if(isTellUs.value == true)
               CommonTextField(
                    controller: serviceController.stockAlertController,
                    obSecure: false,
                    keyboardType: TextInputType.number,
                    // hintText: 'Name',
                    hintText: 'Get notification on your stock quantity'.tr,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Set stock alert is required'.tr),
                    ])),
              if(isTellUs.value == true)
              CommonTextField(
                    controller: serviceController.writeTagsController,
                    obSecure: false,
                    // hintText: 'Name',
                    hintText: 'Write Tags'.tr,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Write Tags is required'.tr),
                    ])),

              // return policy

              GestureDetector(
                onTap: (){
                  setState(() {
                    isReturnPolicy.toggle();
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppTheme.secondaryColor)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('return policy',style: GoogleFonts.poppins(
                        color: AppTheme.primaryColor,
                        fontSize: 15,
                      ),),
                      GestureDetector(
                        child: isReturnPolicy.value == true ? const Icon(Icons.keyboard_arrow_up_rounded) : const Icon(Icons.keyboard_arrow_down_outlined),
                        onTap: (){
                          setState(() {
                            isReturnPolicy.toggle();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if(isReturnPolicy.value == true)
              VendorCommonTextfield(
                  controller: serviceController.titleController,
                  hintText: "DIRISE standard Policy".tr,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "DIRISE standard Policy".tr;
                    }
                    return null;
                  }),
              if(isReturnPolicy.value == true)
              const SizedBox(height: 20),
              if(isReturnPolicy.value == true)
                TextFormField(
                  maxLines: 4,
                  minLines: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please write return policy description';
                    }
                    return null;
                  },
                  controller: serviceController.descController,
                  decoration: InputDecoration(
                    counterStyle: GoogleFonts.poppins(
                      color: AppTheme.primaryColor,
                      fontSize: 25,
                    ),
                    counter: const Offstage(),
                    errorMaxLines: 2,
                    contentPadding: const EdgeInsets.all(15),
                    fillColor: Colors.grey.shade100,
                    hintText: 'policy description',
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
              GestureDetector(
                onTap: (){
                  setState(() {
                    isReturnPolicy.toggle();
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppTheme.secondaryColor)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Location where customer will join ',style: GoogleFonts.poppins(
                        color: AppTheme.primaryColor,
                        fontSize: 15,
                      ),),
                      GestureDetector(
                        child: isReturnPolicy.value == true ? const Icon(Icons.keyboard_arrow_up_rounded) : const Icon(Icons.keyboard_arrow_down_outlined),
                        onTap: (){
                          setState(() {
                            isReturnPolicy.toggle();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if(isLocationPolicy.value == true)
              const SizedBox(height: 20),
              GestureDetector(
                onTap: (){
                  setState(() {
                    isInternationalPolicy.toggle();
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppTheme.secondaryColor)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('International Shipping Details',style: GoogleFonts.poppins(
                        color: AppTheme.primaryColor,
                        fontSize: 15,
                      ),),
                      GestureDetector(
                        child: isInternationalPolicy.value == true ? const Icon(Icons.keyboard_arrow_up_rounded) : const Icon(Icons.keyboard_arrow_down_outlined),
                        onTap: (){
                          setState(() {
                            isInternationalPolicy.toggle();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if(isInternationalPolicy.value == true)
              CommonTextField(
                  controller: serviceController.weightController,
                  obSecure: false,
                  hintText: 'Weight Of the Item ',
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'Product Name is required'.tr),
                  ])),
              if(isInternationalPolicy.value == true)
                CommonTextField(
                    controller: serviceController.dimensionController,
                    obSecure: false,
                    hintText: 'Length X Width X Height ',
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Product Name is required'.tr),
                    ])),
              GestureDetector(
                onTap: (){
                  setState(() {
                    optionalDescription.toggle();
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppTheme.secondaryColor)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Optional Description',style: GoogleFonts.poppins(
                        color: AppTheme.primaryColor,
                        fontSize: 15,
                      ),),
                      GestureDetector(
                        child: optionalDescription.value == true ? const Icon(Icons.keyboard_arrow_up_rounded) : const Icon(Icons.keyboard_arrow_down_outlined),
                        onTap: (){
                          setState(() {
                            optionalDescription.toggle();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              if(optionalDescription.value == true)
                const SizedBox(height: 20),
              if(optionalDescription.value == true)
              TextFormField(
                controller: serviceController.longDescriptionController,
                maxLines: 2,
                minLines: 2,
                decoration: InputDecoration(
                  counterStyle: GoogleFonts.poppins(
                    color: AppTheme.primaryColor,
                    fontSize: 25,
                  ),
                  counter: const Offstage(),

                  errorMaxLines: 2,
                  contentPadding: const EdgeInsets.all(15),
                  fillColor: Colors.grey.shade100,
                  hintText: 'Long Description(optional)',
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
              if(optionalDescription.value == true)
              CommonTextField(
                  controller: serviceController.metaTitleController,
                  obSecure: false,
                  hintText: 'Meta Title'.tr,
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'Meta Title is required'),
                  ])),
              if(optionalDescription.value == true)
              TextFormField(
                maxLines: 2,
                controller: serviceController.metaDescriptionController,
                minLines: 2,
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
              if(optionalDescription.value == true)
              CommonTextField(
                  controller: serviceController.serialNumberController,
                  obSecure: false,
                  hintText: 'Serial Number'.tr,
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'Serial Number is required'),
                  ])),
              if(optionalDescription.value == true)
              CommonTextField(
                  controller: serviceController.productNumberController,
                  obSecure: false,
                  hintText: 'Product number'.tr,
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'Product number is required'),
                  ])),
               const SizedBox(
                  height: 20,
                ),
               GestureDetector(
                  onTap: (){
                    setState(() {
                      optionalClassification.toggle();
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 12),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppTheme.secondaryColor)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Optional Classification',style: GoogleFonts.poppins(
                          color: AppTheme.primaryColor,
                          fontSize: 15,
                        ),),
                        GestureDetector(
                          child: optionalClassification.value == true ? const Icon(Icons.keyboard_arrow_up_rounded) : const Icon(Icons.keyboard_arrow_down_outlined),
                          onTap: (){
                            setState(() {
                              optionalClassification.toggle();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              if(optionalClassification.value == true)
                const SizedBox(
                  height: 20,
                ),
              if(optionalClassification.value == true)
                CommonTextField(
                    controller: serviceController.serialNumberController,
                    obSecure: false,
                    hintText: 'Serial Number'.tr,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Meta Title is required'),
                    ])),
              if(optionalClassification.value == true)
              CommonTextField(
                  controller: serviceController.productNumberController,
                  obSecure: false,
                  hintText: 'Product number'.tr,
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'Serial Number is required'),
                  ])),
              if(optionalClassification.value == true)
              CommonTextField(
                  controller: serviceController.productCodeController,
                  obSecure: false,
                  hintText: 'Product Code'.tr,
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'Product number is required'),
                  ])),
              if(optionalClassification.value == true)
              CommonTextField(
                  controller: serviceController.promotionCodeController,
                  obSecure: false,
                  hintText: 'Promotion Code'.tr,
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'Product number is required'),
                  ])),
              if(optionalClassification.value == true)
              TextFormField(
                controller: serviceController.packageDetailsController,
                maxLines: 5,
                minLines: 5,
                decoration: InputDecoration(
                  counterStyle: GoogleFonts.poppins(
                    color: AppTheme.primaryColor,
                    fontSize: 25,
                  ),
                  counter: const Offstage(),

                  errorMaxLines: 2,
                  contentPadding: const EdgeInsets.all(15),
                  fillColor: Colors.grey.shade100,
                  hintText: 'Package details',
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
              CustomOutlineButton(
                title: 'Confirm',
                borderRadius: 11,
                onPressed: () {
                  Get.to(RewardScreen());
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
