import 'dart:convert';
import 'package:get/get.dart';
import '../../model/model_store_available.dart';
import '../../model/vendor_models/model_store_availability.dart';
import '../../repository/repository.dart';
import '../../utils/api_constant.dart';
import 'add_product_controller.dart';

class VendorStoreTimingController extends GetxController{
  final Repositories repositories = Repositories();
  ModelStoreAvailable modelStoreAvailability = ModelStoreAvailable();
  ModelStoreAvailability modelStoreAvailability1 = ModelStoreAvailability();
  RxInt refreshInt = 0.obs;
  final addProductController = Get.put(AddProductController());
  getTime(id) {
    repositories.getApi(url: ApiUrls.productWeekly+id).then((value) {
      modelStoreAvailability = ModelStoreAvailable.fromJson(jsonDecode(value));
      if(modelStoreAvailability.data == null || modelStoreAvailability.data!.isEmpty){
        modelStoreAvailability.data!.addAll([
        // Data(endTime: "19:00",startTime: "09:00",weekDay: "Master",status: false),
          Data(endTime: "19:00",startTime: "09:00",weekDay: "Mon",status: false,startBreakTime : "09:00",endBreakTime: "19:00"),
          Data(endTime: "19:00",startTime: "09:00",weekDay: "Tue",status: false,startBreakTime : "09:00",endBreakTime: "19:00"),
          Data(endTime: "19:00",startTime: "09:00",weekDay: "Wed",status: false,startBreakTime : "09:00",endBreakTime: "19:00"),
          Data(endTime: "19:00",startTime: "09:00",weekDay: "Thu",status: false,startBreakTime : "09:00",endBreakTime: "19:00"),
          Data(endTime: "19:00",startTime: "09:00",weekDay: "Fri",status: false,startBreakTime : "09:00",endBreakTime: "19:00"),
          Data(endTime: "19:00",startTime: "09:00",weekDay: "Sat",status: false,startBreakTime : "09:00",endBreakTime: "19:00"),
          Data(endTime: "19:00",startTime: "09:00",weekDay: "Sun",status: false,startBreakTime : "09:00",endBreakTime: "19:00"),
        ]);
      }
      refreshInt.value = DateTime.now().millisecondsSinceEpoch;
    });
  }

  @override
  void onInit() {
    super.onInit();
    getTime( addProductController.idProduct.value.toString());
  }

}