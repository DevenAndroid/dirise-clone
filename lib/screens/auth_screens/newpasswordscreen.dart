import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dirise/language/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../model/common_modal.dart';
import '../../utils/api_constant.dart';
import '../../utils/helper.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_textfield.dart';
import '../../bottomavbar.dart';
import 'login_screen.dart';

class NewPasswordScreen extends StatefulWidget {
  static String route = "/NewPasswordScreen";
  const NewPasswordScreen({Key? key}) : super(key: key);

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  String email = "";
  RxBool hide1 = true.obs;
  RxBool hide2 = true.obs;
  @override
  void initState() {
    super.initState();
    email = Get.arguments[0];
  }

  Future<ModelCommonResponse> changePasswordRepo({password, email, context}) async {
    OverlayEntry loader = Helpers.overlayLoader(context);
    Overlay.of(context).insert(loader);
    FocusManager.instance.primaryFocus!.unfocus();
    var map = <String, dynamic>{};
    map['password'] = password;
    map['email'] = email;
    var header = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json",
    };
    final response = await http.post(Uri.parse(ApiUrls.changePasswordUrl), body: jsonEncode(map), headers: header);
    if (response.statusCode == 200 || response.statusCode == 400) {
      log(response.body);
      Helpers.hideLoader(loader);
      return ModelCommonResponse.fromJson(jsonDecode(response.body));
    } else {
      Helpers.hideLoader(loader);
      throw Exception(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
                padding: const EdgeInsets.only(left: 13, right: 13),
                child: Column(children: [
                  const SizedBox(
                    height: 35,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Image(height: 80, image: AssetImage('assets/images/diriselogo.png')),
                  ),
                  SizedBox(
                    height: size.height * .08,
                  ),
                  Obx(() {
                    return CommonTextField(
                      controller: passwordController,
                      obSecure: hide1.value,
                      suffixIcon: IconButton(
                        onPressed: () {
                          hide1.value = !hide1.value;
                        },
                        icon: hide1.value ? const Icon(Icons.visibility) : const Icon(Icons.close),
                      ),
                      hintText: 'New Password'.tr,
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
                      controller: newPasswordController,
                      obSecure: hide2.value,
                      suffixIcon: IconButton(
                        onPressed: () {
                          hide2.value = !hide2.value;
                        },
                        icon: hide2.value ? const Icon(Icons.visibility) : const Icon(Icons.close),
                      ),
                      hintText: AppStrings.newPassword.tr,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Conform password is required '.tr;
                        } else if (value.trim() != passwordController.text.trim()) {
                          return 'Conform password not matching'.tr;
                        } else {
                          return null;
                        }
                      },
                    );
                  }),
                  SizedBox(
                    height: size.height * .03,
                  ),
                  CustomOutlineButton(
                    title: AppStrings.continuee.tr,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        changePasswordRepo(password: passwordController.text, email: email, context: context).then((value) {
                          if (value.status == true) {
                            showToast(value.message.toString());
                            Get.offNamed(BottomNavbar.route);
                            Get.toNamed(LoginScreen.route);
                          } else {
                            showToast(value.message.toString());
                          }
                        });
                      }
                    },
                  ),
                ])),
          ),
        ));
  }
}
