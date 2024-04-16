import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/login_model.dart';
import '../model/vendor_models/model_vendor_dashboard.dart';
import '../utils/api_constant.dart';

Future<ModelVendorDashboard> dashboardRepo() async {
String userInfo = "login_user";
  LoginModal model = LoginModal();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  if (preferences.getString(userInfo) != null) {
    model = LoginModal.fromJson(jsonDecode(preferences.getString(userInfo)!));
  }
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    if (model.token != null) HttpHeaders.authorizationHeader: 'Bearer ${model.token}'
  };
  try {
    http.Response response = await http.post(
      Uri.parse(ApiUrls.vendorDashBoardUrl),
      headers: headers,
    );

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return ModelVendorDashboard.fromJson(jsonDecode(response.body));
    } else {
      print(jsonDecode(response.body));
      return ModelVendorDashboard(
        message: jsonDecode(response.body)["message"],
        status: false,
      );
    }
  } catch (e) {
    return ModelVendorDashboard(message: e.toString(), status: false, );
  }
}
