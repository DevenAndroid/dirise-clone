import 'dart:convert';

import 'package:dirise/language/app_strings.dart';
import 'package:dirise/utils/helper.dart';
import 'package:dirise/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/aboutus_model.dart';
import '../../model/faq_model.dart';
import '../../repository/repository.dart';
import '../../utils/api_constant.dart';

class FrequentlyAskedQuestionsScreen extends StatefulWidget {
  static String route = "/FrequentlyAskedQuestionsScreen";
  const FrequentlyAskedQuestionsScreen({Key? key}) : super(key: key);

  @override
  State<FrequentlyAskedQuestionsScreen> createState() => _FrequentlyAskedQuestionsScreenState();
}

class _FrequentlyAskedQuestionsScreenState extends State<FrequentlyAskedQuestionsScreen> {
  bool senderExpansion = true;
  // Rx<AboutUsmodel> aboutusModal = AboutUsmodel().obs;
  Rx<FaqModel> faqModel = FaqModel().obs;
  // Future aboutUsData() async {
  //   Map<String, dynamic> map = {};
  //   map["id"] = 11;
  //   repositories.postApi(url: ApiUrls.aboutUsUrl, mapData: map).then((value) {
  //     aboutusModal.value = AboutUsmodel.fromJson(jsonDecode(value));
  //   });
  // }
  Future getFaqData() async {

    repositories.getApi(url: ApiUrls.faqListUrl).then((value) {
      faqModel.value = FaqModel.fromJson(jsonDecode(value));
    });
  }

  final Repositories repositories = Repositories();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // aboutUsData();
    getFaqData();
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(140),
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
                   AppStrings.faq.tr,
                    style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            )),
        body: Obx(() {
          return faqModel.value.status == true
              ? SingleChildScrollView(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                     shrinkWrap: true,
                      itemCount: faqModel.value.faq!.length,
                      padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 10),
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 15),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xFFDCDCDC),
                                  width: 1
                                ),
                                borderRadius: BorderRadius.circular(8), ),
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                  unselectedWidgetColor: Colors.white,
                                  colorScheme: const ColorScheme.light(
                                    primary: Colors.black,
                                  ),
                                  dividerColor: Colors.transparent,
                                ),
                                child: ExpansionTile(
                                  childrenPadding: const EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                                  trailing: faqModel.value.faq![index].isOpen == true ? const Icon(Icons.remove) :const Icon(Icons.add),
                                  title: Text(faqModel.value.faq![index].question.toString(),
                                    style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                  children: [
                                    Html(
                                      data: faqModel.value.faq![index].answer.toString(),
                                      onLinkTap: (url, attributes, element) {
                                        launchURL(url!);
                                      },
                                    ),
                                  ],
                                  onExpansionChanged: (value){
                                    setState(() {
                                      faqModel.value.faq![index].isOpen = value;
                                    });
                                  },
                                ),
                              ),
                            )
                          ],
                        );
                      },
                  ),
                )
              : const LoadingAnimation();
        }));
  }
}
