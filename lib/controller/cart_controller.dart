import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:dirise/controller/profile_controller.dart';
import 'package:dirise/model/common_modal.dart';
import 'package:dirise/repository/repository.dart';
import 'package:dirise/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import '../language/app_strings.dart';
import '../model/model_address_list.dart';
import '../model/model_cart_response.dart';
import '../model/myDefaultAddressModel.dart';
import '../model/order_models/model_direct_order_details.dart';
import '../model/order_models/place_order_response.dart';
import '../screens/check_out/order_completed_screen.dart';
import '../utils/api_constant.dart';
import '../vendor/authentication/payment_screen.dart';
import '../vendor/authentication/thank_you_screen.dart';
import 'location_controller.dart';

enum PurchaseType { buy, cart }

class CartController extends GetxController {
  RxInt refreshInt = 0.obs;
  RxInt refreshInt11 = 0.obs;
  String countryCode = '';
  String stateCode = '';
  String cityCode = '';
  RxString countryName = ''.obs;
  RxString address = ''.obs;
  RxString city = ''.obs;
  // int isKuwait = 0;
  RxString stateName = ''.obs;
  RxString cityName = ''.obs;
  final Repositories repositories = Repositories();
  ModelCartResponse cartModel = ModelCartResponse();
  bool apiLoaded = false;
  ModelUserAddressList addressListModel = ModelUserAddressList();
  bool addressLoaded = false;
  String shippingId = "";
  AddressData selectedAddress = AddressData();
  // final locationController = Get.put(LocationController());
  final GlobalKey addressKey = GlobalKey();
  RxString deliveryOption1 = "delivery".obs;
  RxBool showValidation = false.obs;
  RxBool showValidationShipping = false.obs;
  final TextEditingController addressDeliFirstName = TextEditingController();
  final TextEditingController addressDeliLastName = TextEditingController();
  final TextEditingController addressDeliEmail = TextEditingController();
  final TextEditingController addressDeliPhone = TextEditingController();
  final TextEditingController addressDeliAlternate = TextEditingController();
  final TextEditingController addressDeliAddress = TextEditingController();
  final TextEditingController addressDeliOtherInstruction = TextEditingController();
  final TextEditingController addressDeliZipCode = TextEditingController();
  TextEditingController addressCountryController = TextEditingController();
  TextEditingController addressStateController = TextEditingController();
  TextEditingController addressCityController = TextEditingController();
  RxBool isDelivery = false.obs;
  String shippingTitle = '';
  String shippingPrices = '';
  String shippingPrices1 = '';
  String shippingPrices2 = '';
  double withoutSelectPrice = 0.0;
  String shippingPrices3 = '';
  final TextEditingController billingFirstName = TextEditingController();
  final TextEditingController billingLastName = TextEditingController();
  final TextEditingController billingEmail = TextEditingController();
  final TextEditingController billingPhone = TextEditingController();
  RxInt countDown = 30.obs;
  Timer? _timer;
  String formattedTotal = '';
  String formattedTotalddf = '';
  String formattedTotal3 = '';
  String formattedTotal2 = '';
  String formattedTotal4 = '';
  String shippingDates = '';
  double formattedTotal1 = 0.0;
  List<String> shippingList = [];
  List<String> shippingDate = [];
  List<int> shippingVendorId = [];
  List<String> shippingVendorName = [];
  List<String> shippingPriceList = [];
  String storeId= '';
  String storeIdShipping= '';
  String storeNameShipping= '';
  startTimer() {
    stopTimer();
    countDown.value = 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countDown.value != 0) {
        countDown.value--;
      } else {
        stopTimer();
      }
    });
  }

  stopTimer() {
    try {
      if (_timer == null) return;
      _timer!.cancel();
      _timer = null;
    } catch (e) {
      return;
    }
  }

  placeOrder({
    required BuildContext context,
    required String subTotalPrice,
    required String totalPrice,
    required String currencyCode,
    required String deliveryOption,
    required String paymentMethod,
    required String title,
    String? couponCode,
    required String idd,
    String? shippingPrice,
    String? productID,
    String? quantity,
    String? otp,
    String? shippingId,
    String? shipmentProvider,
    required PurchaseType purchaseType,
    required String purchaseType1,
    Map<String, dynamic>? address,
  }) {
    Map<String, dynamic> gg = {
      if (shippingPrice != null) "shipping_price": shippingPrice,
      if (otp != null) "otp": otp,
      if (productID != null) "product_id": productID,
      if (quantity != null) "quantity": quantity,
      "type": purchaseType.name,
      "subtotPrice": subTotalPrice,

      "total": totalPrice,
      "payment_method": paymentMethod,
      "delivery_type": deliveryOption, // delivery or pickup
      "totPrice": totalPrice,
      if (couponCode != null) "coupon_code": couponCode,
      "currency_code": currencyCode,
      "refund_amount_in": "bank",
      "shipping_method": "online",
      "currency_sign": "kwd",
      'callback_url': 'https://diriseapp.com/home/$navigationBackUrl',
      'failure_url': 'https://diriseapp.com/home/$failureUrl',
      "shipping": [
        {"title":title,

          "type":purchaseType1,
          "shipment_provider": shipmentProvider,
          "store_id":  storeIdShipping.toString(), "store_name": storeNameShipping.toString(),"ship_price": shippingPrices1.toString() , "shipping_type_id": shippingId,
        'shipping_date' :  shippingDates.toString()}
      ],
      "cart_id": ["2"],
      'billing_address' : {
        'first_name' : billingFirstName.text.toString(),
        'last_name' :  billingLastName.text.toString(),
        'phone' : billingPhone.text.toString(),
        'email' : billingEmail.text.toString(),
      },
      // if (address != null && deliveryOption1.value == "delivery") "shipping_address": address,
      if (address != null) "billing_address": address,
      if (address != null) "shipping_address": address
    };
    repositories.postApi(url: ApiUrls.placeOrderUrl, context: context, mapData: gg).then((value) {
      // ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      ModelPlaceOrderResponse response = ModelPlaceOrderResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      print("response"+response.message.toString());
      if (response.status == true) {
        log("response"+response.message.toString());
        getCart();
        // if(re)
        if (dialogOpened) {
          Get.back();
        }
         Get.to(() => PaymentScreen(
               paymentUrl: response.URL.toString(),
               onSuccess: () {
                 Get.offNamed(OrderCompleteScreen.route, arguments: response.order_id.toString());
               },
             ));
      } else {
        if (response.message.toString().toLowerCase().contains("otp")) {
          startTimer();
          if (dialogOpened == false) {
            showOTPDialog(
                context: context,
                paymentMethod: paymentMethod,
                purchaseType: purchaseType,
                subTotalPrice: subTotalPrice,
                title: title,
                currencyCode: currencyCode,
                totalPrice: totalPrice,
                address: address,
                productID: productID,
                quantity: quantity,
                purchaseType1: purchaseType1,
                deliveryOption: deliveryOption,
                couponCode: couponCode);
          }
        }
      }
    });
  }

  bool dialogOpened = false;

  showOTPDialog({
    required BuildContext context,
    required PurchaseType purchaseType,
    required String subTotalPrice,
    required String totalPrice,
    required String title,
    required String currencyCode,
    required String deliveryOption,
    required String paymentMethod,
    String? couponCode,
    String? quantity,
    String? productID,
    required String purchaseType1,
    Map<String, dynamic>? address,
  }) {
    dialogOpened = true;
    final TextEditingController otpController = TextEditingController();
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  6.spaceY,
                  Text(
                    AppStrings.otpHasBeenSent,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  12.spaceY,
                  Pinput(
                    controller: otpController,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    keyboardType: TextInputType.number,
                    length: 4,
                    defaultPinTheme: defaultPinTheme,
                  ),
                  15.spaceY,
                  Text(
                    AppStrings.doNotReceivedOtp,
                    style:
                        GoogleFonts.poppins(color: const Color(0xff3D4260), fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  TextButton(
                    onPressed: () async {
                      if (countDown.value != 0) return;
                      placeOrder(
                          context: context,
                          paymentMethod: paymentMethod,
                          currencyCode: currencyCode,
                          subTotalPrice: subTotalPrice,
                          title: title,
                          totalPrice: totalPrice,
                          couponCode: couponCode,
                          quantity: quantity,
                          deliveryOption: deliveryOption,
                          productID: productID,
                          purchaseType: purchaseType,
                          address: address, idd: shippingId, purchaseType1:purchaseType1);
                    },
                    child: Obx(() => Text(
                          countDown.value != 0 ? "Resend OTP in ${countDown.value}s" : AppStrings.resendOtp,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600, color: const Color(0xff578AE8), fontSize: 16),
                        )),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () async {
                            Get.back();
                            stopTimer();
                          },
                          child: Text(
                            "Cancel",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.error, fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () async {
                            if (otpController.text.trim().isEmpty) {
                              showToast("Please enter otp");
                              return;
                            }
                            if (otpController.text.trim().length != 4) {
                              showToast("Please enter valid otp");
                              return;
                            }
                            placeOrder(
                                context: context,
                                paymentMethod: paymentMethod,
                                currencyCode: currencyCode,
                                subTotalPrice: subTotalPrice,
                                totalPrice: totalPrice,
                                couponCode: couponCode,
                                title: title,
                                quantity: quantity,
                                productID: productID,
                                deliveryOption: deliveryOption,
                                address: address,
                                purchaseType: purchaseType,
                                purchaseType1:purchaseType1 ,
                                otp: otpController.text.trim(), idd: shippingId);
                          },
                          child: Text(
                            "Submit",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600, color: const Color(0xff578AE8), fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  5.spaceY,
                ],
              ),
            ),
          );
        });
  }

  final defaultPinTheme = PinTheme(
      width: 45,
      height: 45,
      textStyle: GoogleFonts.poppins(
        fontSize: 18,
        color: const Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: Colors.grey.shade300,
        width: 4.0,
      ))));

  addCart({
    required BuildContext context,
    required String id,
    required String orderId,
    required String productId,
    required String productName,
  }) {
    Map<String, dynamic> map = {};
    map["id"] = id;
    map["orderId"] = orderId;
    map["productId"] = productId;
    map["productName"] = productName;
    repositories.postApi(url: ApiUrls.editAddressUrl, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      if (response.status == true) {
        getAddress();
        Get.back();
      }
    });
  }

  updateAddressApi(
      {required String firstName,
      required String lastName,
      required String email,
      required String phone,
      required String countryName,
      required String alternatePhone,
      required String address,
      required String address2,
      required String city,
      required String country,
      required String state,
      required String stateId,
      required String cityId,
      required String zipCode,
      required String landmark,
      required String title,
      required String phoneCountryCode,
       String? type,
      required BuildContext context,
      id}) {
    final map = {
      if(id != null)
        'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'alternate_phone': alternatePhone,
      'email' : email,
      'address_type': 'shipping',
      'address': address,
      'address2': address2,
      'zip_code': zipCode,
      'landmark': landmark,
      'title': title,
      'country_id': country,
      'country' : countryName,
      'state_id': stateId,
      'city_id': cityId,
      'state': state,
      'city': city,
      'type' : type,
      'phone_country_code' : phoneCountryCode
    };

    // Map<String, dynamic> map = {};
    //
    // if (id != null) {
    //   map["id"] = id;
    // }
    // map["first_name"] = firstName;
    // map["last_name"] = lastName;
    // map["phone"] = phone;
    // map["alternate_phone"] = alternatePhone;
    // map["address"] = address;
    // map["address2"] = address2;
    // map["city"] = city;
    // map["address_type"] = "shipping";
    // map["country"] = country;
    // map["state"] = state;
    // map["zip_code"] = zipCode;
    // map["landmark"] = landmark;
    // map["title"] = title;

    repositories.postApi(url: ApiUrls.editAddressUrl, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      if (response.status == true) {
        getAddress();
        Get.back();
      }
    });
  }

  Future<bool> deleteAddress({required BuildContext context, required String id}) async {
    Map<String, dynamic> map = {};
    map["id"] = id;

    await repositories.postApi(url: ApiUrls.deleteAddressUrl, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      if (response.status == true) {
        getAddress();
        return true;
        // Get.back();
      }
    }).catchError((e) {
      return false;
    });
    return false;
  }

  Future updateCartQuantity({
    required BuildContext context,
    required String productId,
    required String quantity,
  }) async {
    final map = {
      "product_id": productId,
      "qty": quantity,
    };

    await repositories.postApi(url: ApiUrls.quantityUpdateUrl, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      getCart();
    }).catchError((e) {});
    return false;
  }
  final profileController = Get.put(ProfileController());
  getAddress() {
    repositories.postApi(url: ApiUrls.addressListUrl).then((value) {
      addressLoaded = true;
      addressListModel = ModelUserAddressList.fromJson(jsonDecode(value));
      log('address iss....${addressListModel.address!.toJson()}');
      updateUIAdd();
    });
  }

  removeItemFromCart({
    required String productId,
    BuildContext? context,
  }) {
    Map<String, dynamic> map = {};
    map["product_id"] = productId;
    repositories.postApi(url: ApiUrls.deleteCartUrl, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      getCart();
    });
  }
  String countryId = '';
  String zipCode = '';
  String zipCode1 = '';
  TextEditingController addressController = TextEditingController();
  Future getCart() async {
    // if (cartModel.cart != null) {
    //   for (var element in cartModel.cart!) {
    //     element.showDetails.value = false;
    //   }
    // }
    Map<String, dynamic> map = {};
    map["key"] = 'fedexRate';
    map["country_id"]= profileController.model.user!= null && countryId.isEmpty ? profileController.model.user!.country_id : countryId.toString();
    // map["country_id"]= countryId.isNotEmpty ? countryId.toString() : '117';
    map["zip_code"]= zipCode.isNotEmpty ? zipCode.toString() : '302021';
    map["city"]= zipCode.isNotEmpty ?  city.value.toString():"jaipur";
    map["address"]= address.value.toString();
    map["identifier_key"]= "checkout";

    log("mappppppp::::::$map");
    log("mappppppp::::::$countryId");
    await repositories.postApi(url: ApiUrls.cartListUrl,mapData: map ).then((value) {
     cartModel = ModelCartResponse.fromJson(jsonDecode(value));
      log('cart model is ${cartModel.toJson()}');
      print("zip:::::::::::"+zipCode1);
      apiLoaded = true;
      updateUI();
    });
  }
  Rx<MyDefaultAddressModel> myDefaultAddressModel = MyDefaultAddressModel().obs;
  myDefaultAddressData() {
    repositories.getApi(url: ApiUrls.myDefaultAddressStatus).then((value) {
      myDefaultAddressModel.value = MyDefaultAddressModel.fromJson(jsonDecode(value));
      // log('defalut address value....${myDefaultAddressModel.value.defaultAddress!.toJson()}');
    });
  }

  defaultAddressApi({context}) async {
    Map<String, dynamic> map = {};
    map['address_id'] = selectedAddress.id.toString();
    repositories.postApi(url: ApiUrls.defaultAddressStatus, context: context, mapData: map).then((value) async {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      if (response.status == true) {
        showToast(response.message.toString());
        Get.back();
      }else{
        showToast(response.message.toString());
      }
    });
  }
  updateUI() {
    refreshInt.value = DateTime.now().microsecondsSinceEpoch;
  }
  updateUIAdd() {
    refreshInt11.value = DateTime.now().microsecondsSinceEpoch;
  }

  //buy now call address
  String productElementId = '';
  String productQuantity = '';
  bool isBookingProduct = false;
  String selectedDate = '';
  String selectedSlot = '';
  String selectedSlotEnd = '';
  bool isVariantType = false;
  String selectedVariant = '';
  Rx<ModelDirectOrderResponse> directOrderResponse = ModelDirectOrderResponse().obs;

  @override
  void onInit() {
    super.onInit();
    getCart();
  }

  @override
  void dispose() {
    super.dispose();
    stopTimer();
  }
}
