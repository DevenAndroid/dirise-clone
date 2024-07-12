import 'dart:convert';
import 'dart:developer';
import 'package:dirise/iAmHereToSell/personalizeyourstoreScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/profile_controller.dart';
import '../../controller/service_controller.dart';
import '../../model/common_modal.dart';
import '../../model/socialMediaModel.dart';
import '../../repository/repository.dart';
import '../../utils/api_constant.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_textfield.dart';


class SocialMediaStoreAccount extends StatefulWidget {
  const SocialMediaStoreAccount({super.key});

  @override
  State<SocialMediaStoreAccount> createState() => _SocialMediaStoreAccountState();
}

class _SocialMediaStoreAccountState extends State<SocialMediaStoreAccount> {

  final controller = Get.put(ServiceController());
  final Repositories repositories = Repositories();
  socialMediaApi() {
    Map<String, dynamic> map = {};
    map['instagram'] = controller.instagramController.text.trim();
    map['youtube'] =   controller.youtubeController.text.trim();
    map['twitter'] =   controller.twitterController.text.trim();
    map['linkedin'] =  controller.linkedinController.text.trim();
    map['facebook'] =  controller.facebookController.text.trim();
    map['snapchat'] =  controller.snapchatController.text.trim();
    map['pinterest'] = controller.pinterestController.text.trim();
    map['tiktok'] =    controller.tiktokController.text.trim();
    map['threads'] =   controller.threadsController.text.trim();

    FocusManager.instance.primaryFocus!.unfocus();
    repositories.postApi(url: ApiUrls.socialMediaUrl, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      if (response.status == true) {
        showToast(response.message.toString());
        // Get.to(const PersonalizeyourstoreScreen());
      }
    });
  }

  SocialMediaModel socialMediaModel = SocialMediaModel();

  Future getSocialMedia() async {
    await repositories.getApi(url: ApiUrls.getSocialMediaUrl).then((value) {
      socialMediaModel = SocialMediaModel.fromJson(jsonDecode(value));
      log('ffffff ${socialMediaModel.socialMedia!.toJson()}');
      if(socialMediaModel.socialMedia != null){
        controller.instagramController.text = socialMediaModel.socialMedia!.instagram ?? "";
        controller.youtubeController.text = socialMediaModel.socialMedia!.youtube ?? "";
        controller.twitterController.text = socialMediaModel.socialMedia!.twitter ?? "";
        controller.linkedinController.text = socialMediaModel.socialMedia!.linkedin ?? "";
        controller.facebookController.text = socialMediaModel.socialMedia!.facebook ?? "";
        controller.snapchatController.text = socialMediaModel.socialMedia!.snapchat ?? "";
        controller.pinterestController.text  = socialMediaModel.socialMedia!.pinterest ?? "";
        controller.tiktokController.text = socialMediaModel.socialMedia!.tiktok ?? "";
        controller.threadsController.text = socialMediaModel.socialMedia!.threads ?? "";
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    getSocialMedia();

  }

  final profileController = Get.put(ProfileController());
  bool check = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: (){
            Get.back();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              profileController.selectedLAnguage.value != 'English' ?
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
            ],
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 50,
          child: CustomOutlineButton(
            title: 'Add Now'.tr,
            onPressed: () {
              socialMediaApi();
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  CommonTextField(
                    controller: controller.instagramController,
                    obSecure: false,
                    prefix: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('assets/images/instagram.png',width: 35,height: 35,),
                    ),
                    // hintText: 'Name',
                    hintText: 'Enter Your Instagram Profile Link'.tr,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Instagram link is required';
                      }

                      final regex = RegExp(
                        r'^(https?:\/\/)?(www\.)?(([\w-]+\.)*(facebook|twitter|instagram|linkedin)\.com)(\/[\w-]*)*\/?$',
                        caseSensitive: false,
                      );

                      if (!regex.hasMatch(value)) {
                        return 'Please enter a valid instagram link';
                      }

                      return null;
                    }
                    ,),
                  const SizedBox(height: 10,),
                  CommonTextField(
                      controller: controller.youtubeController,
                      obSecure: false,
                      prefix: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Image.asset('assets/images/youtube.png',width: 35,height: 35),
                      ),
                      // hintText: 'Name',
                      hintText: 'Enter Your youtube Profile Link'.tr,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Youtube link is required';
                        }

                        final regex = RegExp(
                          r'^(https?:\/\/)?(www\.)?(([\w-]+\.)*(facebook|twitter|instagram|linkedin|youtube)\.com)(\/[\w-]*)*\/?$',
                          caseSensitive: false,
                        );

                        if (!regex.hasMatch(value)) {
                          return 'Please enter a valid youtube link';
                        }

                        return null;
                      }),
                  const SizedBox(height: 10,),
                  CommonTextField(
                      controller: controller.twitterController,
                      obSecure: false,
                      prefix: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/images/twiter-new.png',width: 25,height: 25),
                      ),
                      // hintText: 'Name',
                      hintText: 'Enter Your twitter Profile Link'.tr,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Twitter link is required';
                        }

                        final regex = RegExp(
                          r'^(https?:\/\/)?(www\.)?(([\w-]+\.)*(facebook|twitter|instagram|linkedin|snapchat|pinterest|tiktok|threads)\.com)(\/[\w-]*)*\/?$',
                          caseSensitive: false,
                        );

                        if (!regex.hasMatch(value)) {
                          return 'Please enter a valid twitter link';
                        }

                        return null;
                      }
                  ),
                  const SizedBox(height: 10,),
                  CommonTextField(
                      controller: controller.linkedinController,
                      obSecure: false,
                      prefix: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/images/linkedin_new.png',width: 35,height: 35),
                      ),
                      // hintText: 'Name',
                      hintText: 'Enter Your linkedin Profile Link'.tr,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Linkedin link is required';
                        }

                        final regex = RegExp(
                          r'^(https?:\/\/)?(www\.)?(([\w-]+\.)*(facebook|twitter|instagram|linkedin|snapchat|pinterest|tiktok|threads)\.com)(\/[\w-]*)*\/?$',
                          caseSensitive: false,
                        );

                        if (!regex.hasMatch(value)) {
                          return 'Please enter a valid linkedin link';
                        }

                        return null;
                      }
                  ),
                  const SizedBox(height: 10,),
                  CommonTextField(
                      controller: controller.facebookController,
                      obSecure: false,
                      prefix: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/images/facebook_new.png',width: 35,height: 35,),
                      ),
                      // hintText: 'Name',
                      hintText: 'Enter Your facebook Profile Link'.tr,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Facebook link is required';
                        }

                        final regex = RegExp(
                          r'^(https?:\/\/)?(www\.)?(([\w-]+\.)*(facebook|twitter|instagram|linkedin|snapchat|pinterest|tiktok|threads)\.com)(\/[\w-]*)*\/?$',
                          caseSensitive: false,
                        );

                        if (!regex.hasMatch(value)) {
                          return 'Please enter a valid facebook link';
                        }

                        return null;
                      }
                  ),
                  const SizedBox(height: 10,),
                  CommonTextField(
                      controller: controller.snapchatController,
                      obSecure: false,
                      prefix:  Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/images/snap_new.png',width: 35,height: 35,),
                      ),
                      // hintText: 'Name',
                      hintText: 'Enter Your snapchat Profile Link'.tr,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Snapchat link is required';
                        }

                        final regex = RegExp(
                          r'^(https?:\/\/)?(www\.)?(([\w-]+\.)*(facebook|twitter|instagram|linkedin|snapchat|pinterest|tiktok|threads)\.com)(\/[\w-]*)*\/?$',
                          caseSensitive: false,
                        );

                        if (!regex.hasMatch(value)) {
                          return 'Please enter a valid snapchat link';
                        }

                        return null;
                      }
                  ),
                  const SizedBox(height: 10,),
                  CommonTextField(
                      controller: controller.pinterestController,
                      obSecure: false,
                      prefix:  Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/images/pinterest.png',width: 35,height: 35,),
                      ),
                      // hintText: 'Name',
                      hintText: 'Enter Your pinterest Profile Link'.tr,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Pinterest link is required';
                        }

                        final regex = RegExp(
                          r'^(https?:\/\/)?(www\.)?(([\w-]+\.)*(facebook|twitter|instagram|linkedin|snapchat|pinterest|tiktok|threads)\.com)(\/[\w-]*)*\/?$',
                          caseSensitive: false,
                        );

                        if (!regex.hasMatch(value)) {
                          return 'Please enter a valid pinterest link';
                        }

                        return null;
                      }
                  ),
                  const SizedBox(height: 10,),
                  CommonTextField(
                      controller: controller.tiktokController,
                      obSecure: false,
                      prefix: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/images/tiktok-new.png',width: 37,height: 37),
                      ),
                      // hintText: 'Name',
                      hintText: 'Enter Your tiktok Profile Link'.tr,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Tiktok link is required';
                        }

                        final regex = RegExp(
                          r'^(https?:\/\/)?(www\.)?(([\w-]+\.)*(facebook|twitter|instagram|linkedin|snapchat|pinterest|tiktok|threads)\.com)(\/[\w-]*)*\/?$',
                          caseSensitive: false,
                        );

                        if (!regex.hasMatch(value)) {
                          return 'Please enter a valid tiktok link';
                        }

                        return null;
                      }
                  ),
                  const SizedBox(height: 10,),
                  CommonTextField(
                      controller: controller.threadsController,
                      obSecure: false,
                      prefix:Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/images/threads-new.png',width: 30,height: 30),
                      ),
                      // hintText: 'Name',
                      hintText: 'Enter Your threads Profile Link'.tr,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Threads link is required';
                        }

                        final regex = RegExp(
                          r'^(https?:\/\/)?(www\.)?(([\w-]+\.)*(facebook|twitter|instagram|linkedin|snapchat|pinterest|tiktok|threads)\.com)(\/[\w-]*)*\/?$',
                          caseSensitive: false,
                        );

                        if (!regex.hasMatch(value)) {
                          return 'Please enter a valid threads link';
                        }

                        return null;
                      }
                  ),
                  const SizedBox(height: 20,),

                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}
