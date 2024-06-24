import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dirise/model/common_modal.dart';
import 'package:dirise/repository/repository.dart';
import 'package:dirise/utils/helper.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/cart_controller.dart';
import '../../controller/profile_controller.dart';
import '../../controller/wish_list_controller.dart';
import '../../model/model_single_product.dart';
import '../../model/order_models/model_direct_order_details.dart';
import '../../model/product_model/model_product_element.dart';
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
  final cartController = Get.put(CartController());
  final wishListController = Get.put(WishListController());

  Size size = Size.zero;
  final Repositories repositories = Repositories();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
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
      ModelDirectOrderResponse response = ModelDirectOrderResponse.fromJson(jsonDecode(value));

      showToast(response.message.toString());
      if (response.status == true) {
        response.prodcutData!.inStock = productQuantity.value;
        if (kDebugMode) {
          print(response.prodcutData!.inStock);
        }
        Get.toNamed(DirectCheckOutScreen.route, arguments: response);
      }
    });
  }

  addToCartProduct() {
    if (!validateSlots()) return;
    Map<String, dynamic> map = {};
    map["product_id"] = widget.productElement.id.toString();
    map["quantity"] = map["quantity"] = int.tryParse(productQuantity.value.toString());
    map["key"] = 'fedexRate';
    map["country_id"] = profileController.model.user != null ? profileController.model.user!.country_id : '117';

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
        bottomSheet(productDetails: widget.productElement, context: context);
      },
      child:  widget.productElement.itemType != 'giveaway'
          ? Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
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
                          " SALE",
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
                                      '${widget.productElement.shippingDate.toString()}',
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
                              )
                        // Text("vendor doesn't ship internationally, contact us for the soloution",  style: GoogleFonts.poppins(
                        //     color: const Color(0xff858484),
                        //     fontSize: 13,
                        //     fontWeight: FontWeight.w500),),
                      ],
                    ),
                  ),
                  // if (canBuyProduct)
                  Expanded(
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            directBuyProduct();
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
      ): Padding(
              padding: const EdgeInsets.all(5.0),
              child: Stack(
                children: [
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
                                    style: GoogleFonts.poppins(
                                        fontSize: 16, fontWeight: FontWeight.w400, color: const Color(0xFF19313C)),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    widget.productElement.shortDescription ?? '',
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
                                    style: const TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF19313B),
                                    ),
                                  ),
                                ),
                                const WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: Text(
                                    'KWD',
                                    style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF19313B),
                                    ),
                                  ),
                                ),
                                const WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: Text(
                                    ' & Estimated arrival by ',
                                    style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF19313B),
                                    ),
                                  ),
                                ),
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child:  Text(
                                    widget.productElement.shippingDate,
                                    style: const TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF19313B),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ) : GestureDetector(
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
                      ],
                    ),
                  ),
                  Positioned(
                    right: 8,
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
                          "Free",
                          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w400, color: const Color(0xFF0C0D0C)),
                        ),
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
