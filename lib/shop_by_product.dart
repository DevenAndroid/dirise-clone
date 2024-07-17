import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dirise/repository/repository.dart';
import 'package:dirise/screens/my_account_screens/contact_us_screen.dart';
import 'package:dirise/screens/product_details/product_widget.dart';
import 'package:dirise/single_products/bookable_single.dart';
import 'package:dirise/single_products/give_away_single.dart';
import 'package:dirise/single_products/simple_product.dart';
import 'package:dirise/single_products/variable_single.dart';
import 'package:dirise/utils/api_constant.dart';
import 'package:dirise/utils/helper.dart';
import 'package:dirise/utils/shimmer_extension.dart';
import 'package:dirise/utils/styles.dart';
import 'package:dirise/widgets/like_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Services/review_publish_service.dart';
import '../../addNewProduct/addProductScreen.dart';
import '../../addNewProduct/addProductStartScreen.dart';
import '../../addNewProduct/myItemIsScreen.dart';
import '../../addNewProduct/reviewPublishScreen.dart';
import '../../controller/profile_controller.dart';
import '../../controller/vendor_controllers/add_product_controller.dart';
import '../../controller/vendor_controllers/products_controller.dart';
import '../../jobOffers/JobReviewandPublishScreen.dart';
import '../../singleproductScreen/ReviewandPublishScreen.dart';
import '../../virtualProduct/ReviewandPublishScreen.dart';
import '../../widgets/common_colour.dart';
import '../../widgets/dimension_screen.dart';
import 'controller/cart_controller.dart';
import 'controller/location_controller.dart';
import 'controller/wish_list_controller.dart';
import 'model/add_current_address.dart';
import 'model/common_modal.dart';
import 'model/shop_by_Product_model.dart';


class ShopProductScreen extends StatefulWidget {
  static String route = "/ApproveProductScreen";

  const ShopProductScreen({Key? key}) : super(key: key);

  @override
  State<ShopProductScreen> createState() => _ShopProductScreenState();
}

class _ShopProductScreenState extends State<ShopProductScreen> {
  void launchURLl(String url) async {
    if (await canLaunch(url)) {
      try {
        await launch(url);
      } catch (e) {
        print('Error launching URL: $url');
        print('Exception: $e');
      }
    } else {
      print('Could not launch $url');
    }
  }

