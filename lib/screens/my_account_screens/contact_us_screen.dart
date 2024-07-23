import 'dart:convert';

import 'package:dirise/language/app_strings.dart';
import 'package:dirise/model/common_modal.dart';
import 'package:dirise/utils/helper.dart';
import 'package:dirise/widgets/common_button.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:dirise/widgets/customsize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controller/profile_controller.dart';
import '../../model/aboutus_model.dart';
import '../../model/model_common.dart';
import '../../model/model_contact_us.dart';
import '../../repository/repository.dart';
import '../../utils/api_constant.dart';
import '../../widgets/common_textfield.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);
  static String route = "/contactUsScreen";

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {

  Rx<CommonModel> contactusModal = CommonModel().obs;
  Rx<ContactUsModel> contactusEmailModal = ContactUsModel().obs;

  Future contactUsData() async {
    Map<String, dynamic> map = {};
    map["name"] = nameController.text.trim().toString();
    map["email"] = emailController.text.trim().toString();
    map["phone"] = phoneController.text.trim().toString();
    map["company"] = companyController.text.trim().toString();
    map["message"] = messageController.text.trim().toString();
    map["platform"] = 'app';
    repositories.postApi(url: ApiUrls.contactUsUrl, mapData: map, context: context).then((value) {
      CommonModel response = CommonModel.fromJson(jsonDecode(value));
      if (response.status == true) {
        showToast(response.message.toString(), center: true);
        nameController.text = '';
        emailController.text = '';
        phoneController.text = '';
        companyController.text = '';
        messageController.text = '';
      }
      else {
        showToast(response.message.toString(), center: true);
      }
    });
  }

  final Repositories repositories = Repositories();

  contactUsEmail() {
    repositories.getApi(url: ApiUrls.getContactUsUrl).then((value) {
      contactusEmailModal.value = ContactUsModel.fromJson(jsonDecode(value));
    });
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    contactUsEmail();
  }
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final profileController = Get.put(ProfileController());
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
                    icon: profileController.selectedLAnguage.value != 'English' ?
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
                    AppStrings.contactUs.tr,
                    style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            )),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: Get.width,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF5F5F5F).withOpacity(0.4),
                      offset: const Offset(0.0, 0.5),
                      blurRadius: 2,
                    ),
                  ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Drop us a Line'.tr,
                        style: GoogleFonts.poppins(
                            color: AppTheme.buttonColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                      addHeight(5),
                      Text('Get in touch with us'.tr,
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      addHeight(20),
                      TextFormField(
                        controller: nameController,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "Please enter your name".tr;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          counterStyle: GoogleFonts.poppins(
                            color: AppTheme.primaryColor,
                            fontSize: 25,
                          ),
                          counter: const Offstage(),

                          errorMaxLines: 2,
                          contentPadding: const EdgeInsets.all(15),
                          //   fillColor: Colors.transparent,
                          hintText: 'Your Name'.tr,
                          hintStyle: GoogleFonts.poppins(
                            color: AppTheme.primaryColor,
                            fontSize: 15,
                          ),

                          border: InputBorder.none,
                          focusedErrorBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(color: AppTheme.secondaryColor)),
                          errorBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(color: AppTheme.secondaryColor)),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(color: AppTheme.secondaryColor)),
                          disabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: AppTheme.secondaryColor),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: AppTheme.secondaryColor),
                          ),
                        ),
                      ),
                      // CommonTextField(
                      //   hintText: 'Your Name'.tr,
                      //   controller: nameController,
                      //     validator: (value) {
                      //       if (value!.trim().isEmpty) {
                      //         return "Please enter your name";
                      //       }
                      //       return null;
                      //     }),
                      addHeight(7),
                      TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "Please enter your email".tr;
                          } else if (value.trim().contains('+') || value.trim().contains(' ')) {
                            return "Email is invalid".tr;
                          } else if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value.trim())) {
                            return null;
                          } else {
                            return 'Please type a valid email address'.tr;
                          }
                        },
                        decoration: InputDecoration(
                          counterStyle: GoogleFonts.poppins(
                            color: AppTheme.primaryColor,
                            fontSize: 25,
                          ),
                          counter: const Offstage(),

                          errorMaxLines: 2,
                          contentPadding: const EdgeInsets.all(15),
                          //   fillColor: Colors.transparent,
                          hintText: 'Your Email'.tr,
                          hintStyle: GoogleFonts.poppins(
                            color: AppTheme.primaryColor,
                            fontSize: 15,
                          ),

                          border: InputBorder.none,
                          focusedErrorBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(color: AppTheme.secondaryColor)),
                          errorBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(color: AppTheme.secondaryColor)),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(color: AppTheme.secondaryColor)),
                          disabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: AppTheme.secondaryColor),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: AppTheme.secondaryColor),
                          ),
                        ),
                      ),
                      // CommonTextField(
                      //   hintText: 'Your Email'.tr,
                      //   controller: emailController,
                      //   validator: (value) {
                      //     if (value!.trim().isEmpty) {
                      //       return "Please enter your email".tr;
                      //     } else if (value.trim().contains('+') || value.trim().contains(' ')) {
                      //       return "Email is invalid";
                      //     } else if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      //         .hasMatch(value.trim())) {
                      //       return null;
                      //     } else {
                      //       return 'Please type a valid email address'.tr;
                      //     }
                      //   },
                      // ),
                      addHeight(7),
                      TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "Please enter phone number".tr;
                          }
                          if (value.trim().length > 15) {
                            return "Please enter valid phone number".tr;
                          }
                          if (value.trim().length < 8) {
                            return "Please enter valid phone number".tr;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          counterStyle: GoogleFonts.poppins(
                            color: AppTheme.primaryColor,
                            fontSize: 25,
                          ),
                          counter: const Offstage(),

                          errorMaxLines: 2,
                          contentPadding: const EdgeInsets.all(15),
                          //   fillColor: Colors.transparent,
                          hintText: 'Phone Number'.tr,
                          hintStyle: GoogleFonts.poppins(
                            color: AppTheme.primaryColor,
                            fontSize: 15,
                          ),

                          border: InputBorder.none,
                          focusedErrorBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(color: AppTheme.secondaryColor)),
                          errorBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(color: AppTheme.secondaryColor)),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(color: AppTheme.secondaryColor)),
                          disabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: AppTheme.secondaryColor),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: AppTheme.secondaryColor),
                          ),
                        ),
                      ),
                      // CommonTextField(
                      //   hintText: 'Phone Number'.tr,
                      //   controller: phoneController,
                      //   keyboardType: TextInputType.phone,
                      //     validator: (value) {
                      //       if (value!.trim().isEmpty) {
                      //         return "Please enter phone number";
                      //       }
                      //       if (value.trim().length > 15) {
                      //         return "Please enter valid phone number";
                      //       }
                      //       if (value.trim().length < 8) {
                      //         return "Please enter valid phone number";
                      //       }
                      //       return null;
                      //     }),
                      addHeight(7),
                      CommonTextField(
                        hintText: 'Company'.tr,
                        controller: companyController,
                      ),
                      addHeight(7),
                      CommonTextField(
                        hintText: 'Message'.tr,
                        controller: messageController,
                        isMulti: true,
                      ),
                      addHeight(10),
                      InkWell(
                        onTap: () async {
                           if(formKey.currentState!.validate()) {
                             await contactUsData();
                           }
                        },
                        child: Container(
                          width: Get.width / 2.5,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: AppTheme.buttonColor
                          ),
                          child: Center(
                            child: Text('Send Message'.tr,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(color: const Color(0xFFFFFFFF),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                addHeight(40),
                Obx(() {
                  return contactusEmailModal.value.status == true ?
                  Container(
                    width: Get.width,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                    decoration: BoxDecoration(color: AppTheme.buttonColor, boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF5F5F5F).withOpacity(0.4),
                        offset: const Offset(0.0, 0.5),
                        blurRadius: 2,
                      ),
                    ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconColumnRowWidget(
                          iconData: 'assets/icons/phone_icon.svg',
                          title: 'Phone Number'.tr,
                          subtitle: contactusEmailModal.value.data!.helpNumber.toString(),
                          onTap: () async {
                            String phoneNumber = Uri.encodeComponent( contactusEmailModal.value.data!.helpNumber.toString());
                            Uri telUri = Uri.parse("tel:$phoneNumber");
                            if (await launchUrl(telUri)) {
                            }
                          },
                        ),
                        addHeight(30),
                        IconColumnRowWidget(
                          iconData: 'assets/icons/Icon ionic-ios-mail.svg',
                          title: 'Support email'.tr,
                          subtitle: contactusEmailModal.value.data!.supportEmail.toString(),
                          onTap: () async {
                            String email = Uri.encodeComponent(contactusEmailModal.value.data!.supportEmail.toString());
                            String subject = Uri.encodeComponent("");
                            String body = Uri.encodeComponent("");
                            //output: Hello%20Flutter
                            Uri mail = Uri.parse(
                                "mailto:$email?subject=$subject&body=$body");
                            if (await launchUrl(mail)) {

                            }
                          },
                        ),
                        addHeight(30),
                        IconColumnRowWidget(
                          iconData: 'assets/images/whatsapp.svg',
                          title: 'Chatbot'.tr,
                          subtitle: '+965 9876 2557',
                          onTap: () async {
                            String phoneNumber = contactusEmailModal.value.data!.helpNumber.toString();
                            String whatsappUrl = "https://wa.me/$phoneNumber";

                            Uri whatsappUri = Uri.parse(whatsappUrl);

                            if (await canLaunchUrl(whatsappUri)) {
                              await launchUrl(whatsappUri);
                            } else {
                              // Handle the error, e.g., show a message to the user
                              print('Could not launch $whatsappUrl');
                            }
                          },
                        ),

                        addHeight(50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap :() {
                                launchURL(contactusEmailModal.value.data!.facebook.toString());
                              },
                              child: Image.asset(
                                'assets/icons/facebook-withoutbg.png',
                                height: 30,
                              ),
                            ),
                            35.spaceX,
                            InkWell(
                              onTap: (){
                                launchURL(contactusEmailModal.value.data!.twitter.toString());
                              },
                              child: Image.asset(
                                'assets/icons/twitter_bg.png',
                                height: 30,
                                color: Colors.white,
                              ),
                            ),
                            35.spaceX,
                            InkWell(
                              onTap : (){
                                launchURL(contactusEmailModal.value.data!.instagram.toString());
                              },
                              child: Image.asset(
                                'assets/icons/insta-bg.png',
                                height: 30,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ): const SizedBox();
                }),
              ],
            ),
          ),
        ));
  }
}


class IconColumnRowWidget extends StatelessWidget {
  final String iconData;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const IconColumnRowWidget({super.key, required this.iconData, required this.title, required this.subtitle,this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 50,
            padding: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
                color: Colors.white
            ),
            child: SvgPicture.asset(
              iconData,
              width: 30,
              height: 30,
              color: AppTheme.buttonColor,
            ),
          ),
          addWidth(20),
          // Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w400
                  ),
                ),
                addHeight(2),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
