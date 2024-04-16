import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/login_model.dart';
import '../model/vendor_models/model_add_tax.dart';
import '../utils/api_constant.dart';

Future<ModelAddTax> taxDataList() async {
  String userInfo = "login_user";
  LoginModal model = LoginModal();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  if (preferences.getString(userInfo) != null) {
    model = LoginModal.fromJson(jsonDecode(preferences.getString(userInfo)!));
  } else {
    throw Exception();

  }
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  //  HttpHeaders.authorizationHeader: 'Bearer ${userInfo.}'
  };

  final response =
  await http.get(Uri.parse(ApiUrls.taxDataUrl), headers: headers);

  if (response.statusCode == 200) {
    print("Allergens data List Repository...${response.body}");
    return ModelAddTax.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(response.body);
  }
}