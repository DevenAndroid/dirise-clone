import 'dart:convert';
import 'package:dirise/repository/repository.dart';
import 'package:dirise/utils/api_constant.dart';
import 'package:get/get.dart';
import '../../model/vendor_models/model_vendor_details.dart';

class VendorProfileController extends GetxController {
  final Repositories repositories = Repositories();
  ModelVendorDetails model = ModelVendorDetails();
  bool apiLoaded = false;
  RxInt refreshInt = 0.obs;

  get updateUI => refreshInt.value = DateTime.now().millisecondsSinceEpoch;

  Future getVendorDetails() async {
    await repositories.getApi(url: ApiUrls.getVendorDetailUrl).then((value) {
      model = ModelVendorDetails.fromJson(jsonDecode(value));
      if (model.user != null) {
        apiLoaded = true;
      } else {
        apiLoaded = false;
      }
      updateUI;
    });
  }

  @override
  void onInit() {
    super.onInit();
    getVendorDetails();
  }
}

const List<String> imgList = [
  'assets/svgs/green_logo.svg',
  'assets/svgs/orange.svg',
  'assets/svgs/blue.svg',
  'assets/svgs/light_blue.svg',
];
