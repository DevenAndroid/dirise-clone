import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dirise/model/common_modal.dart';
import 'package:dirise/repository/repository.dart';
import 'package:dirise/single_products/give_away_single.dart';
import 'package:dirise/utils/helper.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controller/cart_controller.dart';
import '../../controller/home_controller.dart';
import '../../controller/location_controller.dart';
import '../../controller/profile_controller.dart';
import '../../controller/wish_list_controller.dart';
import '../../model/add_current_address.dart';
import '../../model/model_single_product.dart';
import '../../model/order_models/model_direct_order_details.dart';
import '../../model/product_model/model_product_element.dart';
import '../../model/simple_product_model.dart';
import '../../single_products/advirtising_single.dart';
import '../../single_products/bookable_single.dart';
import '../../single_products/simple_product.dart';
import '../../single_products/variable_single.dart';
import '../../utils/api_constant.dart';
import '../../utils/styles.dart';
import '../../widgets/common_colour.dart';
import '../../widgets/like_button.dart';
import '../check_out/direct_check_out.dart';
import '../my_account_screens/contact_us_screen.dart';
import 'single_product.dart';

class ProductUI extends StatefulWidget {
  final ProductElement productElement;
  final Function(bool gg) onLiked;
  bool isSingle = false;
  ProductUI({super.key, required this.productElement, required this.onLiked,required this.isSingle});

  @override
  State<ProductUI> createState() => _ProductUIState();
}

class _ProductUIState extends State<ProductUI> {
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