  Position? _currentPosition;
  String? _address = "";
  final cartController = Get.put(CartController());
  final wishListController = Get.put(WishListController());
  GoogleMapController? mapController;
  Size size = Size.zero;
  final Repositories repositories = Repositories();
  RxInt productQuantity = 1.obs;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery
        .of(context)
        .size;
  }

  final locationController = Get.put(LocationController());

  addCurrentAddress() {
    Map<String, dynamic> map = {};
    map['zip_code'] = locationController.zipcode.value.toString();
    print('current location${map.toString()}');
    FocusManager.instance.primaryFocus!.unfocus();
    repositories.postApi(url: ApiUrls.addCurrentAddress, context: context, mapData: map).then((value) {
      AddCorrentAddressModel response = AddCorrentAddressModel.fromJson(jsonDecode(value));
      cartController.countryId = response.data!.countryId.toString();
      // showToast(response.message.toString());
      // getAllAsync();
      // homeController.trendingData();
      // homeController.popularProductsData();
    });
  }

  Future<void> getAddressFromLatLng(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    if (placemarks != null && placemarks.isNotEmpty) {
      Placemark placemark = placemarks[0];

      setState(() {
        locationController.zipcode.value = placemark.postalCode ?? '';
        locationController.street = placemark.street ?? '';
        locationController.city.value = placemark.locality ?? '';
        locationController.state = placemark.administrativeArea ?? '';
        locationController.countryName = placemark.country ?? '';
        locationController.town = placemark.subAdministrativeArea ?? '';
        // showToast(locationController.countryName.toString());
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('street', placemark.street ?? '');
      await prefs.setString('city', placemark.locality ?? '');
      await prefs.setString('state', placemark.administrativeArea ?? '');
      await prefs.setString('country', placemark.country ?? '');
      await prefs.setString('zipcode', placemark.postalCode ?? '');
      await prefs.setString('town', placemark.subAdministrativeArea ?? '');
    }

    // errorApi();
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

  Future<bool> handleLocationPermission() async {
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

  // addToWishList() {
  //   repositories
  //       .postApi(
  //       url: ApiUrls.addToWishListUrl,
  //       mapData: {
  //         "product_id": widget.productElement.id.toString(),
  //       },
  //       context: context)
  //       .then((value) {
  //     // widget.onLiked(true);
  //     ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
  //     showToast(response.message);
  //     if (response.status == true) {
  //       wishListController.getYourWishList();
  //       wishListController.favoriteItems.add(widget.productElement.id.toString());
  //       wishListController.updateFav;
  //     }
  //   });
  // }
  bool hasShownDialog = false;

  // removeFromWishList() {
  //   repositories
  //       .postApi(
  //       url: ApiUrls.removeFromWishListUrl,
  //       mapData: {
  //         "product_id": widget.productElement.id.toString(),
  //       },
  //       context: context)
  //       .then((value) {
  //     // widget.onLiked(false);
  //     ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
  //     showToast(response.message);
  //     if (response.status == true) {
  //       wishListController.getYourWishList();
  //       wishListController.favoriteItems.removeWhere((element) => element == widget.productElement.id.toString());
  //       wishListController.updateFav;
  //     }
  //   });
  // }
  Future<void> _getCurrentPosition() async {
    final hasPermission = await handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position position) {
      setState(() => _currentPosition = position);
      getAddressFromLatLng(_currentPosition!);
      mapController!.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude), zoom: 15)));
      // _onAddMarkerButtonPressed(LatLng(_currentPosition!.latitude, _currentPosition!.longitude), "current location");
      setState(() {});
      // homeController.trendingData();
      // homeController.popularProductsData();
      // location = _currentAddress!;
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }

  final productController = Get.put(ProductsController());

  int paginationPage = 1;
  ShopByProductModel modelCategoryStores = ShopByProductModel();

  Future getProductList() async {
    String url = ApiUrls.shopByProductUrl;
    // List<String> params = [];
    // if(textEditingController.text.trim().isNotEmpty){
    //   params.add("search=${textEditingController.text.trim()}");
    // }
    // params.add("page=$page");
    // if (selectedValue1 != null && selectedValue1.toString().isNotEmpty) {
    //   params.add("filter_type=${selectedValue1 == "All"?"":selectedValue1.toString()}");
    // }

    await repositories.getApi(
        url: "${url}page=1&pagination=10&category_id=$categoryID&key=fedexRate&country_id=117&zip_code=99999",
        showResponse: true).then((value) {
      // apiLoaded = true;
      modelCategoryStores = ShopByProductModel.fromJson(jsonDecode(value));
      // updateUI;
    });
  }

  bool allLoaded = false;
  bool paginationLoading = false;
  var categoryID = Get.arguments;

  final controller = Get.put(AddProductController(), permanent: true);


  Timer? timer;

  // String? selectedValue;
  //
  // final List<String> dropdownItems = [
  //   'Giveaway',
  //   'Product',
  //   'Job',
  //   'Service',
  //   'Virtual',
  // ];
  debounceSearch() {
    if (timer != null) timer!.cancel();
    timer = Timer(const Duration(milliseconds: 500), () {
      productController.getProductList1(context: context);
    });
  }

  @override
  void initState() {
    super.initState();
    getProductList();
    // SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
    //
    // });
  }

  @override
  void dispose() {
    super.dispose();
    if (timer != null) {
      timer!.cancel();
    }
  }

  String publish = '';
  final addProductController = Get.put(AddProductController());
  final profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F4F4),
      appBar: AppBar(
        title: Text('All Approved Product'.tr,
            style: GoogleFonts.poppins(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: const Color(0xff423E5E),
            )),

        leading: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: profileController.selectedLAnguage.value != 'English' ?
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
              ),
            ),
          ],
        ),
      ),
      body:  modelCategoryStores.status == true
    ?     SizedBox(
        height: 200,
      child: ListView.builder(
        itemCount: modelCategoryStores.product!.data!.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          final item = modelCategoryStores.product!.data![index];
          return ProductUI(
            isSingle: false,
            productElement: item,
            onLiked: (value) {
              modelCategoryStores.product!.data![index].inWishlist = value;
            },
          ).animate(delay: 50.ms).fade(duration: 400.ms);
        },
      ),
    )
        : Center(child: CircularProgressIndicator()),

    );
  }


}
