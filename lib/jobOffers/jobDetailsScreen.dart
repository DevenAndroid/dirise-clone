import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dirise/model/customer_profile/model_state_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/profile_controller.dart';
import '../controller/vendor_controllers/add_product_controller.dart';
import '../controller/vendor_controllers/vendor_profile_controller.dart';
import '../model/common_modal.dart';
import '../model/customer_profile/model_city_list.dart';
import '../model/customer_profile/model_country_list.dart';
import '../model/jobResponceModel.dart';
import '../model/modelJobList.dart';
import '../model/modelSubcategory.dart';
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
  int? id;
  String? jobTitle;
  String? jobCategory;
  String? jobSubCategory;
  String? jobCountry;
  String? jobState;
  String? countryId;
  String? stateId;
  String? cityId;
  String? jobCity;
  String? jobType;
  String? jobModel;
  String? catName;
  String? experience;
  String? salary;
  String? linkedIn;
  String? tellUsAboutYourSelf;
  File? uploadCv;
  JobDetailsScreen(
      {super.key,
      this.id,
      this.jobCity,
      this.catName,
      this.uploadCv,
      this.cityId,
      this.stateId,
      this.countryId,
      this.jobCountry,
      this.jobState,
      this.salary,
      this.experience,
      this.jobModel,
      this.jobType,
      this.jobCategory,
      this.jobSubCategory,
      this.jobTitle,
      this.linkedIn,
      this.tellUsAboutYourSelf});

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
  String searchCategory = 'Agriculture';
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
  ModelJobList modelVendorCategory = ModelJobList(data: []);
  ModelSubcategoryList modelSubCategory = ModelSubcategoryList(subCategory: []);
  ModelCountryList modelCountryList = ModelCountryList(country: []);
  ModelStateList modelStateList = ModelStateList(state: []);
  Rx<ModelCityList> modelCityList = ModelCityList(city: []).obs;
  Rx<RxStatus> vendorCategoryStatus = RxStatus.empty().obs;
  Rx<RxStatus> subCategoryStatus = RxStatus.empty().obs;
  Rx<RxStatus> countryStatus = RxStatus.empty().obs;
  Rx<RxStatus> stateStatus = RxStatus.empty().obs;
  Rx<RxStatus> cityStatus = RxStatus.empty().obs;
  final GlobalKey categoryKey = GlobalKey();
  final GlobalKey categoryKey1 = GlobalKey();
  final GlobalKey categoryKey2 = GlobalKey();
  final GlobalKey categoryKey3 = GlobalKey();
  final GlobalKey categoryKey4 = GlobalKey();
  final GlobalKey subcategoryKey = GlobalKey();
  final GlobalKey productsubcategoryKey = GlobalKey();
  Map<String, Data> allSelectedCategory = {};
  Map<String, Country> allSelectedCategory1 = {};
  Map<String, CountryState> allSelectedCategory2 = {};
  Map<String, City> allSelectedCategory3 = {};
  Map<String, SubCategory> allSelectedCategory4 = {};
  String selectedCategory = '';
  String selectedCountry = '';
  String selectedState = '';
  String selectedCity = '';
  String? selectedSubCategory;
  String? cityId;
  String? stateCategory;
  String? idCountry;
  RxString categoryName = "".obs;
  RxString subCategoryName = "".obs;
  RxString countryName = "".obs;
  RxString stateName = "".obs;
  RxString cityName = "".obs;
  String selectedValue = "";
  final Repositories repositories = Repositories();
  VendorUser get vendorInfo => vendorProfileController.model.user!;
  final vendorProfileController = Get.put(VendorProfileController());
  void getVendorCategories() {
    vendorCategoryStatus.value = RxStatus.loading();
    repositories.getApi(url: ApiUrls.jobCategoryListUrl, showResponse: true).then((value) {
      modelVendorCategory = ModelJobList.fromJson(jsonDecode(value));
      vendorCategoryStatus.value = RxStatus.success();

      for (var element in vendorInfo.vendorCategory!) {
        allSelectedCategory[element.id.toString()] = Data.fromJson(element.toJson());
      }
      setState(() {});
    }).catchError((e) {
      vendorCategoryStatus.value = RxStatus.error();
    });
  }

  void getSubCategories(id) {
    subCategoryStatus.value = RxStatus.loading();
    repositories.getApi(url: ApiUrls.jobSubCategoryListUrl + id, showResponse: true).then((value) {
      modelSubCategory = ModelSubcategoryList.fromJson(jsonDecode(value));
      subCategoryStatus.value = RxStatus.success();

      for (var element in vendorInfo.vendorCategory!) {
        allSelectedCategory4[element.id.toString()] = SubCategory.fromJson(element.toJson());
      }
      setState(() {});
    }).catchError((e) {
      subCategoryStatus.value = RxStatus.error();
    });
  }

  void getCountry() {
    countryStatus.value = RxStatus.loading();
    repositories.getApi(url: ApiUrls.allCountriesUrl, showResponse: false).then((value) {
      modelCountryList = ModelCountryList.fromJson(jsonDecode(value));
      countryStatus.value = RxStatus.success();

      for (var element in vendorInfo.vendorCategory!) {
        allSelectedCategory1[element.id.toString()] = Country.fromJson(element.toJson());
      }
      setState(() {});
    }).catchError((e) {
      countryStatus.value = RxStatus.error();
    });
  }

  getStateApi() {
    Map<String, dynamic> map = {};
    map['country_id'] = idCountry.toString();

    /////please change this when image ui is done

    final Repositories repositories = Repositories();
    FocusManager.instance.primaryFocus!.unfocus();
    stateStatus.value = RxStatus.loading();
    repositories.postApi(url: ApiUrls.stateList, context: context, mapData: map).then((value) {
      modelStateList = ModelStateList.fromJson(jsonDecode(value));
      // ModelStateList response = ModelStateList.fromJson(jsonDecode(value));
      stateStatus.value = RxStatus.success();
      print(idCountry.toString());
      for (var element in vendorInfo.vendorCategory!) {
        allSelectedCategory2[element.id.toString()] = CountryState.fromJson(element.toJson());
      }
      print('API Response Status Code: ${modelStateList.status}');
      showToast(modelStateList.message.toString());
      if (modelStateList.status == true) {
        print(addProductController.idProduct.value.toString());
      }
    });
  }

  getCityApi() {
    Map<String, dynamic> map = {};
    map['state_id'] = stateCategory.toString();

    /////please change this when image ui is done

    final Repositories repositories = Repositories();
    FocusManager.instance.primaryFocus!.unfocus();
    cityStatus.value = RxStatus.loading();
    repositories.postApi(url: ApiUrls.citiesList, context: context, mapData: map).then((value) {
      modelCityList.value = ModelCityList.fromJson(jsonDecode(value));
      // ModelStateList response = ModelStateList.fromJson(jsonDecode(value));
      cityStatus.value = RxStatus.success();
      for (var element in vendorInfo.vendorCategory!) {
        allSelectedCategory3[element.id.toString()] = City.fromJson(element.toJson());
      }
      print('API Response Status Code: ${modelCityList.value.city}');
      showToast(modelCityList.value.message.toString());
      if (modelCityList.value.status == true) {
        print(addProductController.idProduct.value.toString());
      }
    });
  }

  List<SubCategory> fetchedDropdownItems = [];
  TextEditingController describe_job_roleController = TextEditingController();
  TextEditingController linkdin_urlController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController jobTitle = TextEditingController();
  final formKey2 = GlobalKey<FormState>();
  final addProductController = Get.put(AddProductController());
  int tappedIndex = -1;
  Map<String, File> picture = {};

  void updateProfile1() {
    Map<String, String> map = {};
    picture["upload_cv"] = idProof;
    map["job_cat"] = selectedSubCategory ?? "";
    map["job_type"] = jobselectedItem;
    map["job_model"] = hiringselectedItem;
    map["about_yourself"] = describe_job_roleController.text;
    map["linkdin_url"] = linkdin_urlController.text;
    map["experience"] = experienceController.text;
    map["salary"] = salaryController.text;
    map["item_type"] = 'job';
    map["product_name"] = jobTitle.text.toString();
    map["job_country_id"] = idCountry.toString();
    map["job_state_id"] = stateCategory.toString();
    map["job_city_id"] = cityId.toString();
    map['id'] = addProductController.idProduct.value.toString();

    repositories
        .multiPartApi(
            mapData: map,
            images: picture,
            context: context,
            url: ApiUrls.giveawayProductAddress,
            onProgress: (int bytes, int totalBytes) {})
        .then((value) {
      JobResponceModel response = JobResponceModel.fromJson(jsonDecode(value));
      if (response.status == true && idProof.path.isNotEmpty) {
        Get.to(JobReviewPublishScreen(
          category: selectedCategory,
          subCategory: selectedSubCategory,
        ));
      } else {
        showToast('Please Upload CV'.tr);
      }
    });
  }

  TextEditingController subCeteController = TextEditingController();
  bool isItemDetailsVisible = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVendorCategories();
    getCountry();
    if (widget.id != null) {
      describe_job_roleController.text = widget.tellUsAboutYourSelf.toString();
      linkdin_urlController.text = widget.linkedIn.toString();
      experienceController.text = widget.experience.toString();
      salaryController.text = widget.salary.toString();
      jobTitle.text = widget.jobTitle.toString();
      subCategoryName.value = widget.catName.toString();
      log('select value issss...${subCategoryName.value.toString()}');
      subCeteController.text = widget.jobSubCategory.toString();
      idCountry = widget.countryId.toString();
      categoryName.value = widget.jobCategory.toString();
      countryName.value = widget.jobCountry.toString();
      stateName.value = widget.jobState.toString();
      cityName.value = widget.jobCity.toString();
      stateCategory = widget.stateId.toString();
      idProof = File(widget.uploadCv.toString());
      cityId = widget.cityId.toString();
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        getStateApi();
        getCityApi();
      });
    }
  }

  void showBottomSheet({
    required BuildContext context,
    required List<String> items,
    required String selectedItem,
    required ValueChanged<String> onItemSelected,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        TextEditingController searchController = TextEditingController();
        List<String> filteredItems = List.from(items);

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: searchController,
                    decoration:  InputDecoration(
                      labelText: 'Search'.tr,
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        filteredItems =
                            items.where((item) => item.toLowerCase().contains(value.toLowerCase())).toList();
                      });
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      String item = filteredItems[index];
                      return ListTile(
                        title: Text(item),
                        selected: item == selectedItem,
                        onTap: () {
                          onItemSelected(item);
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  final profileController = Get.put(ProfileController());
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              profileController.selectedLAnguage.value != 'English'
                  ? Image.asset(
                      'assets/images/forward_icon.png',
                      height: 19,
                      width: 19,
                    )
                  : Image.asset(
                      'assets/images/back_icon_new.png',
                      height: 19,
                      width: 19,
                    ),
            ],
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
          key: formKey2,
          child: Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonTextField(
                  controller: jobTitle,
                  obSecure: false,
                  hintText: 'Job Title'.tr,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Job Title'.tr;
                    }
                    return null; // Return null if validation passes
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    showBottomSheet(
                      context: context,
                      items: modelVendorCategory.data!
                          .map((e) => e.title.toString())
                          .toList(),
                      selectedItem: selectedCategory,
                      onItemSelected: (newValue) {
                        setState(() {
                          var selectedCategoryData = modelVendorCategory.data!
                              .firstWhere((element) => element.title == newValue);
                          selectedCategory = selectedCategoryData.id.toString();
                          categoryName.value = selectedCategoryData.title.toString();
                          getSubCategories(selectedCategory);

                        });
                      },
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          categoryName.value.isEmpty
                              ? 'Select job type'.tr
                              : modelVendorCategory.data!
                              .firstWhereOrNull((element) => element.title == categoryName.value)
                              ?.title
                              .toString() ?? 'Select job type'.tr,
                        ),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                categoryName.value.isEmpty
                    ? const SizedBox()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Choose Sub Category'.tr,
                            style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            onChanged: (value) {
                              selectedValue = '';
                              fetchedDropdownItems = modelSubCategory.subCategory!
                                  .where((element) => element.title!.toLowerCase().contains(value.toLowerCase()))
                                  .map((vendorCategory) =>
                                      SubCategory(id: vendorCategory.id, title: vendorCategory.title))
                                  .toList();
                              setState(() {});
                            },
                            controller: subCeteController,
                            decoration: InputDecoration(
                              hintText: 'Search'.tr,
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          if (selectedValue.isEmpty)
                            ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: fetchedDropdownItems.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                var data = fetchedDropdownItems[index];
                                return GestureDetector(
                                  onTap: () {
                                    // fetchDataBasedOnId(data.id);
                                    isItemDetailsVisible = !isItemDetailsVisible;
                                    selectedSubCategory = data.id.toString();
                                    subCategoryName.value = data.title.toString();
                                    setState(() {
                                      selectedValue = data.title!;
                                      tappedIndex = index;
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 5),
                                    padding: const EdgeInsets.all(10),
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: tappedIndex == index ? AppTheme.buttonColor : Colors.grey.shade400,
                                            width: 2)),
                                    child: Text(data.title.toString()),
                                  ),
                                );
                              },
                            ),
                          if (selectedValue.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.all(10),
                              height: 50,
                              width: Get.width,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: AppTheme.buttonColor, width: 2)),
                              child: Text(selectedValue),
                            ),
                        ],
                      ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    showBottomSheet(
                      context: context,
                      items: modelCountryList.country!
                          .map((e) => e.name.toString())
                          .toList(),
                      selectedItem: selectedCountry,
                      onItemSelected: (newValue) {
                        setState(() {
                          var selectedCountryData = modelCountryList.country!
                              .firstWhere((element) => element.name == newValue);
                          idCountry = selectedCountryData.id.toString();
                          countryName.value = selectedCountryData.name.toString();
                          getStateApi();

                        });
                      },
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          countryName.value.isEmpty
                              ? 'Select country'.tr
                              : modelCountryList.country!
                              .firstWhereOrNull((element) => element.name == countryName.value)
                              ?.name
                              .toString() ?? 'Select country'.tr,
                        ),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    showBottomSheet(
                      context: context,
                      items: modelStateList.state!
                          .map((e) => e.stateName.toString())
                          .toList(),
                      selectedItem: selectedState,
                      onItemSelected: (newValue) {
                        setState(() {
                          var selectedStateData = modelStateList.state!
                              .firstWhere((element) => element.stateName == newValue);
                          stateCategory = selectedStateData.stateId.toString();
                          stateName.value = selectedStateData.stateName.toString();
                          getCityApi();


                        });
                      },
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          stateName.value.isEmpty
                              ? 'Select state'.tr
                              : modelStateList.state!
                              .firstWhereOrNull((element) => element.stateName == stateName.value)
                              ?.stateName
                              .toString() ?? 'Select state'.tr,
                        ),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    showBottomSheet(
                      context: context,
                      items: modelCityList.value.city!
                          .map((e) => e.cityName.toString())
                          .toList(),
                      selectedItem: selectedCity,
                      onItemSelected: (newValue) {
                        setState(() {
                          var selectedCityData = modelCityList.value.city!
                              .firstWhere((element) => element.cityName == newValue);
                          cityId = selectedCityData.cityId.toString();
                          cityName.value = selectedCityData.cityName.toString();


                        });
                      },
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          modelCityList.value.city!.isEmpty
                              ? 'Select city'.tr
                              :  modelCityList.value.city!
                              .firstWhereOrNull((element) => element.cityName == cityName.value)
                              ?.cityName
                              .toString() ?? 'Select city'.tr,
                        ),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ),

                const SizedBox(
                  height: 17,
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
                      return 'Please select an item'.tr;
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
                      return 'Please select an item'.tr;
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  maxLines: 2,
                  minLines: 2,
                  controller: describe_job_roleController,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Tell Us About Yourself'.tr;
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
                    hintText: 'Tell Us About Yourself'.tr,
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

                const SizedBox(
                  height: 10,
                ),
                CommonTextField(
                  controller: linkdin_urlController,
                  obSecure: false,
                  hintText: 'Add your LinkedIn profile link'.tr,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Add your LinkedIn profile link is required'.tr;
                    }
                    return null; // Return null if validation passes
                  },
                ),
                const SizedBox(
                  height: 10,
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
                            return 'Experience period is required'.tr;
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
                          hintText: 'Experience Period'.tr,
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
                            return 'Asking salary is required'.tr;
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
                          hintText: 'Asking Salary'.tr,
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
                  title: 'Confirm'.tr,
                  borderRadius: 11,
                  onPressed: () {
                    if (formKey2.currentState!.validate()) {
                      if (categoryName.value == "") {
                        showToast("Please select category");
                      } else if (subCategoryName.value == "") {
                        showToast("Please select sub category");
                      } else if (countryName.value == "") {
                        showToast("Please select country");
                      } else if (stateName.value == "") {
                        showToast("Please select state");
                      } else {
                        updateProfile1();
                      }
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
