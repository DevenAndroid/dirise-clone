import 'dart:convert';
import 'dart:developer';
import 'package:dirise/model/common_modal.dart';
import 'package:dirise/utils/helper.dart';
import 'package:dirise/widgets/loading_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/cart_controller.dart';
import '../../controller/profile_controller.dart';
import '../../model/customer_profile/model_city_list.dart';
import '../../model/customer_profile/model_country_list.dart';
import '../../model/customer_profile/model_state_list.dart';
import '../../model/model_address_list.dart';
import '../../model/model_cart_response.dart';
import '../../model/vendor_models/model_payment_method.dart';
import '../../repository/repository.dart';
import '../../utils/api_constant.dart';
import '../../utils/styles.dart';
import '../../widgets/common_colour.dart';
import '../../widgets/common_textfield.dart';
import 'address/address_screen.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  static var route = "/checkOutScreen";

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  final cartController = Get.put(CartController());
  final profileController = Get.put(ProfileController());
  final _formKey = GlobalKey<FormState>();
  String shippingPrice = '0';
  String couponApplied = "";
  String appliedCode = "";
  String paymentMethod1 = "";
  double sPrice1 = 0.0;
  dynamic sPrice = 0.0;
  RxBool showValidation = false.obs;
  final TextEditingController couponController = TextEditingController();
  final TextEditingController deliveryInstructions = TextEditingController();
  ModelPaymentMethods? methods;

  getPaymentGateWays() {
    Repositories().getApi(url: ApiUrls.paymentMethodsUrl).then((value) {
      methods = ModelPaymentMethods.fromJson(jsonDecode(value));
      setState(() {});
    });
  }

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
      stateRefresh.value = DateTime.now().millisecondsSinceEpoch;
    }).catchError((e) {
      stateRefresh.value = DateTime.now().millisecondsSinceEpoch;
    });
  }
  RxString shippingType= "".obs;
  applyCouponCode() {
    if (couponController.text.trim().isEmpty) {
      showToast("Please enter coupon code".tr);
      return;
    }
    cartController.refreshInt.value = -2;
    Map<String, dynamic> map = {};
    map["coupon_code"] = couponController.text.trim();
    map["total_price"] = cartController.cartModel.subtotal.toString();
    cartController.repositories.postApi(url: ApiUrls.applyCouponUrl, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message);
      if (response.status == true) {
        couponApplied = jsonDecode(value)["discount"].toString();
        appliedCode = couponController.text.trim();
        couponController.clear();
        setState(() {});
      }
      cartController.updateUI();
    }).catchError((e) {
      cartController.updateUI();
    });
  }

  RxString paymentOption = "".obs;
  RxString shipmentProvider = "".obs;

  // double sPrice = 0.0;
  bool get userLoggedIn => profileController.userLoggedIn;
  double total = 0.0;

  @override
  void initState() {
    super.initState();
    getCountryList();
    getPaymentGateWays();
    cartController.selectedAddress = AddressData();
    cartController.countryName.value = '';
    cartController.shippingId = '';
    cartController.addressCountryController = TextEditingController(text: cartController.selectedAddress.getCountry ?? "");
    cartController.addressStateController = TextEditingController(text: cartController.selectedAddress.getState ?? "");
    cartController.addressCityController = TextEditingController(text: cartController.selectedAddress.getCity ?? "");
    cartController.deliveryOption1.value = '';
    cartController.isDelivery.value = false;
    cartController.addressDeliFirstName.text = '';
    cartController.addressDeliLastName.text = '';
    cartController.addressDeliEmail.text = '';
    cartController.addressDeliPhone.text = '';
    cartController.addressDeliAlternate.text = '';
    cartController.addressDeliAddress.text = '';
    cartController.addressDeliZipCode.text = '';
    cartController.myDefaultAddressData();
    profileController.checkUserLoggedIn().then((value) {
      if (value == false) return;
      cartController.getAddress();
    });
  }

  goBack() {
    // if(cartController.cartModel.cart!.getAllProducts.isEmpty){
    //   Future.delayed(Duration(seconds: 1)).then((value) {
    //     Get.back();
    //   });
    // }
  }

  ModelCountryList? modelCountryList;
  Country? selectedCountry;
  RxInt cityRefresh = 2.obs;
