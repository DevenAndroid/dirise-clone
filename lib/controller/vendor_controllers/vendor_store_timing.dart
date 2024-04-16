import 'dart:convert';
import 'package:get/get.dart';
import '../../model/vendor_models/model_store_availability.dart';
import '../../repository/repository.dart';
import '../../utils/api_constant.dart';

class VendorStoreTimingController extends GetxController{
  final Repositories repositories = Repositories();
  ModelStoreAvailability modelStoreAvailability = ModelStoreAvailability();
  RxInt refreshInt = 0.obs;

  getTime() {
    repositories.getApi(url: ApiUrls.storeTimingUrl).then((value) {
      modelStoreAvailability = ModelStoreAvailability.fromJson(jsonDecode(value));
      if(modelStoreAvailability.data == null || modelStoreAvailability.data!.isEmpty){
        modelStoreAvailability.data!.addAll([
          TimeData(endTime: "19:00",startTime: "09:00",weekDay: "Mon",status: false),
          TimeData(endTime: "19:00",startTime: "09:00",weekDay: "Tue",status: false),
          TimeData(endTime: "19:00",startTime: "09:00",weekDay: "Wed",status: false),
          TimeData(endTime: "19:00",startTime: "09:00",weekDay: "Thu",status: false),
          TimeData(endTime: "19:00",startTime: "09:00",weekDay: "Fri",status: false),
          TimeData(endTime: "19:00",startTime: "09:00",weekDay: "Sat",status: false),
          TimeData(endTime: "19:00",startTime: "09:00",weekDay: "Sun",status: false),
        ]);
      }
      refreshInt.value = DateTime.now().millisecondsSinceEpoch;
    });
  }

  @override
  void onInit() {
    super.onInit();
    getTime();
  }

}