  final cartController = Get.put(CartController());
  final wishListController = Get.put(WishListController());
  GoogleMapController? mapController;
  Size size = Size.zero;
  final Repositories repositories = Repositories();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
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
      homeController.trendingData();
      homeController.popularProductsData();
    });
  }
  final homeController = Get.put(TrendingProductsController());
  Future getAllAsync() async {
    if (!mounted) return;
    homeController.homeData();
    if (!mounted) return;
    profileController.getDataProfile();
    if (!mounted) return;
    homeController.getVendorCategories();
    if (!mounted) return;
    homeController.authorData();
    if (!mounted) return;
    cartController.myDefaultAddressData();
    if (!mounted) return;
    homeController.featuredStores();
    if (!mounted) return;
    homeController.showCaseProductsData();
    if (!mounted) return;
    homeController.trendingData();
    if (!mounted) return;
    homeController.popularProductsData();
    if (!mounted) return;
  }
  Position? _currentPosition;
  String? _address = "";
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
      homeController.trendingData();
      homeController.popularProductsData();
      // location = _currentAddress!;
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
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
  addToWishList() {
    repositories
        .postApi(
        url: ApiUrls.addToWishListUrl,
        mapData: {
          "product_id": widget.productElement.id.toString(),
        },
        context: context)
        .then((value) {
      widget.onLiked(true);
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message);
      if (response.status == true) {
        wishListController.getYourWishList();
        wishListController.favoriteItems.add(widget.productElement.id.toString());
        wishListController.updateFav;
      }
    });
  }
  bool hasShownDialog = false;
  removeFromWishList() {
    repositories
        .postApi(
        url: ApiUrls.removeFromWishListUrl,
        mapData: {
          "product_id": widget.productElement.id.toString(),
        },
        context: context)
        .then((value) {
      widget.onLiked(false);
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message);
      if (response.status == true) {
        wishListController.getYourWishList();
        wishListController.favoriteItems.removeWhere((element) => element == widget.productElement.id.toString());
        wishListController.updateFav;
      }
    });
  }

  ////data
  final TextEditingController selectedDate = TextEditingController();
  bool get isBookingProduct => productElement.productType == "booking";
  bool get isVirtualProduct => productElement.productType == "virtual_product";
  String selectedSlot = "";
  bool get isVariantType => productElement.productType == "variants";

  bool get isVirtualProductAudio => productElement.virtualProductType == "voice";
  ModelSingleProduct modelSingleProduct = ModelSingleProduct();
  final GlobalKey slotKey = GlobalKey();
  final formKey = GlobalKey<FormState>();
  bool validateSlots() {
    if (showValidation == false) {
      showValidation = true;
      setState(() {});
    }

    selectedDate.checkEmpty;

    if (isBookingProduct) {
      if (modelSingleProduct.product == null) {
        showToast("Please wait loading available slots");
        return false;
      }
      if (modelSingleProduct.product!.serviceTimeSloat == null) {
        showToast("Slots are not available");
        return false;
      }
      if (selectedSlot.isEmpty) {
        slotKey.currentContext!.navigate;
        showToast("Please select slot");
        return false;
      }
      return true;
    }
    if (isVariantType) {
      if (selectedVariant == null) {
        showToast("Please select Variation");
        return false;
      }
    }
    return true;
  }

  RxInt productQuantity = 1.obs;
  ProductElement get productDetails => productElement;
  bool showValidation = false;
  Map<String, dynamic> get getMap {
    Map<String, dynamic> map = {};
    map["product_id"] = productDetails.id.toString();
    map["quantity"] = productQuantity.value.toString();
    // map["key"] = 'fedexRate';
    // map["country_id"]=profileController.model.user!.country_id;

    if (isBookingProduct) {
      map["start_date"] = selectedDate.text.trim();
      map["time_sloat"] = selectedSlot.split("--").first;
      map["sloat_end_time"] = selectedSlot.split("--").last;
    }
    if (isVariantType) {
      map["variation"] = selectedVariant!.id.toString();
    }
    return map;
  }

  ProductElement productElement = ProductElement();
  // final Repositories repositories = Repositories();
  List<String> imagesList = [];
  RxInt currentIndex = 0.obs;
  Variants? selectedVariant;

  bool get canBuyProduct => productElement.addToCart == true;
  final profileController = Get.put(ProfileController());
  directBuyProduct() {
    if (!validateSlots()) return;
    Map<String, dynamic> map = {};
    map["product_id"] = widget.productElement.id.toString();
    map["quantity"] = map["quantity"] = int.tryParse(productQuantity.value.toString());

    map["key"] = 'fedexRate';
    map["country_id"] =
    profileController.model.user!= null ? profileController.model.user!.country_id ?? '117' : '117';

    if (isBookingProduct) {
      map["start_date"] = selectedDate.text.trim();
      map["time_sloat"] = selectedSlot.split("--").first;
      map["sloat_end_time"] = selectedSlot.split("--").last;
    }
    if (isVariantType) {
      map["variation"] = selectedVariant!.id.toString();
    }
    repositories.postApi(url: ApiUrls.buyNowDetailsUrl, mapData: map, context: context).then((value) {
      print('product...');
      cartController.directOrderResponse.value  = ModelDirectOrderResponse.fromJson(jsonDecode(value));

      showToast(cartController.directOrderResponse.value.message.toString());
      if (cartController.directOrderResponse.value.status == true) {
        cartController.directOrderResponse.value.prodcutData!.inStock = productQuantity.value;
        log('daadadda${cartController.directOrderResponse.value.toJson()}');
        if (kDebugMode) {
          print(cartController.directOrderResponse.value.prodcutData!.inStock);
        }
        // Get.toNamed(DirectCheckOutScreen.route, arguments: response);
        Get.toNamed(DirectCheckOutScreen.route);
      }
    });
  }

  addToCartProduct() {
    if (!validateSlots()) return;
    Map<String, dynamic> map = {};
    map["product_id"] = widget.productElement.id.toString();
    map["quantity"] = map["quantity"] = int.tryParse(productQuantity.value.toString());
    map["key"] = 'fedexRate';
    map["country_id"] =  profileController.model.user!= null && cartController.countryId.isEmpty ? profileController.model.user!.country_id : cartController.countryId.toString();

    if (isBookingProduct) {
      map["start_date"] = selectedDate.text.trim();
      map["time_sloat"] = selectedSlot.split("--").first;
      map["sloat_end_time"] = selectedSlot.split("--").last;
    }
    if (isVariantType) {
      map["variation"] = selectedVariant!.id.toString();
    }
    repositories.postApi(url: ApiUrls.addToCartUrl, mapData: map, context: context).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      if (response.status == true) {
        widget.isSingle == false ? Get.back(): '';
        cartController.getCart();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          print(widget.productElement.id);

          if (widget.productElement.itemType == 'giveaway') {
            Get.to(() => const GiveAwayProduct(), arguments: widget.productElement.id.toString());
          }
          else if (widget.productElement.productType == 'variants'&& widget.productElement.itemType == 'product') {
            Get.to(() => const VarientsProductScreen(), arguments: widget.productElement.id.toString());
          }
          else if (widget.productElement.productType == 'booking'&& widget.productElement.itemType == 'product') {
            Get.to(() => const BookableProductScreen(), arguments: widget.productElement.id.toString());
          }
          else if (widget.productElement.itemType == 'product') {
            Get.to(() => const SimpleProductScreen(), arguments: widget.productElement.id.toString());
          }
        },
      child:  widget.productElement.itemType != 'giveaway' &&   widget.productElement.isShowcase != true
          ? Padding(
        padding: const EdgeInsets.all(5.0),
        child:

        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              color: Colors.white, boxShadow: [
            BoxShadow(
              blurStyle: BlurStyle.outer,
              offset: Offset(1, 1),
              color: Colors.black12,
              blurRadius: 3,
            )
          ]),
          constraints: BoxConstraints(
            // maxHeight: 100,
            minWidth: 0,
            maxWidth: size.width * .8,
          ),
          // color: Colors.red,
          margin: const EdgeInsets.only(right: 9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.productElement.discountOff !=  '0.00'?
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(color: const Color(0xFFFF6868), borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Text(
                          " SALE".tr,
                          style: GoogleFonts.poppins(
                              fontSize: 12, fontWeight: FontWeight.w700, color: const Color(0xFFFFDF33)),
                        ),
                        Text(
                          " ${widget.productElement.discountOff}${'%'}  ",
                          style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white),
                        ),
                      ],
                    ),
                  ) :const SizedBox.shrink(),
                  Obx(() {
                    if (wishListController.refreshFav.value > 0) {}
                    return LikeButtonCat(
                      onPressed: () {
                        if (wishListController.favoriteItems.contains(widget.productElement.id.toString())) {
                          removeFromWishList();
                        } else {
                          addToWishList();
                        }
                      },
                      isLiked: wishListController.favoriteItems.contains(widget.productElement.id.toString()),
                    );
                  }),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Center(
                          child: CachedNetworkImage(
                              imageUrl: widget.productElement.featuredImage.toString(),
                              height: 150,
                              fit: BoxFit.fill,
                              errorWidget: (_, __, ___) => Image.asset('assets/images/new_logo.png')),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                widget.productElement.pName.toString(),
                maxLines: 2,
                style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: const Color(0xFF19313C)),
              ),
              const SizedBox(
                height: 3,
              ),

              widget.productElement.itemType != 'giveaway'
                  ? Row(
                children: [
                  widget.productElement.discountOff !=  '0.00'? Expanded(
                    child: Text(
                      'KWD ${widget.productElement.pPrice.toString()}',
                      style: GoogleFonts.poppins(
                          decorationColor: Colors.red,
                          decorationThickness: 2,
                          decoration: TextDecoration.lineThrough,
                          color: const Color(0xff19313B),
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ): const SizedBox.shrink(),
                  const SizedBox(
                    width: 7,
                  ),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: '${widget.productElement.discountPrice.toString().split('.')[0]}.',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF19313B),
                        ),
                        children: [
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  'KWD',
                                  style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF19313B),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    print("date:::::::::::" + widget.productElement.shippingDate);
                                  },
                                  child: Text(
                                    '${widget.productElement.discountPrice.toString().split('.')[1]}',
                                    style: const TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF19313B),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
                  : const SizedBox.shrink(),

              const SizedBox(
                height: 8,
              ),

              widget.productElement.inStock == "-1"?const SizedBox.shrink():
              Text(

                '${'QTY'}: ${widget.productElement.inStock} ${'piece'}',
                style: normalStyle,
              ),
              // if (canBuyProduct)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RatingBar.builder(
                          initialRating: double.parse(widget.productElement.rating.toString()),
                          minRating: 1,
                          direction: Axis.horizontal,
                          updateOnDrag: true,
                          tapOnlyMode: false,
                          ignoreGestures: true,
                          allowHalfRating: true,
                          itemSize: 20,
                          itemCount: 5,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            size: 8,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                        // ,Text(
                        //   '${widget.productElement.inStock.toString()} ${'pieces'.tr}',
                        //   style: GoogleFonts.poppins(color: Colors.grey.shade700, fontSize: 15,fontWeight: FontWeight.w500),
                        // ),
                        const SizedBox(
                          height: 7,
                        ),
                        if(Platform.isAndroid)
                          widget.productElement.shippingDate != "No Internation Shipping Available"
                              ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'shipping',
                                style: GoogleFonts.poppins(
                                    color: const Color(0xff858484), fontSize: 13, fontWeight: FontWeight.w500),
                              ),
                              if (widget.productElement.lowestDeliveryPrice != null)
                                Text(
                                  'KWD${widget.productElement.lowestDeliveryPrice.toString()}',
                                  style: GoogleFonts.poppins(
                                      color: const Color(0xff858484), fontSize: 13, fontWeight: FontWeight.w500),
                                ),
                              if (widget.productElement.shippingDate != null)
                                Text(
                                  widget.productElement.shippingDate.toString(),
                                  style: GoogleFonts.poppins(
                                      color: const Color(0xff858484), fontSize: 13, fontWeight: FontWeight.w500),
                                ),
                            ],
                          )
                              : GestureDetector(
                            onTap: () {
                              Get.to(() => const ContactUsScreen());
                            },
                            child: RichText(
                              text: TextSpan(
                                  text: 'international shipping not available',
                                  style: GoogleFonts.poppins(
                                      color: const Color(0xff858484), fontSize: 13, fontWeight: FontWeight.w500),
                                  children: [
                                    TextSpan(
                                        text: ' contact us',
                                        style: GoogleFonts.poppins(
                                            decoration: TextDecoration.underline,
                                            color: AppTheme.buttonColor,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500)),
                                    TextSpan(
                                        text: ' for the soloution',
                                        style: GoogleFonts.poppins(
                                            color: const Color(0xff858484),
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500)),
                                  ]),
                            ),
                          ),
                        // Text("vendor doesn't ship internationally, contact us for the soloution",  style: GoogleFonts.poppins(
                        //     color: const Color(0xff858484),
                        //     fontSize: 13,
                        //     fontWeight: FontWeight.w500),),
                        if(Platform.isIOS)
                          widget.productElement.shippingDate != "No Internation Shipping Available"
                              ?  Expanded(
                            child: Text.rich(
                              TextSpan(
                                text: 'Shipping: ',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF19313B),
                                ),
                                children: [
                                  if (widget.productElement.lowestDeliveryPrice != null)
                                    WidgetSpan(
                                      alignment: PlaceholderAlignment.middle,
                                      child:  Text(
                                        widget.productElement.lowestDeliveryPrice.toString(),
                                        style:  GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    child: Text(
                                      ' KWD ',
                                      style:  GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  const WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    child: Text(
                                      ' & Estimated arrival by ',
                                      style: TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF19313B),
                                      ),
                                    ),
                                  ),
                                  WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    child:  Text(
                                      widget.productElement.shippingDate ?? '',
                                      style:  GoogleFonts.poppins(
                                        fontSize: 14,
                                        letterSpacing: 0.5,
                                        height: 2,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ) :
                          GestureDetector(
                            onTap: () async {

                              SharedPreferences preferences = await SharedPreferences.getInstance();
                              hasShownDialog = preferences.getBool('hasShownDialog') ?? false;
                              // Get.to(() => const ContactUsScreen());
                              await preferences.setBool('hasShownDialog', true);
                              _getCurrentPosition();
                              addCurrentAddress();

                            },
                            child: RichText(
                              text: TextSpan(
                                  text: 'international shipping not available',
                                  style: GoogleFonts.poppins(
                                      color: const Color(0xff858484), fontSize: 13, fontWeight: FontWeight.w500),
                                  children: [
                                    TextSpan(
                                        text: ' allow location',
                                        style: GoogleFonts.poppins(
                                            decoration: TextDecoration.underline,
                                            color: AppTheme.buttonColor,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500)),
                                    TextSpan(
                                        text: ' for the soloution',
                                        style: GoogleFonts.poppins(
                                            color: const Color(0xff858484),
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500)),
                                  ]),
                            ),
                          ),
                      ],
                    ),
                  ),
                  // if (canBuyProduct)
                  Expanded(
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if(widget.productElement.productType == 'variants'){
                              bottomSheet(productDetails: widget.productElement, context: context);
                            }else {
                              cartController.productElementId =  widget.productElement.id.toString();
                              cartController.productQuantity = productQuantity.value.toString();
                              directBuyProduct();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            surfaceTintColor: Colors.red,
                          ),
                          child: FittedBox(
                            child: Text(
                              "  Buy Now  ".tr,
                              style:
                              GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if(widget.productElement.productType == 'variants'){
                              bottomSheet(productDetails: widget.productElement, context: context);
                            }else{
                              addToCartProduct();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.buttonColor,
                            surfaceTintColor: AppTheme.buttonColor,
                          ),
                          child: FittedBox(
                            child: Text(
                              "Add to Cart".tr,
                              style:
                              GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                            ),
                          ),
                        ),



                        widget.productElement.itemType != 'giveaway'
                            ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (productQuantity.value > 1) {
                                  productQuantity.value--;
                                }
                              },
                              child: Center(
                                  child: Text(
                                    "-",
                                    style: GoogleFonts.poppins(
                                        fontSize: 40, fontWeight: FontWeight.w300, color: const Color(0xFF014E70)),
                                  )),
                            ),
                            SizedBox(
                              width: size.width * .02,
                            ),
                            Obx(() {
                              return Text(
                                productQuantity.value.toString(),
                                style: GoogleFonts.poppins(
                                    fontSize: 26, fontWeight: FontWeight.w500, color: const Color(0xFF014E70)),
                              );
                            }),
                            SizedBox(
                              width: size.width * .02,
                            ),
                            GestureDetector(
                              onTap: () {
                                if (widget.productElement.inStock ==0) {
                                  showToast("Out Of Stock".tr);

                                } else {
                                  productQuantity.value++;
                                }
                              },
                              child: Center(
                                  child: Text(
                                    "+",
                                    style: GoogleFonts.poppins(
                                        fontSize: 30, fontWeight: FontWeight.w300, color: const Color(0xFF014E70)),
                                  )),
                            ),
                          ],
                        )
                            : const SizedBox(),
                      ],
                    ),

                  )],
              ),
            ],
          ),
        ),
      )
          :
      widget.productElement.isShowcase != true ?
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          // margin: widget.isSingle == false ? EdgeInsets.zero :const EdgeInsets.only(right: 9),
          // padding: widget.isSingle == false ? EdgeInsets.zero :const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              color: Colors.white, boxShadow: [
            BoxShadow(
              blurStyle: BlurStyle.outer,
              offset: Offset(1, 1),
              color: Colors.black12,
              blurRadius: 3,
            )
          ]),
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(8),

                constraints: BoxConstraints(
                  // maxHeight: 100,
                  minWidth: 0,
                  maxWidth: size.width * .9,
                ),
                // color: Colors.red,
                margin: const EdgeInsets.only(right: 9),
                // constraints: BoxConstraints(
                //   // maxHeight: 100,
                //   minWidth: 0,
                //   maxWidth: size.width,
                // ),
                // color: Colors.red,
                // margin: const EdgeInsets.only(right: 9,left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: CachedNetworkImage(
                              imageUrl: widget.productElement.featuredImage.toString(),
                              height: 180,
                              width: 120,
                              fit: BoxFit.cover,
                              errorWidget: (_, __, ___) => Image.asset('assets/images/new_logo.png')),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              Obx(() {
                                if (wishListController.refreshFav.value > 0) {}

                                return LikeButtonCat(
                                  onPressed: () {
                                    if (wishListController.favoriteItems.contains(widget.productElement.id.toString())) {
                                      removeFromWishList();
                                    } else {
                                      addToWishList();
                                    }
                                  },
                                  isLiked: wishListController.favoriteItems.contains(widget.productElement.id.toString()),
                                );
                              }),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                widget.productElement.pName.toString(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                    fontSize: 16, fontWeight: FontWeight.w400, color: const Color(0xFF19313C)),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                widget.productElement.shortDescription ?? '',
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                    fontSize: 16, fontWeight: FontWeight.w400, color: const Color(0xFF19313C)),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    30.spaceY,
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              cartController.productElementId =  widget.productElement.id.toString();
                              cartController.productQuantity = productQuantity.value.toString();
                              directBuyProduct();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFDF33),
                              surfaceTintColor:const Color(0xFFFFDF33),
                            ),
                            child: FittedBox(
                              child: Text(
                                "Get it".tr,
                                style:
                                GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        15.spaceX,
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              addToCartProduct();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.buttonColor,
                              surfaceTintColor: AppTheme.buttonColor,
                            ),
                            child: FittedBox(
                              child: Text(
                                "Add to Cart".tr,
                                style:
                                GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                              ),
                            ),
                          ),
                        ),



                        widget.productElement.itemType != 'giveaway'
                            ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (productQuantity.value > 1) {
                                  productQuantity.value--;
                                }
                              },
                              child: Center(
                                  child: Text(
                                    "-",
                                    style: GoogleFonts.poppins(
                                        fontSize: 40, fontWeight: FontWeight.w300, color: const Color(0xFF014E70)),
                                  )),
                            ),
                            SizedBox(
                              width: size.width * .02,
                            ),
                            Obx(() {
                              return Text(
                                productQuantity.value.toString(),
                                style: GoogleFonts.poppins(
                                    fontSize: 26, fontWeight: FontWeight.w500, color: const Color(0xFF014E70)),
                              );
                            }),
                            SizedBox(
                              width: size.width * .02,
                            ),
                            GestureDetector(
                              onTap: () {
                                if (widget.productElement.inStock ==0) {
                                  showToast("Out Of Stock".tr);

                                } else {
                                  productQuantity.value++;
                                }
                              },
                              child: Center(
                                  child: Text(
                                    "+",
                                    style: GoogleFonts.poppins(
                                        fontSize: 30, fontWeight: FontWeight.w300, color: const Color(0xFF014E70)),
                                  )),
                            ),
                          ],
                        )
                            : const SizedBox(),
                      ],
                    ),
                    15.spaceY,
                    if(  Platform.isAndroid)
                      widget.productElement.shippingDate != "No Internation Shipping Available"
                          ?  Expanded(
                        child: Text.rich(
                          TextSpan(
                            text: 'Shipping: ',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF19313B),
                            ),
                            children: [
                              if (widget.productElement.lowestDeliveryPrice != null)
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child:  Text(
                                    widget.productElement.lowestDeliveryPrice.toString(),
                                    style:  GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Text(
                                  ' KWD ',
                                  style:  GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Text(
                                  ' & Estimated arrival by ',
                                  style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF19313B),
                                  ),
                                ),
                              ),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child:  Text(
                                  widget.productElement.shippingDate ?? '',
                                  style:  GoogleFonts.poppins(
                                    fontSize: 14,
                                    letterSpacing: 0.5,
                                    height: 2,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ) :
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const ContactUsScreen());
                        },
                        child: RichText(
                          text: TextSpan(
                              text: 'international shipping not available',
                              style: GoogleFonts.poppins(
                                  color: const Color(0xff858484), fontSize: 13, fontWeight: FontWeight.w500),
                              children: [
                                TextSpan(
                                    text: ' contact us',
                                    style: GoogleFonts.poppins(
                                        decoration: TextDecoration.underline,
                                        color: AppTheme.buttonColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500)),
                                TextSpan(
                                    text: ' for the soloution',
                                    style: GoogleFonts.poppins(
                                        color: const Color(0xff858484),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500)),
                              ]),
                        ),
                      ),
                    if(  Platform.isIOS)
                      widget.productElement.shippingDate != "No Internation Shipping Available"
                          ?  Expanded(
                        child: Text.rich(
                          TextSpan(
                            text: 'Shipping: ',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF19313B),
                            ),
                            children: [
                              if (widget.productElement.lowestDeliveryPrice != null)
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child:  Text(
                                    widget.productElement.lowestDeliveryPrice.toString(),
                                    style:  GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Text(
                                  ' KWD ',
                                  style:  GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Text(
                                  ' & Estimated arrival by ',
                                  style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF19313B),
                                  ),
                                ),
                              ),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child:  Text(
                                  widget.productElement.shippingDate ?? '',
                                  style:  GoogleFonts.poppins(
                                    fontSize: 14,
                                    letterSpacing: 0.5,
                                    height: 2,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ) :
                      GestureDetector(
                        onTap: () {
                          // Get.to(() => const ContactUsScreen());
                          // Navigator.of(context).pop();
                          _getCurrentPosition();
                          addCurrentAddress();
                        },
                        child: RichText(
                          text: TextSpan(
                              text: 'international shipping not available',
                              style: GoogleFonts.poppins(
                                  color: const Color(0xff858484), fontSize: 13, fontWeight: FontWeight.w500),
                              children: [
                                TextSpan(
                                    text: ' allow location',
                                    style: GoogleFonts.poppins(
                                        decoration: TextDecoration.underline,
                                        color: AppTheme.buttonColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500)),
                                TextSpan(
                                    text: ' for the soloution',
                                    style: GoogleFonts.poppins(
                                        color: const Color(0xff858484),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500)),
                              ]),
                        ),
                      ),
                  ],
                ),
              ),
              Positioned(
                right: 1,
                top: 0,
                child: Container(
                  width: 100,
                  decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          // blurStyle: BlurStyle.outer,
                          offset: Offset(2, 3),
                          color: Colors.black26,
                          blurRadius: 3,
                        )
                      ],
                      color: Color(0xFFFFDF33)),
                  child: Center(
                    child: Text(
                      "Free".tr,
                      style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w400, color: const Color(0xFF0C0D0C)),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ):
      Padding(
        padding: const EdgeInsets.all(0.0),
        child: Stack(
          children: [
            Container(
              height: 350,
              width: Get.width,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      blurStyle: BlurStyle.outer,
                      offset: Offset(1, 1),
                      color: Colors.black12,
                      blurRadius: 3,

                    )
                  ]
              ),
              // constraints: BoxConstraints(
              //   // maxHeight: 100,
              //   minWidth: 0,
              //   maxWidth: size.width,
              // ),
              // color: Colors.red,
              // margin: const EdgeInsets.only(right: 9,left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  const SizedBox(height: 20,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: CachedNetworkImage(
                            imageUrl:  widget.productElement.featuredImage.toString(),
                            height: 150,
                            width: 150,
                            fit: BoxFit.contain,
                            errorWidget: (_, __, ___) => Image.asset('assets/images/new_logo.png')),
                      ),

                      const SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          children: [
                            const SizedBox(height: 15,),
                            Row(
                              children: [
                                Image.asset('assets/svgs/flagk.png'),
                                const SizedBox(width: 5,),
                                Expanded(
                                  child: Text("Kuwait City",
                                    maxLines: 2,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0xFF19313C)),
                                  ),
                                ),
                                const SizedBox(width: 5,),
                                Obx(() {
                                  if (wishListController.refreshFav.value > 0) {}
                                  return LikeButtonCat(
                                    onPressed: () {
                                      if (wishListController.favoriteItems.contains( widget.productElement.id.toString())) {
                                        repositories
                                            .postApi(
                                            url: ApiUrls.removeFromWishListUrl,
                                            mapData: {
                                              "product_id":  widget.productElement.id.toString(),
                                            },
                                            context: context)
                                            .then((value) {
                                          ModelCommonResponse response = ModelCommonResponse.fromJson(
                                              jsonDecode(value));
                                          log('api response is${response.toJson()}');
                                          showToast(response.message);
                                          wishListController.getYourWishList();
                                          wishListController.favoriteItems.remove( widget.productElement.id.toString());
                                          wishListController.updateFav;
                                          setState(() {
                        
                                          });
                                        });
                                      } else {
                                        repositories
                                            .postApi(
                                            url: ApiUrls.addToWishListUrl,
                                            mapData: {
                                              "product_id":  widget.productElement.id.toString(),
                                            },
                                            context: context)
                                            .then((value) {
                                          ModelCommonResponse response = ModelCommonResponse.fromJson(
                                              jsonDecode(value));
                                          showToast(response.message);
                                          if (response.status == true) {
                                            wishListController.getYourWishList();
                                            wishListController.favoriteItems.add( widget.productElement.id.toString());
                                            wishListController.updateFav;
                                          }
                                        });
                                      }
                                    },
                                    isLiked: wishListController.favoriteItems.contains( widget.productElement.id.toString()),
                                  );
                                }),
                              ],
                            ),
                            const SizedBox(height: 25,),
                            Text(widget.productElement.pName.toString(), style: GoogleFonts.poppins(
                                fontSize: 16, fontWeight: FontWeight.w400, color: const Color(0xFF19313C)),
                            ),
                            const SizedBox(height: 25,),
                            Row(
                              children: [
                                Expanded(
                                  child: Text("yokun", style: GoogleFonts.poppins(
                                      fontSize: 10, fontWeight: FontWeight.w400, color: const Color(0xFF19313C)),
                                    maxLines: 1,
                                  ),
                                ),
                                const SizedBox(width: 6,),
                                Expanded(
                                  child: Text("gmc", style: GoogleFonts.poppins(
                                      fontSize: 10, fontWeight: FontWeight.w400, color: const Color(0xFF19313C)),
                                    maxLines: 1,
                                  ),
                                ),
                                const SizedBox(width: 6,),
                                Expanded(
                                  child: Text("used", style: GoogleFonts.poppins(
                                      fontSize: 10, fontWeight: FontWeight.w400, color: const Color(0xFF19313C)),
                                    maxLines: 1,
                                  ),
                                ),
                                const SizedBox(width: 6,),
                                Expanded(
                                  child: Text("2024", style: GoogleFonts.poppins(
                                      fontSize: 10, fontWeight: FontWeight.w400, color: const Color(0xFF19313C)),
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 35,),
                            Text.rich(
                              TextSpan(
                                text: '${widget.productElement.discountPrice.toString().split('.')[0]}.',
                        
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF19313B),
                                ),
                                children: [
                                  WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'KWD',
                                          style: TextStyle(
                                            fontSize: 8,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF19313B),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            // print("date:::::::::::" + widget.productElement.shippingDate);
                                          },
                                          child: Text(
                                            '${widget.productElement.discountPrice.toString().split('.')[1]}',
                                            style: const TextStyle(
                                              fontSize: 8,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF19313B),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        
                          ],
                        ),
                      )
                    ],
                  ),
                  25.spaceY,
                  Row(
                    children: [
                      Expanded(
                        child: Text(widget.productElement.shortDescription.toString(), style: GoogleFonts.poppins(
                            fontSize: 11, fontWeight: FontWeight.w400, color: const Color(0xFF19313C)),
                          maxLines: 3,
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          // launchURLl('tel:${ widget.productElement.vendorDetails!.phoneNumber.toString()}');
                        },
                        child: SvgPicture.asset('assets/svgs/phonee.svg',
                          width: 25,
                          height: 25,),
                      ),
                      const SizedBox(width: 10,),
                      GestureDetector(
                        onTap: () {
                          // launchURLl('mailto:${ widget.productElement.vendorDetails!.email.toString()}');
                        },
                        child: SvgPicture.asset('assets/svgs/chat-dots.svg',
                          width: 25,
                          height: 25,),
                      ),
                    ],
                  ),


                  // SizedBox(height: 10,),
                  // Align(
                  //   alignment: Alignment.center,
                  //   child: Center(
                  //     child: CachedNetworkImage(
                  //         imageUrl: item.featuredImage.toString(),
                  //         height: 150,
                  //         fit: BoxFit.fill,
                  //         errorWidget: (_, __, ___) => Image.asset('assets/images/new_logo.png')
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  //
                  // const SizedBox(
                  //   height: 3,
                  // ),
                  // Text(
                  //   item.pname.toString(),
                  //   maxLines: 2,
                  //   style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500,color: Color(0xFF19313C)),
                  // ),
                  // const SizedBox(
                  //   height: 3,
                  // ),
                  // Text(
                  //   item.shortDescription.toString(),
                  //   maxLines: 2,
                  //   style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500,color: Color(0xFF19313C)),
                  // ),
                  // const SizedBox(
                  //   height: 3,
                  // ),


                ],
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      const BoxShadow(

                        // blurStyle: BlurStyle.outer,
                        offset: Offset(2, 3),
                        color: Colors.black26,
                        blurRadius: 3,

                      )
                    ],
                    borderRadius: const BorderRadius.only(topRight: Radius.circular(8)),
                    color: const Color(0xFF27D6FF).withOpacity(0.6)
                ),
                child: Text(" Showcase ".tr,
                  style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future bottomSheet({required ProductElement productDetails, required BuildContext context}) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      constraints: BoxConstraints(maxHeight: context.getSize.height * .9, minHeight: context.getSize.height * .4),
      builder: (context) {
        return SingleProductDetails(
          productDetails: productDetails,
        );
      });
}