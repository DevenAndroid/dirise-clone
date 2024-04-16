import 'dart:convert';
import 'package:dirise/repository/repository.dart';
import 'package:get/get.dart';
import '../../model/bank_details/model_bank_details.dart';
import '../../model/bank_details/model_bank_list.dart';
import '../../utils/api_constant.dart';

class BankDetailsController extends GetxController{
  final Repositories repositories = Repositories();

  ModelBankList modelBankList = ModelBankList();
  ModelBankInfo modelBankInfo = ModelBankInfo();

  Future getBankDetails() async {
    await repositories.getApi(url: ApiUrls.accountDetailsUrl).then((value) {
      modelBankInfo = ModelBankInfo.fromJson(jsonDecode(value));
    });
  }

  Future getBankList() async {
    await repositories.getApi(url: ApiUrls.bankListUrl).then((value) {
      modelBankList = ModelBankList.fromJson(jsonDecode(value));
    });
  }

}