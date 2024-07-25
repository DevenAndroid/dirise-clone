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
  String? countryId;
  String? stateId;
  String? cityId;
  String? jobState;
  String? jobCity;
  String? catName;
  String? jobType;
  String? jobModel;
  String? experience;
  String? salary;
  String? linkedIn;
  String? tellUsAboutYourSelf;
  int? hoursPerWeek;
  dynamic jobCatIds;
  HiringJobDetailsScreen(
      {super.key,
        this.id,
        this.jobCity,
        this.catName,
        this.stateId,
        this.cityId,
        this.jobCountry,
        this.countryId,
        this.jobState,
        this.salary,
        this.experience,
        this.jobCatIds,
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
  String selectedCategory = '';
  String selectedCountry = '';
  String selectedState = '';
  String selectedCity = '';
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
  TextEditingController subCeteController = TextEditingController();
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
        categoryName.value = widget.jobCategory.toString();
        countryName.value = widget.jobCountry.toString();
        idCountry = widget.countryId.toString();
        stateCategory = widget.stateId.toString();
        cityId = widget.cityId.toString();
        subCategoryName.value = widget.catName.toString();
        stateName.value = widget.jobState.toString();
        selectedSubCategory = widget.jobCatIds.toString();
        cityName.value = widget.jobCity.toString();
        subCeteController.text = widget.jobSubCategory.toString();
        selectedCategory = widget.jobCategory.toString();
        linkdin_urlController.text = widget.linkedIn.toString();
        experienceController.text =widget.experience.toString();
        salaryController.text = widget.salary.toString();
        jobTitle.text = widget.jobTitle.toString();
        hoursperweekController.text = widget.hoursPerWeek.toString();
        stateCategory = widget.stateId.toString();
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
                    decoration: const InputDecoration(
                      labelText: 'Search',
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
                                ? 'Select job type'
                                : modelVendorCategory.data!
                                .firstWhereOrNull((element) => element.title == categoryName.value)
                                ?.title
                                .toString() ?? 'Select job type',
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
                          hintText: 'Search',
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
                                ? 'Select country'
                                : modelCountryList.country!
                                .firstWhereOrNull((element) => element.name == countryName.value)
                                ?.name
                                .toString() ?? 'Select country',
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
                                ? 'Select state'
                                : modelStateList.state!
                                .firstWhereOrNull((element) => element.stateName == stateName.value)
                                ?.stateName
                                .toString() ?? 'Select state',
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
                                ? 'Select city'
                                :  modelCityList.value.city!
                                .firstWhereOrNull((element) => element.cityName == cityName.value)
                                ?.cityName
                                .toString() ?? 'Select city',
                          ),
                          const Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
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
