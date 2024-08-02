import 'dart:convert';
import 'dart:developer';

import 'package:dirise/utils/helper.dart';
import 'package:dirise/widgets/customsize.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../controller/cart_controller.dart';
import '../../controller/google_map_controlleer.dart';
import '../../controller/profile_controller.dart';
import '../../model/common_modal.dart';
import '../../model/customer_profile/model_city_list.dart';
import '../../model/customer_profile/model_country_list.dart';
import '../../model/customer_profile/model_state_list.dart';
import '../../model/model_address_list.dart';

import '../../model/order_models/model_direct_order_details.dart';
import '../../model/vendor_models/model_payment_method.dart';
import '../../newAddress/map_find_my_location.dart';
import '../../repository/repository.dart';
import '../../utils/api_constant.dart';
import '../../utils/styles.dart';
import '../../widgets/common_colour.dart';
import '../../widgets/common_textfield.dart';
import '../../widgets/loading_animation.dart';
import '../auth_screens/login_screen.dart';
import '../my_account_screens/editprofile_screen.dart';

class DirectCheckOutScreen extends StatefulWidget {
  static String route = "/DirectCheckOutScreen";

  const DirectCheckOutScreen({super.key});

  @override
  State<DirectCheckOutScreen> createState() => _DirectCheckOutScreenState();
}

class _DirectCheckOutScreenState extends State<DirectCheckOutScreen> {
  final cartController = Get.put(CartController());
  final controllerMap = Get.put(ControllerMap());
  final profileController = Get.put(ProfileController());
  final TextEditingController deliveryInstructions = TextEditingController();
  AddressData selectedAddress = AddressData();
  final GlobalKey addressKey = GlobalKey();
  String shippingPrice = '0';
  double total = 0.0;
  double fedxTotal = 0.0;
  double fedxTotalShip = 0.0;
  ModelPaymentMethods? methods;
  double commisionShipping = 0.0;
  getPaymentGateWays() {
    Repositories().getApi(url: ApiUrls.paymentMethodsUrl).then((value) {
      methods = ModelPaymentMethods.fromJson(jsonDecode(value));
      setState(() {});
    });
  }

  double sPrice1 = 0.0;
  dynamic sPrice = 0.0;
  final _formKey = GlobalKey<FormState>();
  String paymentMethod1 = "";
  RxBool showValidation = false.obs;
  RxString deliveryOption = "".obs;
  RxString paymentOption = "".obs;

  bool get userLoggedIn => profileController.userLoggedIn;

  ModelStateList? modelStateList;
  CountryState? selectedState;

  ModelCityList? modelCityList;
  City? selectedCity;
  final Repositories repositories = Repositories();
  RxInt stateRefresh = 2.obs;

  getCountryList() {
    if (modelCountryList != null) return;
    repositories.getApi(url: ApiUrls.allCountriesUrl).then((value) {
      modelCountryList = ModelCountryList.fromString(value);
    });
  }

  Future getStateList({required String countryId, bool? reset}) async {
    if (reset == true) {
      modelStateList = null;
      selectedState = null;
      modelCityList = null;
      selectedCity = null;
    }
    stateRefresh.value = -5;
    final map = {'country_id': countryId};
    await repositories.postApi(url: ApiUrls.allStatesUrl, mapData: map).then((value) {
      modelStateList = ModelStateList.fromJson(jsonDecode(value));
      stateRefresh.value = DateTime
          .now()
          .millisecondsSinceEpoch;
    }).catchError((e) {
      stateRefresh.value = DateTime
          .now()
          .millisecondsSinceEpoch;
    });
  }

  defaultAddressApi() async {
    Map<String, dynamic> map = {};
    map['address_id'] = cartController.selectedAddress.id.toString();
    repositories.postApi(url: ApiUrls.defaultAddressStatus, context: context, mapData: map).then((value) async {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      if (response.status == true) {
        showToast(response.message.toString());
        Get.back();
      } else {
        showToast(response.message.toString());
      }
    });
  }

  ModelCountryList? modelCountryList;
  Country? selectedCountry;
  RxInt cityRefresh = 2.obs;

  Future getCityList({required String stateId, bool? reset}) async {
    if (reset == true) {
      modelCityList = null;
      selectedCity = null;
    }
    cityRefresh.value = -5;
    final map = {'state_id': stateId};
    await repositories.postApi(url: ApiUrls.allCityUrl, mapData: map).then((value) {
      modelCityList = ModelCityList.fromJson(jsonDecode(value));
      cityRefresh.value = DateTime
          .now()
          .millisecondsSinceEpoch;
    }).catchError((e) {
      cityRefresh.value = DateTime
          .now()
          .millisecondsSinceEpoch;
    });
  }

  String countryIddd = '';
  String stateIddd = '';
  RxString shipId = "".obs;
  RxString shipmentProvider = "".obs;

