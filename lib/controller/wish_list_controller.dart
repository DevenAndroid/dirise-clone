import 'dart:convert';

import 'package:dirise/repository/repository.dart';
import 'package:get/get.dart';

import '../model/model_whishlist.dart';
import '../utils/api_constant.dart';

class WishListController extends GetxController {
  final Repositories repositories = Repositories();
  Rx<WhishlistModel> model = WhishlistModel().obs;
  bool apiLoaded = false;
  RxInt refreshInt = 0.obs;
  RxInt refreshFav = 0.obs;

  get updateUI => refreshInt.value = DateTime.now().millisecondsSinceEpoch;
  get updateFav => refreshFav.value = DateTime.now().millisecondsSinceEpoch;

  List<String> favoriteItems = [];

  @override
  void onInit() {
    super.onInit();
    getYourWishList();
  }

  getYourWishList() async {
    await repositories.postApi(url: ApiUrls.wishListUrl).then((value) {
      model.value = WhishlistModel.fromJson(jsonDecode(value));
      favoriteItems = model.value.wishlist!.map((e) => e.id.toString()).toList();
      apiLoaded = true;
      updateUI;
    });
  }
}
