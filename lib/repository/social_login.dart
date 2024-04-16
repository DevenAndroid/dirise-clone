import 'dart:io';
import 'package:dirise/utils/api_constant.dart';

import '../model/social_login_model.dart';
import '../utils/helper.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


Future<SocialLoginModel> socialLogin({required provider, required token, required BuildContext context}) async {
  var map = <String, dynamic>{};
  map['provider'] = provider;
  map['access_token'] = token;

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };

  http.Response response = await http.post(Uri.parse(ApiUrls.socialLoginUrl), body: jsonEncode(map), headers: headers);
  print(response.body);
  if (response.statusCode == 200 || response.statusCode == 400) {
    return SocialLoginModel.fromJson(json.decode(response.body));
  } else {
    Helpers.createSnackBar(context, response.statusCode.toString());
    throw Exception(response.body);
  }
}