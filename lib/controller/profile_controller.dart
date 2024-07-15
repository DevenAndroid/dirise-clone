import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/aboutus_model.dart';
import '../model/customer_profile/model_city_list.dart';
import '../model/customer_profile/model_country_list.dart';
import '../model/customer_profile/model_state_list.dart';
import '../model/product_details.dart';
import '../model/profile_model.dart';
import '../model/vendor_models/model_vendor_details.dart';
import '../repository/repository.dart';
import '../utils/api_constant.dart';

class ProfileController extends GetxController {
  String vendorType = '';
  File featuredImage = File("");
  List<File> selectedFiles = [];
  checkLanguage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("app_language") == null ||
        sharedPreferences.getString("app_language") == "English") {
      Get.updateLocale(const Locale('en', 'US'));
     selectedLAnguage.value = "English";
    } else {
      Get.updateLocale(const Locale('ar', 'Ar'));
      selectedLAnguage.value = 'عربي';
    }
  }
  Rx<ModelProductDetails> productDetailsModel = ModelProductDetails().obs;
  getVendorCategories(id) {
    repositories.getApi(url: ApiUrls.getProductDetailsUrl + id).then((value) {
      productDetailsModel.value = ModelProductDetails.fromJson(jsonDecode(value));

    });
  }


  ProfileModel model = ProfileModel();
  final Repositories repositories = Repositories();
  bool apiLoaded = false;
  final ImagePicker picker = ImagePicker();
  RxInt refreshInt = 0.obs;
  bool userLoggedIn = false;
  RxString selectedLAnguage = "English".obs;
  String code = 'KW';
  String code1 = 'KW';
  ModelCountryList? modelCountryList;
  Country? selectedCountry;
  Rx<AboutUsmodel> aboutusModal = AboutUsmodel().obs;
  String planID = '';
  String selectedPlan = '';
  int productID = 0;
  int productAvailabilityId = 0;
  File productImage = File('');
  String thankYouValue = '';
  Future aboutUsData() async {
    Map<String, dynamic> map = {};
    map["id"] = 12;
    repositories.postApi(url: ApiUrls.aboutUsUrl, mapData: map).then((value) {
      aboutusModal.value = AboutUsmodel.fromJson(jsonDecode(value));
    });
  }
  ModelStateList? modelStateList;
  CountryState? selectedState;

  ModelCityList? modelCityList;
  City? selectedCity;

  Rx<ModelVendorDetails> modelVendorProfile = ModelVendorDetails().obs;
  getVendorDetails()  {
    repositories.getApi(url: ApiUrls.getVendorDetailUrl).then((value) {
      modelVendorProfile.value = ModelVendorDetails.fromJson(jsonDecode(value));
      log('proooooooo${modelVendorProfile.value.toJson()}');

    });
  }

  getCountryList() {
    if(modelCountryList != null)return;
    repositories.getApi(url: ApiUrls.allCountriesUrl).then((value) {
      modelCountryList = ModelCountryList.fromString(value);
    });
  }

  RxInt stateRefresh = 2.obs;
  Future getStateList({required String countryId,bool? reset}) async {
    if(reset == true) {
      modelStateList = null;
      selectedState = null;
      modelCityList = null;
      selectedCity = null;
    }
    stateRefresh.value = -5;
    final map = {'country_id': countryId};
    await repositories.postApi(url: ApiUrls.allStatesUrl, mapData: map).then((value) {
      modelStateList = ModelStateList.fromJson(jsonDecode(value));
      stateRefresh.value = DateTime.now().millisecondsSinceEpoch;
    }).catchError((e){
      stateRefresh.value = DateTime.now().millisecondsSinceEpoch;
    });
  }

  RxInt cityRefresh = 2.obs;
  Future getCityList({required String stateId,bool? reset}) async {
    if(reset == true) {
      modelCityList = null;
      selectedCity = null;
    }
    cityRefresh.value = -5;
    final map = {'state_id': stateId};
    await repositories.postApi(url: ApiUrls.allCityUrl, mapData: map).then((value) {
      modelCityList = ModelCityList.fromJson(jsonDecode(value));
      cityRefresh.value = DateTime.now().millisecondsSinceEpoch;
    }).catchError((e){
      cityRefresh.value = DateTime.now().millisecondsSinceEpoch;
    });
  }

  Future<bool> checkUserLoggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getString(Repositories.userInfo) != null) {
      userLoggedIn = true;
    } else {
      userLoggedIn = false;
    }
    return userLoggedIn;
  }

  updateUI() {
    refreshInt.value = DateTime.now().millisecondsSinceEpoch;
  }

  bool isVendorRegistered = false;

  @override
  void onInit() {
    super.onInit();
    checkUserLoggedIn().then((value) {
      getDataProfile();
    });
  }

  Future getDataProfile() async {
    await checkUserLoggedIn();
    if (userLoggedIn) {
      await repositories.postApi(url: ApiUrls.userProfile).then((value) {
        model = ProfileModel.fromJson(jsonDecode(value));
        if (kDebugMode) print(model.user!.firstName);
        apiLoaded = true;
        updateUI();
      });
    } else {
      model = ProfileModel();
      updateUI();
    }
  }


}


class CommonAddressRelatedClass{
  final String title;
  final String addressId;
  final String? flagUrl;
  CommonAddressRelatedClass({required this.title, required this.addressId,this.flagUrl});
}
