import 'dart:convert';
import 'dart:io';

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

class JobDetailsScreen extends StatefulWidget {
  const JobDetailsScreen({super.key});

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  String jobcat = "";
  String jobtype = "";
  String jobmodel = "";
  String jobdesc = "";
  String linkedIN = "";
  String experince = "";
  String salery = "";

  String jobselectedItem = 'full time'; // Default selected item
  String hiringselectedItem = 'Remote'; // Default selected item
  File idProof = File("");
  RxBool showValidation = false.obs;
  bool checkValidation(bool bool1, bool2) {
    if (bool1 == true && bool2 == true) {
      return true;
    } else {
      return false;
    }
  }

  List<String> jobitemList = [
    'full time',
    'part time',
    'freelancing',
  ];
  List<String> hiringitemList = [
    'Remote',
    'hybrid',
    'office',
  ];
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
  final formKey1 = GlobalKey<FormState>();

  Map<String, File> picture = {};

  void updateProfile() {
    Map<String, String> map = {};
    picture["upload_cv"] = idProof;
    map["job_cat"] = selectedCategory ?? "";
    map["job_type"] = jobselectedItem;
    map["job_model"] = hiringselectedItem;
    map["describe_job_role"] = describe_job_roleController.text;
    map["linkdin_url"] = linkdin_urlController.text;
    map["experience"] = experienceController.text;
    map["salary"] = salaryController.text;
    map["item_type"] = 'job';

    repositories
        .multiPartApi(
            mapData: map,
            images: picture,
            context: context,
            url: ApiUrls.giveawayProductAddress,
            onProgress: (int bytes, int totalBytes) {})
        .then((value) {
      JobResponceModel response = JobResponceModel.fromJson(jsonDecode(value));
      showToast(response.message.toString());

      jobcat = response.productDetails!.product!.jobCat.toString();
      jobtype = response.productDetails!.product!.jobType.toString();
      jobmodel = response.productDetails!.product!.jobModel.toString();
      jobdesc = response.productDetails!.product!.describeJobRole.toString();
      linkedIN = response.productDetails!.product!.linkdinUrl.toString();
      experince = response.productDetails!.product!.experience.toString();
      salery = response.productDetails!.product!.salary.toString();
      if (response.status == true && idProof.path.isNotEmpty) {
        Get.to(JobReviewPublishScreen(
          jobcat: jobcat,
          experince: experince,
          jobdesc: jobdesc,
          jobmodel: jobmodel,
          jobtype: jobtype,
          linkedIN: linkedIN,
          salery: salery,
        ));
      }else{
        showToast('Please Upload CV');
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
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xff0D5877),
            size: 16,
          ),
          onPressed: () {
            Get.back();
            // Handle back button press
          },
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
            margin: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  if (kDebugMode) {
                    print(modelVendorCategory.usphone!
                        .map((e) => DropdownMenuItem(value: e, child: Text(e.name.toString().capitalize!)))
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
                        .map((e) => DropdownMenuItem(value: e, child: Text(e.name.toString().capitalize!)))
                        .toList(),
                    hint: Text('Search category to choose'.tr),
                    onChanged: (value) {
                      setState(() {
                        selectedCategory =
                            value!.id.toString(); // Assuming you want to use the ID as the category value
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
                const SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField<String>(
                  value: jobselectedItem,
                  onChanged: (String? newValue) {
                    setState(() {
                      jobselectedItem = newValue!;
                    });
                  },
                  items: jobitemList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(fontSize: 15),
                      ),
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
                const SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField<String>(
                  value: hiringselectedItem,
                  onChanged: (String? newValue) {
                    setState(() {
                      hiringselectedItem = newValue!;
                    });
                  },
                  items: hiringitemList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(fontSize: 15),
                      ),
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
                const SizedBox(
                  height: 20,
                ),
                CommonTextField(
                  controller: describe_job_roleController,
                  obSecure: false,
                  hintText: 'Tell Us About Yourself'.tr,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Tell Us About Yourself is required';
                    }
                    return null; // Return null if validation passes
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CommonTextField(
                  controller: linkdin_urlController,
                  obSecure: false,
                  hintText: 'Add your LinkedIn profile link'.tr,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Add your LinkedIn profile link is required';
                    }
                    return null; // Return null if validation passes
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        maxLines: 2,
                        minLines: 2,
                        controller: experienceController,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Experience period is required';
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
                          hintText: 'Experience Period',
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
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        maxLines: 2,
                        minLines: 2,
                        controller: salaryController,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Asking salary is required';
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
                          hintText: 'Asking Salary',
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
                ImageWidget(
                  // key: paymentReceiptCertificateKey,
                  title: "Upload CV".tr,
                  file: idProof,
                  validation: checkValidation(showValidation.value, idProof.path.isEmpty),
                  filePicked: (File g) {
                    idProof = g;
                  },
                ),
                CustomOutlineButton(
                  title: 'Confirm',
                  borderRadius: 11,
                  onPressed: () {
                    if (formKey1.currentState!.validate()) {
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