RxString shipId = "".obs;
  Future getCityList({required String stateId, bool? reset}) async {
    if (reset == true) {
      modelCityList = null;
      selectedCity = null;
    }
    cityRefresh.value = -5;
    final map = {'state_id': stateId};
    await repositories.postApi(url: ApiUrls.allCityUrl, mapData: map).then((value) {
      modelCityList = ModelCityList.fromJson(jsonDecode(value));
      cityRefresh.value = DateTime.now().millisecondsSinceEpoch;
    }).catchError((e) {
      cityRefresh.value = DateTime.now().millisecondsSinceEpoch;
    });
  }

  double shippingTotal = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xff014E70), size: 20),
          onPressed: () => Navigator.of(context).pop(),
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
        return CustomScrollView(
          shrinkWrap: true,
          slivers: [
            const AddressScreen(),
            30.spaceY.toBoxAdapter,
            paymentMethod(size).toBoxAdapter,
            // if(cartController.deliveryOption1.value != "delivery")
            //   pickupInstruction().toBoxAdapter,
            // if(cartController.deliveryOption1.value == "delivery")
            products().toBoxAdapter,
            deliveryInstruction().toBoxAdapter,
            couponCode().toBoxAdapter,
            const SizedBox(
              height: 30,
            ).toBoxAdapter,
            orderDetails().toBoxAdapter
          ],
        );
      }),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {
          if (cartController.selectedAddress.id != null ||
              cartController.myDefaultAddressModel.value.defaultAddress != null) {
            cartController.showValidation.value = true;
            showValidation.value = true;

            // this condition for pick and delivery both
            // if (cartController.deliveryOption1.value.isEmpty)
            if (cartController.deliveryOption1.value == 'delivery') {
              BuildContext? context1 = cartController.addressKey.currentContext;
              if (context1 != null) {
                Scrollable.ensureVisible(context1, duration: const Duration(milliseconds: 650));
              }
              showToast("Please select delivery options".tr);
              return;
            }
            if (cartController.deliveryOption1.value == "delivery" && cartController.selectedAddress.id == null) {
              BuildContext? context1 = cartController.addressKey.currentContext;
              if (context1 != null) {
                Scrollable.ensureVisible(context1, duration: const Duration(milliseconds: 650));
              }
              showToast("Select delivery address to complete order".tr);
              return;
            }
            cartController.dialogOpened = false;
            if (paymentMethod1.isEmpty) {
              showToast("Please select payment Method".tr);
              return;
            }
            // if (cartController.deliveryOption1.value == "delivery") {
            for (var item in cartController.cartModel.cart!.carsShowroom!.entries) {
              var showroom = item.value;
              if (item.value.shippingOption.isEmpty) {
                showToast("Please select shipping Method".tr);
                return;
              }

            }
            // for (var item in cartController.cartModel.cart!.carsShowroom!.entries) {
            //   var showroom = item.value;
            //   if (item.value.fedexShippingOption.isEmpty && cartController.countryName.value != 'Kuwait') {
            //     showToast("Please select shipping Method".tr);
            //     return;
            //   }
            // }
            // }
            cartController.shippingList.clear();
            cartController.shippingVendorId.clear();
            cartController.shippingVendorName.clear();
            cartController.shippingPriceList.clear();
            for (var item in cartController.cartModel.cart!.carsShowroom!.entries) {
              cartController.shippingList.add(item.value.shippingId.value);
              cartController.shippingVendorId.add(item.value.vendorId.value);
              cartController.shippingVendorName.add(item.value.shippingVendorName.value);
              cartController.shippingPriceList.add(item.value.vendorPrice.value.toString());
              // cartController.shippingTitle.add(item.value.vendorPrice.vale.toString());
            }

            //fedx shipping date
            // if (cartController.cartModel.cart != null && cartController.cartModel.cart!.carsShowroom != null) {
            //   cartController.shippingDate.clear();
            //   for (var item in cartController.cartModel.cart!.carsShowroom!.entries) {
            //     if (item.value.shipping != null &&
            //         item.value.shipping!.output != null &&
            //         item.value.shipping!.output!.rateReplyDetails != null) {
            //       cartController.shippingDate.clear();
            //       for (var item1 in item.value.shipping!.output!.rateReplyDetails!) {
            //         if (item1.operationalDetail != null && item1.operationalDetail!.deliveryDate != null) {
            //           cartController.shippingDate.add(item1.shippingDate);
            //         }
            //       }
            //     }
            //   }
            // }


            cartController.placeOrder(
              context: context,
              currencyCode: "kwd",
              paymentMethod: paymentMethod1,
              shippingId:  shipId.value.toString(),
shipmentProvider: shipmentProvider.value.toString(),
              // deliveryOption: cartController.deliveryOption1.value,
              deliveryOption: 'delivery',
              purchaseType: PurchaseType.cart,
              subTotalPrice: cartController.cartModel.subtotal.toString(),
              totalPrice: cartController.formattedTotal.toString(),

              couponCode: couponApplied.isNotEmpty ? appliedCode : null,
              purchaseType1:   shippingType.value.toString(),
              address: cartController.selectedAddress.id != null
                  ? cartController.selectedAddress.toJson()
                  : cartController.myDefaultAddressModel.value.defaultAddress!.toJson(),
              idd: cartController.shippingList.join(','),
            );
          } else {
            showToast('Please Choose Address');
          }
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          backgroundColor: const Color(0xff014E70),
        ),
        child: Container(
          // decoration: const BoxDecoration(color: Color(0xff014E70)),
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

  Container orderDetails() {
    return Container(
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
              // Text("Subtotal (${cartController.cartModel.totalQuantity} items)",
              //     style: GoogleFonts.poppins(fontWeight: FontWeight.w400, color: const Color(0xff949495))),
              Text("KWD ${cartController.cartModel.subtotal.toString()}",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w400, color: const Color(0xff949495))),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Obx(() {
            if (cartController.refreshInt.value > 0) {}
            goBack();
            return couponApplied.isNotEmpty
                ? Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${'Coupon Applied'.tr}: $appliedCode",
                              style: GoogleFonts.poppins(fontWeight: FontWeight.w400, color: CupertinoColors.activeGreen)),
                          Text("KWD $couponApplied",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  color: CupertinoColors.activeGreen,
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: Colors.lightGreenAccent)),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  )
                : const SizedBox.shrink();
          }),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Sub Total".tr, style: GoogleFonts.poppins(fontWeight: FontWeight.w400, color: const Color(0xff949495))),
              Text("KWD ${cartController.cartModel.subtotal.toString()}",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w400, color: const Color(0xff949495))),
            ],
          ),
          10.spaceY,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Shipping Fees".tr,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w400, color: const Color(0xff949495))),
              Text("KWD ${sPrice1.toString()}",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w400, color: const Color(0xff949495))),
            ],
          ),
          10.spaceY,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total".tr, style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18)),
              total == 0.0
                  ? Text("KWD ${cartController.cartModel.subtotal.toString()}",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18))
                  : Text("KWD ${cartController.formattedTotal.toString()}",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18)),
            ],
          ),
        ],
      ),
    );
  }

  Column couponCode() {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Text("Have a coupon code?".tr, style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Expanded(child: CommonTextfield(obSecure: false, hintText: 'Enter Code',)),
                    Expanded(
                      child: TextFormField(
                          style: GoogleFonts.poppins(),
                          controller: couponController,
                          decoration: InputDecoration.collapsed(
                            hintText: "Enter Code".tr,
                            hintStyle: GoogleFonts.poppins(color: const Color(0xff949495), fontSize: 14),
                          )),
                    ),
                    Obx(() {
                      return cartController.refreshInt.value == -2
                          ? const CupertinoActivityIndicator()
                          : const SizedBox.shrink();
                    }),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        applyCouponCode();
                      },
                      child: Container(
                        decoration: BoxDecoration(color: const Color(0xff014E70), borderRadius: BorderRadius.circular(22)),
                        padding: const EdgeInsets.fromLTRB(22, 9, 22, 9),
                        child: Text(
                          "Apply".tr,
                          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Column products() {
    return Column(
      children: [
        Obx(() {
          if (cartController.refreshInt.value > 0) {}
          return
            // cartController.myDefaultAddressModel.value.defaultAddress!= null ?
          SingleChildScrollView(
            child: Column(
              children: cartController.cartModel.cart!.carsShowroom!.entries
                  .map((e) =>
                  Column(
                    children: [
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: e.value.products!.length,
                        itemBuilder: (context, ii) {
                          Products product = e.value.products![ii];
                          cartController.storeIdShipping = product.vendorId.toString();
                          cartController.storeNameShipping = e.key;
                          return Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              //   border: ii != product.length - 1
                              //       ? const Border(bottom: BorderSide(color: Color(0xffD9D9D9)))
                              //       : null,
                            ),
                            margin: EdgeInsets.only(top: ii == 0 ? 16 : 0),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (ii == 0)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: Text(
                                      "${'Sold By'.tr} ${e.key}",
                                      style: titleStyle,
                                    ),
                                  ),
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
                                              product.featuredImage.toString(),
                                              fit: BoxFit.contain,
                                              errorBuilder: (_, __, ___) =>  Image.asset(
                                                  'assets/images/new_logo.png'
                                              )
                                          ),
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
                                              product.pname.toString(),
                                              style: titleStyle.copyWith(fontWeight: FontWeight.w400),
                                              textAlign: TextAlign.start,
                                            ),
                                            const SizedBox(
                                              height: 6,
                                            ),
                                            Text(
                                              'KWD ${product.sPrice}',
                                              style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w400),
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            // IntrinsicHeight(
                                            //   child: Row(
                                            //     children: [
                                            //       product.qty!= '1' ? IconButton(
                                            //           onPressed: () {
                                            //             if (product.qty
                                            //                 .toString()
                                            //                 .toNum > 1) {
                                            //               cartController.updateCartQuantity(
                                            //                   context: context,
                                            //                   productId: product.id.toString(),
                                            //                   quantity: (product.qty
                                            //                       .toString()
                                            //                       .toNum - 1).toString());
                                            //             } else {
                                            //               cartController.removeItemFromCart(
                                            //                   productId: product.id.toString(), context: context);
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
                                            //           )) : IconButton(
                                            //           onPressed: () {},
                                            //           style: IconButton.styleFrom(
                                            //             shape: RoundedRectangleBorder(
                                            //                 borderRadius: BorderRadius.circular(2)),
                                            //             backgroundColor: AppTheme.primaryColor,
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
                                            //           product.qty.toString(),
                                            //           style: normalStyle,
                                            //         ),
                                            //       ),
                                            //       5.spaceX,
                                            //       IconButton(
                                            //           onPressed: () {
                                            //                 if (product.qty.toString().toNum <
                                            //                     product.inStock.toString().toNum) {
                                            //                   cartController.updateCartQuantity(
                                            //                       context: context,
                                            //                       productId: product.id.toString(),
                                            //                       quantity: (product.qty.toString().toNum + 1).toString());
                                            //                 }else{
                                            //                   showToastCenter("Out Of Stock".tr);
                                            //                 }
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
                                      //           productId: product.id.toString(), context: context);
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
                          );
                        },
                      ),
                      10.spaceY,
                      // if ( e.value.products!.any((e) =>
                      // e.vendorCountryId == '117' && e.isShipping == true) && cartController.countryName.value == 'Kuwait' ||  cartController.myDefaultAddressModel.value.defaultAddress!.country == 'Kuwait')
                      if(e.value.localShipping == true)
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
                      // if ( e.value.products!.any((e) =>
                      // e.vendorCountryId == '117' && e.isShipping == true) && cartController.countryName.value == 'Kuwait' ||   cartController.myDefaultAddressModel.value.defaultAddress!.country == 'Kuwait')
                      if(e.value.localShipping == true)
                        Container(
                          color: Colors.white,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: e.value.shipping!.localShipping!.length,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15).copyWith(top: 0),
                            itemBuilder: (context, ii) {
                              LocalShipping product = e.value.shipping!.localShipping![ii];
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
                                          groupValue: e.value.shippingOption.value,
                                          visualDensity: const VisualDensity(horizontal: -4.0),
                                          fillColor: e.value.shippingOption.value.isEmpty
                                              ? MaterialStateProperty.all(Colors.red)
                                              : null,
                                          onChanged: (value) {
                                            setState(() {
                                              e.value.shippingOption.value = value.toString();
                                              e.value.shippingId.value = e.value.shipping!.localShipping![ii].id.toString();
                                              e.value.vendorId.value = e.value.shipping!.localShipping![ii].vendorId!;
                                              e.value.shippingVendorName.value = e.value.shipping!.localShipping![ii].name.toString();
                                              e.value.vendorPrice.value = e.value.shipping!.localShipping![ii].value.toString();
                                              shippingPrice = e.value.shipping!.localShipping![ii].value.toString();
                                              double shipping = double.parse(shippingPrice);
                                              double subtotal = double.parse(cartController.cartModel.subtotal.toString());
                                              total = subtotal + shipping;
                                              cartController.formattedTotal = total.toString();
                                              print('total isss${cartController.formattedTotal.toString()}');

                                              // total = subtotal + shipping;
                                              cartController.formattedTotal = total.toStringAsFixed(3);
                                              e.value.sMethod = double.parse(e.value.shipping!.localShipping![ii].value.toString());
                                              // double sPrice = 0.0;
                                              sPrice1 = 0.0;
                                              for (var item in cartController.cartModel.cart!.carsShowroom!.entries) {
                                                if (item.value.shippingOption.value.isNotEmpty) {
                                                  sPrice1 = sPrice1 + item.value.sMethod;
                                                  // sPrice.toStringAsFixed(fractionDigits)
                                                  // Update sPrice directly without reassigning
                                                }
                                                total = subtotal + sPrice1;
                                                cartController.formattedTotal = total.toStringAsFixed(3);
                                                log("Final sPrice::::::: $sPrice1");
                                                log("Final sPrice:::Total:::: $total");
                                              }
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
                                                style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16)),
                                            3.spaceY,
                                            Text('kwd ${product.value.toString()}',
                                                style: GoogleFonts.poppins(fontWeight: FontWeight.w400,
                                                    fontSize: 16,
                                                    color: const Color(0xFF03a827))),
                                          ],
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
                      // fedx
                      // if (e.value.products!.any((e) =>
                      // e.vendorCountryId != '117'  && e.isShipping == true) || cartController.countryName.value != 'Kuwait' && cartController.myDefaultAddressModel.value.defaultAddress!.country != 'Kuwait')
                      //   cartController.selectedAddress.id != null ||
                      //       cartController.myDefaultAddressModel.value.defaultAddress != null?
                        if(e.value.localShipping != true)
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
                      //       : const SizedBox(),

                      // if (e.value.products!.any((e) =>
                      // e.vendorCountryId != '117'  && e.isShipping == true) || cartController.countryName.value != 'Kuwait' &&  cartController.myDefaultAddressModel.value.defaultAddress!.country != 'Kuwait'
                      // )
                        if( e.value.localShipping != true && e.value.shipping!.fedexShipping!.output == null)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('FedEx service is not currently available to this origin / destination combination. Enter new information or contact FedEx Customer Service.'.tr,style: const TextStyle(
                              fontSize: 17
                                                    ),),
                          ),
                      //   cartController.selectedAddress.id != null || cartController.myDefaultAddressModel.value.defaultAddress != null ?
                      //   e.value.fedexShipping!.output !=null ?
                      if(e.value.localShipping != true && e.value.shipping!.fedexShipping!.output != null)
                        Container(
                          color: Colors.white,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: e.value.shipping!.fedexShipping!.output!.rateReplyDetails!.length,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15).copyWith(top: 0),
                            itemBuilder: (context, ii) {
                              return e.value.shipping!.fedexShipping!.output!= null ?
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: e.value.shipping!.fedexShipping!.output!.rateReplyDetails![ii].ratedShipmentDetails!.length,
                                      itemBuilder: (context, index) {
                                        RateReplyDetails product = e.value.shipping!.fedexShipping!.output!.rateReplyDetails![ii];
                                        RatedShipmentDetails product1 = e.value.shipping!.fedexShipping!.output!.rateReplyDetails![ii].ratedShipmentDetails![index];
                                        double subtotal = double.parse(e.value.fedexCommision.toString());
                                        double shipping = double.parse(product1.totalNetCharge.toString());
                                        total = subtotal + shipping;
                                        cartController.formattedTotal = total.toStringAsFixed(3);
                                        print("icarryCommision"+ e.value.fedexCommision.toString());
                                        print("rate"+product1.totalNetCharge.toString());
                                        print('total isss${cartController.formattedTotal.toString()}');
                                        cartController.shippingPrices2 = cartController.formattedTotal.toString();
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
                                                    groupValue:  e.value.shipping!.fedexShippingOption.value,
                                                    visualDensity: const VisualDensity(horizontal: -4.0),
                                                    fillColor:  e.value.shipping!.fedexShippingOption.value.isEmpty
                                                        ? MaterialStateProperty.all(Colors.red)
                                                        : null,
                                                    onChanged: (value) {
                                                      log("which is selected + $value");
                                                      setState(() {
                                                        shippingType.value = "fedex_shipping";
                                                        shipId.value = "";
                                                        shipmentProvider.value = "";
                                                        e.value.shipping!.fedexShippingOption.value = value.toString();
                                                      cartController.shippingDates =product.commit!.dateDetail!.dayFormat.toString();
                                                        // e.value.shipping![ii].output!.rateReplyDetails![index].shippingDate = product.operationalDetail!.deliveryDate;
                                                        cartController.shippingTitle = product.serviceName.toString();
                                                        // cartController.shippingPrices = product.ratedShipmentDetails![index].totalNetCharge.toString();
                                                        e.value.shippingOption.value = value.toString();
                                                        print( e.value.shipping!.fedexShippingOption.value.toString());
                                                        print(cartController.shippingTitle.toString());
                                                        print('select value${cartController.shippingPrices.toString()}');
                                                        print(cartController. shippingPrices.toString());
                                                        shippingPrice =  product.ratedShipmentDetails![index].totalNetCharge.toString();
                                                        double subtotal = double.parse(e.value.fedexCommision.toString());
                                                        double shipping = double.parse(product1.totalNetCharge.toString());
                                                        total = subtotal + shipping;
                                                        cartController.formattedTotal2 = total.toStringAsFixed(3);
                                                        print("icarryCommision"+ e.value.fedexCommision.toString());
                                                        print("rate"+product1.totalNetCharge.toString());
                                                        print('total isss${cartController.formattedTotal2.toString()}');
                                                        cartController.shippingPrices1 = cartController.formattedTotal2.toString();
                                                        // e.value.shippingId.value = product.id.toString();
                                                        // e.value.vendorId.value = e.value.shipping![ii].vendorId!;
                                                        e.value.shippingVendorName.value = product.serviceName.toString();
                                                        e.value.vendorPrice.value = product.ratedShipmentDetails![index].totalNetCharge.toString();

                                                        e.value.sPrice = product.ratedShipmentDetails![index].totalNetCharge;

                                                        log("Initial sPrice:$sPrice1");
                                                        log("Initial sPrice:"+cartController.shippingTitle);  log("Initial sPrice::::::::::::::::::::::"+  cartController.shippingDates);

                                                        sPrice1 = 0.0;
                                                        for (var item in cartController
                                                            .cartModel.cart!.carsShowroom!.entries) {
                                                          // sPrice1 = 0.0;
                                                          if (item.value.shipping!.fedexShippingOption.value.isNotEmpty) {
                                                            log("kiska price hai + ${item.value.sPrice}");
                                                            sPrice1 = sPrice1 + item.value.sPrice;
                                                            // sPrice.toStringAsFixed(fractionDigits)
                                                            // Update sPrice directly without reassigning
                                                          }
                                                          total = subtotal + sPrice1;
                                                          print('total isss${total.toString()}');
                                                          // cartController.formattedTotal = total.toStringAsFixed(3);
                                                        }

                                                      });
                                                    },
                                                  ),
                                                  20.spaceX,
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(product.serviceName.toString().capitalize!.replaceAll('_', ' '),
                                                            style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16)),
                                                        3.spaceY,
                                                        Text('kwd ${ cartController.shippingPrices2.toString()}',
                                                            style: GoogleFonts.poppins(fontWeight: FontWeight.w400,
                                                                fontSize: 16,
                                                                color: const Color(0xFF03a827))),
                                                        3.spaceY,
                                                        Text('${product.operationalDetail!.deliveryDay ?? ''}  ${product.operationalDetail!.deliveryDate ?? ''}',
                                                            style: GoogleFonts.poppins(fontWeight: FontWeight.w400,
                                                                fontSize: 15,
                                                                fontStyle: FontStyle.italic,
                                                                color: const Color(0xFF000000))),
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

                      if(e.value.shipping!.icarryShipping!=null)
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
                      if(e.value.shipping!.icarryShipping!=null)
                        Container(
                          color: Colors.white,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: e.value.shipping!.icarryShipping!.length,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15).copyWith(top: 0),
                            itemBuilder: (context, ii) {
                              IcarryShipping product = e.value.shipping!.icarryShipping![ii];
                              double subtotal = double.parse(e.value.icarryCommision.toString());
                              double shipping = double.parse(product.rate.toString());
                              total = subtotal + shipping;
                              cartController.formattedTotal = total.toStringAsFixed(3);
                              print("icarryCommision"+ e.value.icarryCommision.toString());
                              print("rate"+product.rate.toString());
                              print('total isss${cartController.formattedTotal.toString()}');
                              cartController.shippingPrices = cartController.formattedTotal.toString();
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
                                          groupValue:  e.value.shipping!.fedexShippingOption.value,
                                          visualDensity: const VisualDensity(horizontal: -4.0),
                                          fillColor: e.value.shipping!.fedexShippingOption.value.isEmpty
                                              ? MaterialStateProperty.all(Colors.red)
                                              : null,
                                          onChanged: (value) {
                                            setState(() {
                                              shippingType.value = "icarry_shipping";
                                              shipId.value =product.methodId.toString();
                                              shipmentProvider.value =product.carrierModel!.systemName.toString();
                                              cartController.shippingDates =product.methodName.toString();
                                              e.value.shippingOption.value = value.toString();
                                              e.value.shipping!.fedexShippingOption.value = value.toString();
                                              cartController.shippingTitle =    product.name.toString();
                                              // cartController.shippingPrices = product.price.toString();
                                              print( e.value.shipping!.fedexShippingOption.value.toString());
                                              print(cartController.shippingTitle.toString());
                                              print('select value${cartController.shippingPrices.toString()}');
                                              print("shipping price"+cartController.shippingPrices.toString());
                                              shippingPrice =   product.price.toString();
                                              // double subtotal = double.parse(cartController.cartModel.subtotal.toString());
                                              double subtotal = double.parse(e.value.icarryCommision.toString());
                                              double shipping = double.parse(product.rate.toString());
                                              total = subtotal + shipping;
                                              cartController.formattedTotal2 = total.toStringAsFixed(3);

                                              cartController.shippingPrices1 = cartController.formattedTotal2.toString();
                                              // double shipping = double.parse(shippingPrice.toString());
                                              // total = subtotal + shipping;
                                              // cartController.formattedTotal = total.toStringAsFixed(3);
                                              // e.value.shippingId.value = product.id.toString();
                                              // e.value.vendorId.value = e.value.shipping![ii].vendorId!;
                                              // e.value.shippingVendorName.value = product.serviceName.toString();
                                              // e.value.vendorPrice.value = product.ratedShipmentDetails![index].totalNetCharge.toString();

                                              e.value.sPrice = product.rate;

                                              log("Initial sPrice:$sPrice1");
                                              log("Initial sPrice:"+  cartController.shippingTitle.toString());
                                              log("Initial sPrice::::::::::::::::::::::"+  cartController.shippingDates);
                                              log("Initial sPrice:::::::::"+shipmentProvider.value.toString());
                                              sPrice1 = 0.0;
                                              for (var item in cartController
                                                  .cartModel.cart!.carsShowroom!.entries) {
                                                // sPrice1 = 0.0;
                                                if (item.value.shipping!.fedexShippingOption.value.isNotEmpty) {
                                                  log("kiska price hai + ${item.value.sPrice}");
                                                  sPrice1 = sPrice1 + item.value.sPrice;
                                                  // sPrice.toStringAsFixed(fractionDigits)
                                                  // Update sPrice directly without reassigning
                                                }
                                                total = subtotal + sPrice1;
                                                print('total isss${total.toString()}');

                                              }

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
                                                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16)),
                                              3.spaceY,
                                              Text( "KWD "+cartController.shippingPrices.toString(),
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
                  )).toList(),
            ),
          );

          // : const SizedBox.shrink();
          // CustomScrollView(
          //   shrinkWrap: true,
          //   physics: const NeverScrollableScrollPhysics(),
          //   slivers: cartController.cartModel.cart!.carsShowroom!.entries
          //       .map((e) => SliverList(
          //               delegate: SliverChildBuilderDelegate(
          //             childCount: e.value.products!.length,
          //             (context, ii) {
          //               Products product = e.value.products![ii];
          //               return Container(
          //                 decoration: const BoxDecoration(
          //                   color: Colors.white,
          //                   //   border: ii != product.length - 1
          //                   //       ? const Border(bottom: BorderSide(color: Color(0xffD9D9D9)))
          //                   //       : null,
          //                 ),
          //                 margin: EdgeInsets.only(top: ii == 0 ? 16 : 0),
          //                 padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          //                 child: Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     if (ii == 0)
          //                       Padding(
          //                         padding: const EdgeInsets.only(bottom: 16),
          //                         child: Text(
          //                           "${'Sold By'.tr} ${e.key}",
          //                           style: titleStyle,
          //                         ),
          //                       ),
          //                     IntrinsicHeight(
          //                       child: Row(
          //                         crossAxisAlignment: CrossAxisAlignment.start,
          //                         children: [
          //                           Container(
          //                             width: 75,
          //                             height: 75,
          //                             decoration: BoxDecoration(
          //                               borderRadius: BorderRadius.circular(12),
          //                             ),
          //                             child: ClipRRect(
          //                               borderRadius: BorderRadius.circular(12),
          //                               child: Image.network(
          //                                 product.featuredImage.toString(),
          //                                 fit: BoxFit.contain,
          //                                 errorBuilder: (_, __, ___) => const SizedBox.shrink(),
          //                               ),
          //                             ),
          //                           ),
          //                           const SizedBox(
          //                             width: 16,
          //                           ),
          //                           Expanded(
          //                             child: Column(
          //                               crossAxisAlignment: CrossAxisAlignment.start,
          //                               // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //                               children: [
          //                                 Text(
          //                                   product.pname.toString(),
          //                                   style: titleStyle.copyWith(fontWeight: FontWeight.w400),
          //                                   textAlign: TextAlign.start,
          //                                 ),
          //                                 const SizedBox(
          //                                   height: 6,
          //                                 ),
          //                                 Text(
          //                                   '\$${product.sPrice}',
          //                                   style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w400),
          //                                 ),
          //                                 const SizedBox(
          //                                   height: 4,
          //                                 ),
          //                                 IntrinsicHeight(
          //                                   child: Row(
          //                                     children: [
          //                                       IconButton(
          //                                           onPressed: () {
          //                                             if (product.qty.toString().toNum > 1) {
          //                                               cartController.updateCartQuantity(
          //                                                   context: context,
          //                                                   productId: product.id.toString(),
          //                                                   quantity: (product.qty.toString().toNum - 1).toString());
          //                                             } else {
          //                                               cartController.removeItemFromCart(
          //                                                   productId: product.id.toString(), context: context);
          //                                             }
          //                                           },
          //                                           style: IconButton.styleFrom(
          //                                             shape:
          //                                                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
          //                                             backgroundColor: AppTheme.buttonColor,
          //                                           ),
          //                                           constraints: const BoxConstraints(minHeight: 0),
          //                                           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          //                                           visualDensity: VisualDensity.compact,
          //                                           icon: const Icon(
          //                                             Icons.remove,
          //                                             color: Colors.white,
          //                                             size: 20,
          //                                           )),
          //                                       5.spaceX,
          //                                       Container(
          //                                         decoration: BoxDecoration(
          //                                             borderRadius: BorderRadius.circular(2),
          //                                             // color: Colors.grey,
          //                                             border: Border.all(color: Colors.grey.shade800)),
          //                                         margin: const EdgeInsets.symmetric(vertical: 6),
          //                                         padding: const EdgeInsets.symmetric(horizontal: 15),
          //                                         alignment: Alignment.center,
          //                                         child: Text(
          //                                           product.qty.toString(),
          //                                           style: normalStyle,
          //                                         ),
          //                                       ),
          //                                       5.spaceX,
          //                                       IconButton(
          //                                           onPressed: () {
          //                                             if (product.qty.toString().toNum <
          //                                                 product.stockAlert.toString().toNum) {
          //                                               cartController.updateCartQuantity(
          //                                                   context: context,
          //                                                   productId: product.id.toString(),
          //                                                   quantity: (product.qty.toString().toNum + 1).toString());
          //                                             }
          //                                           },
          //                                           style: IconButton.styleFrom(
          //                                             shape:
          //                                                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
          //                                             backgroundColor: AppTheme.buttonColor,
          //                                           ),
          //                                           constraints: const BoxConstraints(minHeight: 0),
          //                                           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          //                                           visualDensity: VisualDensity.compact,
          //                                           icon: const Icon(
          //                                             Icons.add,
          //                                             color: Colors.white,
          //                                             size: 20,
          //                                           )),
          //                                     ],
          //                                   ),
          //                                 )
          //                               ],
          //                             ),
          //                           ),
          //                           IconButton(
          //                               onPressed: () {
          //                                 cartController.removeItemFromCart(
          //                                     productId: product.id.toString(), context: context);
          //                               },
          //                               visualDensity: VisualDensity.compact,
          //                               icon: SvgPicture.asset(
          //                                 "assets/svgs/delete.svg",
          //                                 height: 18,
          //                                 width: 18,
          //                               ))
          //                         ],
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               );
          //             },
          //           )))
          //       .toList()
          //
          //   // slivers: List.generate(cartController.cartModel.cart!.carsShowroom!.length, (i) {
          //   //   List<SellersData> items = cartController.cartModel.cart!.getAllProducts[i];
          //   //   return SliverList(
          //   //       delegate: SliverChildBuilderDelegate(
          //   //     childCount: items.length,
          //   //     (context, ii) {
          //   //       SellersData product = items[ii];
          //   //       return Container(
          //   //         decoration: BoxDecoration(
          //   //           color: Colors.white,
          //   //           border: ii != items.length - 1
          //   //               ? const Border(bottom: BorderSide(color: Color(0xffD9D9D9)))
          //   //               : null,
          //   //         ),
          //   //         margin: EdgeInsets.only(top: ii == 0 ? 16 : 0),
          //   //         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          //   //         child: Column(
          //   //           crossAxisAlignment: CrossAxisAlignment.start,
          //   //           children: [
          //   //             if (ii == 0)
          //   //               Padding(
          //   //                 padding: const EdgeInsets.only(bottom: 16),
          //   //                 child: Text(
          //   //                   "${'Sold By'.tr} ${product.storeName}",
          //   //                   style: titleStyle,
          //   //                 ),
          //   //               ),
          //   //             IntrinsicHeight(
          //   //               child: Row(
          //   //                 crossAxisAlignment: CrossAxisAlignment.start,
          //   //                 children: [
          //   //                   Container(
          //   //                     width: 75,
          //   //                     height: 75,
          //   //                     decoration: BoxDecoration(
          //   //                       borderRadius: BorderRadius.circular(12),
          //   //                     ),
          //   //                     child: ClipRRect(
          //   //                       borderRadius: BorderRadius.circular(12),
          //   //                       child: Image.network(
          //   //                         product.featuredImage.toString(),
          //   //                         fit: BoxFit.contain,
          //   //                         errorBuilder: (_, __, ___) => const SizedBox.shrink(),
          //   //                       ),
          //   //                     ),
          //   //                   ),
          //   //                   const SizedBox(
          //   //                     width: 16,
          //   //                   ),
          //   //                   Expanded(
          //   //                     child: Column(
          //   //                       crossAxisAlignment: CrossAxisAlignment.start,
          //   //                       // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   //                       children: [
          //   //                         Text(
          //   //                           product.pName.toString(),
          //   //                           style: titleStyle.copyWith(fontWeight: FontWeight.w400),
          //   //                           textAlign: TextAlign.start,
          //   //                         ),
          //   //                         const SizedBox(
          //   //                           height: 6,
          //   //                         ),
          //   //                         Text(
          //   //                           '\$${product.sPrice}',
          //   //                           style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w400),
          //   //                         ),
          //   //                         const SizedBox(
          //   //                           height: 4,
          //   //                         ),
          //   //                         IntrinsicHeight(
          //   //                           child: Row(
          //   //                             children: [
          //   //                               IconButton(
          //   //                                   onPressed: () {
          //   //                                     if (product.qty.toString().toNum > 1) {
          //   //                                       cartController.updateCartQuantity(
          //   //                                           context: context,
          //   //                                           productId: product.id.toString(),
          //   //                                           quantity: (product.qty.toString().toNum - 1).toString());
          //   //                                     } else {
          //   //                                       cartController.removeItemFromCart(
          //   //                                           productId: product.id.toString(), context: context);
          //   //                                     }
          //   //                                   },
          //   //                                   style: IconButton.styleFrom(
          //   //                                     shape: RoundedRectangleBorder(
          //   //                                         borderRadius: BorderRadius.circular(2)),
          //   //                                     backgroundColor: AppTheme.buttonColor,
          //   //                                   ),
          //   //                                   constraints: const BoxConstraints(minHeight: 0),
          //   //                                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          //   //                                   visualDensity: VisualDensity.compact,
          //   //                                   icon: const Icon(
          //   //                                     Icons.remove,
          //   //                                     color: Colors.white,
          //   //                                     size: 20,
          //   //                                   )),
          //   //                               5.spaceX,
          //   //                               Container(
          //   //                                 decoration: BoxDecoration(
          //   //                                     borderRadius: BorderRadius.circular(2),
          //   //                                     // color: Colors.grey,
          //   //                                     border: Border.all(color: Colors.grey.shade800)),
          //   //                                 margin: const EdgeInsets.symmetric(vertical: 6),
          //   //                                 padding: const EdgeInsets.symmetric(horizontal: 15),
          //   //                                 alignment: Alignment.center,
          //   //                                 child: Text(
          //   //                                   product.qty.toString(),
          //   //                                   style: normalStyle,
          //   //                                 ),
          //   //                               ),
          //   //                               5.spaceX,
          //   //                               IconButton(
          //   //                                   onPressed: () {
          //   //                                     if (product.qty.toString().toNum <
          //   //                                         product.stockAlert.toString().toNum) {
          //   //                                       cartController.updateCartQuantity(
          //   //                                           context: context,
          //   //                                           productId: product.id.toString(),
          //   //                                           quantity: (product.qty.toString().toNum + 1).toString());
          //   //                                     }
          //   //                                   },
          //   //                                   style: IconButton.styleFrom(
          //   //                                     shape: RoundedRectangleBorder(
          //   //                                         borderRadius: BorderRadius.circular(2)),
          //   //                                     backgroundColor: AppTheme.buttonColor,
          //   //                                   ),
          //   //                                   constraints: const BoxConstraints(minHeight: 0),
          //   //                                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          //   //                                   visualDensity: VisualDensity.compact,
          //   //                                   icon: const Icon(
          //   //                                     Icons.add,
          //   //                                     color: Colors.white,
          //   //                                     size: 20,
          //   //                                   )),
          //   //                             ],
          //   //                           ),
          //   //                         )
          //   //                       ],
          //   //                     ),
          //   //                   ),
          //   //                   IconButton(
          //   //                       onPressed: () {
          //   //                         cartController.removeItemFromCart(
          //   //                             productId: product.id.toString(), context: context);
          //   //                       },
          //   //                       visualDensity: VisualDensity.compact,
          //   //                       icon: SvgPicture.asset(
          //   //                         "assets/svgs/delete.svg",
          //   //                         height: 18,
          //   //                         width: 18,
          //   //                       ))
          //   //                 ],
          //   //               ),
          //   //             ),
          //   //           ],
          //   //         ),
          //   //       );
          //   //     },
          //   //   ));
          //   // }),
          //   );
        })
      ],
    );
  }

  Column pickupInstruction() {
    return Column(
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
                  ...commonField(
                      textController: cartController.billingFirstName,
                      title: "First Name *".tr,
                      hintText: "Enter your first name".tr,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        // if (value!.trim().isEmpty) {
                        //   return "Please enter first name";
                        // }
                        return null;
                      }),
                  ...commonField(
                      textController: cartController.billingLastName,
                      title: "Last Name *".tr,
                      hintText: "Enter your last name".tr,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        // if (value!.trim().isEmpty) {
                        //   return "Please enter last name";
                        // }
                        return null;
                      }),
                  ...commonField(
                    textController: cartController.billingEmail,
                    title: "Email *".tr,
                    hintText: "Enter your Email".tr,
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
                      textController: cartController.billingPhone,
                      title: "Phone Number *".tr,
                      hintText: "Enter your phone number".tr,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        // if (value!.trim().isEmpty) {
                        //   return "Please enter phone number";
                        // }
                        // if (value.trim().length > 15) {
                        //   return "Please enter valid phone number";
                        // }
                        // if (value.trim().length < 8) {
                        //   return "Please enter valid phone number";
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
    );
  }

  Column deliveryInstruction() {
    return Column(
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
                    'Billing Address'.tr,
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
                        'Same As Shipping Address'.tr,
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black),
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
                      title: "First Name *".tr,
                      hintText: "Enter your first name".tr,
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
                      // } else if (value.trim().contains('+') || value.trim().contains(' ')) {
                      //   return "Email is invalid";
                      // } else if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
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
                    hintText: 'Select Country',
                    readOnly: true,
                    onTap: () {
                      showAddressSelectorDialog(
                          addressList: modelCountryList!.country!
                              .map((e) => CommonAddressRelatedClass(
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
                    controller: TextEditingController(
                        text: (selectedCountry ?? Country()).name ?? cartController.addressCountryController.text),
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
                        text: (selectedState ?? CountryState()).stateName ?? cartController.addressStateController.text),
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
                                  CommonAddressRelatedClass(title: e.stateName.toString(), addressId: e.stateId.toString()))
                              .toList(),
                          selectedAddressIdPicked: (String gg) {
                            String previous = ((selectedState ?? CountryState()).stateId ?? "").toString();
                            selectedState = modelStateList!.state!.firstWhere((element) => element.stateId.toString() == gg);
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
                    title: 'City',
                    hintText: 'Select City',
                    readOnly: true,
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
                          addressList: modelCityList!.city!
                              .map((e) =>
                                  CommonAddressRelatedClass(title: e.cityName.toString(), addressId: e.cityId.toString()))
                              .toList(),
                          selectedAddressIdPicked: (String gg) {
                            selectedCity = modelCityList!.city!.firstWhere((element) => element.cityId.toString() == gg);
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
                  if (cartController.countryName.value != 'Kuwait')
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
                          .map((e) => DropdownMenuItem(
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
          height: 25,
        ),
      ],
    );
  }
}

List<Widget> fieldWithName(
    {required String title,
    required String hintText,
    required TextEditingController controller,
    FormFieldValidator<String>? validator,
    bool? readOnly,
    VoidCallback? onTap,
    Widget? suffixIcon}) {
  return [
    Text(
      title.tr,
      style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500),
    ),
    const SizedBox(
      height: 5,
    ),
    CommonTextField(
      onTap: onTap,
      hintText: hintText.tr,
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
