import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/vendor_controllers/add_product_controller.dart';
import '../controller/vendor_controllers/vendor_profile_controller.dart';
import '../model/customer_profile/model_city_list.dart';
import '../model/customer_profile/model_country_list.dart';
import '../model/customer_profile/model_state_list.dart';
import '../model/jobResponceModel.dart';
import '../model/modelJobList.dart';
import '../model/modelSubcategory.dart';
import '../model/vendor_models/model_vendor_details.dart';
import '../repository/repository.dart';
import '../utils/api_constant.dart';
import '../widgets/common_button.dart';
import '../widgets/common_colour.dart';
import '../widgets/common_textfield.dart';
import 'JobReviewandPublishScreen.dart';
import 'hiringReviewandPublishScreen.dart';

class HiringJobDetailsScreen extends StatefulWidget {
  int? id;
  String? jobTitle;
  String? jobCategory;
  String? jobSubCategory;
  String? jobCountry;
  String? jobState;
  String? jobCity;
  String? jobType;
  String? jobModel;
  String? experience;
  String? salary;
  String? linkedIn;
  String? tellUsAboutYourSelf;
  int? hoursPerWeek;
  HiringJobDetailsScreen(
      {super.key,
        this.id,
        this.jobCity,
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
        this.tellUsAboutYourSelf,
        this.hoursPerWeek
      });


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
  RxString categoryName = "".obs;
  RxString subCategoryName = "".obs;
  RxString countryName = "".obs;
  RxString stateName = "".obs;
  RxString cityName = "".obs;
  File idProof = File("");
  RxBool showValidation = false.obs;

  List<String> jobLocationitemList = [
    'Remote',
    'hybrid',
    'office',
  ];
  final formKey1 = GlobalKey<FormState>();
  ModelJobList modelVendorCategory = ModelJobList(data: []);
  ModelSubcategoryList modelSubCategory = ModelSubcategoryList(subCategory: []);
  Rx<RxStatus> vendorCategoryStatus = RxStatus.empty().obs;
  final GlobalKey categoryKey = GlobalKey();
  final GlobalKey subcategoryKey = GlobalKey();
  final GlobalKey productsubcategoryKey = GlobalKey();
  Map<String, Data> allSelectedCategory = {};
  ModelCountryList modelCountryList = ModelCountryList(country: []);
  ModelStateList modelStateList = ModelStateList(state: []);
  Rx<ModelCityList> modelCityList = ModelCityList(city: []).obs;
  Rx<RxStatus> countryStatus = RxStatus.empty().obs;
  Rx<RxStatus> stateStatus = RxStatus.empty().obs;
  Rx<RxStatus> cityStatus = RxStatus.empty().obs;
  String? selectedCategory;
  Map<String, Country> allSelectedCategory1 = {};
  Map<String, CountryState> allSelectedCategory2 = {};
  Map<String, City> allSelectedCategory3 = {};
  final GlobalKey categoryKey1 = GlobalKey();
  final GlobalKey categoryKey2 = GlobalKey();
  final GlobalKey categoryKey3 = GlobalKey();
  Map<String, SubCategory> allSelectedCategory4 = {};
  String? cityId;
  String selectedValue = "";
  String? selectedSubCategory;
  String? stateCategory;
  String? idCountry;
  String jobselectedItem = 'full time';
  List<String> jobitemList = [
    'full time',
    'part time',
    'freelancing',
  ];
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

