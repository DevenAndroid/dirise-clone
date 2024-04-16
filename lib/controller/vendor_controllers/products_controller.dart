import 'dart:convert';
import 'package:dirise/model/common_modal.dart';
import 'package:dirise/repository/repository.dart';
import 'package:dirise/utils/api_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../model/vendor_models/model_vendor_product_list.dart';

enum ProductTypes{
  all,
  virtual,
  simple,
  booking,
  variant,
}

class ProductsController extends GetxController {
  final Repositories repositories = Repositories();
  RxInt refreshInt = 0.obs;
  bool apiLoaded = false;

  ModelProductsList model = ModelProductsList(product: []);

  void get updateUI => refreshInt.value = DateTime.now().millisecondsSinceEpoch;

  final TextEditingController textEditingController = TextEditingController();

  int page = 1;

  Future getProductList({bool? reset}) async {
    String url = ApiUrls.myProductsListUrl;
    List<String> params = [];
    if(textEditingController.text.trim().isNotEmpty){
      params.add("search=${textEditingController.text.trim()}");
    }
    params.add("page=$page");
    if(params.isNotEmpty){
      url = "$url?${params.join("&")}";
    }
    await repositories.getApi(url: "$url&limit=50").then((value) {
      apiLoaded = true;
      model = ModelProductsList.fromJson(jsonDecode(value));
      updateUI;
    });
  }

  Future updateProductStatus({
    required BuildContext context,
    required String productID,
    required Function(bool gg) changed,
  }) async {
    await repositories
        .postApi(url: ApiUrls.updateProductStatusUrl, mapData: {"product_id": productID}, context: context)
        .then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      if (response.status == true) {
        changed(true);
      }
      showToast(response.message.toString());
      updateUI;
    });
    changed(false);
  }
}
