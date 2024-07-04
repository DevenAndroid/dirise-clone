import 'dart:convert';

import 'package:dirise/language/app_strings.dart';
import 'package:dirise/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../controller/profile_controller.dart';
import '../../model/aboutus_model.dart';
import '../../repository/repository.dart';
import '../../utils/api_constant.dart';
import '../../widgets/loading_animation.dart';

class TermConditionScreen extends StatefulWidget {
  static String route = "/TermConditionScreen";
  const TermConditionScreen({Key? key}) : super(key: key);

  @override
  State<TermConditionScreen> createState() => _TermConditionScreenState();
}

class _TermConditionScreenState extends State<TermConditionScreen> {
  Rx<AboutUsmodel> aboutusModal = AboutUsmodel().obs;
  Future aboutUsData() async {
    Map<String, dynamic> map = {};
    map["id"] = 9;
    repositories.postApi(url: ApiUrls.aboutUsUrl, mapData: map).then((value) {
      aboutusModal.value = AboutUsmodel.fromJson(jsonDecode(value));
    });
  }
  final profileController = Get.put(ProfileController());
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
                    icon:    profileController.selectedLAnguage.value != 'English' ?
                    Image.asset(
                      'assets/images/forward_icon.png',
                      height: 19,
                      width: 19,
                    ) :
                    Image.asset(
                      'assets/images/back_icon_new.png',
                      height: 19,
                      width: 19,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  10.spaceX,
                  Text(
                   AppStrings.termsCondition.tr,
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
