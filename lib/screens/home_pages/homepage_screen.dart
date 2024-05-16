import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dirise/screens/home_pages/star_of_month.dart';
import 'package:dirise/utils/helper.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../controller/cart_controller.dart';
import '../../controller/home_controller.dart';
import '../../controller/location_controller.dart';
import '../../controller/profile_controller.dart';
import '../../language/app_strings.dart';
import '../../model/common_modal.dart';
import '../../repository/repository.dart';
import '../../utils/api_constant.dart';
import '../../vendor/authentication/vendor_plans_screen.dart';
import '../../vendor/dashboard/dashboard_screen.dart';
import '../../vendor/dashboard/store_open_time_screen.dart';
import '../../vendor/orders/vendor_order_list_screen.dart';
import '../../vendor/payment_info/bank_account_screen.dart';
import '../../vendor/payment_info/withdrawal_screen.dart';
import '../../vendor/products/all_product_screen.dart';
import '../../widgets/cart_widget.dart';
import '../auth_screens/login_screen.dart';
import '../search_products.dart';
import 'ad_banner.dart';
import 'add-edit-address.dart';
import 'addedit_withlogin.dart';
import 'authers.dart';
import 'popular_products.dart';
import 'category_items.dart';
import 'slider.dart';
import 'trending_products.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = Get.put(TrendingProductsController());
  final cartController = Get.put(CartController());
  final Completer<GoogleMapController> googleMapController = Completer();
  GoogleMapController? mapController;

  String? _address = "";
  Position? _currentPosition;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    if (placemarks != null && placemarks.isNotEmpty) {
      Placemark placemark = placemarks[0];

      setState(() {
        locationController.street = placemark.street ?? '';
        locationController.city.value = placemark.locality ?? '';
        locationController.state = placemark.administrativeArea ?? '';
        locationController.countryName = placemark.country ?? '';
        locationController.zipcode.value = placemark.postalCode ?? '';
        locationController.town = placemark.subAdministrativeArea ?? '';
      });
    }
    await placemarkFromCoordinates(_currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _address = '${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
      mapController!.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude), zoom: 15)));
      // _onAddMarkerButtonPressed(LatLng(_currentPosition!.latitude, _currentPosition!.longitude), "current location");
      setState(() {});
      // location = _currentAddress!;
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }

  Future getAllAsync() async {
    if (!mounted) return;
    homeController.homeData();
    if (!mounted) return;
    homeController.getVendorCategories();
    if (!mounted) return;
    homeController.trendingData();
    if (!mounted) return;
    homeController.popularProductsData();
    if (!mounted) return;
    homeController.authorData();
    if (!mounted) return;
  }

  showVendorDialog() {
    if (Platform.isAndroid) {
      showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              insetPadding: const EdgeInsets.symmetric(horizontal: 20),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppStrings.vendorRegister,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    10.spaceY,
                    TextButton(
                        onPressed: () {
                          Get.back();
                          Get.toNamed(
                            LoginScreen.route,
                          );
                        },
                        child: Text(AppStrings.createAccount))
                  ],
                ),
              ),
            );
          });
      return;
    }
    if (Platform.isIOS) {
      showDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text(
                "${'To register as vendor partner need to '.tr}"
                    "${'create an account first.'.tr}",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              actions: [
                CupertinoDialogAction(
                    onPressed: () {
                      Get.back();
                      Get.toNamed(
                        LoginScreen.route,
                      );
                    },
                    child: Text("Create Account".tr))
              ],
            );
          });
      return;
    }
  }

  final RxBool _isValue = false.obs;
  var vendor = ['Dashboard', 'Order', 'Products', 'Store open time', 'Bank Details', 'Earnings'];
  var vendorRoutes = [
    VendorDashBoardScreen.route,
    VendorOrderList.route,
    VendorProductScreen.route,
    SetTimeScreen.route,
    BankDetailsScreen.route,
    WithdrawMoney.route,
  ];
  final locationController = Get.put(LocationController());
  final Repositories repositories = Repositories();

  @override
  void initState() {
    super.initState();
    locationController.checkGps(context);
    profileController.aboutUsData();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      getAllAsync();
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getCurrentPosition();
    });
  }

  final profileController = Get.put(ProfileController());

  List<Widget> vendorPartner() {
    return [
      // GestureDetector(
      //   onTap: () {
      //     if (profileController.model.user == null) {
      //       showVendorDialog();
      //       return;
      //     }
      //     if (profileController.model.user!.isVendor != true) {
      //       Get.to(() => const VendorPlansScreen());
      //       return;
      //     }
      //     if (profileController.model.user!.isVendor == true) {
      //       Get.to(() => const VendorDashBoardScreen());
      //       return;
      //     }
      //     _isValue.value = !_isValue.value;
      //     setState(() {});
      //   },
      //   child: Container(
      //     alignment: Alignment.center,
      //     padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      //     height: 40,
      //     decoration: BoxDecoration(
      //         borderRadius: BorderRadius.circular(8),
      //         color: Colors.white
      //     ),
      //     child: Row(
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         SvgPicture.asset('assets/icons/plus_icon.svg', height: 25, color: AppTheme.buttonColor),
      //         const SizedBox(
      //           width: 6,
      //         ),
      //         Text(
      //           'Sell'.tr,
      //           style: GoogleFonts.poppins(color: AppTheme.buttonColor, fontSize: 17, fontWeight: FontWeight.w500),
      //         ),
      //         const SizedBox(
      //           width: 3,
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      // _isValue.value == true
      //     ? Obx(() {
      //   if (profileController.refreshInt.value > 0) {}
      //`
      //   return profileController.model.user != null
      //       ? Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children:
      //         ? List.generate(
      //         vendor.length,
      //             (index) => Row(
      //           children: [
      //             const SizedBox(
      //               width: 30,
      //             ),
      //             // Expanded(
      //             //   child: TextButton(
      //             //     onPressed: () {
      //             //       Get.toNamed(vendorRoutes[index]);
      //             //     },
      //             //     style: TextButton.styleFrom(
      //             //         visualDensity: const VisualDensity(vertical: -3, horizontal: -3),
      //             //         padding: EdgeInsets.zero.copyWith(left: 16)),
      //             //     child: Row(
      //             //       children: [
      //             //         Expanded(
      //             //           child: Text(
      //             //             vendor[index],
      //             //             style: GoogleFonts.poppins(
      //             //                 fontSize: 16,
      //             //                 fontWeight: FontWeight.w400,
      //             //                 color: Colors.grey.shade500),
      //             //           ),
      //             //         ),
      //             //         const Icon(
      //             //           Icons.arrow_forward_ios_rounded,
      //             //           size: 14,
      //             //         )
      //             //       ],
      //             //     ),
      //             //   ),
      //             // ),
      //           ],
      //         ))
      //         : [],
      //   )
      //       : const SizedBox();
      // })
      //     : const SizedBox(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: kToolbarHeight + 10,
          backgroundColor: AppTheme.buttonColor,
          surfaceTintColor: AppTheme.buttonColor,
          title: const Padding(
            padding: EdgeInsets.only(left: 0),
            child: SizedBox(
              height: kToolbarHeight - 14,
              child: Image(
                  color: Colors.white,
                  image: AssetImage(
                    'assets/images/diries logo.png',
                  )),
            ),
          ),
          actions: [
            ...vendorPartner(),
            const CartBagCard(),
          ],
        ),
        backgroundColor: AppTheme.buttonColor,
        body: RefreshIndicator(
            onRefresh: () async {
              await getAllAsync();
            },
            child: Column(
              children: [
                Container(
                  color: AppTheme.buttonColor,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      profileController.userLoggedIn ?
                      locationController.zipcode.isNotEmpty ?
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Address',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            4.spaceY,
                            GestureDetector(onTap: () {
                              Get.to(() => const HomeAddEditAddressLogin(), arguments: 'home');
                            }, child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/location.svg',
                                  height: 20,
                                  color: Colors.white,
                                ),
                                5.spaceX,
                                Flexible(
                                    child: Obx(() {
                                      return Text(
                                        "Deliver to ${locationController.city.toString()} , ${locationController.zipcode ??
                                            ''}",
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      );
                                    })
                                ),
                                5.spaceX,
                                SvgPicture.asset(
                                  'assets/images/pencilImg.svg',
                                  height: 18,
                                  color: Colors.white,
                                ),
                              ],
                            )
                            ),
                          ],
                        ),
                      ) : const SizedBox.shrink() :
                      locationController.zipcode.isNotEmpty ?
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Address',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            4.spaceY,
                            GestureDetector(onTap: () {
                              Get.to(() => HomeAddEditAddress(), arguments: 'home');
                            }, child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/location.svg',
                                  height: 20,
                                  color: Colors.white,
                                ),
                                5.spaceX,
                                Flexible(
                                  child: Obx(() {
                                    return Text(
                                      "Deliver to ${locationController.city.toString()} , ${locationController.zipcode
                                          .toString()}",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    );
                                  }),
                                ),
                                5.spaceX,
                                SvgPicture.asset(
                                  'assets/images/pencilImg.svg',
                                  height: 18,
                                  color: Colors.white,
                                ),
                              ],
                            )
                            ),
                          ],
                        ),
                      ) : const SizedBox.shrink(),
                      10.spaceY,
                      Hero(
                        tag: "search_tag",
                        child: Material(
                          color: Colors.transparent,
                          surfaceTintColor: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: TextField(
                              maxLines: 1,
                              style: GoogleFonts.poppins(fontSize: 16),
                              textInputAction: TextInputAction.search,
                              onSubmitted: (vb) {
                                Get.to(() =>
                                    SearchProductsScreen(
                                      searchText: vb,
                                    ));
                              },
                              decoration: InputDecoration(
                                  filled: true,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Image.asset(
                                      'assets/icons/search.png',
                                      height: 5,
                                    ),
                                  ),
                                  border: InputBorder.none,
                                  enabledBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(8)),
                                      borderSide: BorderSide(color: AppTheme.buttonColor)),
                                  disabledBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(8)),
                                      borderSide: BorderSide(color: AppTheme.buttonColor)),
                                  focusedBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(8)),
                                      borderSide: BorderSide(color: AppTheme.buttonColor)),
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.all(15),
                                  hintText: AppStrings.searchFieldText.tr,
                                  hintStyle:
                                  GoogleFonts.poppins(color: AppTheme.buttonColor, fontWeight: FontWeight.w400)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: const SingleChildScrollView(
                        child: Column(children: [
                          SliderWidget(),
                          CategoryItems(),
                          TrendingProducts(),
                          AdBannerUI(),
                          PopularProducts(),
                          StarOfMonthScreen(),
                          AuthorScreen(),
                          SizedBox(
                            height: 30,
                          ),
                        ])),
                  ),
                ),
              ],
            )));
  }
}
