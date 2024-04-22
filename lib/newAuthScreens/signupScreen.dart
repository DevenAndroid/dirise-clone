import 'dart:convert';
import 'package:dirise/language/app_strings.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_textfield.dart';
import '../model/common_modal.dart';
import '../repository/repository.dart';
import '../screens/auth_screens/otp_screen.dart';
import '../utils/api_constant.dart';
import 'newOtpScreen.dart';

class CreateAccountNewScreen extends StatefulWidget {
  static String route = "/CreateAccountScreen";

  const CreateAccountNewScreen({Key? key}) : super(key: key);

  @override
  State<CreateAccountNewScreen> createState() => _CreateAccountNewScreenState();
}

class _CreateAccountNewScreenState extends State<CreateAccountNewScreen> {
  final formKey1 = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _referralEmailController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  RxBool hide = true.obs;
  RxBool hide1 = true.obs;
  bool showValidation = false;
  bool? _isValue = false;
  final Repositories repositories = Repositories();
  String code = "+91";
  registerApi() {
    if (_isValue == false) return;
    Map<String, dynamic> map = {};
    map['first_name'] = firstNameController.text.trim();
    map['last_name'] = lastNameController.text.trim();
    map['email'] = _emailController.text.trim();
    map['password'] = _passwordController.text.trim();
    map['confirm_password'] = _confirmPasswordController.text.trim();
    map['phone'] = phoneNumberController.text.trim();
    map['phone_country_code'] = code;
    FocusManager.instance.primaryFocus!.unfocus();
    repositories.postApi(url: ApiUrls.newRegisterUrl, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      if (response.status == true) {
        Get.toNamed(NewOtpScreen.route, arguments: [_emailController.text, true, map]);
      }
    });
  }

  _makingPrivacyPolicy() async {
    var url = Uri.parse('https://diriseapp.com/en/privacy-policy/');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  _termsCondition() async {
    var url = Uri.parse('https://diriseapp.com/en/terms-and-conditions/');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: const Icon(
          Icons.arrow_back_ios_new,
          color: Color(0xff0D5877),
          size: 16,
        ),
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.signUp.tr,
              style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
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
                    controller: firstNameController,
                    obSecure: false,
                    // hintText: 'Name',
                    hintText: AppStrings.firstName.tr,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'First Name is required'.tr),
                    ])),
                SizedBox(
                  height: size.height * .01,
                ),
                CommonTextField(
                    controller: lastNameController,
                    obSecure: false,
                    // hintText: 'Name',
                    hintText: AppStrings.lastName.tr,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Last Name is required'.tr),
                    ])),
                SizedBox(
                  height: size.height * .01,
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
                IntlPhoneField(
                  dropdownIcon: const Icon(Icons.arrow_drop_down_rounded, color: Colors.black),
                  flagsButtonPadding: const EdgeInsets.all(8),
                  dropdownIconPosition: IconPosition.trailing,
                  controller: phoneNumberController,
                  style: const TextStyle(color: Colors.black),
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'Please enter your phone number'.tr),
                  ]).call,
                  dropdownTextStyle: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'Enter your Mobile number'.tr,
                    hintStyle: const TextStyle(color: AppTheme.secondaryColor),
                    filled: true,
                    enabled: true,
                    enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppTheme.secondaryColor)),
                    focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppTheme.secondaryColor)),
                    iconColor: Colors.black,
                    errorBorder: const OutlineInputBorder(borderSide: BorderSide(width: 1)),
                    fillColor: const Color(0x63ffffff).withOpacity(.2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(width: 1, color: Colors.black),
                    ),
                    disabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppTheme.secondaryColor)),
                  ),
                  onCountryChanged: (Country phone) {
                    setState(() {
                      code = "+${phone.dialCode}";
                      if (kDebugMode) {
                        print(code.toString());
                      }
                    });
                  },
                  initialCountryCode: 'IE',
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.number,
                ),
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
                          errorText:
                          'Password must be at least 8 characters, with 1 special character & 1 numerical'.tr),
                      // MaxLengthValidator(16, errorText: "Password maximum length is 16"),
                      PatternValidator(r"(?=.*\W)(?=.*?[#?!@()$%^&*-_])(?=.*[0-9])",
                          errorText:
                          "Password must be at least 8 characters, with 1 special character & 1 numerical".tr),
                    ]),
                  );
                }),
                SizedBox(
                  height: size.height * .01,
                ),
                Obx(() {
                  return CommonTextField(
                    obSecure: hide1.value,
                    controller: _confirmPasswordController,
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
                    hintText: 'Referral Point (Optional)'.tr,
                    validator: MultiValidator([
                      //RequiredValidator(errorText: 'Referral email is required'),
                      EmailValidator(errorText: 'Please enter valid Referral Point'.tr),
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
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'By clicking Register, you agree to the DIRISE'.tr,
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500, fontSize: 13, color: const Color(0xff808384)),
                            ),
                            TextSpan(
                              text: ' Terms of Service and'.tr,
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500, fontSize: 13, color: const Color(0xff808384)),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  _termsCondition(); // Call your method here
                                },
                            ),
                            TextSpan(
                              text: ' Privacy Policy'.tr,
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500, fontSize: 13, color: const Color(0xff808384)),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  _makingPrivacyPolicy(); // Call your method here
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * .03,
                ),
                CustomOutlineButton(
                  title: AppStrings.register,
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
                            fontWeight: FontWeight.w600,
                            color: AppTheme.buttonColor,
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.back();
                          },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * .02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Container(
                      height: 62,
                      width: 62,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.apple,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * .02,
                    ),
                    Container(
                      height: 62,
                      width: 62,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xffCACACA), width: 2)),
                      child: Center(
                        child: Image.asset(
                          'assets/icons/google.png',
                          height: 27,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
