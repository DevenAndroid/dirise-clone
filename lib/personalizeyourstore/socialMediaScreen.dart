import 'dart:convert';
import 'dart:developer';

import 'package:dirise/iAmHereToSell/personalizeyourstoreScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/common_modal.dart';
import '../model/socialMediaModel.dart';
import '../repository/repository.dart';
import '../utils/api_constant.dart';
import '../widgets/common_button.dart';
import '../widgets/common_textfield.dart';

class SocialMediaStore extends StatefulWidget {
  const SocialMediaStore({super.key});

  @override
  State<SocialMediaStore> createState() => _SocialMediaStoreState();
}

class _SocialMediaStoreState extends State<SocialMediaStore> {
  TextEditingController instagramController = TextEditingController();
  TextEditingController youtubeController = TextEditingController();
  TextEditingController twitterController = TextEditingController();
  TextEditingController linkedinController = TextEditingController();
  TextEditingController facebookController = TextEditingController();
  TextEditingController snapchatController = TextEditingController();
  TextEditingController pinterestController = TextEditingController();
  TextEditingController tiktokController = TextEditingController();
  TextEditingController threadsController = TextEditingController();

  final Repositories repositories = Repositories();
  socialMediaApi() {
    Map<String, dynamic> map = {};
    map['instagram'] = instagramController.text.trim();
    map['youtube'] = youtubeController.text.trim();
    map['twitter'] = twitterController.text.trim();
    map['linkedin'] = linkedinController.text.trim();
    map['facebook'] = facebookController.text.trim();
    map['snapchat'] = snapchatController.text.trim();
    map['pinterest'] = pinterestController.text.trim();
    map['tiktok'] = tiktokController.text.trim();
    map['threads'] = threadsController.text.trim();

    FocusManager.instance.primaryFocus!.unfocus();
    repositories.postApi(url: ApiUrls.socialMediaUrl, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      if (response.status == true) {
        showToast(response.message.toString());
        Get.to(PersonalizeyourstoreScreen());
      }
    });
  }

  SocialMediaModel socialMediaModel = SocialMediaModel();

  Future getSocialMedia() async {
    await repositories.getApi(url: ApiUrls.getSocialMediaUrl).then((value) {
      socialMediaModel = SocialMediaModel.fromJson(jsonDecode(value));
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    getSocialMedia();
    log('fffffff'+socialMediaModel.message.toString());
  }

  bool check = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xff0D5877),
            size: 16,
          ),
        ),
        // actions: [
        //   GestureDetector(
        //       onTap: () {
        //         check = true;
        //         setState(() {});
        //         print(check.toString());
        //       },
        //       child: const Padding(
        //         padding: EdgeInsets.only(right: 10),
        //         child: Icon(Icons.add_circle_outline),
        //       ))
        // ],
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Social media'.tr,
              style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              socialMediaModel.socialMedia != null ?
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Instagram :- ${socialMediaModel.socialMedia!.instagram.toString() ?? ""}'),
                  const SizedBox(height: 10,),
                  Text('Linkedin :- ${socialMediaModel.socialMedia!.linkedin.toString() ?? ""}'),
                  const SizedBox(height: 10,),
                  Text('Pinterest :- ${socialMediaModel.socialMedia!.pinterest.toString() ?? ""}'),
                  const SizedBox(height: 10,),
                  Text('Snapchat :- ${socialMediaModel.socialMedia!.snapchat.toString() ?? ""}'),
                  const SizedBox(height: 10,),
                  Text('Threads :- ${socialMediaModel.socialMedia!.threads.toString() ?? ""}'),
                  const SizedBox(height: 10,),
                  Text('Twitter :- ${socialMediaModel.socialMedia!.twitter.toString() ?? ""}'),
                  const SizedBox(height: 10,),
                  Text('Tiktok :- ${socialMediaModel.socialMedia!.tiktok.toString() ?? ""}'),
                  const SizedBox(height: 10,),
                  Text('Youtube :- ${socialMediaModel.socialMedia!.youtube.toString() ?? ""}'),


                ],
              ) : CircularProgressIndicator(),
              const SizedBox(
                height: 20,
              ),
              check == true
                  ? Column(
                      children: [
                        CommonTextField(
                            controller: instagramController,
                            obSecure: false,
                            // hintText: 'Name',
                            hintText: 'Enter Your Instagram Username'.tr,
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'Instagram Username is required'.tr),
                            ])),
                        CommonTextField(
                            controller: youtubeController,
                            obSecure: false,
                            // hintText: 'Name',
                            hintText: 'Enter Your youtube Username'.tr,
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'youtube Username is required'.tr),
                            ])),
                        CommonTextField(
                            controller: twitterController,
                            obSecure: false,
                            // hintText: 'Name',
                            hintText: 'Enter Your twitter Username'.tr,
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'twitter Username is required'.tr),
                            ])),
                        CommonTextField(
                            controller: linkedinController,
                            obSecure: false,
                            // hintText: 'Name',
                            hintText: 'Enter Your linkedin Username'.tr,
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'linkedin Username is required'.tr),
                            ])),
                        CommonTextField(
                            controller: facebookController,
                            obSecure: false,
                            // hintText: 'Name',
                            hintText: 'Enter Your facebook Username'.tr,
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'facebook Username is required'.tr),
                            ])),
                        CommonTextField(
                            controller: snapchatController,
                            obSecure: false,
                            // hintText: 'Name',
                            hintText: 'Enter Your snapchat Username'.tr,
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'snapchat Username is required'.tr),
                            ])),
                        CommonTextField(
                            controller: pinterestController,
                            obSecure: false,
                            // hintText: 'Name',
                            hintText: 'Enter Your pinterest Username'.tr,
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'pinterest Username is required'.tr),
                            ])),
                        CommonTextField(
                            controller: tiktokController,
                            obSecure: false,
                            // hintText: 'Name',
                            hintText: 'Enter Your tiktok Username'.tr,
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'tiktok Username is required'.tr),
                            ])),
                        CommonTextField(
                            controller: threadsController,
                            obSecure: false,
                            // hintText: 'Name',
                            hintText: 'Enter Your threads Username'.tr,
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'threads Username is required'.tr),
                            ])),
                        CustomOutlineButton(
                          title: 'Add Now',
                          onPressed: () {
                            socialMediaApi();
                          },
                        ),
                      ],
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
