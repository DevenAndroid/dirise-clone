import 'dart:convert';
import 'package:dirise/repository/repository.dart';
import 'package:get/get.dart';
import '../model/author_modal.dart';
import '../model/home_modal.dart';
import '../model/popular_product_modal.dart';
import '../model/showCase_product_model.dart';
import '../model/trending_products_modal.dart';
import '../model/vendor_models/vendor_category_model.dart';
import '../utils/api_constant.dart';
import 'cart_controller.dart';
import 'location_controller.dart';

class TrendingProductsController extends GetxController {
  Rx<HomeModal> homeModal = HomeModal().obs;
  final cartController = Get.put(CartController());
  Rx<PopularProductsModal> popularProdModal = PopularProductsModal().obs;
  Rx<GetShowCaseProductModel> getShowModal = GetShowCaseProductModel().obs;
  Rx<AuthorModal> authorModal = AuthorModal().obs;
  final Repositories repositories = Repositories();
  Rx<TendingModel> trendingModel = TendingModel().obs;
  final locationController = Get.put(LocationController());
  ModelVendorCategory vendorCategory = ModelVendorCategory();
  RxInt updateCate = 0.obs;


  Future trendingData() async {
    Map<String, dynamic> map = {};

    // map["country_id"]= profileController.model.user!= null && countryId.isEmpty ? profileController.model.user!.country_id : countryId.toString();
    map["country_id"]= cartController.countryId.toString();
      map["zip_code"]= locationController.zipcode.value.toString();
      map["state"]= locationController.state.toString();
    await repositories.postApi(url: ApiUrls.trendingProductsUrl, mapData:map,showResponse: true).then((value) {
      trendingModel.value = TendingModel.fromJson(jsonDecode(value));
    });
  }

  Future homeData() async {
    await repositories.postApi(url: ApiUrls.homeUrl, mapData: {}).then((value) {
      homeModal.value = HomeModal.fromJson(jsonDecode(value));
    });
  }

  Future popularProductsData() async {
    Map<String, dynamic> map = {};

    // map["country_id"]= profileController.model.user!= null && countryId.isEmpty ? profileController.model.user!.country_id : countryId.toString();
    map["country_id"]= cartController.countryId.isNotEmpty ? cartController.countryId.toString() : '117';
    map["zip_code"]= locationController.zipcode.value.toString();
    map["state"]= locationController.state.toString();
    await repositories.postApi(url: ApiUrls.popularProductUrl, mapData: map).then((value) {
      popularProdModal.value = PopularProductsModal.fromJson(jsonDecode(value));
    });
  }
  Future showCaseProductsData() async {

    await repositories.getApi(url: ApiUrls.showCaseProductUrl,).then((value) {
      getShowModal.value = GetShowCaseProductModel.fromJson(jsonDecode(value));
    });
  }

  Future authorData() async {
    await repositories.getApi(url: ApiUrls.authorUrl).then((value) {
      authorModal.value = AuthorModal.fromJson(jsonDecode(value));
    });
  }

  getVendorCategories() {
    repositories.getApi(url: ApiUrls.vendorCategoryListUrl).then((value) {
      vendorCategory = ModelVendorCategory.fromJson(jsonDecode(value));
      updateCate.value = DateTime.now().millisecondsSinceEpoch;
    });
  }

  Future getAll() async {
    homeData();
    getVendorCategories();
    trendingData();
    popularProductsData();
    showCaseProductsData();
    authorData();
  }
}
