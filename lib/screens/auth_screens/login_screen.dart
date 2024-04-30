import 'dart:convert';
import 'dart:developer';

import 'dart:io';
import 'package:dirise/language/app_strings.dart';
import 'package:dirise/utils/styles.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:dirise/widgets/common_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../controller/profile_controller.dart';
import '../../model/login_model.dart';
import '../../model/social_login_model.dart';
import '../../newAuthScreens/signupScreen.dart';
import '../../repository/repository.dart';
import '../../repository/social_login.dart';
import '../../routers/my_routers.dart';
import '../../utils/api_constant.dart';
import '../../widgets/common_button.dart';
import '../../bottomavbar.dart';
import 'createacc_screen.dart';
import 'forgetpass_screen.dart';

class LoginScreen extends StatefulWidget {
  static String route = "/LoginScreen";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool isRemember = false;
  late Box box1;

  void getData() async {
    if (box1.get('email') != null) {
      emailController.text = box1.get('email');
      isRemember = true;
      setState(() {});
    }
    if (box1.get('pass') != null) {
      passwordController.text = box1.get('pass');
      isRemember = true;
      setState(() {});
    }
  }

  final loginFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final Repositories repositories = Repositories();
  final profileController = Get.put(ProfileController());
  RxBool hide = true.obs;
  RxString messageForEmail = ''.obs;
  RxString messageForPass = ''.obs;
  String? token = "";

  loginUserApi() async {
    String? token1 = await FirebaseMessaging.instance.getAPNSToken();
    String? token = await FirebaseMessaging.instance.getToken();
    print('token iss ${token.toString()}');
    if (loginFormKey.currentState!.validate()) {
// if(Platform.isIOS){
//   String? token = await FirebaseMessaging.instance.getAPNSToken();
// }
// if(Platform.isAndroid){
//   String? token = await FirebaseMessaging.instance.getAPNSToken();
// }
      if (isRemember) {
        box1.put('email', emailController.text.trim());

        box1.put('pass', passwordController.text.trim());
      }
      if (!isRemember) {
        box1.delete('email');
        box1.delete('pass');
      }
      FocusManager.instance.primaryFocus!.unfocus();
      Map<String, dynamic> map = {};
      map['email'] = emailController.text.trim();
      map['password'] = passwordController.text.trim();
      // map['fcm_token'] = Platform.isAndroid?token:token1;
      map['fcm_token'] = token;
      repositories.postApi(url: ApiUrls.loginUrl, context: context, mapData: map).then((value) async {
        LoginModal response = LoginModal.fromJson(jsonDecode(value));
        repositories.saveLoginDetails(jsonEncode(response));
        messageForEmail.value = response.message.toString();
        messageForPass.value = response.message.toString();
        print('messageForEmail ${messageForEmail}');
        print('messageForEmail ${messageForPass}');
        // showToast(response.message.toString());
        if (response.status == true) {
          Get.offAllNamed(BottomNavbar.route);
        }
      });
    }
  }