  Rx<RxStatus> subCategoryStatus = RxStatus.empty().obs;
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
      print(idCountry.toString() );
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
    repositories.getApi(url: ApiUrls.jobSubCategoryListUrl+id, showResponse: true).then((value) {
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
  int tappedIndex = -1;
  bool isItemDetailsVisible = false;
  List<SubCategory> fetchedDropdownItems = [];
  final GlobalKey categoryKey4 = GlobalKey();
  TextEditingController describe_job_roleController = TextEditingController();
  TextEditingController linkdin_urlController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController hoursperweekController = TextEditingController();
  final addProductController = Get.put(AddProductController());
  TextEditingController jobTitle = TextEditingController();
  void updateProfile() {
    Map<String, String> map = {};
    map["job_cat"] = selectedSubCategory ?? "";
    map["job_type"] = jobselectedItem;
    map["job_model"] = joblocationselectedItem;
    map["describe_job_role"] = describe_job_roleController.text;
    map["linkdin_url"] = linkdin_urlController.text;
    map["experience"] = experienceController.text;
    map["salary"] = salaryController.text;
    map["job_hours"] = hoursperweekController.text;
    map["product_name"] = jobTitle.text.toString();
    map["job_country_id"] = idCountry.toString();
    map["job_state_id"] = stateCategory.toString();
    map["job_city_id"] = cityId.toString();
    map["item_type"] = 'job';
    map['id'] = addProductController.idProduct.value.toString();

    repositories.postApi(url: ApiUrls.giveawayProductAddress, context: context, mapData: map).then((value) {
      JobResponceModel response = JobResponceModel.fromJson(jsonDecode(value));
      if (response.status == true) {
        Get.to(HiringReviewPublishScreen());
      }
    });
  }
    @override
    void initState() {
      // TODO: implement initState
      super.initState();
      getVendorCategories();
      getCountry();
      if(widget.id != null){
        describe_job_roleController.text = widget.tellUsAboutYourSelf.toString();
        linkdin_urlController.text = widget.linkedIn.toString();
        experienceController.text =widget.experience.toString();
        salaryController.text = widget.salary.toString();
        jobTitle.text = widget.jobTitle.toString();
        hoursperweekController.text = widget.hoursPerWeek.toString();
      }
    }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading:GestureDetector(
            onTap: (){
              Get.back();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
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
            key: formKey1,
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
                        return 'Job Title';
                      }
                      return null; // Return null if validation passes
                    },
                  ),


                  SizedBox(height: 10,),
                  Obx(() {
                    if (kDebugMode) {
                      print(modelVendorCategory.data!
                          .map((e) => DropdownMenuItem(value: e, child: Text(e.title.toString().capitalize!)))
                          .toList());
                    }
                    return DropdownButtonFormField<Data>(
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
                      items: modelVendorCategory.data!
                          .map((e) => DropdownMenuItem(value: e, child: Text(e.title.toString().capitalize!)))
                          .toList(),
                      hint: Text('Search category to choose'.tr),
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value!.id.toString();
                          categoryName.value = value!.title.toString();
                          getSubCategories(selectedCategory.toString());// Assuming you want to use the ID as the category value
                        });
                        // if (value == null) return;
                        // if (allSelectedCategory.isNotEmpty) return;
                        // allSelectedCategory[value.id.toString()] = value;
                        // setState(() {});
                      },
                      // validator: (value) {
                      //   if (allSelectedCategory.isEmpty) {
                      //     return "Please select Category".tr;
                      //   }
                      //   return null;
                      // },
                    );
                  }),
                  SizedBox(height: 7,),
                  categoryName.value.isEmpty?SizedBox():

                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(
                       'Choose Sub Category'.tr,
                       style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14),
                     ),
                     SizedBox(height: 8),
                     TextField(
                       onChanged: (value) {
                         selectedValue = '';
                         fetchedDropdownItems = modelSubCategory.subCategory!
                             .where((element) =>
                             element.title!.toLowerCase().contains(value.toLowerCase()))
                             .map((vendorCategory) => SubCategory(
                             id: vendorCategory.id,
                             title: vendorCategory.title)) // Convert vendor category to product category
                             .toList();
                         setState(() {});
                       },
                       decoration: InputDecoration(
                         hintText: 'Search',
                         prefixIcon: const Icon(Icons.search),
                         border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(10),
                         ),
                       ),
                     ),
                     SizedBox(height: 5),
                     if (selectedValue.isEmpty)
                     ListView.builder(
                       padding: EdgeInsets.zero,
                       itemCount: fetchedDropdownItems.length,
                       shrinkWrap: true,
                       physics: NeverScrollableScrollPhysics(),
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
                             margin: EdgeInsets.only(bottom: 5),
                             padding: const EdgeInsets.all(10),
                             height: 50,
                             decoration: BoxDecoration(
                                 color: Colors.grey.shade200,
                                 borderRadius: BorderRadius.circular(10),
                                 border: Border.all(color: tappedIndex == index ? AppTheme.buttonColor : Colors.grey.shade400, width: 2)),
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
                  // Obx(() {
                  //   if (kDebugMode) {
                  //     print(modelSubCategory.subCategory!
                  //         .map((e) => DropdownMenuItem(value: e, child: Text(e.title.toString().capitalize!)))
                  //         .toList());
                  //   }
                  //   return DropdownButtonFormField<SubCategory>(
                  //     isExpanded: true,
                  //     key: categoryKey4,
                  //     autovalidateMode: AutovalidateMode.onUserInteraction,
                  //     icon: subCategoryStatus.value.isLoading
                  //         ? const CupertinoActivityIndicator()
                  //         : const Icon(Icons.keyboard_arrow_down_rounded),
                  //     iconSize: 30,
                  //     iconDisabledColor: const Color(0xff97949A),
                  //     iconEnabledColor: const Color(0xff97949A),
                  //     value: null,
                  //     style: GoogleFonts.poppins(color: Colors.black, fontSize: 14),
                  //     decoration: InputDecoration(
                  //       border: InputBorder.none,
                  //       filled: true,
                  //       fillColor: const Color(0xffE2E2E2).withOpacity(.35),
                  //       contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10).copyWith(right: 8),
                  //       focusedErrorBorder: const OutlineInputBorder(
                  //           borderRadius: BorderRadius.all(Radius.circular(8)),
                  //           borderSide: BorderSide(color: AppTheme.secondaryColor)),
                  //       errorBorder: const OutlineInputBorder(
                  //           borderRadius: BorderRadius.all(Radius.circular(8)),
                  //           borderSide: BorderSide(color: Color(0xffE2E2E2))),
                  //       focusedBorder: const OutlineInputBorder(
                  //           borderRadius: BorderRadius.all(Radius.circular(8)),
                  //           borderSide: BorderSide(color: AppTheme.secondaryColor)),
                  //       disabledBorder: const OutlineInputBorder(
                  //         borderRadius: BorderRadius.all(Radius.circular(8)),
                  //         borderSide: BorderSide(color: AppTheme.secondaryColor),
                  //       ),
                  //       enabledBorder: const OutlineInputBorder(
                  //         borderRadius: BorderRadius.all(Radius.circular(8)),
                  //         borderSide: BorderSide(color: AppTheme.secondaryColor),
                  //       ),
                  //     ),
                  //     items: modelSubCategory.subCategory!
                  //         .map((e) => DropdownMenuItem(value: e, child: Text(e.title.toString().capitalize!)))
                  //         .toList(),
                  //     hint: Text('sub category'.tr),
                  //     onChanged: (value) {
                  //       setState(() {
                  //         selectedSubCategory =
                  //             value!.id.toString();
                  //         subCategoryName.value = value!.title.toString(); // // Assuming you want to use the ID as the category value
                  //       });
                  //       // if (value == null) return;
                  //       // if (allSelectedCategory.isNotEmpty) return;
                  //       // allSelectedCategory[value.id.toString()] = value;
                  //       // setState(() {});
                  //     },
                  //     // validator: (value) {
                  //     //   if (allSelectedCategory.isEmpty) {
                  //     //     return "Please select Category".tr;
                  //     //   }
                  //     //   return null;
                  //     // },
                  //   );
                  // }),
                  SizedBox(height: 12,),
                  Obx(() {
                    if (kDebugMode) {
                      print(modelCountryList.country!
                          .map((e) => DropdownMenuItem(value: e, child: Text(e.name.toString().capitalize!)))
                          .toList());
                    }
                    return DropdownButtonFormField<Country>(
                      key: categoryKey1,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      icon: countryStatus.value.isLoading
                          ? const CupertinoActivityIndicator()
                          : const Icon(Icons.keyboard_arrow_down_rounded),
                      iconSize: 30,
                      iconDisabledColor: const Color(0xff97949A),
                      iconEnabledColor: const Color(0xff97949A),
                      value: null,
                      style: GoogleFonts.poppins(color: Colors.black, fontSize: 14),
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
                      items: modelCountryList.country!
                          .map((e) => DropdownMenuItem(value: e, child: Text(e.name.toString().capitalize!)))
                          .toList(),
                      hint: Text('Search country '.tr),
                      onChanged: (value) {
                        setState(() {
                          idCountry = value!.id.toString();
                          countryName.value = value!.name.toString();

                          getStateApi(); // Assuming you want to use the ID as the category value
                        });
                        modelStateList = ModelStateList();
                        // if (value == null) return;
                        // if (allSelectedCategory1.isNotEmpty) return;
                        // allSelectedCategory1[value.id.toString()] = value;
                        // setState(() {});
                      },
                      // validator: (value) {
                      //   if (allSelectedCategory1.isEmpty) {
                      //     return "Please select country".tr;
                      //   }
                      //   return null;
                      // },
                    );
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(() {
                    // if (kDebugMode) {
                    //   print(modelStateList.state!
                    //       .map((e) => DropdownMenuItem(value: e, child: Text(e.stateName.toString().capitalize!)))
                    //       .toList());
                    // }
                    return modelStateList.state!=null ?
                    DropdownButtonFormField<CountryState>(
                      key: categoryKey2,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      icon: stateStatus.value.isLoading
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
                      items: modelStateList.state!
                          .map((e) => DropdownMenuItem(value: e, child: Text(e.stateName.toString().capitalize!)))
                          .toList(),
                      hint: Text('Search state to choose'.tr),
                      onChanged: (value) {
                        setState(() {
                          stateCategory = value!.stateId.toString();
                          stateName.value = value.stateName.toString();
                          getCityApi(); // Assuming you want to use the ID as the category value
                        });
                        // modelCityList.value = ModelCityList();
                        // if (value == null) return;
                        // if (allSelectedCategory2.isNotEmpty) return;
                        // allSelectedCategory2[value.stateId.toString()] = value;
                        // setState(() {});
                      },
                      // validator: (value) {
                      //   if (allSelectedCategory2.isEmpty) {
                      //     return "Please select state".tr;
                      //   }
                      //   return null;
                      // },
                    ): const SizedBox.shrink();
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(() {
                    // if (kDebugMode) {
                    //   print(modelCityList.city!
                    //       .map((e) => DropdownMenuItem(value: e, child: Text(e.cityName.toString().capitalize!)))
                    //       .toList());
                    // }
                    return modelCityList.value.city!.isNotEmpty
                        ? DropdownButtonFormField<City>(
                      key: categoryKey3,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      icon: cityStatus.value.isLoading
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
                      items: modelCityList.value.city!
                          .map((e) => DropdownMenuItem(value: e, child: Text(e.cityName.toString().capitalize!)))
                          .toList(),
                      hint: Text('Search city to choose'.tr),
                      onChanged: (value) {
                        setState(() {
                          cityId =
                              value!.cityId.toString(); // Assuming you want to use the ID as the category value
                          cityName.value =
                              value!.cityName.toString(); // Assuming you want to use the ID as the category value
                        });
                        // if (value == null) return;
                        // if (allSelectedCategory3.isNotEmpty) return;
                        // allSelectedCategory3[value.cityId.toString()] = value;
                        // setState(() {});
                      },
                      // validator: (value) {
                      //   if (allSelectedCategory3.isEmpty) {
                      //     return "Please select city".tr;
                      //   }
                      //   return null;
                      // },
                    )
                        : const SizedBox.shrink();
                  }),
                  // Obx(() {
                  //   // if (kDebugMode) {
                  //   //   print(modelCityList.city!
                  //   //       .map((e) => DropdownMenuItem(value: e, child: Text(e.cityName.toString().capitalize!)))
                  //   //       .toList());
                  //   // }
                  //   return modelCityList.city!= null ?
                  //   DropdownButtonFormField<City>(
                  //     key: categoryKey3,
                  //     autovalidateMode: AutovalidateMode.onUserInteraction,
                  //     icon: cityStatus.value.isLoading
                  //         ? const CupertinoActivityIndicator()
                  //         : const Icon(Icons.keyboard_arrow_down_rounded),
                  //     iconSize: 30,
                  //     iconDisabledColor: const Color(0xff97949A),
                  //     iconEnabledColor: const Color(0xff97949A),
                  //     value: null,
                  //     style: GoogleFonts.poppins(color: Colors.black, fontSize: 16),
                  //     decoration: InputDecoration(
                  //       border: InputBorder.none,
                  //       filled: true,
                  //       fillColor: const Color(0xffE2E2E2).withOpacity(.35),
                  //       contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10).copyWith(right: 8),
                  //       focusedErrorBorder: const OutlineInputBorder(
                  //           borderRadius: BorderRadius.all(Radius.circular(8)),
                  //           borderSide: BorderSide(color: AppTheme.secondaryColor)),
                  //       errorBorder: const OutlineInputBorder(
                  //           borderRadius: BorderRadius.all(Radius.circular(8)),
                  //           borderSide: BorderSide(color: Color(0xffE2E2E2))),
                  //       focusedBorder: const OutlineInputBorder(
                  //           borderRadius: BorderRadius.all(Radius.circular(8)),
                  //           borderSide: BorderSide(color: AppTheme.secondaryColor)),
                  //       disabledBorder: const OutlineInputBorder(
                  //         borderRadius: BorderRadius.all(Radius.circular(8)),
                  //         borderSide: BorderSide(color: AppTheme.secondaryColor),
                  //       ),
                  //       enabledBorder: const OutlineInputBorder(
                  //         borderRadius: BorderRadius.all(Radius.circular(8)),
                  //         borderSide: BorderSide(color: AppTheme.secondaryColor),
                  //       ),
                  //     ),
                  //     items: modelCityList.city!
                  //         .map((e) => DropdownMenuItem(value: e, child: Text(e.cityName.toString().capitalize!)))
                  //         .toList(),
                  //     hint: Text('Search city to choose'.tr),
                  //     onChanged: (value) {
                  //       setState(() {
                  //         cityId = value!.cityId.toString(); // Assuming you want to use the ID as the category value
                  //         cityName.value =
                  //             value!.cityName.toString(); // Assuming you want to use the ID as the category value
                  //       });
                  //       // if (value == null) return;
                  //       // if (allSelectedCategory3.isNotEmpty) return;
                  //       // allSelectedCategory3[value.cityId.toString()] = value;
                  //       // setState(() {});
                  //     },
                  //     // validator: (value) {
                  //     //   if (allSelectedCategory3.isEmpty) {
                  //     //     return "Please select city".tr;
                  //     //   }
                  //     //   return null;
                  //     // },
                  //   ): const SizedBox.shrink();
                  // }),
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
                  SizedBox(height: 10,),
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
                         if (categoryName.value =="") {showToast("Please select category");}
                        else if (subCategoryName.value =="") {showToast("Please select sub category");}
                        else  if(countryName.value ==""){showToast("Please select country");}
                        else if (stateName.value =="") {showToast("Please select state");}
                        // else if (cityName.value =="") {showToast("Please select city");}
                        else {
                           updateProfile();
                         }    }

                    },
                  ),
                  SizedBox(height: 20,),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
