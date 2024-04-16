import 'dart:convert';
import 'package:dirise/language/app_strings.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../model/common_modal.dart';
import '../../repository/repository.dart';
import '../../utils/api_constant.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_textfield.dart';
import 'otp_screen.dart';

class CreateAccountScreen extends StatefulWidget {
  static String route = "/CreateAccountScreen";
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final formKey1 = GlobalKey<FormState>();

  // final TextEditingController _nameController = TextEditingController();
  RxBool hide = true.obs;
  RxBool hide1 = true.obs;
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _referralEmailController = TextEditingController();

  final Repositories repositories = Repositories();
  bool showValidation = false;
  bool? _isValue = false;

  registerApi() {
    if (_isValue == false) return;
    Map<String, dynamic> map = {};
    map['email'] = _emailController.text.trim();
    map['phone'] = _mobileNumberController.text.trim();
    map['password'] = _passwordController.text.trim();
    map['referral_email'] = _referralEmailController.text;
    FocusManager.instance.primaryFocus!.unfocus();
    repositories.postApi(url: ApiUrls.signInUrl, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      if (response.status == true) {
        Get.toNamed(OtpScreen.route, arguments: [_emailController.text, true, map]);
      }
    });
  }
  _makingPrivacyPolicy() async {
    var url = Uri.parse('https://diriseapp.com/en/privacy-policy/');
    if (await canLaunchUrl(url)) {
      await launchUrl(url,mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
  _termsCondition() async {
    var url = Uri.parse('https://diriseapp.com/en/terms-and-conditions/');
    if (await canLaunchUrl(url)) {
      await launchUrl(url,mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  void dispose() {
    super.dispose();
    // _nameController.dispose();
    _mobileNumberController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset(
            'assets/icons/backicon.png',
            height: 25,
            width: 25,
          ),
          onPressed: () => Get.back(),
        ),
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
           AppStrings.createAccount.tr,
              style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 22),
            ),
          ],
        ),
      ),
      body: Form(
        key: formKey1,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Image(height: 70, image: AssetImage('assets/images/diriselogo.png')),
                ),
                SizedBox(
                  height: size.height * .08,
                ),
                CommonTextField(
                    controller: _emailController,
                    obSecure: false,
                    // hintText: 'Name',
                    hintText: AppStrings.email.tr,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Email is required'.tr),
                      EmailValidator(errorText: 'Please enter valid email address'.tr),
                    ])),
                SizedBox(
                  height: size.height * .01,
                ),
                Obx(() {
                  return CommonTextField(
                    controller: _passwordController,
                    hintText: AppStrings.password.tr,
                    obSecure: hide.value,
                    suffixIcon: IconButton(
                      onPressed: () {
                        hide.value = !hide.value;
                      },
                      icon: hide.value ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                    ),
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Please enter your password'.tr),
                      MinLengthValidator(8,
                          errorText: 'Password must be at least 8 characters, with 1 special character & 1 numerical'.tr),
                      // MaxLengthValidator(16, errorText: "Password maximum length is 16"),
                      PatternValidator(r"(?=.*\W)(?=.*?[#?!@()$%^&*-_])(?=.*[0-9])",
                          errorText: "Password must be at least 8 characters, with 1 special character & 1 numerical".tr),
                    ]),
                  );
                }),
                SizedBox(
                  height: size.height * .01,
                ),
                Obx(() {
                  return CommonTextField(
                    obSecure: hide1.value,
                    suffixIcon: IconButton(
                      onPressed: () {
                        hide1.value = !hide1.value;
                      },
                      icon: hide1.value ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                    ),
                    hintText: AppStrings.confirmPassword.tr,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return AppStrings.enterConfirmPassword.tr;
                      }
                      if (value.trim() != _passwordController.text.trim()) {
                        return AppStrings.enterReType.tr;
                      }
                      return null;
                    },
                  );
                }),
                SizedBox(
                  height: size.height * .01,
                ),
                CommonTextField(
                    controller: _referralEmailController,
                    obSecure: false,
                    // hintText: 'Name',
                    hintText: 'Referral Email'.tr,
                    validator: MultiValidator([
                      //RequiredValidator(errorText: 'Referral email is required'),
                      EmailValidator(errorText: 'Please enter valid Referral email'.tr),
                    ])),
                SizedBox(
                  height: size.height * .01,
                ),
                Row(
                  children: [
                    Transform.translate(
                      offset: const Offset(-6, 0),
                      child: Checkbox(
                          visualDensity: const VisualDensity(horizontal: -1, vertical: -3),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          value: _isValue,
                          side: BorderSide(
                            color: showValidation == false ? AppTheme.buttonColor : Colors.red,
                          ),
                          onChanged: (bool? value) {
                            setState(() {
                              _isValue = value;
                            });
                          }),
                    ),
                    GestureDetector(
                      onTap: (){
                        _makingPrivacyPolicy();
                      },
                      child: Text(
                        'Privacy Policy'.tr,
                        style:
                        GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 15, color: const Color(0xff808384)),
                      ),
                    ),
                    SizedBox(width: size.width * .01,),
                    Text(
                      '&',
                      style:
                      GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 15, color: const Color(0xff808384)),
                    ),
                    SizedBox(width: size.width * .01,),
                    GestureDetector(
                      onTap: (){
                        _termsCondition();
                      },
                      child: Text(
                        'Terms and Conditions'.tr,
                        style:
                        GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 15, color: const Color(0xff808384)),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * .03,
                ),
                CustomOutlineButton(
                  title: AppStrings.createAccount,
                  onPressed: () {
                    showValidation = true;
                    if (formKey1.currentState!.validate()) {
                      registerApi();
                    }
                    setState(() {});
                  },
                ),
                SizedBox(
                  height: size.height * .02,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: AppStrings.alreadyAccount.tr,
                        style: GoogleFonts.poppins(color: Colors.black),
                      ),
                      TextSpan(
                        text: AppStrings.login.tr,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600, color: AppTheme.buttonColor, decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.back();
                          },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