  @override
  void initState() {
    super.initState();
    getCountryList();
    cartController.addressCountryController = TextEditingController(text: selectedAddress.getCountry ?? "");
    cartController.addressStateController = TextEditingController(text: selectedAddress.getState ?? "");
    cartController.addressCityController = TextEditingController(text: selectedAddress.getCity ?? "");
    cartController.shippingId = '';
    cartController.deliveryOption1.value = '';
    cartController.isDelivery.value = false;
    cartController.addressDeliFirstName.text = '';
    cartController.addressDeliLastName.text = '';
    cartController.addressDeliEmail.text = '';
    cartController.addressDeliPhone.text = '';
    cartController.addressDeliAlternate.text = '';
    cartController.addressDeliAddress.text = '';
    cartController.addressDeliZipCode.text = '';
    cartController.countryName.value = '';
    getPaymentGateWays();
    // if (Get.arguments != null) {
    //   cartController.directOrderResponse.value = Get.arguments;
    // }
    profileController.checkUserLoggedIn().then((value) {
      if (value == false) return;
    });
    cartController.getAddress();
    cartController.myDefaultAddressData();
  }
  RxString shippingType = "".obs;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cartController.directOrderResponse;
  }
  double shippingCommision=  0.0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              profileController.selectedLAnguage.value != 'English' ?
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
            ],
          ),
        ),
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Checkout".tr,
              style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 22),
            ),
          ],
        ),
      ),
      body: Obx(() {
        return cartController.directOrderResponse.value.prodcutData != null ?
          SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addressPart(size),
              const SizedBox(
                height: 30,
              ),
              paymentMethod(size),
              Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15).copyWith(top: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${'Sold By'.tr} ${cartController.directOrderResponse.value.prodcutData!.slug.toString()}",
                              style: titleStyle,
                            ),
                            addHeight(20),
                            IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 75,
                                    height: 75,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                          cartController.directOrderResponse.value.prodcutData!.featureImageApp.toString(),
                                          fit: BoxFit.contain,
                                          errorBuilder: (_, __, ___) => Image.asset('assets/images/new_logo.png')),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          cartController.directOrderResponse.value.prodcutData!.pname.toString(),
                                          style: titleStyle.copyWith(fontWeight: FontWeight.w400),
                                          textAlign: TextAlign.start,
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        Text(
                                          cartController.directOrderResponse.value.prodcutData!.productType == 'variants'
                                              ? 'KWD ${cartController.directOrderResponse.value.prodcutData!.variantPrice}'
                                              : 'KWD ${cartController.directOrderResponse.value.prodcutData!.discountPrice}',
                                          // 'KWD ${directOrderResponse.prodcutData!.sPrice.toString()}',
                                          style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w400),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        // IntrinsicHeight(
                                        //   child: Row(
                                        //     children: [
                                        //       IconButton(
                                        //           onPressed: () {
                                        //             if (directOrderResponse.returnData!.quantity.toNum > 1) {
                                        //               cartController.updateCartQuantity(
                                        //                   context: context,
                                        //                   productId: directOrderResponse.prodcutData!.id.toString(),
                                        //                   quantity: (directOrderResponse.returnData!.quantity.toNum - 1).toString());
                                        //             } else {
                                        //               cartController.removeItemFromCart(
                                        //                   productId: directOrderResponse.prodcutData!.id.toString(), context: context);
                                        //             }
                                        //           },
                                        //           style: IconButton.styleFrom(
                                        //             shape: RoundedRectangleBorder(
                                        //                 borderRadius: BorderRadius.circular(2)),
                                        //             backgroundColor: AppTheme.buttonColor,
                                        //           ),
                                        //           constraints: const BoxConstraints(minHeight: 0),
                                        //           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                                        //           visualDensity: VisualDensity.compact,
                                        //           icon: const Icon(
                                        //             Icons.remove,
                                        //             color: Colors.white,
                                        //             size: 20,
                                        //           )),
                                        //       5.spaceX,
                                        //       Container(
                                        //         decoration: BoxDecoration(
                                        //             borderRadius: BorderRadius.circular(2),
                                        //             // color: Colors.grey,
                                        //             border: Border.all(color: Colors.grey.shade800)),
                                        //         margin: const EdgeInsets.symmetric(vertical: 6),
                                        //         padding: const EdgeInsets.symmetric(horizontal: 15),
                                        //         alignment: Alignment.center,
                                        //         child: Text(
                                        //           directOrderResponse.returnData!.quantity.toString(),
                                        //           style: normalStyle,
                                        //         ),
                                        //       ),
                                        //       5.spaceX,
                                        //       IconButton(
                                        //           onPressed: () {
                                        //             if (directOrderResponse.returnData!.quantity.toString().toNum <
                                        //                 directOrderResponse.prodcutData!.inStock.toString().toNum) {
                                        //               cartController.updateCartQuantity(
                                        //                   context: context,
                                        //                   productId:   directOrderResponse.prodcutData!.id.toString(),
                                        //                   quantity: (directOrderResponse.returnData!.quantity.toString().toNum + 1).toString());
                                        //             }else{
                                        //               showToastCenter("Out Of Stock".tr);
                                        //             }
                                        //           },
                                        //           style: IconButton.styleFrom(
                                        //             shape: RoundedRectangleBorder(
                                        //                 borderRadius: BorderRadius.circular(2)),
                                        //             backgroundColor: AppTheme.buttonColor,
                                        //           ),
                                        //           constraints: const BoxConstraints(minHeight: 0),
                                        //           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                                        //           visualDensity: VisualDensity.compact,
                                        //           icon: const Icon(
                                        //             Icons.add,
                                        //             color: Colors.white,
                                        //             size: 20,
                                        //           )),
                                        //     ],
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  ),
                                  // IconButton(
                                  //     onPressed: () {
                                  //       cartController.removeItemFromCart(
                                  //           productId:   directOrderResponse.prodcutData!.id.toString(), context: context);
                                  //     },
                                  //     visualDensity: VisualDensity.compact,
                                  //     icon: SvgPicture.asset(
                                  //       "assets/svgs/delete.svg",
                                  //       height: 18,
                                  //       width: 18,
                                  //     ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      10.spaceY,
                      if (
                      // selectedAddress.id != null &&
                      // directOrderResponse.prodcutData!.isShipping == true &&
                      // directOrderResponse.vendorCountryId == '117' &&
                      // cartController.countryName.value == 'Kuwait'
                      cartController.directOrderResponse.value.localShipping == true
                      )
                        Column(
                          children: [
                            Container(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/images/shipping_icon.png', height: 32, width: 32),
                                    20.spaceX,
                                    Text("Shipping Method".tr,
                                        style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18)),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: cartController.directOrderResponse.value.shippingType!.localShipping!.length,
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15).copyWith(top: 0),
                                itemBuilder: (context, ii) {
                                  var product = cartController.directOrderResponse.value.shippingType!.localShipping![ii];
                                  cartController.storeIdShipping =
                                      cartController.directOrderResponse.value.prodcutData!.vendorId.toString();
                                  return Obx(() {
                                    return Column(
                                      children: [
                                        10.spaceY,
                                        ii == 0
                                            ? 0.spaceY
                                            : const Divider(
                                          color: Color(0xFFD9D9D9),
                                          thickness: 0.8,
                                        ),
                                        Row(
                                          children: [
                                            Radio(
                                              value: product.id.toString(),
                                              groupValue: cartController.directOrderResponse.value.shippingOption.value,
                                              visualDensity: const VisualDensity(horizontal: -4.0),
                                              onChanged: (value) {
                                                setState(() {
                                                  // directOrderResponse.fedexShippingOption.value = value.toString();
                                                  cartController.directOrderResponse.value.shippingOption.value =
                                                      value.toString();
                                                  cartController.shippingId = cartController.directOrderResponse.value
                                                      .shippingOption.value;
                                                  // shippingPrice =directOrderResponse.shippingType!.localShipping!.map((e) {
                                                  //   return e.value.toString();
                                                  // });
                                                  shippingType.value = "local_shipping";
                                                  double subtotal = double.parse(cartController.directOrderResponse.value.subtotal.toString().replaceAll(',', ''));
                                                  double shipping = double.parse(product.value.toString());
                                                  shippingPrice = product.value.toString();
                                                  commisionShipping = double.tryParse(product.value.toString())!;
                                                  total = total + shipping;
                                                  cartController.formattedTotal = total.toString();
                                                  cartController.shippingTitle = product.name.toString();
                                                  cartController.shippingPrices1 = product.value.toString();
                                                  commisionShipping = double.tryParse(product.value.toString())!;
                                                  print('total isss${cartController.formattedTotal.toString()}');
                                                  cartController.shipping_new_api = product.value.toString();
                                                  print('fdfdff${cartController.shipping_new_api.toString()}');
                                                  log(cartController.directOrderResponse.value.shippingOption.value);
                                                  log(cartController.shippingId);
                                                  cartController.directOrderResponse.value.sPrice = double.parse(product
                                                      .value.toString());
                                                  cartController.formattedTotal = total.toStringAsFixed(3);
                                                  sPrice1 = 0.0;
                                                  if (cartController.directOrderResponse.value.shippingOption.value
                                                      .isNotEmpty) {
                                                    log("kiska price hai + ${cartController.directOrderResponse.value
                                                        .prodcutData!.discountPrice}");
                                                    sPrice1 = sPrice1 + cartController.directOrderResponse.value.sPrice;
                                                    print('vafd${sPrice1.toString()}');
                                                    // sPrice.toStringAsFixed(fractionDigits)
                                                    // Update sPrice directly without reassigning
                                                  }
                                                  print('value changeesss${cartController.shippingPrices.toString()}');
                                                  total = subtotal + sPrice1;
                                                  cartController.formattedTotal = total.toStringAsFixed(3);
                                                  print('total isss${total.toString()}');
                                                });
                                              },
                                            ),
                                            20.spaceX,
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(product.name
                                                    .toString()
                                                    .capitalize!
                                                    .replaceAll('_', ' '),
                                                    style:
                                                    GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16)),
                                                3.spaceY,
                                                Text('kwd ${product.value.toString()}',
                                                    style: GoogleFonts.poppins(
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 16,
                                                        color: const Color(0xFF03a827))),
                                              ],
                                            ),
                                            // Text(product.name.toString().capitalize!.replaceAll('_', ' '),
                                            //     style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 16)),
                                          ],
                                        ),
                                      ],
                                    );
                                  });
                                  // : 0.spaceY,;
                                },
                              ),
                            ),
                          ],
                        ),

                      // selectedAddress.id != null
                      //     ?
                      if(cartController.directOrderResponse.value.shippingType!.fedexShipping != null)
                        Column(
                          children: [
                            if(cartController.directOrderResponse.value.shippingType!.fedexShipping!.output != null)
                              Container(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/images/shipping_icon.png', height: 32, width: 32),
                                      20.spaceX,
                                      Text("Fedex Shipping Method".tr,
                                          style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18)),
                                    ],
                                  ),
                                ),
                              ),

                            // if( directOrderResponse.localShipping != true &&
                            //     directOrderResponse.shippingType!.fedexShipping!.output == null)
                            //
                            //   Padding(
                            //     padding: const EdgeInsets.all(8.0),
                            //     child: Text(
                            //       'FedEx service is not currently available to this origin / destination combination. Enter new information or contact FedEx Customer Service.'
                            //           .tr, style: const TextStyle(
                            //         fontSize: 17
                            //     ),),),

                            if(cartController.directOrderResponse.value.shippingType!.fedexShipping!.output != null)
                              Container(
                                color: Colors.white,
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: cartController.directOrderResponse.value.shippingType!.fedexShipping!.output!
                                      .rateReplyDetails!.length,
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15).copyWith(top: 0),
                                  itemBuilder: (context, ii) {
                                    return cartController.directOrderResponse.value.shippingType!.fedexShipping!.output !=
                                        null ?
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: cartController.directOrderResponse.value.shippingType!.fedexShipping!
                                          .output!.rateReplyDetails![ii]
                                          .ratedShipmentDetails!.length,
                                      itemBuilder: (context, index) {
                                        cartController.storeIdShipping =
                                            cartController.directOrderResponse.value.prodcutData!.vendorId.toString();
                                        RateReplyDetails product = cartController.directOrderResponse.value.shippingType!
                                            .fedexShipping!.output!
                                            .rateReplyDetails![ii];
                                        RatedShipmentDetails product1 = cartController.directOrderResponse.value
                                            .shippingType!.fedexShipping!.output!
                                            .rateReplyDetails![ii].ratedShipmentDetails![index];
                                        shippingCommision = double.parse(cartController.directOrderResponse.value.fedexCommision.toString());
                                        double shipping = double.parse(product1.totalNetCharge.toString());
                                        double fedxTotalIs = shipping + shippingCommision;
                                        // double subtotal = double.parse(directOrderResponse.fedexCommision.toString());
                                        // double shipping = double.parse(product1.totalNetCharge.toString());
                                        // fedxTotal = subtotal + shipping;
                                        // cartController.formattedTotal = fedxTotal.toStringAsFixed(3);
                                        // print("icarryCommision" + directOrderResponse.fedexCommision.toString());
                                        // print("rate" + product1.totalNetCharge.toString());
                                        // print('total isss${cartController.formattedTotal.toString()}');
                                        // cartController.shippingPrices = cartController.formattedTotal.toString();
                                        return Obx(() {
                                          return Column(
                                            children: [
                                              10.spaceY,
                                              index == 0
                                                  ? 0.spaceY
                                                  : const Divider(
                                                color: Color(0xFFD9D9D9),
                                                thickness: 0.8,
                                              ),
                                              Row(
                                                children: [
                                                  Radio(
                                                    value: product.serviceType.toString(),
                                                    groupValue: cartController.directOrderResponse.value.fedexShippingOption
                                                        .value,
                                                    visualDensity: const VisualDensity(horizontal: -4.0),
                                                    fillColor: cartController.directOrderResponse.value.fedexShippingOption
                                                        .value.isEmpty
                                                        ? MaterialStateProperty.all(Colors.red)
                                                        : null,
                                                    onChanged: (value) {
                                                      log("which is selected + $value");
                                                      setState(() {
                                                        cartController.directOrderResponse.value.fedexShippingOption.value =
                                                            value.toString();
                                                        shippingType.value = "fedex_shipping";
                                                        shipId.value = "";
                                                        shipmentProvider.value = "";
                                                        // cartController.shippingDates = product.commit!.dateDetail!.dayFormat!
                                                        //     .toString();
                                                        // e.value.shipping![ii].output!.rateReplyDetails![index].shippingDate = product.operationalDetail!.deliveryDate;
                                                        cartController.shippingTitle = product.serviceName.toString();
                                                        // cartController.shippingPrices = product.ratedShipmentDetails![index].totalNetCharge.toString();
                                                        cartController.directOrderResponse.value.shippingOption.value =
                                                            value.toString();
                                                        cartController.shipping_new_api = fedxTotalIs.toString();
                                                        print('fdfdff${cartController.shipping_new_api.toString()}');
                                                        print(cartController.directOrderResponse.value.fedexShippingOption
                                                            .value.toString());
                                                        print(cartController.shippingTitle.toString());
                                                        print('select value${cartController.shippingPrices.toString()}');
                                                        print(cartController.shippingPrices.toString());
                                                        double subtotal = double.parse(
                                                            cartController.directOrderResponse.value.subtotal.toString());
                                                        double shipping = double.parse(product1.totalNetCharge.toString());
                                                        double total123 = subtotal + shipping;
                                                        total = total123 + shippingCommision;
                                                        cartController.formattedTotal2 = total.toStringAsFixed(3);
                                                        cartController.formattedTotal2 = total.toStringAsFixed(3);
                                                        print("icarryCommision" +
                                                            cartController.directOrderResponse.value.fedexCommision
                                                                .toString());
                                                        print("rate" + product1.totalNetCharge.toString());
                                                        print('total isss${cartController.formattedTotal2.toString()}');
                                                        cartController.shippingPrices1 = cartController.formattedTotal2
                                                            .toString();
                                                        // e.value.shippingId.value = product.id.toString();
                                                        // e.value.vendorId.value = e.value.shipping![ii].vendorId!;
                                                        // directOrderResponse.s.value = product.serviceName.toString();
                                                        // e.value.vendorPrice.value = product.ratedShipmentDetails![index].totalNetCharge.toString();

                                                        // directOrderResponse.prodcutData!.sPrice = product.ratedShipmentDetails![index].totalNetCharge;
                                                        // shippingPrice = product.ratedShipmentDetails![index].totalNetCharge.toString() + directOrderResponse.fedexCommision.toString() ;
                                                        double subtotalForShip = double.parse(
                                                            cartController.directOrderResponse.value.fedexCommision
                                                                .toString());
                                                        double shippingForShip = double.parse(
                                                            product1.totalNetCharge.toString());
                                                        fedxTotalShip = subtotalForShip + shippingForShip;
                                                        shippingPrice = fedxTotalShip.toStringAsFixed(3);
                                                        log("Initial sPrice:$sPrice1");
                                                        log("Initial sPrice" + cartController.shippingTitle);
                                                        log(product.serviceType.toString());
                                                        commisionShipping = fedxTotalIs.toDouble();
                                                        cartController.directOrderResponse.value.sPrice =
                                                            double.parse(fedxTotalIs.toString());
                                                        sPrice1 = 0.0;
                                                        // cartController.withoutSelectPrice = double.parse(cartController.shippingPrices);
                                                        print('value change:::${cartController.shippingPrices.toString()}');
                                                        // sPrice1 = 0.0;
                                                        if (cartController.directOrderResponse.value.shippingOption.value
                                                            .isNotEmpty) {
                                                          log("kiska price hai + ${cartController.directOrderResponse.value
                                                              .prodcutData!.sPrice}");
                                                          sPrice1 =
                                                              sPrice1 + cartController.directOrderResponse.value.sPrice;
                                                          print('vafd${sPrice1.toString()}');
                                                          // sPrice.toStringAsFixed(fractionDigits)
                                                          // Update sPrice directly without reassigning
                                                        }
                                                        print('subtotal ${subtotal.toString()}');
                                                        total = subtotal + sPrice1;
                                                        print('total is ${total}');
                                                        cartController.formattedTotal = total.toStringAsFixed(3);
                                                      });
                                                    },
                                                  ),
                                                  20.spaceX,
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(product.serviceName
                                                            .toString()
                                                            .capitalize!
                                                            .replaceAll('_', ' '),
                                                            style: GoogleFonts.poppins(fontWeight: FontWeight.w500,
                                                                fontSize: 16)),
                                                        3.spaceY,
                                                        Text('kwd ${ fedxTotalIs.toString()}',
                                                            style: GoogleFonts.poppins(fontWeight: FontWeight.w400,
                                                                fontSize: 16,
                                                                color: const Color(0xFF03a827))),
                                                        3.spaceY,
                                                        // Text('${product.operationalDetail!.deliveryDay ?? ''}  ${product.operationalDetail!.deliveryDate ?? ''}',
                                                        // style: GoogleFonts.poppins(fontWeight: FontWeight.w400,
                                                        // fontSize: 15,
                                                        // fontStyle: FontStyle.italic,
                                                        // color: const Color(0xFF000000))),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );
                                        });
                                      },
                                    )
                                        : const LoadingAnimation();
                                    // : 0.spaceY,;
                                  },
                                ),
                                //   )  : const LoadingAnimation() : const SizedBox(),
                              ),

                            if(cartController.directOrderResponse.value.shippingType!.icarryShipping!.isNotEmpty)
                              Container(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/images/shipping_icon.png', height: 32, width: 32),
                                      20.spaceX,
                                      Text("Icarry Shipping Method".tr,
                                          style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18)),
                                    ],
                                  ),
                                ),
                              ),
                            if(cartController.directOrderResponse.value.shippingType!.icarryShipping!.isNotEmpty)
                              Container(
                                color: Colors.white,
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: cartController.directOrderResponse.value.shippingType!.icarryShipping!.length,
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15).copyWith(top: 0),
                                  itemBuilder: (context, ii) {
                                    cartController.storeIdShipping =
                                        cartController.directOrderResponse.value.prodcutData!.vendorId.toString();
                                    IcarryShipping product = cartController.directOrderResponse.value.shippingType!
                                        .icarryShipping![ii];
                                    shippingCommision = double.parse(cartController.directOrderResponse.value.icarryCommision.toString());
                                    double shipping = double.parse(product.rate.toString());
                                    double icarryTotal = shipping + shippingCommision;
                                    // double subtotal = double.parse(directOrderResponse.icarryCommision.toString());
                                    // double shipping = double.parse(product.rate.toString());
                                    // fedxTotal = subtotal + shipping;
                                    // cartController.formattedTotal = fedxTotal.toStringAsFixed(3);
                                    // print("icarryCommision" + directOrderResponse.icarryCommision.toString());
                                    // print("rate" + product.rate.toString());
                                    // print('total isss${cartController.formattedTotal.toString()}');
                                    // cartController.shippingPrices = cartController.formattedTotal.toString();
                                    return Obx(() {
                                      return Column(
                                        children: [
                                          10.spaceY,
                                          ii == 0
                                              ? 0.spaceY
                                              : const Divider(
                                            color: Color(0xFFD9D9D9),
                                            thickness: 0.8,
                                          ),

                                          Row(
                                            children: [
                                              Radio(
                                                value: product.methodId.toString(),
                                                groupValue: cartController.directOrderResponse.value.fedexShippingOption
                                                    .value,
                                                visualDensity: const VisualDensity(horizontal: -4.0),
                                                fillColor: cartController.directOrderResponse.value.fedexShippingOption.value
                                                    .isEmpty
                                                    ? MaterialStateProperty.all(Colors.red)
                                                    : null,
                                                onChanged: (value) {
                                                  setState(() {
                                                    shippingType.value = "icarry_shipping";
                                                    shipId.value = product.methodId.toString();
                                                    shipmentProvider.value = product.carrierModel!.systemName.toString();
                                                    cartController.directOrderResponse.value.shippingOption.value = value
                                                        .toString();
                                                    cartController.directOrderResponse.value.fedexShippingOption.value =
                                                        value.toString();
                                                    cartController.shippingTitle = product.name.toString();
                                                    cartController.shippingDates = product.methodName.toString();
                                                    cartController.shipping_new_api = icarryTotal.toString();
                                                    //  double subtotal = double.parse(directOrderResponse.icarryCommision.toString());
                                                    //  double shipping = double.parse(product.rate.toString());
                                                    //  total = subtotal + shipping;
                                                    //  cartController.formattedTotal = total.toString();
                                                    //  print("icarryCommision"+directOrderResponse.icarryCommision.toString());
                                                    //  print("rate"+product.rate.toString());
                                                    //  print('total isss${cartController.formattedTotal.toString()}');
                                                    // cartController.shippingPrices = cartController.formattedTotal.toString();
                                                    print(cartController.directOrderResponse.value.fedexShippingOption.value
                                                        .toString());
                                                    print(cartController.shippingTitle.toString());
                                                    print('select value${cartController.shippingPrices.toString()}');
                                                    print(cartController.shippingPrices.toString());

                                                    double subtotal = double.parse(
                                                        cartController.directOrderResponse.value.icarryCommision.toString());
                                                    double shipping = double.parse(product.rate.toString());
                                                    double total123 = subtotal + shipping;
                                                    total = total123 + shippingCommision;
                                                    cartController.formattedTotal2 = total.toStringAsFixed(3);
                                                    commisionShipping = icarryTotal;
                                                    total = subtotal + shipping;
                                                    cartController.formattedTotal2 = total.toStringAsFixed(3);
                                                    print("icarryCommision" +
                                                        cartController.directOrderResponse.value.icarryCommision.toString());
                                                    print("rate" + product.rate.toString());
                                                    print('total isss${cartController.formattedTotal2.toString()}');
                                                    cartController.shippingPrices1 = cartController.formattedTotal2
                                                        .toString();
                                                    double subtotalForShip = double.parse(
                                                        cartController.directOrderResponse.value.icarryCommision.toString());
                                                    double shippingForShip = double.parse(product.rate.toString());
                                                    fedxTotalShip = subtotalForShip + shippingForShip;
                                                    shippingPrice = fedxTotalShip.toStringAsFixed(3);
                                                    // shippingPrice =   product.price.toString();
                                                    // double subtotal = double.parse(cartController.cartModel.subtotal.toString());
                                                    // double shipping = double.parse(shippingPrice.toString());
                                                    // total = subtotal + shipping;
                                                    // cartController.formattedTotal = total.toStringAsFixed(3);
                                                    // e.value.shippingId.value = product.id.toString();
                                                    // e.value.vendorId.value = e.value.shipping![ii].vendorId!;
                                                    // e.value.shippingVendorName.value = product.serviceName.toString();
                                                    // e.value.vendorPrice.value = product.ratedShipmentDetails![index].totalNetCharge.toString();

                                                    // directOrderResponse.prodcutData!.sPrice = product.rate;
                                                    shippingPrice = product.rate.toString();
                                                    log("Initial sPrice:$sPrice1");
                                                    log("Initial sPrice::::::::" + shipId.value.toString());
                                                    log("Initial sPrice::::::fdsggsgggggggg::" +
                                                        cartController.shippingDates.toString());
                                                    log("Initial sPrice:" + cartController.shippingTitle.toString());
                                                    log("Initial sPrice::" + shipmentProvider.value.toString());
                                                    cartController.directOrderResponse.value.prodcutData!.sPrice = double.parse(icarryTotal.toString());
                                                    sPrice1 = 0.0;
                                                    log("kiska price hai :::::::::::::::s+ ${shippingType.value
                                                        .toString()}");
                                                    // sPrice1 = 0.0;
                                                    if (cartController.directOrderResponse.value.shippingOption.value
                                                        .isNotEmpty) {
                                                      log("kiska price hai + ${cartController.directOrderResponse.value
                                                          .prodcutData!.sPrice }");
                                                      sPrice1 = sPrice1 +
                                                          cartController.directOrderResponse.value.prodcutData!.sPrice;
                                                      // sPrice.toStringAsFixed(fractionDigits)
                                                      // Update sPrice directly without reassigning
                                                    }

                                                    total = subtotal + sPrice1;
                                                    print('total isss${total.toString()}');
                                                    cartController.formattedTotal = total.toStringAsFixed(3);
                                                  });
                                                },
                                              ),
                                              20.spaceX,
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(product.name
                                                        .toString()
                                                        .capitalize!
                                                        .replaceAll('_', ' '),
                                                        style: GoogleFonts.poppins(fontWeight: FontWeight.w500,
                                                            fontSize: 16)),
                                                    3.spaceY,
                                                    Text("KWD " + icarryTotal.toString(),
                                                        style: GoogleFonts.poppins(fontWeight: FontWeight.w400,
                                                            fontSize: 16,
                                                            color: const Color(0xFF03a827))),
                                                    3.spaceY,
                                                    Text(product.methodName.toString(),
                                                        style: GoogleFonts.poppins(fontWeight: FontWeight.w400,
                                                            fontSize: 16,
                                                            color: Colors.black)),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    });
                                    // : 0.spaceY,;
                                  },
                                ),
                              ),


                          ],
                        )
                      // : const SizedBox()
                    ],
                  )
                ],
              ),
              20.spaceY,
              //   Column(
              //   children: [
              //     Form(
              //       key: _formKey,
              //       child: Container(
              //         decoration: const BoxDecoration(color: Colors.white),
              //         child: Padding(
              //           padding: const EdgeInsets.symmetric(horizontal: 20),
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               const SizedBox(
              //                 height: 15,
              //               ),
              //               Text(
              //                 'Billing Address',
              //                 style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.black),
              //               ),
              //               const SizedBox(
              //                 height: 15,
              //               ),
              //               ...commonField(
              //                   textController: cartController.billingFirstName,
              //                   title: "First Name *",
              //                   hintText: "Enter your first name",
              //                   keyboardType: TextInputType.text,
              //                   validator: (value) {
              //                     if (value!.trim().isEmpty) {
              //                       return "Please enter first name";
              //                     }
              //                     return null;
              //                   }),
              //               ...commonField(
              //                   textController: cartController.billingLastName,
              //                   title: "Last Name *",
              //                   hintText: "Enter your last name",
              //                   keyboardType: TextInputType.text,
              //                   validator: (value) {
              //                     if (value!.trim().isEmpty) {
              //                       return "Please enter last name";
              //                     }
              //                     return null;
              //                   }),
              //               ...commonField(
              //                 textController: cartController.billingEmail,
              //                 title: "Email *",
              //                 hintText: "Enter your Email",
              //                 keyboardType: TextInputType.text,
              //                 validator: (value) {
              //                   if (value!.trim().isEmpty) {
              //                     return "Please enter your email".tr;
              //                   } else if (value.trim().contains('+') || value.trim().contains(' ')) {
              //                     return "Email is invalid";
              //                   } else if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              //                       .hasMatch(value.trim())) {
              //                     return null;
              //                   } else {
              //                     return 'Please type a valid email address'.tr;
              //                   }
              //                 },
              //               ),
              //               ...commonField(
              //                   textController: cartController.billingPhone,
              //                   title: "Phone Number *",
              //                   hintText: "Enter your phone number",
              //                   keyboardType: TextInputType.phone,
              //                   validator: (value) {
              //                     if (value!.trim().isEmpty) {
              //                       return "Please enter phone number";
              //                     }
              //                     return null;
              //                   }),
              //               const SizedBox(
              //                 height: 20,
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ),
              //     const SizedBox(
              //       height: 15,
              //     ),
              //   ],
              // ),
              Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Billing Address',
                              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.black),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Same As Shipping Address',
                                  style:
                                  GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black),
                                ),
                                10.spaceX,
                                Transform.translate(
                                  offset: const Offset(-6, 0),
                                  child: Checkbox(
                                      visualDensity: const VisualDensity(horizontal: -1, vertical: -3),
                                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      value: cartController.isDelivery.value,
                                      // side: BorderSide(
                                      //   color: showValidation.value == false ? AppTheme.buttonColor : Colors.red,
                                      // ),
                                      side: const BorderSide(
                                        color: AppTheme.buttonColor,
                                      ),
                                      onChanged: (bool? value) {
                                        setState(() {
                                          cartController.isDelivery.value = value!;
                                          if (cartController.isDelivery.value == true &&
                                              (cartController.selectedAddress.id != null ||
                                                  cartController.myDefaultAddressModel.value.defaultAddress != null)) {
                                            if (cartController.selectedAddress.id != null) {
                                              cartController.addressDeliFirstName.text = cartController.selectedAddress.getFirstName;
                                              cartController.addressDeliLastName.text = cartController.selectedAddress.getLastName;
                                              cartController.addressDeliEmail.text = cartController.selectedAddress.getEmail;
                                              cartController.addressDeliPhone.text = cartController.selectedAddress.getPhone;
                                              cartController.addressDeliAlternate.text = cartController.selectedAddress.getAlternate;
                                              cartController.addressDeliAddress.text = cartController.selectedAddress.getAddress;
                                              cartController.addressCountryController.text = cartController.selectedAddress.getCountry;
                                              cartController.addressStateController.text = cartController.selectedAddress.getState;
                                              cartController.addressCityController.text = cartController.selectedAddress.getCity;
                                              cartController.addressDeliZipCode.text = cartController.selectedAddress.getZipCode;
                                            } else if (cartController.myDefaultAddressModel.value.defaultAddress != null) {
                                              cartController.addressDeliFirstName.text =
                                                  cartController.myDefaultAddressModel.value.defaultAddress!.getFirstName;
                                              cartController.addressDeliLastName.text =
                                                  cartController.myDefaultAddressModel.value.defaultAddress!.getLastName;
                                              cartController.addressDeliEmail.text =
                                                  cartController.myDefaultAddressModel.value.defaultAddress!.getEmail;
                                              cartController.addressDeliPhone.text =
                                                  cartController.myDefaultAddressModel.value.defaultAddress!.getPhone;
                                              cartController.addressDeliAlternate.text =
                                                  cartController.myDefaultAddressModel.value.defaultAddress!.getAlternate;
                                              cartController.addressDeliAddress.text =
                                                  cartController.myDefaultAddressModel.value.defaultAddress!.getAddress;
                                              cartController.addressCountryController.text =
                                                  cartController.myDefaultAddressModel.value.defaultAddress!.getCountry;
                                              cartController.addressStateController.text =
                                                  cartController.myDefaultAddressModel.value.defaultAddress!.getState;
                                              cartController.addressCityController.text =
                                                  cartController.myDefaultAddressModel.value.defaultAddress!.getCity;
                                              cartController.addressDeliZipCode.text =
                                                  cartController.myDefaultAddressModel.value.defaultAddress!.getZipCode;
                                            }
                                          } else if (cartController.isDelivery.value == true &&
                                              cartController.selectedAddress.id == null &&
                                              cartController.myDefaultAddressModel.value.defaultAddress == null) {
                                            showToast("Please Select Address".tr);
                                            cartController.isDelivery.value = false;
                                          } else {
                                            cartController.addressDeliFirstName.text = '';
                                            cartController.addressDeliLastName.text = '';
                                            cartController.addressDeliEmail.text = '';
                                            cartController.addressDeliPhone.text = '';
                                            cartController.addressDeliAlternate.text = '';
                                            cartController.addressDeliAddress.text = '';
                                            cartController.addressDeliZipCode.text = '';
                                            cartController.addressCountryController.text = '';
                                            cartController.addressStateController.text = '';
                                            cartController.addressCityController.text = '';
                                          }
                                        });
                                      }),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            ...commonField(
                                textController: cartController.addressDeliFirstName,
                                title: "First Name *",
                                hintText: "Enter your first name",
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  // if (value!.trim().isEmpty) {
                                  //   return "Please enter first name";
                                  // }
                                  return null;
                                }),
                            ...commonField(
                                textController: cartController.addressDeliLastName,
                                title: "Last Name *",
                                hintText: "Enter your last name",
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  // if (value!.trim().isEmpty) {
                                  //   return "Please enter last name";
                                  // }
                                  return null;
                                }),
                            ...commonField(
                              textController: cartController.addressDeliEmail,
                              title: "Email *",
                              hintText: "Enter your Email",
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                // if (value!.trim().isEmpty) {
                                //   return "Please enter your email".tr;
                                // }
                                // else if (value.trim().contains('+') || value.trim().contains(' ')) {
                                //   return "Email is invalid";
                                // }
                                // else if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                //     .hasMatch(value.trim())) {
                                //   return null;
                                // } else {
                                //   return 'Please type a valid email address'.tr;
                                // }
                                return null;
                              },
                            ),
                            ...commonField(
                                textController: cartController.addressDeliPhone,
                                title: "Phone Number *",
                                hintText: "Enter your phone number",
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  // if (value!.trim().isEmpty) {
                                  //   return "Please enter phone number";
                                  // }
                                  return null;
                                }),
                            ...commonField(
                                textController: cartController.addressDeliAlternate,
                                title: "Alternate Phone Number *",
                                hintText: "Enter your alternate phone number",
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  return null;
                                }),
                            ...fieldWithName(
                              title: 'Country/Region',
                              hintText: 'United States',
                              readOnly: true,
                              onTap: () {
                                showAddressSelectorDialog(
                                    addressList: modelCountryList!.country!
                                        .map((e) =>
                                        CommonAddressRelatedClass(
                                            title: e.name.toString(),
                                            addressId: e.id.toString(),
                                            flagUrl: e.icon.toString()))
                                        .toList(),
                                    selectedAddressIdPicked: (String gg) {
                                      String previous = ((selectedCountry ?? Country()).id ?? "").toString();
                                      selectedCountry =
                                          modelCountryList!.country!.firstWhere((element) => element.id.toString() == gg);
                                      cartController.countryCode = gg.toString();
                                      cartController.countryName.value = selectedCountry!.name.toString();
                                      print('countrrtr ${cartController.countryName.toString()}');
                                      print('countrrtr ${cartController.countryCode.toString()}');
                                      if (previous != selectedCountry!.id.toString()) {
                                        getStateList(countryId: gg, reset: true).then((value) {
                                          setState(() {});
                                        });
                                        setState(() {});
                                      }
                                    },
                                    selectedAddressId: ((selectedCountry ?? Country()).id ?? "").toString());
                              },
                              controller: TextEditingController(
                                  text: (selectedCountry ?? Country()).name ??
                                      cartController.addressCountryController.text),
                              validator: (v) {
                                if (v!.trim().isEmpty) {
                                  return "Please select country";
                                }
                                return null;
                              },
                            ),
                            ...fieldWithName(
                              title: 'State',
                              hintText: 'Select State',
                              controller: TextEditingController(
                                  text: (selectedState ?? CountryState()).stateName ??
                                      cartController.addressStateController.text),
                              readOnly: true,
                              onTap: () {
                                if (modelStateList == null && stateRefresh.value > 0) {
                                  showToast("Select Country First");
                                  return;
                                }
                                if (stateRefresh.value < 0) {
                                  return;
                                }
                                if (modelStateList!.state!.isEmpty) return;
                                showAddressSelectorDialog(
                                    addressList: profileController.selectedLAnguage.value == 'English'
                                        ? modelStateList!.state!
                                        .map((e) =>
                                        CommonAddressRelatedClass(
                                            title: e.stateName.toString(), addressId: e.stateId.toString()))
                                        .toList()
                                        : modelStateList!.state!
                                        .map((e) =>
                                        CommonAddressRelatedClass(
                                            title: e.arabStateName.toString(), addressId: e.stateId.toString()))
                                        .toList(),
                                    selectedAddressIdPicked: (String gg) {
                                      String previous = ((selectedState ?? CountryState()).stateId ?? "").toString();
                                      selectedState = modelStateList!.state!
                                          .firstWhere((element) => element.stateId.toString() == gg);
                                      if (previous != selectedState!.stateId.toString()) {
                                        getCityList(stateId: gg, reset: true).then((value) {
                                          setState(() {});
                                        });
                                        setState(() {});
                                      }
                                    },
                                    selectedAddressId: ((selectedState ?? CountryState()).stateId ?? "").toString());
                              },
                              suffixIcon: Obx(() {
                                if (stateRefresh.value > 0) {
                                  return const Icon(Icons.keyboard_arrow_down_rounded);
                                }
                                return const CupertinoActivityIndicator();
                              }),
                              validator: (v) {
                                if (v!.trim().isEmpty) {
                                  return "Please select state";
                                }
                                return null;
                              },
                            ),
                            // if (modelCityList != null && modelCityList!.city!.isNotEmpty)
                            ...fieldWithName(
                              readOnly: true,
                              title: 'City',
                              hintText: 'Select City',
                              controller: TextEditingController(
                                  text: (selectedCity ?? City()).cityName ?? cartController.addressCityController.text),
                              onTap: () {
                                if (modelCityList == null && cityRefresh.value > 0) {
                                  showToast("Select State First");
                                  return;
                                }
                                if (cityRefresh.value < 0) {
                                  return;
                                }
                                if (modelCityList!.city!.isEmpty) return;
                                showAddressSelectorDialog(
                                    addressList: profileController.selectedLAnguage.value == 'English'
                                        ? modelCityList!.city!
                                        .map((e) =>
                                        CommonAddressRelatedClass(
                                            title: e.cityName.toString(), addressId: e.cityId.toString()))
                                        .toList()
                                        : modelCityList!.city!
                                        .map((e) =>
                                        CommonAddressRelatedClass(
                                            title: e.arabCityName.toString(), addressId: e.cityId.toString()))
                                        .toList(),
                                    selectedAddressIdPicked: (String gg) {
                                      selectedCity =
                                          modelCityList!.city!.firstWhere((element) => element.cityId.toString() == gg);
                                      cartController.cityCode = gg.toString();
                                      cartController.cityName.value = selectedCity!.cityName.toString();
                                      setState(() {});
                                    },
                                    selectedAddressId: ((selectedCity ?? City()).cityId ?? "").toString());
                              },
                              suffixIcon: Obx(() {
                                if (cityRefresh.value > 0) {
                                  return const Icon(Icons.keyboard_arrow_down_rounded);
                                }
                                return const CupertinoActivityIndicator();
                              }),
                              validator: (v) {
                                if (v!.trim().isEmpty) {
                                  return "Please select state";
                                }
                                return null;
                              },
                            ),
                            ...commonField(
                                textController: cartController.addressDeliAddress,
                                title: "Address *",
                                hintText: "Enter your address",
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  // if (value!.trim().isEmpty) {
                                  //   return "Please enter your address";
                                  // }
                                  return null;
                                }),
                            // ...commonField(
                            //     textController: cartController.addressDeliOtherInstruction,
                            //     title: "Other instruction *",
                            //     hintText: "Enter other instruction",
                            //     keyboardType: TextInputType.text,
                            //     validator: (value) {
                            //       return null;
                            //     }
                            // ),
                            ...commonField(
                                textController: cartController.addressDeliZipCode,
                                title: "Zip Code *",
                                hintText: "Enter location Zip-Code",
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  // if (value!.trim().isEmpty) {
                                  //   return "Please enter phone number";
                                  // }
                                  return null;
                                }),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Your Order".tr, style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18)),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Subtotal'.tr,
                          // Text("${'Subtotal'.tr} (${cartController.directOrderResponse.value.prodcutData!.inStock} ${'items'
                          //   .tr})",
                            style: GoogleFonts.poppins(fontWeight: FontWeight.w400, color: const Color(0xff949495))),
                        Text("KWD ${cartController.directOrderResponse.value.subtotal.toString()}",
                            style: GoogleFonts.poppins(fontWeight: FontWeight.w400, color: const Color(0xff949495))),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Shipping".tr,
                            style: GoogleFonts.poppins(fontWeight: FontWeight.w400, color: const Color(0xff949495))),
                        Text("KWD ${commisionShipping.toString()}",
                            style: GoogleFonts.poppins(fontWeight: FontWeight.w400, color: const Color(0xff949495))),
                        // Text("KWD ${sPrice1.toString()}",
                        //     style: GoogleFonts.poppins(fontWeight: FontWeight.w400, color: const Color(0xff949495))),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total".tr, style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18)),
                        total == 0.0
                            ? Text("KWD ${cartController.directOrderResponse.value.subtotal.toString()}",
                            style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18))
                            : Text("KWD ${cartController.formattedTotal.toString()}",
                            style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18)),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ) : const LoadingAnimation();
      }),
      bottomNavigationBar: InkWell(
        onTap: () {
          print("id::::::::::::::::::::::::::::" + cartController.countryId);
          if (cartController.countryId.isNotEmpty) {
            showValidation.value = true;
            if (cartController.deliveryOption1.value == 'delivery') {
              BuildContext? context1 = addressKey.currentContext;
              if (context1 != null) {
                Scrollable.ensureVisible(context1, duration: const Duration(milliseconds: 650));
              }
              showToast("Please select delivery options".tr);
              return;
            }
            if (cartController.countryId.isEmpty) {
              BuildContext? context1 = addressKey.currentContext;
              if (context1 != null) {
                Scrollable.ensureVisible(context1, duration: const Duration(milliseconds: 650));
              }
              showToast("Select delivery address to complete order".tr);
              return;
            }
            if(cartController.directOrderResponse.value.prodcutData!.itemType != 'service' && cartController.directOrderResponse.value.prodcutData!.itemType != 'virtual_product') {
              if (cartController.directOrderResponse.value.fedexShippingOption.isEmpty &&
                  cartController.countryName.value != 'Kuwait') {
                showToast("Please select shipping Method".tr);
                return;
              }
            }
            cartController.dialogOpened = false;
            print("type" + shippingType.value);
            cartController.placeOrder(
              idd: cartController.shippingId,
              title: cartController.shippingTitle.toString(),
              context: context,
              currencyCode: "kwd",
              paymentMethod: paymentMethod1,
              shippingId: shipId.value.toString(),
              shipmentProvider: shipmentProvider.value.toString(),
              // deliveryOption: deliveryOption.value,
              purchaseType: PurchaseType.buy,
              deliveryOption: 'delivery',
              productID: cartController.directOrderResponse.value.prodcutData!.id.toString(),
              subTotalPrice: cartController.directOrderResponse.value.subtotal.toString(),
              totalPrice: cartController.formattedTotal != '' ? cartController.formattedTotal.toString() : cartController.directOrderResponse.value.subtotal.toString() ,
              quantity: cartController.directOrderResponse.value.prodcutData!.inStock.toString(),
              purchaseType1: shippingType.value.toString(),
              address: selectedAddress.toJson(),);
          } else {
            showToast('Please Choose Address');
          }
        },
        child: Container(
          decoration: const BoxDecoration(color: Color(0xff014E70)),
          height: 56,
          alignment: Alignment.bottomCenter,
          child: Align(
              alignment: Alignment.center,
              child: Text("Complete Payment".tr,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white))),
        ),
      ),
    );
  }

  showAddressSelectorDialog({
    required List<CommonAddressRelatedClass> addressList,
    required String selectedAddressId,
    required Function(String selectedId) selectedAddressIdPicked,
  }) {
    FocusManager.instance.primaryFocus!.unfocus();
    final TextEditingController searchController = TextEditingController();
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            insetPadding: const EdgeInsets.all(18),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: StatefulBuilder(builder: (context, newState) {
                String gg = searchController.text.trim().toLowerCase();
                List<CommonAddressRelatedClass> filteredList =
                addressList.where((element) => element.title.toString().toLowerCase().contains(gg)).toList();
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: searchController,
                      onChanged: (gg) {
                        newState(() {});
                      },
                      autofocus: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: AppTheme.buttonColor, width: 1.2)),
                          enabled: true,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: AppTheme.buttonColor, width: 1.2)),
                          suffixIcon: const Icon(Icons.search),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12)),
                    ),
                    Flexible(
                        child: ListView.builder(
                            itemCount: filteredList.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return ListTile(
                                // dense: true,
                                onTap: () {
                                  selectedAddressIdPicked(filteredList[index].addressId);
                                  FocusManager.instance.primaryFocus!.unfocus();
                                  Get.back();
                                },
                                leading: filteredList[index].flagUrl != null
                                    ? SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: filteredList[index].flagUrl.toString().contains("svg")
                                        ? SvgPicture.network(
                                      filteredList[index].flagUrl.toString(),
                                    )
                                        : Image.network(
                                      filteredList[index].flagUrl.toString(),
                                      errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                                    ))
                                    : null,
                                visualDensity: VisualDensity.compact,
                                title: Text(filteredList[index].title),
                                trailing: selectedAddressId == filteredList[index].addressId
                                    ? const Icon(
                                  Icons.check,
                                  color: Colors.purple,
                                )
                                    : Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 18,
                                  color: Colors.grey.shade800,
                                ),
                              );
                            }))
                  ],
                );
              }),
            ),
          );
        });
  }

  Column paymentMethod(Size size) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                Text("Payment".tr, style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18)),
                const SizedBox(
                  height: 15,
                ),
                // Row(
                //   children: [
                //     Container(
                //       width: size.width * .3,
                //       height: size.height * .08,
                //       decoration: BoxDecoration(
                //           border: Border.all(color: const Color(0xffAFB1B1)), borderRadius: BorderRadius.circular(12)),
                //       alignment: Alignment.center,
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Image.asset(
                //             "assets/images/knet.png",
                //             width: 50,
                //             height: 55,
                //           )
                //         ],
                //       ),
                //     ),
                //     const SizedBox(
                //       width: 15,
                //     ),
                //     Container(
                //       width: size.width * .3,
                //       height: size.height * .08,
                //       decoration: BoxDecoration(
                //           border: Border.all(color: const Color(0xffAFB1B1)), borderRadius: BorderRadius.circular(12)),
                //       alignment: Alignment.center,
                //       child: Column(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           const Icon(
                //             Icons.credit_card,
                //             color: Color(0xffAFB1B1),
                //           ),
                //           Text("Credit Card".tr, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12)),
                //         ],
                //       ),
                //     )
                //   ],
                // ),
                if (methods != null && methods!.data != null)
                  DropdownButtonFormField(
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: AppTheme.secondaryColor),
                        ),
                        enabled: true,
                        filled: true,
                        hintText: "Select Payment Method".tr,
                        labelStyle: GoogleFonts.poppins(color: Colors.black),
                        labelText: "Select Payment Method".tr,
                        fillColor: const Color(0xffE2E2E2).withOpacity(.35),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: AppTheme.secondaryColor),
                        ),
                      ),
                      isExpanded: true,
                      items: methods!.data!
                          .map((e) =>
                          DropdownMenuItem(
                              value: e.paymentMethodId.toString(),
                              child: Row(
                                children: [
                                  Expanded(child: Text(e.paymentMethodEn.toString())),
                                  SizedBox(width: 35, height: 35, child: Image.network(e.imageUrl.toString()))
                                ],
                              )))
                          .toList(),
                      onChanged: (value) {
                        if (value == null) return;
                        paymentMethod1 = value;
                        setState(() {});
                      })
                else
                  const LoadingAnimation(),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  Container addressPart(Size size) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        key: addressKey,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Obx(() {
          if (cartController.refreshInt.value > 0) {}
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row(
              //   children: [
              //     Expanded(
              //         child:
              //         Text("Delivery to".tr, style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18))),
              //     Radio<String>(
              //       value: "delivery",
              //       groupValue: cartController.deliveryOption1.value.isNotEmpty
              //           ? cartController.deliveryOption1.value
              //           : "delivery",
              //       visualDensity: VisualDensity.compact,
              //       // fillColor: cartController.deliveryOption1.value.isEmpty &&
              //       //     cartController.showValidation.value
              //       //     ? MaterialStateProperty.all(Colors.red)
              //       //     : null,
              //       onChanged: (value) {
              //         cartController.deliveryOption1.value = value!;
              //       },
              //     )
              //
              //   ],
              // ),
              const SizedBox(
                height: 15,
              ),
              // if (deliveryOption.value == "delivery") ...[
              //   Material(
              //     child: InkWell(
              //       onTap: () {
              //         if (userLoggedIn) {
              //           bottomSheetChangeAddress();
              //         } else {
              //           addAddressWithoutLogin(addressData: selectedAddress);
              //         }
              //       },
              //       child: DottedBorder(
              //         color: const Color(0xff014E70),
              //         strokeWidth: 1.2,
              //         dashPattern: const [6, 3, 0, 3],
              //         child: Container(
              //           // height: 50,
              //           padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              //           width: size.width,
              //           alignment: Alignment.center,
              //           child: selectedAddress.id != null
              //               ? Text(selectedAddress.getShortAddress,
              //               style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16))
              //               : Text("Select Address ".tr,
              //               style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16)),
              //         ),
              //       ),
              //     ),
              //   ),
              //   const SizedBox(
              //     height: 15,
              //   ),
              //   if (selectedAddress.id != null)
              //     InkWell(
              //         onTap: () {
              //           if (userLoggedIn) {
              //             bottomSheetChangeAddress();
              //           } else {
              //             addAddressWithoutLogin(addressData: selectedAddress);
              //           }
              //         },
              //         child: Align(
              //             alignment: Alignment.topRight,
              //             child: Text("Change Address".tr,
              //                 style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)))),
              // ],

              Material(
                child: InkWell(
                  onTap: () {
                    if (userLoggedIn) {
                      if (selectedAddress.id == null) {
                        bottomSheetChangeAddress();
                      } else {
                        showDialog<String>(
                            context: context,
                            builder: (BuildContext context) =>
                                AlertDialog(
                                  title: Text('Change Address'.tr),
                                  content: Text('Do you want to change your address.'.tr),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => Get.back(),
                                      child: Text('Cancel'.tr),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        Get.back();
                                        bottomSheetChangeAddress();
                                      },
                                      child: Text('Yes'.tr),
                                    ),
                                  ],
                                ));
                      }
                    } else {
                      addAddressWithoutLogin(addressData: selectedAddress);
                    }
                  },
                  child: DottedBorder(
                    color: const Color(0xff014E70),
                    strokeWidth: 1.2,
                    dashPattern: const [6, 3, 0, 3],
                    child: Container(
                      // height: 50,
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                      width: size.width,
                      alignment: Alignment.center,

                      child: cartController.selectedAddress.id != null
                          ? Text(cartController.selectedAddress.getShortAddress,
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16))
                          : cartController.myDefaultAddressModel.value.defaultAddress?.isDefault == true
                          ? Text(cartController.myDefaultAddressModel.value.defaultAddress!.getShortAddress,
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16))
                          : Text("Choose Address".tr,
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16)),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              if (selectedAddress.id != null ||
                  cartController.myDefaultAddressModel.value.defaultAddress?.isDefault == true)
                InkWell(
                    onTap: () {
                      if (userLoggedIn) {
                        bottomSheetChangeAddress();
                      } else {
                        Get.toNamed(
                          LoginScreen.route,
                        );
                      }
                    },
                    child: Align(
                        alignment: Alignment.topRight,
                        child: Text("Change Address".tr,
                            style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)))),

              // Row(
              //   children: [
              //     Expanded(
              //         child: Text("Pick Up".tr, style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18))),
              //     Radio<String>(
              //         value: "pickup",
              //         groupValue: deliveryOption.value,
              //         visualDensity: VisualDensity.compact,
              //         fillColor: deliveryOption.value.isEmpty && showValidation.value
              //             ? MaterialStateProperty.all(Colors.red)
              //             : null,
              //         onChanged: (value) {
              //           deliveryOption.value = value!;
              //         })
              //   ],
              // ),
              const SizedBox(
                height: 10,
              ),
            ],
          );
        }),
      ),
    );
  }

  Future bottomSheet({required AddressData addressData}) {
    Size size = MediaQuery
        .of(context)
        .size;
    final TextEditingController firstNameController = TextEditingController(text: addressData.firstName ?? "");
    final TextEditingController emailController = TextEditingController(text: addressData.email ?? "");
    final TextEditingController lastNameController = TextEditingController(text: addressData.lastName ?? "");
    final TextEditingController phoneController = TextEditingController(text: addressData.phone ?? "");
    final TextEditingController alternatePhoneController =
    TextEditingController(text: addressData.alternatePhone ?? "");
    final TextEditingController addressController = TextEditingController(text: addressData.address ?? "");
    final TextEditingController address2Controller = TextEditingController(text: addressData.address2 ?? "");
    final TextEditingController cityController = TextEditingController(text: addressData.city ?? "");
    final TextEditingController countryController = TextEditingController(text: addressData.country ?? "");
    final TextEditingController stateController = TextEditingController(text: addressData.state ?? "");
    final TextEditingController zipCodeController = TextEditingController(text: addressData.zipCode ?? "");
    final TextEditingController landmarkController = TextEditingController(text: addressData.landmark ?? "");
    final TextEditingController titleController = TextEditingController(text: addressData.type ?? "");

    final formKey = GlobalKey<FormState>();
    String code = 'KW';
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: size.width,
              height: size.height * .8,
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...commonField(
                          textController: titleController,
                          title: "${'Title'.tr}*",
                          hintText: "Title".tr,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter address title".tr;
                            }
                            return null;
                          }),
                      ...commonField(
                          textController: firstNameController,
                          title: "${'First Name'.tr}*",
                          hintText: "First Name".tr,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter first name".tr;
                            }
                            return null;
                          }),
                      ...commonField(
                          textController: lastNameController,
                          title: "${'Last Name'.tr}*",
                          hintText: "Last Name".tr,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter Last name".tr;
                            }
                            return null;
                          }),
                      ...commonField(
                          textController: emailController,
                          title: "Email Address*",
                          hintText: "Email Address",
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter email address";
                            }
                            if (value
                                .trim()
                                .invalidEmail) {
                              return "Please enter valid email address";
                            }
                            return null;
                          }),

                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Phone *'.tr,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500, fontSize: 16, color: const Color(0xff585858)),
                      ),
                      const SizedBox(
                        height: 8,
                      ),

                      IntlPhoneField(
                        key: ValueKey(profileController.code),
                        flagsButtonPadding: const EdgeInsets.all(8),
                        dropdownIconPosition: IconPosition.trailing,
                        showDropdownIcon: true,
                        cursorColor: Colors.black,
                        textInputAction: TextInputAction.next,
                        dropdownTextStyle: const TextStyle(color: Colors.black),
                        style: const TextStyle(color: AppTheme.textColor),
                        controller: phoneController,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            hintStyle: TextStyle(color: AppTheme.textColor),
                            hintText: 'Enter your phone number',
                            labelStyle: TextStyle(color: AppTheme.textColor),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppTheme.shadowColor)),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppTheme.shadowColor))),
                        initialCountryCode: profileController.code.toString(),
                        languageCode: '+91',
                        onCountryChanged: (phone) {
                          profileController.code = phone.code;
                          print(phone.code);
                          print(profileController.code.toString());
                        },
                        onChanged: (phone) {
                          profileController.code = phone.countryISOCode.toString();
                          print(phone.countryCode);
                          print(profileController.code.toString());
                        },
                      ),

                      const SizedBox(
                        height: 5,
                      ),
                      // Text(
                      //   'Alternate Phone *'.tr,
                      //   style: GoogleFonts.poppins(
                      //       fontWeight: FontWeight.w500, fontSize: 16, color: const Color(0xff585858)),
                      // ),
                      // const SizedBox(
                      //   height: 8,
                      // ),
                      // IntlPhoneField(
                      //   // key: ValueKey(code),
                      //   flagsButtonPadding: const EdgeInsets.all(8),
                      //   dropdownIconPosition: IconPosition.trailing,
                      //   showDropdownIcon: true,
                      //   cursorColor: Colors.black,
                      //   textInputAction: TextInputAction.next,
                      //   dropdownTextStyle: const TextStyle(color: Colors.black),
                      //   style: const TextStyle(color: AppTheme.textColor),
                      //
                      //   controller: alternatePhoneController,
                      //   decoration: const InputDecoration(
                      //       contentPadding: EdgeInsets.zero,
                      //       hintStyle: TextStyle(color: AppTheme.textColor),
                      //       hintText: 'Enter your phone number',
                      //       labelStyle: TextStyle(color: AppTheme.textColor),
                      //       border: OutlineInputBorder(
                      //         borderSide: BorderSide(),
                      //       ),
                      //       enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppTheme.shadowColor)),
                      //       focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppTheme.shadowColor))),
                      //   initialCountryCode: code.toString(),
                      //   languageCode: '+91',
                      //   onCountryChanged: (phone) {
                      //     code = phone.code;
                      //     print(phone.code);
                      //     print(code.toString());
                      //   },
                      //   onChanged: (phone) {
                      //     code = phone.countryISOCode.toString();
                      //     print(phone.countryCode);
                      //     print(code.toString());
                      //   },
                      // ),

                      // ...commonField(
                      //     textController: phoneController,
                      //     title: "${'Phone'.tr}*",
                      //     hintText: "Enter your phone number".tr,
                      //     keyboardType: TextInputType.number,
                      //     validator: (value) {
                      //       if (value!.trim().isEmpty) {
                      //         return "Please enter phone number".tr;
                      //       }
                      //       if (value.trim().length > 15) {
                      //         return "Please enter valid phone number".tr;
                      //       }
                      //       if (value.trim().length < 8) {
                      //         return "Please enter valid phone number".tr;
                      //       }
                      //       return null;
                      //     }),
                      ...commonField(
                          textController: alternatePhoneController,
                          title: "${'Alternate Phone'.tr}*",
                          hintText: "Enter your alternate phone number".tr,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            // if(value!.trim().isEmpty){
                            //   return "Please enter phone number";
                            // }
                            // if(value.trim().length > 15){
                            //   return "Please enter valid phone number";
                            // }
                            // if(value.trim().length < 8){
                            //   return "Please enter valid phone number";
                            // }
                            return null;
                          }),
                      ...commonField(
                          textController: addressController,
                          title: "${'Address'.tr}*",
                          hintText: "Enter your delivery address".tr,
                          keyboardType: TextInputType.streetAddress,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter delivery address".tr;
                            }
                            return null;
                          }),
                      ...commonField(
                          textController: address2Controller,
                          title: "${'Address'.tr} 2",
                          hintText: "Enter your delivery address".tr,
                          keyboardType: TextInputType.streetAddress,
                          validator: (value) {
                            // if(value!.trim().isEmpty){
                            //   return "Please enter delivery address";
                            // }
                            return null;
                          }),

                      ...fieldWithName(
                        title: 'Country/Region',
                        hintText: 'Select Country',
                        readOnly: true,
                        onTap: () {
                          showAddressSelectorDialog(
                              addressList: modelCountryList!.country!
                                  .map((e) =>
                                  CommonAddressRelatedClass(
                                      title: e.name.toString(), addressId: e.id.toString(), flagUrl: e.icon.toString()))
                                  .toList(),
                              selectedAddressIdPicked: (String gg) {
                                String previous = ((selectedCountry ?? Country()).id ?? "").toString();
                                selectedCountry =
                                    modelCountryList!.country!.firstWhere((element) => element.id.toString() == gg);
                                cartController.countryCode = gg.toString();
                                cartController.countryName.value = selectedCountry!.name.toString();
                                print('countrrtr ${cartController.countryName.toString()}');
                                print('countrrtr ${cartController.countryCode.toString()}');
                                if (previous != selectedCountry!.id.toString()) {
                                  getStateList(countryId: gg, reset: true).then((value) {
                                    setState(() {});
                                  });
                                  setState(() {});
                                }
                              },
                              selectedAddressId: ((selectedCountry ?? Country()).id ?? "").toString());
                        },
                        controller:
                        TextEditingController(text: (selectedCountry ?? Country()).name ?? countryController.text),
                        validator: (v) {
                          if (v!.trim().isEmpty) {
                            return "Please select country";
                          }
                          return null;
                        },
                      ),
                      ...fieldWithName(
                        title: 'State',
                        hintText: 'Select State',
                        controller: TextEditingController(
                            text: (selectedState ?? CountryState()).stateName ?? stateController.text),
                        readOnly: true,
                        onTap: () {
                          if (modelStateList == null && stateRefresh.value > 0) {
                            showToast("Select Country First");
                            return;
                          }
                          if (stateRefresh.value < 0) {
                            return;
                          }
                          if (modelStateList!.state!.isEmpty) return;
                          showAddressSelectorDialog(
                              addressList: modelStateList!.state!
                                  .map((e) =>
                                  CommonAddressRelatedClass(
                                      title: e.stateName.toString(), addressId: e.stateId.toString()))
                                  .toList(),
                              selectedAddressIdPicked: (String gg) {
                                String previous = ((selectedState ?? CountryState()).stateId ?? "").toString();
                                selectedState =
                                    modelStateList!.state!.firstWhere((element) => element.stateId.toString() == gg);
                                cartController.stateCode = gg.toString();
                                cartController.stateName.value = selectedState!.stateName.toString();
                                print('state ${cartController.stateCode.toString()}');
                                print('stateNameee ${cartController.stateName.toString()}');
                                if (previous != selectedState!.stateId.toString()) {
                                  getCityList(stateId: gg, reset: true).then((value) {
                                    setState(() {});
                                  });
                                  setState(() {});
                                }
                              },
                              selectedAddressId: ((selectedState ?? CountryState()).stateId ?? "").toString());
                        },
                        suffixIcon: Obx(() {
                          if (stateRefresh.value > 0) {
                            return const Icon(Icons.keyboard_arrow_down_rounded);
                          }
                          return const CupertinoActivityIndicator();
                        }),
                        validator: (v) {
                          if (v!.trim().isEmpty) {
                            return "Please select state";
                          }
                          return null;
                        },
                      ),
                      // if (modelCityList != null && modelCityList!.city!.isNotEmpty)
                      ...fieldWithName(
                        readOnly: true,
                        title: 'City',
                        hintText: 'Select City',
                        controller:
                        TextEditingController(text: (selectedCity ?? City()).cityName ?? cityController.text),
                        onTap: () {
                          if (modelCityList == null && cityRefresh.value > 0) {
                            showToast("Select State First");
                            return;
                          }
                          if (cityRefresh.value < 0) {
                            return;
                          }
                          if (modelCityList!.city!.isEmpty) return;
                          showAddressSelectorDialog(
                              addressList: modelCityList!.city!
                                  .map((e) =>
                                  CommonAddressRelatedClass(
                                      title: e.cityName.toString(), addressId: e.cityId.toString()))
                                  .toList(),
                              selectedAddressIdPicked: (String gg) {
                                selectedCity =
                                    modelCityList!.city!.firstWhere((element) => element.cityId.toString() == gg);
                                cartController.cityCode = gg.toString();
                                cartController.cityName.value = selectedCity!.cityName.toString();
                                print('state ${cartController.cityName.toString()}');
                                print('stateNameee ${cartController.cityCode.toString()}');
                                setState(() {});
                              },
                              selectedAddressId: ((selectedCity ?? City()).cityId ?? "").toString());
                        },
                        suffixIcon: Obx(() {
                          if (cityRefresh.value > 0) {
                            return const Icon(Icons.keyboard_arrow_down_rounded);
                          }
                          return const CupertinoActivityIndicator();
                        }),
                        validator: (v) {
                          if (v!.trim().isEmpty) {
                            return "Please select state";
                          }
                          return null;
                        },
                      ),
                      if (cartController.countryName.value != 'Kuwait')
                        ...commonField(
                            textController: landmarkController,
                            title: "Landmark".tr,
                            hintText: "Enter your nearby landmark".tr,
                            keyboardType: TextInputType.streetAddress,
                            validator: (value) {
                              // if(value!.trim().isEmpty){
                              //   return "Please enter delivery address";
                              // }
                              return null;
                            }),
                      if (cartController.countryName.value != 'Kuwait')
                        ...commonField(
                            textController: zipCodeController,
                            title: "${'Zip-Code'.tr}*",
                            hintText: "Enter location Zip-Code".tr,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return "${'Please enter Zip-Code'.tr}*";
                              }
                              return null;
                            }),
                      const SizedBox(
                        height: 16,
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            cartController.updateAddressApi(
                                context: context,
                                email: emailController.text.trim(),
                                firstName: firstNameController.text.trim(),
                                title: titleController.text.trim(),
                                lastName: lastNameController.text.trim(),
                                state: cartController.stateName.toString(),
                                countryName: cartController.countryName.toString(),
                                stateId: cartController.stateCode.toString(),
                                cityId: cartController.cityCode.toString(),
                                country: cartController.countryCode.toString(),
                                city: cartController.cityName.toString(),
                                address2: address2Controller.text.trim(),
                                address: addressController.text.trim(),
                                alternatePhone: alternatePhoneController.text.trim(),
                                landmark: landmarkController.text.trim(),
                                phone: phoneController.text.trim(),
                                zipCode: zipCodeController.text.trim(),
                                phoneCountryCode: profileController.code.toString(),
                                type: 'checkout',
                                id: addressData.id, shortCode: controllerMap.countryCode.toString());
                          }
                        },
                        child: Container(
                          decoration: const BoxDecoration(color: Color(0xff014E70)),
                          height: 56,
                          alignment: Alignment.bottomCenter,
                          child: Align(
                              alignment: Alignment.center,
                              child: Text("Save".tr,
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500, fontSize: 19, color: Colors.white))),
                        ),
                      ),
                      SizedBox(height: MediaQuery
                          .of(context)
                          .viewInsets
                          .bottom),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  List<Widget> fieldWithName({required String title,
    required String hintText,
    required TextEditingController controller,
    FormFieldValidator<String>? validator,
    bool? readOnly,
    VoidCallback? onTap,
    Widget? suffixIcon}) {
    return [
      Text(
        title,
        style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500),
      ),
      const SizedBox(
        height: 5,
      ),
      CommonTextField(
        onTap: onTap,
        hintText: hintText,
        controller: controller,
        validator: validator,
        readOnly: readOnly ?? false,
        suffixIcon: suffixIcon,
      ),
      const SizedBox(
        height: 12,
      ),
    ];
  }

  List<Widget> commonField({
    required TextEditingController textController,
    required String title,
    required String hintText,
    required FormFieldValidator<String>? validator,
    required TextInputType keyboardType,
  }) {
    return [
      const SizedBox(
        height: 5,
      ),
      Text(
        title,
        style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18, color: const Color(0xff585858)),
      ),
      const SizedBox(
        height: 8,
      ),
      CommonTextField(
        controller: textController,
        obSecure: false,
        hintText: hintText,
        validator: validator,
        keyboardType: keyboardType,
      ),
    ];
  }

  Future bottomSheetChangeAddress() {
    Size size = MediaQuery
        .of(context)
        .size;
    cartController.getAddress();
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(20).copyWith(top: 10),
            child: SizedBox(
              width: size.width,
              height: size.height * .88,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 6,
                        decoration: BoxDecoration(color: Colors.grey.shade400, borderRadius: BorderRadius.circular(100)),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CommonTextField(
                    onTap: () {
                      // bottomSheet();
                    },
                    obSecure: false,
                    hintText: '+ Add Address',
                  ),
                  Expanded(
                    child: Obx(() {
                      if (cartController.refreshInt11.value > 0) {}
                      List<AddressData> shippingAddress = cartController.addressListModel.address!.shipping ?? [];

                      return CustomScrollView(
                        shrinkWrap: true,
                        slivers: [
                          SliverToBoxAdapter(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Shipping Address",
                                    style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16),
                                  ),
                                ),
                                TextButton.icon(
                                    onPressed: () {
                                      bottomSheet(addressData: AddressData());
                                    },
                                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                                    icon: const Icon(
                                      Icons.add,
                                      size: 20,
                                    ),
                                    label: Text(
                                      "Add New",
                                      style: GoogleFonts.poppins(fontSize: 15),
                                    ))
                              ],
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Row(
                              children: [
                                const Expanded(
                                  child:SizedBox(),
                                ),
                                TextButton.icon(
                                    onPressed: () {
                                      Get.to(()=> FindMyLocationAddress());
                                    },
                                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                                    icon: const Icon(
                                      Icons.add,
                                      size: 20,
                                    ),
                                    label: Text(
                                      "Find my location",
                                      style: GoogleFonts.poppins(fontSize: 15),
                                    ))
                              ],
                            ),
                          ),
                          const SliverPadding(padding: EdgeInsets.only(top: 4)),
                          shippingAddress.isNotEmpty
                              ? SliverList(
                              delegate: SliverChildBuilderDelegate(
                                childCount: shippingAddress.length,
                                    (context, index) {
                                  final address = shippingAddress[index];
                                  return GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () {
                                      cartController.selectedAddress = address;
                                      cartController.countryId = address.countryId.toString();
                                      countryIddd = address.countryId.toString();
                                      log('fdfd${countryIddd.toString()}');
                                      cartController.zipCode = address.zipCode.toString();
                                      directBuyProduct();
                                      // cartController.getCart();
                                      cartController.countryName.value = address.country.toString();
                                      print('onTap is....${cartController.countryName.value}');
                                      if (cartController.isDelivery.value == true) {
                                        cartController.addressDeliFirstName.text =
                                            cartController.selectedAddress.getFirstName;
                                        cartController.addressDeliLastName.text = cartController.selectedAddress.getLastName;
                                        cartController.addressDeliEmail.text = cartController.selectedAddress.getEmail;
                                        cartController.addressDeliPhone.text = cartController.selectedAddress.getPhone;
                                        cartController.addressDeliAlternate.text =
                                            cartController.selectedAddress.getAlternate;
                                        cartController.addressDeliAddress.text = cartController.selectedAddress.getAddress;
                                        cartController.addressDeliZipCode.text = cartController.selectedAddress.getZipCode;
                                        cartController.addressCountryController.text =
                                            cartController.selectedAddress.getCountry;
                                        cartController.addressStateController.text = cartController.selectedAddress.getState;
                                        cartController.addressCityController.text = cartController.selectedAddress.getCity;
                                      }
                                      print('codeee isss${cartController.countryId.toString()}');
                                      Get.back();
                                      setState(() {});
                                    },
                                    child: Container(
                                      width: size.width,
                                      margin: const EdgeInsets.only(bottom: 15),
                                      padding: const EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(color: const Color(0xffDCDCDC))),
                                      child: IntrinsicHeight(
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Icon(Icons.location_on_rounded),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Text(
                                                address.getCompleteAddressInFormat,
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15,
                                                    color: const Color(0xff585858)),
                                              ),
                                            ),
                                            Column(
                                              children: [

                                                PopupMenuButton(
                                                    color: Colors.white,
                                                    iconSize: 20,
                                                    icon: const Icon(
                                                      Icons.more_vert,
                                                      color: Colors.black,
                                                    ),
                                                    padding: EdgeInsets.zero,
                                                    onSelected: (value) {
                                                      setState(() {

                                                      });
                                                      Navigator.pushNamed(context, value.toString());
                                                    },
                                                    itemBuilder: (ac) {
                                                      return [
                                                        PopupMenuItem(
                                                          onTap: () {
                                                            bottomSheet(addressData: address);
                                                          },
                                                          // value: '/Edit',
                                                          child: Text("Edit".tr),
                                                        ),
                                                        PopupMenuItem(
                                                          onTap: () {
                                                            cartController.selectedAddress = address;
                                                            cartController.countryName.value = address.country.toString();
                                                            cartController.countryId = address.getCountryId.toString();
                                                            cartController.zipCode = address.zipCode.toString();
                                                            print('onTap is....${cartController.selectedAddress}');
                                                            print('onTap is....${cartController.selectedAddress.id
                                                                .toString()}');
                                                            if (cartController.isDelivery.value == true) {
                                                              cartController.addressDeliFirstName.text =
                                                                  cartController.selectedAddress.getFirstName;
                                                              cartController.addressDeliLastName.text =
                                                                  cartController.selectedAddress.getLastName;
                                                              cartController.addressDeliEmail.text =
                                                                  cartController.selectedAddress.getEmail;
                                                              cartController.addressDeliPhone.text =
                                                                  cartController.selectedAddress.getPhone;
                                                              cartController.addressDeliAlternate.text =
                                                                  cartController.selectedAddress.getAlternate;
                                                              cartController.addressDeliAddress.text =
                                                                  cartController.selectedAddress.getAddress;
                                                              cartController.addressDeliZipCode.text =
                                                                  cartController.selectedAddress.getZipCode;
                                                              cartController.addressCountryController.text =
                                                                  cartController.selectedAddress.getCountry;
                                                              cartController.addressStateController.text =
                                                                  cartController.selectedAddress.getState;
                                                              cartController.addressCityController.text =
                                                                  cartController.selectedAddress.getCity;
                                                            }


                                                            defaultAddressApi();
                                                            setState(() {

                                                            });
                                                          },
                                                          // value: '/slotViewScreen',
                                                          child: Text("Default Address".tr),
                                                        ),
                                                        PopupMenuItem(
                                                          onTap: () {
                                                            cartController
                                                                .deleteAddress(
                                                              context: context,
                                                              id: address.id.toString(),
                                                            )
                                                                .then((value) {
                                                              if (value == true) {
                                                                cartController.addressListModel.address!.shipping!
                                                                    .removeWhere(
                                                                        (element) =>
                                                                    element.id.toString() == address.id.toString());
                                                                cartController.updateUI();
                                                              }
                                                            });
                                                          },
                                                          // value: '/deactivate',
                                                          child: Text("Delete".tr),
                                                        )
                                                      ];
                                                    }),
                                                address.isDefault == true ?
                                                Text(
                                                  "Default",
                                                  style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 15,
                                                      color: const Color(0xff585858)),
                                                ) : SizedBox(),


                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ))
                              : SliverToBoxAdapter(
                            child: Text(
                              "No Shipping Address Added!",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: SizedBox(
                              height: MediaQuery
                                  .of(context)
                                  .viewInsets
                                  .bottom,
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),
          );
        });
  }
   String productId =  '';
   String quantity = '';
  directBuyProduct() {
    Map<String, dynamic> map = {};
    productId = cartController.productElementId.toString();
    quantity = cartController.productQuantity.toString();
    map["product_id"] = productId.toString();
    map["quantity"] = quantity.toString();
    map["key"] = 'fedexRate';
    map["country_id"] = countryIddd.toString();
    map["zip_code"] = cartController.zipCode.toString();

    if (cartController.isBookingProduct) {
      map["start_date"] = cartController.selectedDate.toString();
      map["time_sloat"] = cartController.selectedSlot.toString();
      map["sloat_end_time"] = cartController.selectedSlot.toString();
    }
    if (cartController.isVariantType) {
      map["variation"] = cartController.selectedVariant.toString();
    }
    repositories.postApi(url: ApiUrls.buyNowDetailsUrl, mapData: map, context: context).then((value) {
      log("Value>>>>>>>$value");
      print('singleee');
      cartController.directOrderResponse.value = ModelDirectOrderResponse.fromJson(jsonDecode(value));
      showToast(cartController.directOrderResponse.value.message.toString());
      if (cartController.directOrderResponse.value.status == true) {
        if (kDebugMode) {
          print(cartController.directOrderResponse.value.prodcutData!.inStock);
        }
        // Get.toNamed(DirectCheckOutScreen.route, arguments: response);
      }
    });
  }

  Future addAddressWithoutLogin({required AddressData addressData}) {
    Size size = MediaQuery
        .of(context)
        .size;
    final TextEditingController firstNameController = TextEditingController(text: addressData.firstName ?? "");
    final TextEditingController emailController = TextEditingController(text: addressData.email ?? "");
    final TextEditingController lastNameController = TextEditingController(text: addressData.lastName ?? "");
    final TextEditingController phoneController = TextEditingController(text: addressData.phone ?? "");
    final TextEditingController alternatePhoneController =
    TextEditingController(text: addressData.alternatePhone ?? "");
    final TextEditingController addressController = TextEditingController(text: addressData.address ?? "");
    final TextEditingController address2Controller = TextEditingController(text: addressData.address2 ?? "");
    final TextEditingController cityController = TextEditingController(text: addressData.city ?? "");
    final TextEditingController countryController = TextEditingController(text: addressData.country ?? "");
    final TextEditingController stateController = TextEditingController(text: addressData.state ?? "");
    final TextEditingController zipCodeController = TextEditingController(text: addressData.zipCode ?? "");
    final TextEditingController landmarkController = TextEditingController(text: addressData.landmark ?? "");
    final TextEditingController titleController = TextEditingController(text: addressData.type ?? "");

    final formKey = GlobalKey<FormState>();

    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: size.width,
              height: size.height * .8,
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...commonField(
                          textController: titleController,
                          title: "${'Title'.tr}*",
                          hintText: "Title".tr,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter address title".tr;
                            }
                            return null;
                          }),
                      ...commonField(
                          textController: emailController,
                          title: "${'Email Address'.tr}*",
                          hintText: "Email Address".tr,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter email address".tr;
                            }
                            if (value
                                .trim()
                                .invalidEmail) {
                              return "Please enter valid email address".tr;
                            }
                            return null;
                          }),
                      ...commonField(
                          textController: firstNameController,
                          title: "${'First Name'.tr}*",
                          hintText: "First Name".tr,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter first name".tr;
                            }
                            return null;
                          }),
                      ...commonField(
                          textController: lastNameController,
                          title: "${'Last Name'.tr}*",
                          hintText: "Last Name".tr,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter Last name".tr;
                            }
                            return null;
                          }),
                      // ...commonField(
                      //     textController: emailController,
                      //     title: "Email Address*",
                      //     hintText: "Email Address",
                      //     keyboardType: TextInputType.emailAddress,
                      //     validator: (value) {
                      //       if (value!.trim().isEmpty) {
                      //         return "Please enter email address";
                      //       }
                      //       if (value.trim().invalidEmail) {
                      //         return "Please enter valid email address";
                      //       }
                      //       return null;
                      //     }),

                      Text(
                        'Phone *'.tr,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500, fontSize: 16, color: const Color(0xff585858)),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      IntlPhoneField(
                        key: ValueKey(profileController.code),
                        flagsButtonPadding: const EdgeInsets.all(8),
                        dropdownIconPosition: IconPosition.trailing,
                        showDropdownIcon: true,
                        cursorColor: Colors.black,
                        textInputAction: TextInputAction.next,
                        dropdownTextStyle: const TextStyle(color: Colors.black),
                        style: const TextStyle(color: AppTheme.textColor),
                        controller: phoneController,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            hintStyle: TextStyle(color: AppTheme.textColor),
                            hintText: 'Enter your phone number',
                            labelStyle: TextStyle(color: AppTheme.textColor),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppTheme.shadowColor)),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppTheme.shadowColor))),
                        initialCountryCode: profileController.code.toString(),
                        languageCode: '+91',
                        onCountryChanged: (phone) {
                          profileController.code = phone.code;
                          print(phone.code);
                          print(profileController.code.toString());
                        },
                        onChanged: (phone) {
                          profileController.code = phone.countryISOCode.toString();
                          print(phone.countryCode);
                          print(profileController.code.toString());
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Alternate Phone*'.tr,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500, fontSize: 16, color: const Color(0xff585858)),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      IntlPhoneField(
                        // key: ValueKey(profileController.code),
                        flagsButtonPadding: const EdgeInsets.all(8),
                        dropdownIconPosition: IconPosition.trailing,
                        showDropdownIcon: true,
                        cursorColor: Colors.black,
                        textInputAction: TextInputAction.next,
                        dropdownTextStyle: const TextStyle(color: Colors.black),
                        style: const TextStyle(color: AppTheme.textColor),
                        controller: alternatePhoneController,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            hintStyle: TextStyle(color: AppTheme.textColor),
                            hintText: 'Enter your phone number',
                            labelStyle: TextStyle(color: AppTheme.textColor),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppTheme.shadowColor)),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppTheme.shadowColor))),
                        initialCountryCode: profileController.code.toString(),
                        languageCode: '+91',
                        onCountryChanged: (phone) {
                          profileController.code = phone.code;
                          print(phone.code);
                          print(profileController.code.toString());
                        },
                        onChanged: (phone) {
                          profileController.code = phone.countryISOCode.toString();
                          print(phone.countryCode);
                          print(profileController.code.toString());
                        },
                      ),
                      ...commonField(
                          textController: addressController,
                          title: "${'Address'.tr}*",
                          hintText: "Enter your delivery address".tr,
                          keyboardType: TextInputType.streetAddress,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter delivery address".tr;
                            }
                            return null;
                          }),
                      ...commonField(
                          textController: address2Controller,
                          title: "${'Address'.tr} 2",
                          hintText: "Enter your delivery address".tr,
                          keyboardType: TextInputType.streetAddress,
                          validator: (value) {
                            // if(value!.trim().isEmpty){
                            //   return "Please enter delivery address";
                            // }
                            return null;
                          }),
                      ...fieldWithName(
                        title: 'Country/Region',
                        hintText: 'Select Country',
                        readOnly: true,
                        onTap: () {
                          showAddressSelectorDialog(
                              addressList: modelCountryList!.country!
                                  .map((e) =>
                                  CommonAddressRelatedClass(
                                      title: e.name.toString(), addressId: e.id.toString(), flagUrl: e.icon.toString()))
                                  .toList(),
                              selectedAddressIdPicked: (String gg) {
                                String previous = ((selectedCountry ?? Country()).id ?? "").toString();
                                selectedCountry =
                                    modelCountryList!.country!.firstWhere((element) => element.id.toString() == gg);
                                cartController.countryCode = gg.toString();
                                cartController.countryName.value = selectedCountry!.name.toString();
                                print('countrrtr ${cartController.countryName.toString()}');
                                print('countrrtr ${cartController.countryCode.toString()}');
                                if (previous != selectedCountry!.id.toString()) {
                                  countryIddd = gg.toString();
                                  getStateList(countryId: countryIddd.toString(), reset: true).then((value) {
                                    setState(() {});
                                  });
                                  setState(() {});
                                }
                              },
                              selectedAddressId: ((selectedCountry ?? Country()).id ?? "").toString());
                        },
                        controller:
                        TextEditingController(text: (selectedCountry ?? Country()).name ?? countryController.text),
                        validator: (v) {
                          if (v!.trim().isEmpty) {
                            return "Please select country";
                          }
                          return null;
                        },
                      ),
                      ...fieldWithName(
                        title: 'State',
                        hintText: 'Select State',
                        controller: TextEditingController(
                            text: (selectedState ?? CountryState()).stateName ?? stateController.text),
                        readOnly: true,
                        onTap: () {
                          if (countryIddd == 'null') {
                            showToast("Select Country First");
                            return;
                          }
                          if (modelStateList == null && stateRefresh.value > 0) {
                            showToast("Select Country First");
                            return;
                          }
                          if (stateRefresh.value < 0) {
                            return;
                          }
                          if (modelStateList!.state!.isEmpty) return;
                          showAddressSelectorDialog(
                              addressList: profileController.selectedLAnguage.value == 'English'
                                  ? modelStateList!.state!
                                  .map((e) =>
                                  CommonAddressRelatedClass(
                                      title: e.stateName.toString(), addressId: e.stateId.toString()))
                                  .toList()
                                  : modelStateList!.state!
                                  .map((e) =>
                                  CommonAddressRelatedClass(
                                      title: e.arabStateName.toString(), addressId: e.stateId.toString()))
                                  .toList(),
                              selectedAddressIdPicked: (String gg) {
                                String previous = ((selectedState ?? CountryState()).stateId ?? "").toString();
                                selectedState =
                                    modelStateList!.state!.firstWhere((element) => element.stateId.toString() == gg);
                                cartController.stateCode = gg.toString();
                                cartController.stateName.value = selectedState!.stateName.toString();
                                print('state ${cartController.stateCode.toString()}');
                                print('stateNameee ${cartController.stateName.toString()}');
                                if (previous != selectedState!.stateId.toString()) {
                                  stateIddd = gg.toString();
                                  getCityList(stateId: stateIddd.toString(), reset: true).then((value) {
                                    setState(() {});
                                  });
                                  setState(() {});
                                }
                              },
                              selectedAddressId: ((selectedState ?? CountryState()).stateId ?? "").toString());
                        },
                        suffixIcon: Obx(() {
                          if (stateRefresh.value > 0) {
                            return const Icon(Icons.keyboard_arrow_down_rounded);
                          }
                          return const CupertinoActivityIndicator();
                        }),
                        validator: (v) {
                          if (v!.trim().isEmpty) {
                            return "Please select state";
                          }
                          return null;
                        },
                      ),
                      // if (modelCityList != null && modelCityList!.city!.isNotEmpty)
                      ...fieldWithName(
                        readOnly: true,
                        title: 'City',
                        hintText: 'Select City',
                        controller:
                        TextEditingController(text: (selectedCity ?? City()).cityName ?? cityController.text),
                        onTap: () {
                          if (modelCityList == null && cityRefresh.value > 0) {
                            showToast("Select State First");
                            return;
                          }
                          if (cityRefresh.value < 0) {
                            return;
                          }
                          if (modelCityList!.city!.isEmpty) return;
                          showAddressSelectorDialog(
                              addressList: profileController.selectedLAnguage.value == 'English'
                                  ? modelCityList!.city!
                                  .map((e) =>
                                  CommonAddressRelatedClass(
                                      title: e.cityName.toString(), addressId: e.cityId.toString()))
                                  .toList()
                                  : modelCityList!.city!
                                  .map((e) =>
                                  CommonAddressRelatedClass(
                                      title: e.arabCityName.toString(), addressId: e.cityId.toString()))
                                  .toList(),
                              selectedAddressIdPicked: (String gg) {
                                selectedCity =
                                    modelCityList!.city!.firstWhere((element) => element.cityId.toString() == gg);
                                cartController.cityCode = gg.toString();
                                cartController.cityName.value = selectedCity!.cityName.toString();
                                print('state ${cartController.cityName.toString()}');
                                print('state Nameee ${cartController.cityCode.toString()}');
                                setState(() {});
                              },
                              selectedAddressId: ((selectedCity ?? City()).cityId ?? "").toString());
                        },
                        suffixIcon: Obx(() {
                          if (cityRefresh.value > 0) {
                            return const Icon(Icons.keyboard_arrow_down_rounded);
                          }
                          return const CupertinoActivityIndicator();
                        }),
                        validator: (v) {
                          if (v!.trim().isEmpty) {
                            return "Please select state";
                          }
                          return null;
                        },
                      ),
                      if (cartController.countryName.value != 'Kuwait')
                        ...commonField(
                            textController: zipCodeController,
                            title: "Zip-Code*",
                            hintText: "Enter location Zip-Code",
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return "Please enter Zip-Code*";
                              }
                              return null;
                            }),
                      if (cartController.countryName.value != 'Kuwait')
                        ...commonField(
                            textController: landmarkController,
                            title: "Landmark",
                            hintText: "Enter your nearby landmark",
                            keyboardType: TextInputType.streetAddress,
                            validator: (value) {
                              // if(value!.trim().isEmpty){
                              //   return "Please enter delivery address";
                              // }
                              return null;
                            }),
                      const SizedBox(
                        height: 16,
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            selectedAddress = AddressData(
                              id: "",
                              type: titleController.text.trim(),
                              firstName: firstNameController.text.trim(),
                              lastName: lastNameController.text.trim(),
                              state: stateController.text.trim(),
                              country: countryController.text.trim(),
                              city: cityController.text.trim(),
                              address2: address2Controller.text.trim(),
                              address: addressController.text.trim(),
                              alternatePhone: alternatePhoneController.text.trim(),
                              landmark: landmarkController.text.trim(),
                              phone: phoneController.text.trim(),
                              zipCode: zipCodeController.text.trim(),
                              email: emailController.text.trim(),
                            );
                            directBuyProduct();
                            cartController.countryId = countryIddd.toString();
                            setState(() {});
                            Get.back();
                            // cartController.updateAddressApi(
                            //     context: context,
                            //     firstName: firstNameController.text.trim(),
                            //     title: titleController.text.trim(),
                            //     lastName: lastNameController.text.trim(),
                            //     state: stateController.text.trim(),
                            //     country: countryController.text.trim(),
                            //     city: cityController.text.trim(),
                            //     address2: address2Controller.text.trim(),
                            //     address: addressController.text.trim(),
                            //     alternatePhone: alternatePhoneController.text.trim(),
                            //     landmark: landmarkController.text.trim(),
                            //     phone: phoneController.text.trim(),
                            //     zipCode: zipCodeController.text.trim(),
                            //     id: addressData.id);
                          }
                        },
                        child: Container(
                          decoration: const BoxDecoration(color: Color(0xff014E70)),
                          height: 56,
                          alignment: Alignment.bottomCenter,
                          child: Align(
                              alignment: Alignment.center,
                              child: Text("Save".tr,
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500, fontSize: 19, color: Colors.white))),
                        ),
                      ),
                      SizedBox(height: MediaQuery
                          .of(context)
                          .viewInsets
                          .bottom),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