  Future<void> _signInWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final OAuthProvider oAuthProvider = OAuthProvider('apple.com');
      final AuthCredential credential1 = oAuthProvider.credential(
        idToken: credential.identityToken, accessToken: credential.authorizationCode,
      );

      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential1);

      // Navigate to the next screen or perform any other actions upon successful login
    } catch (error) {
      // Handle login errors
      print('Failed to sign in with Apple: $error');
    }
  }

  void createBox() async {
    box1 = await Hive.openBox('logindata');
    getData();
  }

  @override
  void initState() {
    super.initState();
    createBox();
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
        leading: IconButton(
          icon: Image.asset(
            'assets/icons/backicon.png',
            height: 25,
            width: 25,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        return Form(
          key: loginFormKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Image(
                        height: 70,
                        image: AssetImage(
                          'assets/images/diriselogo.png',
                        )),
                  ),
                  SizedBox(
                    height: size.height * .1,
                  ),
                  CommonTextField(
                    controller: emailController,
                    obSecure: false,
                    hintText: AppStrings.phoneNumber.tr,
                    onChanged: (va) {
                       messageForEmail.value = '';
                      setState(() {

                      });
                    },
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Please enter your email".tr;
                      } else if (value.trim().contains('+') || value.trim().contains(' ')) {
                        return "Email is invalid";
                      } else if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value.trim())) {
                        return null;
                      } else {
                        return 'Please type a valid email address'.tr;
                      }
                    },
                  ),
                  messageForEmail.value == 'Email is incorrect' ? Align(
                      alignment: Alignment.topLeft, child: Text(messageForEmail.toString(), style: const TextStyle(
                      color: Colors.red
                  ),)) : const SizedBox.shrink(),
                  SizedBox(
                    height: size.height * .01,
                  ),
                  Obx(() {
                    return CommonTextField(
                      controller: passwordController,
                      obSecure: hide.value,
                      suffixIcon: IconButton(
                        onPressed: () {
                          hide.value = !hide.value;
                        },
                        icon: hide.value ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                      ),
                      hintText: AppStrings.password.tr,
                      onChanged: (va){
                        messageForPass.value = '';
                        setState(() {

                        });
                      },
                      validator: (value) {
                        if (value!.trim().isEmpty) return AppStrings.passwordRequired.tr;
                        return null;
                      },
                    );
                  }),
                  messageForPass.value == 'Password is incorrect' ? Align(
                      alignment: Alignment.topLeft, child: Text(messageForPass.toString(), style: const TextStyle(
                      color: Colors.red
                  ),)) : const SizedBox.shrink(),

                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: Checkbox(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            visualDensity: VisualDensity.comfortable,
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            value: isRemember,
                            onChanged: (value) {
                              isRemember = !isRemember;
                              setState(() {

                              });
                            }),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text('Remember me', style: titleStyle),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomOutlineButton(
                    title: AppStrings.signIn.tr,
                    onPressed: () {
                      loginUserApi();
                      // loginWithApple();
                    },
                  ),
                  SizedBox(
                    height: size.height * .02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.toNamed(ForgetPasswordScreen.route);
                        },
                        child: Text(
                          AppStrings.forgotPassword.tr,
                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: AppTheme.buttonColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(
                            height: 20,
                            thickness: 1,
                            indent: 5,
                            endIndent: 5,
                            color: Color(
                              0xffDCDCDC,
                            )),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          AppStrings.signInWith.tr,
                          style: GoogleFonts.poppins(color: AppTheme.buttonColor),
                        ),
                      ),
                      const Expanded(
                        child: Divider(
                            height: 20,
                            thickness: 1,
                            indent: 5,
                            endIndent: 5,
                            color: Color(
                              0xffDCDCDC,
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if(Platform.isIOS)
                        InkWell(
                          onTap: () {
                            loginWithApple1();
                            // _signInWithApple();
                          },
                          child: Container(
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
                        ),
                      const SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () {
                          signInWithGoogle();
                        },
                        child: Container(
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
                      ),
                      // const SizedBox(
                      //   width: 20,
                      // ),
                      // InkWell(
                      //   child: Container(
                      //     height: 62,
                      //     width: 62,
                      //     decoration:
                      //         BoxDecoration(borderRadius: BorderRadius.circular(10), color: const Color(0xff0B60A8)),
                      //     child: Center(
                      //       child: Image.asset(
                      //         'assets/icons/facebook.png',
                      //         height: 27,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * .03,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: AppStrings.noAccount.tr,
                          style: GoogleFonts.poppins(color: Colors.black),
                        ),
                        TextSpan(
                          text: AppStrings.signUp.tr,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: AppTheme.buttonColor,
                              decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.to(const CreateAccountNewScreen());
                            },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  signInWithGoogle() async {
    var fcmToken = await FirebaseMessaging.instance.getToken();
    await GoogleSignIn().signOut();
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      Map<String, dynamic> map = {};
      map['provider'] = "google";
      map['access_token'] = value.credential!.accessToken!;
      repositories.postApi(url: ApiUrls.socialLoginUrl, context: context, mapData: map).then((value) async {
        LoginModal response = LoginModal.fromJson(jsonDecode(value));
        repositories.saveLoginDetails(jsonEncode(response));
        if (response.status == true) {
          showToast(response.message.toString());
          profileController.userLoggedIn = true;
          Get.offAllNamed(BottomNavbar.route);
        } else {
          showToast(response.message.toString());
        }
      });
    });
  }

  signInWithGoogle1() async {
    await GoogleSignIn().signOut();
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    print("Token---------${googleAuth.accessToken}");
    final value = await FirebaseAuth.instance.signInWithCredential(credential);
    log('tokkeeeem${value.credential!.accessToken!}');
    Map<String, dynamic> map = {};
    map['provider'] = "google";
    map['access_token'] = value.credential!.accessToken!;
    repositories.postApi(url: ApiUrls.socialLoginUrl, context: context, mapData: map).then((value) async {
      LoginModal response = LoginModal.fromJson(jsonDecode(value));
      repositories.saveLoginDetails(jsonEncode(response));
      if (response.status == true) {
        showToast(response.message.toString());
        profileController.userLoggedIn = true;
        Get.offAllNamed(BottomNavbar.route);
      } else {
        showToast(response.message.toString());
      }
    });
    // socialLogin(provider: "google", token: value.credential!.accessToken!, context: context).then((value) async {
    //   if (value.status == true) {
    //     SharedPreferences pref = await SharedPreferences.getInstance();
    //     pref.setString('login_user', jsonEncode(value));
    //     showToast(value.message);
    //     Get.offAllNamed(BottomNavbar.route);
    //   } else {
    //     showToast(value.message);
    //   }
    // });
  }

  // loginWithApple() async {
  //   var fcmToken = await FirebaseMessaging.instance.getToken();
  //   final appleProvider = AppleAuthProvider().addScope("email").addScope("FullName");
  //   await FirebaseAuth.instance.signInWithProvider(appleProvider).then((value) async {
  //
  //     log(value.credential!.accessToken.toString());
  //     Map<String, dynamic> map = {};
  //     map['provider'] =  "apple";
  //     map['access_token'] = value.credential!.accessToken!;
  //     repositories.postApi(url: ApiUrls.socialLoginUrl, context: context, mapData: map).then((value) async {
  //       LoginModal response = LoginModal.fromJson(jsonDecode(value));
  //       repositories.saveLoginDetails(jsonEncode(response));
  //       if (response.status == true) {
  //         showToast(response.message.toString());
  //         profileController.userLoggedIn = true;
  //         Get.offAllNamed(BottomNavbar.route);
  //       } else {
  //         showToast(response.message.toString());
  //       }
  //     });
  // });
  // }
  loginWithApple1() async {
    var fcmToken = await FirebaseMessaging.instance.getToken();
    final appleProvider = AppleAuthProvider().addScope("email").addScope("FullName");
    await FirebaseAuth.instance.signInWithProvider(appleProvider).then((value) async {
      log(value.credential!.accessToken.toString());
      Map<String, dynamic> map = {};
      map['provider'] = "apple";
      map['access_token'] = value.credential!.accessToken!;
      repositories.postApi(url: ApiUrls.socialLoginUrl, context: context, mapData: map).then((value) async {
        LoginModal response = LoginModal.fromJson(jsonDecode(value));
        repositories.saveLoginDetails(jsonEncode(response));
        if (response.status == true) {
          showToast(response.message.toString());
          profileController.userLoggedIn = true;
          Get.offAllNamed(BottomNavbar.route);
        } else {
          showToast(response.message.toString());
        }
      });
    });
  }
//   loginWithApple1() async {
//     log("Hello from apple ");
//     final appleProvider = AppleAuthProvider().addScope("email").addScope("fullName");
//     await FirebaseAuth.instance.signInWithProvider(appleProvider).then((value) async {
//
//       log("Tokenisss -------${value.credential!.accessToken}");
//       Map<String, dynamic> map = {};
//       map['provider'] =  "apple";
//       map['access_token'] = value.credential!.accessToken!;
//       repositories.postApi(url: ApiUrls.socialLoginUrl, context: context, mapData: map).then((value) async {
//         LoginModal response = LoginModal.fromJson(jsonDecode(value));
//         repositories.saveLoginDetails(jsonEncode(response));
//         if (response.status == true) {
//           showToast(response.message.toString());
//           profileController.userLoggedIn = true;
//           Get.offAllNamed(BottomNavbar.route);
//         } else {
//           showToast(response.message.toString());
//         }
//       });
//   });
// }
}
