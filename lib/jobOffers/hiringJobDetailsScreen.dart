import 'dart:convert';
import 'dart:io';

import 'package:dirise/jobOffers/hiringReviewandPublishScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/vendor_controllers/vendor_profile_controller.dart';
import '../model/common_modal.dart';
import '../model/jobResponceModel.dart';
import '../model/vendor_models/model_vendor_details.dart';
import '../model/vendor_models/vendor_category_model.dart';
import '../repository/repository.dart';
import '../utils/api_constant.dart';
import '../vendor/authentication/image_widget.dart';
import '../widgets/common_button.dart';
import '../widgets/common_colour.dart';
import '../widgets/common_textfield.dart';
import 'JobReviewandPublishScreen.dart';

class HiringJobDetailsScreen extends StatefulWidget {
  const HiringJobDetailsScreen({super.key});

  @override
  State<HiringJobDetailsScreen> createState() => _HiringJobDetailsScreenState();
}

class _HiringJobDetailsScreenState extends State<HiringJobDetailsScreen> {
  String joblocationselectedItem = 'Remote'; // Default selected item
  String jobcat = "";
  String jobtype = "";
  String jobmodel = "";
  String jobdesc = "";
  String linkedIN = "";
  String experince = "";
  String salery = "";

  File idProof = File("");
  RxBool showValidation = false.obs;

  List<String> jobLocationitemList = [
    'Remote',
    'hybrid',
    'office',
  ];
  final formKey1 = GlobalKey<FormState>();
  ModelVendorCategory modelVendorCategory = ModelVendorCategory(usphone: []);
  Rx<RxStatus> vendorCategoryStatus = RxStatus.empty().obs;
  final GlobalKey categoryKey = GlobalKey();
  final GlobalKey subcategoryKey = GlobalKey();
  final GlobalKey productsubcategoryKey = GlobalKey();
  Map<String, VendorCategoriesData> allSelectedCategory = {};
  String? selectedCategory;
  final Repositories repositories = Repositories();
  VendorUser get vendorInfo => vendorProfileController.model.user!;
  final vendorProfileController = Get.put(VendorProfileController());
  void getVendorCategories() {
    vendorCategoryStatus.value = RxStatus.loading();
    repositories.getApi(url: ApiUrls.vendorCategoryListUrl, showResponse: false).then((value) {
      modelVendorCategory = ModelVendorCategory.fromJson(jsonDecode(value));
      vendorCategoryStatus.value = RxStatus.success();

      for (var element in vendorInfo.vendorCategory!) {
        allSelectedCategory[element.id.toString()] = VendorCategoriesData.fromJson(element.toJson());
      }
      setState(() {});
    }).catchError((e) {
      vendorCategoryStatus.value = RxStatus.error();
    });
  }

  TextEditingController describe_job_roleController = TextEditingController();
  TextEditingController linkdin_urlController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController hoursperweekController = TextEditingController();


