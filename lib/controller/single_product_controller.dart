import 'dart:convert';
import 'package:dirise/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/filter_by_price_model.dart';
import '../model/single_category_model.dart';
import '../utils/api_constant.dart';

class SingleCategoryController extends GetxController {
  final Repositories repositories = Repositories();
  Rx<SingleCategoryModel> model = SingleCategoryModel().obs;
  RxBool isDataLoading = false.obs;
  RangeValues currentRangeValues = const RangeValues(0, 0);
  RxBool isFilter = false.obs;
  @override
  void onInit() {
    super.onInit();
    getYourSingleOrder();
  }

  getYourSingleOrder() async {
    await repositories.postApi(url: ApiUrls.storesUrl).then((value) {
      model.value = SingleCategoryModel.fromJson(jsonDecode(value));
      isDataLoading.value = true;
    });
  }
  // filterProduct({productId}) {
  //   repositories
  //       .postApi(
  //       url: ApiUrls.filterByPriceUrl,
  //       mapData: {
  //         "min_price": currentRangeValues.start.toInt(),
  //         "max_price": currentRangeValues.end.toInt(),
  //         "product_id": productId,
  //       },)
  //       .then((value) {
  //     filterModel.value = ModelFilterByPrice.fromJson(jsonDecode(value));
  //     if (filterModel.value.status == true) {
  //       showToast(filterModel.value.message);
  //       print(filterModel.value.product.toString());
  //     }
  //   });
  // }
}
