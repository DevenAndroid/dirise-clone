import 'dart:convert';
import 'package:dirise/repository/repository.dart';
import 'package:get/get.dart';
import '../model/author_modal.dart';
import '../model/home_modal.dart';
import '../model/popular_product_modal.dart';
import '../model/trending_products_modal.dart';
import '../model/vendor_models/vendor_category_model.dart';
import '../utils/api_constant.dart';

class TrendingProductsController extends GetxController {
  Rx<HomeModal> homeModal = HomeModal().obs;
  Rx<PopularProductsModal> popularProdModal = PopularProductsModal().obs;
  Rx<AuthorModal> authorModal = AuthorModal().obs;
  final Repositories repositories = Repositories();
  Rx<TendingModel> trendingModel = TendingModel().obs;

  ModelVendorCategory vendorCategory = ModelVendorCategory();
  RxInt updateCate = 0.obs;

  Future trendingData() async {
    await repositories.postApi(url: ApiUrls.trendingProductsUrl, mapData: {}).then((value) {
      trendingModel.value = TendingModel.fromJson(jsonDecode(value));
    });
  }

  Future homeData() async {
    await repositories.postApi(url: ApiUrls.homeUrl, mapData: {}).then((value) {
      homeModal.value = HomeModal.fromJson(jsonDecode(value));
    });
  }

  Future popularProductsData() async {
    await repositories.postApi(url: ApiUrls.popularProductUrl, mapData: {}).then((value) {
      popularProdModal.value = PopularProductsModal.fromJson(jsonDecode(value));
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
    authorData();
  }
}
