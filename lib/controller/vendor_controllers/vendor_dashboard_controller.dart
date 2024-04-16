import 'dart:convert';
import 'dart:developer';

import 'package:dirise/repository/delete_user_repo.dart';
import 'package:dirise/repository/repository.dart';
import 'package:get/get.dart';

import '../../model/vendor_models/model_vendor_dashboard.dart';
import '../../utils/api_constant.dart';

class VendorDashboardController extends GetxController {
  ModelVendorDashboard modelVendorDashboard = ModelVendorDashboard();
  final Repositories repositories = Repositories();
  RxInt refreshInt = 0.obs;

  void get updateUI => refreshInt.value = DateTime.now().millisecondsSinceEpoch;
  // getVendorDashBoard() {
  //   dashboardRepo().then((value) async {
  //     modelVendorDashboard = value;
  //     if (value.status == true) {
  //       modelVendorDashboard.status = true;
  //                modelVendorDashboard.dashboard ??= Dashboard();
  //                   modelVendorDashboard.order ??= [];
  //
  //       // holder();
  //     } else {
  //       // statusOfLogout.value = RxStatus.error();
  //     }
  //
  //     print('logout response${value.message.toString()}');
  //   });
  // }
  Future getVendorDashBoard() async {
    await repositories
        .postApi(
            url: ApiUrls.vendorDashBoardUrl,
            withStatus: (int status, String body) {
              modelVendorDashboard = ModelVendorDashboard.fromJson(jsonDecode(body));
              if (status == 200) {
                log('vendor dashboard${body.toString()}');
                modelVendorDashboard.status = true;
                modelVendorDashboard.dashboard ??= Dashboard();
                modelVendorDashboard.order ??= [];
              }
              updateUI;
            })
        .then((value) {});
  }
}