  void updateProfile() {
    Map<String, String> map = {};
    map["job_cat"] = selectedCategory ?? "";
    map["job_model"] = joblocationselectedItem;
    map["describe_job_role"] = describe_job_roleController.text;
    map["linkdin_url"] = linkdin_urlController.text;
    map["experience"] = experienceController.text;
    map["salary"] = salaryController.text;
    map["job_hours"] = hoursperweekController.text;
    map["item_type"] = 'job';

    repositories.postApi(url: ApiUrls.giveawayProductAddress, context: context, mapData: map).then((value) {
      JobResponceModel response = JobResponceModel.fromJson(jsonDecode(value));
      jobcat = response.productDetails!.product!.jobCat.toString();
      jobtype = response.productDetails!.product!.jobType.toString();
      jobmodel = response.productDetails!.product!.jobModel.toString();
      jobdesc = response.productDetails!.product!.describeJobRole.toString();
      linkedIN = response.productDetails!.product!.linkdinUrl.toString();
      experince = response.productDetails!.product!.experience.toString();
      salery = response.productDetails!.product!.salary.toString();
      if (response.status == true) {
        Get.to(JobReviewPublishScreen(
          jobcat: jobcat,
          experince: experince,
          jobdesc: jobdesc,
          jobmodel: jobmodel,
          jobtype: jobtype,
          linkedIN: linkedIN,
          salery: salery,
        ));
      }
    });
  }
    @override
    void initState() {
      // TODO: implement initState
      super.initState();
      getVendorCategories();
    }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Color(0xff0D5877),
                size: 16,
              ),
              onPressed: () {
                // Handle back button press
              },
            ),
          ),
          titleSpacing: 0,
          title: Text(
            'Job Details'.tr,
            style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey1,
            child: Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() {
                    if (kDebugMode) {
                      print(modelVendorCategory.usphone!
                          .map((e) =>
                          DropdownMenuItem(value: e, child: Text(e.name
                              .toString()
                              .capitalize!)))
                          .toList());
                    }
                    return DropdownButtonFormField<VendorCategoriesData>(
                      key: categoryKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      icon: vendorCategoryStatus.value.isLoading
                          ? const CupertinoActivityIndicator()
                          : const Icon(Icons.keyboard_arrow_down_rounded),
                      iconSize: 30,
                      iconDisabledColor: const Color(0xff97949A),
                      iconEnabledColor: const Color(0xff97949A),
                      value: null,
                      style: GoogleFonts.poppins(color: Colors.black, fontSize: 16),
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
                      items: modelVendorCategory.usphone!
                          .map((e) =>
                          DropdownMenuItem(value: e, child: Text(e.name
                              .toString()
                              .capitalize!)))
                          .toList(),
                      hint: Text('Search category to choose'.tr),
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value!.id.toString(); // Assuming you want to use the ID as the category value
                        });
                        if (value == null) return;
                        if (allSelectedCategory.isNotEmpty) return;
                        allSelectedCategory[value.id.toString()] = value;
                        setState(() {});
                      },
                      validator: (value) {
                        if (allSelectedCategory.isEmpty) {
                          return "Please select Category".tr;
                        }
                        return null;
                      },
                    );
                  }),
                  const SizedBox(height: 20,),
                  DropdownButtonFormField<String>(
                    value: joblocationselectedItem,
                    onChanged: (String? newValue) {
                      setState(() {
                        joblocationselectedItem = newValue!;
                      });
                    },
                    items: jobLocationitemList.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: TextStyle(fontSize: 15),),
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
                  const SizedBox(height: 20,),
                  TextFormField(
                    maxLines: 2,
                    minLines: 2,
                    controller: linkdin_urlController,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Add your LinkedIn profile link is required';
                      }
                      return null; // Return null if validation passes
                    },
                    decoration: InputDecoration(
                      counterStyle: GoogleFonts.poppins(
                        color: AppTheme.primaryColor,
                        fontSize: 25,
                      ),
                      counter: const Offstage(),

                      errorMaxLines: 2,
                      contentPadding: const EdgeInsets.all(15),
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintText: 'Add LinkedIn Profile link',
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
                  const SizedBox(height: 20,),
                  TextFormField(
                    maxLines: 2,
                    minLines: 2,
                    controller: describe_job_roleController,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Describe the role is required';
                      }
                      return null; // Return null if validation passes
                    },
                    decoration: InputDecoration(
                      counterStyle: GoogleFonts.poppins(
                        color: AppTheme.primaryColor,
                        fontSize: 25,
                      ),
                      counter: const Offstage(),

                      errorMaxLines: 2,
                      contentPadding: const EdgeInsets.all(15),
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintText: 'Describe the role',
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
                  const SizedBox(height: 20,),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          maxLines: 2,
                          minLines: 2,
                          controller: experienceController,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return 'Minimum Experience is required';
                            }
                            return null; // Return null if validation passes
                          },
                          decoration: InputDecoration(
                            counterStyle: GoogleFonts.poppins(
                              color: AppTheme.primaryColor,
                              fontSize: 25,
                            ),
                            counter: const Offstage(),

                            errorMaxLines: 2,
                            contentPadding: const EdgeInsets.all(15),
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: 'Minimum Experience',
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
                      ),

                      SizedBox(width: 10,),
                      Expanded(
                        child: TextFormField(
                          maxLines: 2,
                          minLines: 2,
                          controller: hoursperweekController,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return 'Hours per week is required';
                            }
                            return null; // Return null if validation passes
                          },
                          decoration: InputDecoration(
                            counterStyle: GoogleFonts.poppins(
                              color: AppTheme.primaryColor,
                              fontSize: 25,
                            ),
                            counter: const Offstage(),

                            errorMaxLines: 2,
                            contentPadding: const EdgeInsets.all(15),
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: 'Hours per week',
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
                      ),

                    ],
                  ),
                  SizedBox(width: 10,),
                  TextFormField(
                    maxLines: 2,
                    minLines: 2,
                    controller: salaryController,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Salary range';
                      }
                      return null; // Return null if validation passes
                    },
                    decoration: InputDecoration(
                      counterStyle: GoogleFonts.poppins(
                        color: AppTheme.primaryColor,
                        fontSize: 25,
                      ),
                      counter: const Offstage(),

                      errorMaxLines: 2,
                      contentPadding: const EdgeInsets.all(15),
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintText: 'Salary range',
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
                  SizedBox(height: 20,),
                  CustomOutlineButton(
                    title: 'Confirm',
                    borderRadius: 11,
                    onPressed: () {
                      if(formKey1.currentState!.validate()){
                        updateProfile();
                      }

                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
