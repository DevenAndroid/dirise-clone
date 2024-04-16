import 'dart:convert';

import 'package:dirise/language/app_strings.dart';
import 'package:dirise/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/profile_controller.dart';
import '../../model/aboutus_model.dart';
import '../../repository/repository.dart';
import '../../utils/api_constant.dart';

class ReturnPolicyScreen extends StatefulWidget {
  const ReturnPolicyScreen({Key? key}) : super(key: key);
  static String route = "/ReturnPolicyScreen";

  @override
  State<ReturnPolicyScreen> createState() => _ReturnPolicyScreenState();
}

class _ReturnPolicyScreenState extends State<ReturnPolicyScreen> {
  bool senderExpansion = true;
  Rx<AboutUsmodel> aboutusModal = AboutUsmodel().obs;
  final profileController = Get.put(ProfileController());
  Future aboutUsData() async {
    Map<String, dynamic> map = {};
    map["id"] = 14;
    repositories.postApi(url: ApiUrls.aboutUsUrl, mapData: map).then((value) {
      aboutusModal.value = AboutUsmodel.fromJson(jsonDecode(value));
    });
  }

  final Repositories repositories = Repositories();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    aboutUsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: SafeArea(
              child: Row(
                children: [
                  IconButton(
                    icon: Image.asset(
                      'assets/icons/backicon.png',
                      height: 25,
                      width: 25,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Text(
                    AppStrings.returnPolicy.tr,
                    style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            )),
        body: Obx(() {
          return aboutusModal.value.status == true
              ? SingleChildScrollView(
            child: profileController.selectedLAnguage.value == 'English' ?
            Html(data: aboutusModal.value.data!.content!) : Html(data: aboutusModal.value.data!.arabContent!),
                )
              : const LoadingAnimation();
        }));
  }
}
