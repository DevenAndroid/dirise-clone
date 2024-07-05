import 'dart:async';
import 'dart:io';
import 'package:dirise/addNewProduct/internationalshippingdetailsScreem.dart';
import 'package:dirise/language/app_strings.dart';
import 'package:dirise/routers/my_routers.dart';
import 'package:dirise/screens/auth_screens/login_screen.dart';
import 'package:dirise/screens/home_pages/coustom_drawer.dart';
import 'package:dirise/screens/home_pages/homepage_screen.dart';
import 'package:dirise/screens/return_policy.dart';
import 'package:dirise/screens/wishlist/whishlist_screen.dart';
import 'package:dirise/utils/api_constant.dart';
import 'package:dirise/utils/helper.dart';
import 'package:dirise/vendor/authentication/vendor_registration_screen.dart';
import 'package:dirise/vendor/dashboard/dashboard_screen.dart';
import 'package:dirise/vendor/shipping_policy.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'addNewProduct/addProductStartScreen.dart';
import 'controller/cart_controller.dart';
import 'controller/homepage_controller.dart';
import 'controller/location_controller.dart';
import 'controller/profile_controller.dart';
import 'newAuthScreens/signupScreen.dart';
import 'screens/categories/categories_screen.dart';
import 'widgets/common_colour.dart';
import 'screens/my_account_screens/myaccount_scrren.dart';

class BottomNavbar extends StatefulWidget {
  static String route = "/BottomNavbar";
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  final bottomController = Get.put(BottomNavBarController());
  final profileController = Get.put(ProfileController());
  final cartController = Get.put(CartController());
  bool get userLoggedIn => profileController.userLoggedIn;
  final pages = [
    const HomePage(),
    const CategoriesScreen(),
    const WishListScreen(),
    const MyAccountScreen(),
  ];

  bool isLoggedIn = false;
  bool allowExitApp = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // locationController.checkGps(context);
    checkUser();
    // _showWelcomeDialog();
  }

  final locationController = Get.put(LocationController());

  Future<void> checkUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    isLoggedIn = preferences.getString('login_user') != null;
    if (mounted) setState(() {});
  }

  Future<void> _showWelcomeDialog() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool hasShownDialog = preferences.getBool('hasShownDialog') ?? false;

    if (!hasShownDialog) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await showDialog(
          context: context,
          barrierDismissible: false, // Prevents dialog from being dismissed by tapping outside
          builder: (BuildContext context) {
            return WillPopScope(
              onWillPop: () async {
                // Prevent back button from dismissing the dialog
                return false;
              },
              child: AlertDialog(
                title: const Text("Purpose of collecting location"),
                content: const Text(
                    "This app collects location data to show your current city and zip code, and also for shipping information, even when the app is closed or not in use."),
                actions: [
                  TextButton(
                    onPressed: () {
                      // Navigator.of(context).pop();
                      // showToast('message');
                      FlutterExitApp.exitApp(iosForceExit: true);

                      // if (Platform.isAndroid) {
                      //   SystemNavigator.pop();
                      // } else if (Platform.isIOS) {
                      //   showToast('message');
                      //   exit(0);
                      // }
                    },
                    child: const Text("Exit App"),
                  ),
                  TextButton(
                    onPressed: () async {
                      await preferences.setBool('hasShownDialog', true);
                      Navigator.of(context).pop();
                      locationController.checkGps(context);
                    },
                    child: const Text("Allow"),
                  ),
                ],
              ),
            );
          },
        );
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    stopTimer();
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  bool exitApp() {
    if (allowExitApp) {
      stopTimer();
      hideToast();
      return true;
    }

    allowExitApp = true;
    stopTimer();
    showToast("Press again to exit app".tr, gravity: ToastGravity.CENTER);
    _timer = Timer(const Duration(milliseconds: 500), () {
      allowExitApp = false;
    });
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (bottomController.pageIndex.value != 0) {
          bottomController.pageIndex.value = 0;
          return false;
        } else {
          return exitApp();
        }
      },
      child: Obx(() {
        return Scaffold(
          body: pages[bottomController.pageIndex.value],
          backgroundColor: const Color(0xFFEBF3F6),
          bottomNavigationBar: buildMyNavBar(),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Visibility(
            child: GestureDetector(
              onTap: () {
                if (userLoggedIn) {
                  Get.to(const AddProductOptionScreen());
                } else {
                  Get.to(const LoginScreen());
                }
              },
              child: Container(
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.2),
                  borderRadius: BorderRadius.circular(100)
                ),
                child: Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/svgs/D-Sell-Icon.svg',
                      height: 30,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget buildMyNavBar() {
    const padding = EdgeInsets.only(bottom: 7, top: 3);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SafeArea(
          bottom: true,
          child: Card(
            color: const Color(0xFFEBF3F6),
            elevation: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: MaterialButton(
                          padding: padding,
                          onPressed: () {
                            bottomController.updateIndexValue(0);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'assets/images/home_new.png',
                              width: 30,
                              color:
                                  bottomController.pageIndex.value == 0 ? AppTheme.buttonColor : AppTheme.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: MaterialButton(
                          padding: padding,
                          onPressed: () {
                            bottomController.updateIndexValue(1);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'assets/images/category_new.png',
                              width: 30,
                              color:
                                  bottomController.pageIndex.value == 1 ? AppTheme.buttonColor : AppTheme.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: MaterialButton(
                          padding: padding,
                          onPressed: () {
                            bottomController.updateIndexValue(2);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'assets/images/fav_new.png',
                              width: 30,
                              color:
                                  bottomController.pageIndex.value == 2 ? AppTheme.buttonColor : AppTheme.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: MaterialButton(
                          padding: padding,
                          onPressed: () {
                            bottomController.updateIndexValue(3);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'assets/images/profile_new.png',
                              width: 30,
                              color:
                                  bottomController.pageIndex.value == 3 ? AppTheme.buttonColor : AppTheme.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
