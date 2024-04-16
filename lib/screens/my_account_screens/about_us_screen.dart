import 'dart:convert';

import 'package:dirise/language/app_strings.dart';
import 'package:dirise/utils/helper.dart';
import 'package:dirise/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../controller/profile_controller.dart';
import '../../model/aboutus_model.dart';
import '../../repository/repository.dart';
import '../../utils/api_constant.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);
  static String route = "/AboutUsScreen";

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {

  final profileController = Get.put(ProfileController());
  final Repositories repositories = Repositories();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileController.aboutUsData();
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
                  10.spaceX,
                  Text(
                    AppStrings.aboutUs.tr,
                    style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            )),
        body: Obx(() {
          return profileController.aboutusModal.value.status == true
              ? SingleChildScrollView(
            child: profileController.selectedLAnguage.value == 'English' ?
            Html(data: profileController.aboutusModal.value.data!.content!) : Html(data: profileController.aboutusModal.value.data!.arabContent!),
                )
              : const SizedBox();
        }));
  }
}
