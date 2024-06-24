import 'dart:convert';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dirise/utils/helper.dart';
import 'package:dirise/widgets/common_textfield.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../controller/cart_controller.dart';
import '../../controller/profile_controller.dart';
import '../../model/add_review_model.dart';
import '../../model/common_modal.dart';
import '../../model/get_review_model.dart';
import '../../model/model_single_product.dart';
import '../../model/order_models/model_direct_order_details.dart';
import '../../model/product_model/model_product_element.dart';
import '../../repository/repository.dart';
import '../../utils/api_constant.dart';
import '../../utils/styles.dart';
import '../../widgets/common_colour.dart';
import '../../widgets/loading_animation.dart';
import '../check_out/direct_check_out.dart';
import '../my_account_screens/contact_us_screen.dart';

class SingleProductDetails extends StatefulWidget {
  const SingleProductDetails({super.key, required this.productDetails});

  final ProductElement productDetails;

  @override
  State<SingleProductDetails> createState() => _SingleProductDetailsState();
}

class _SingleProductDetailsState extends State<SingleProductDetails> {
  final Repositories repositories = Repositories();
  ProductElement productElement = ProductElement();
  TextEditingController reviewController = TextEditingController();
  final profileController = Get.put(ProfileController());

 ProductElement get productDetails => productElement;
  ModelSingleProduct modelSingleProduct = ModelSingleProduct();
  ModelAddReview modelAddReview = ModelAddReview();

  bool get isBookingProduct => productElement.productType == "booking";

  bool get isVirtualProduct => productElement.productType == "virtual_product";

  bool get isVariantType => productElement.productType == "variants";

  bool get isVirtualProductAudio => productElement.virtualProductType == "voice";

  bool get canBuyProduct => productElement.addToCart == true;
  String dropdownvalue1 = 'red';
  String dropdownvalue2 = 'l';
  var items1 = [
    'red',
    'black',
    'white',
  ];
  var items2 = [
    'l',
    'M',
  ];

  String selectedSlot = "";
  final TextEditingController selectedDate = TextEditingController();
  DateTime selectedDateTime = DateTime.now();
  final formKey = GlobalKey<FormState>();

  final DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  final GlobalKey slotKey = GlobalKey();

  bool showValidation = false;

  bool validateSlots() {
    if (showValidation == false) {
      showValidation = true;
      setState(() {});
    }
    if (!formKey.currentState!.validate()) {
      selectedDate.checkEmpty;
      return false;
    }
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

  pickDate({required Function(DateTime gg) onPick, DateTime? initialDate, DateTime? firstDate, DateTime? lastDate}) async {
    DateTime lastD = lastDate ?? DateTime(2101);
    DateTime initialD = initialDate ?? firstDate ?? DateTime.now();

    if (lastD.isBefore(firstDate ?? DateTime.now())) {
      lastD = firstDate ?? DateTime.now();
    }

    if (initialD.isAfter(lastD)) {
      initialD = lastD;
    }

    if (initialD.isBefore(firstDate ?? DateTime.now())) {
      initialD = firstDate ?? DateTime.now();
    }

    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: initialD,
        firstDate: firstDate ?? DateTime.now(),
        lastDate: lastD,
        initialEntryMode: DatePickerEntryMode.calendarOnly);
    if (pickedDate == null) return;
    onPick(pickedDate);
    // updateValues();
  }

  Map<String, dynamic> get getMap {
    Map<String, dynamic> map = {};
    map["product_id"] = productElement.id.toString();
    map["quantity"] = map["quantity"] = int.tryParse(productQuantity.value.toString());
     map["key"] = 'fedexRate';
     map["country_id"]=profileController.model.user!.country_id;

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

  getProductDetails() {
    repositories.postApi(url: ApiUrls.singleProductUrl, mapData: {"id": productElement.id.toString(),"key":'fedexRate'}).then((value) {
      modelSingleProduct = ModelSingleProduct.fromJson(jsonDecode(value));
      if (modelSingleProduct.product != null) {
        log("modelSingleProduct.product!.toJson().....${modelSingleProduct.product!.toJson()}");
        // log("modelSingleProduct.product!.toJson().....${modelSingleProduct.product!.variants.toString()}");
        productElement = modelSingleProduct.product!;
        imagesList.addAll(modelSingleProduct.product!.galleryImage ?? []);
        imagesList = imagesList.toSet().toList();
        for (var element in productElement.variants!) {
          imagesList.add(element.image.toString());
        }
      }
      setState(() {});
    });
  }

  addToCartProduct() {
    if (!validateSlots()) return;
    Map<String, dynamic> map = {};
    map["product_id"] = productElement.id.toString();
    map["quantity"] = map["quantity"] = int.tryParse(productQuantity.value.toString());
    map["key"] = 'fedexRate';
    map["country_id"]= profileController.model.user!= null ? profileController.model.user!.country_id ?? '117' : '117';

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
        Get.back();
        cartController.getCart();
      }
    });
  }

  directBuyProduct() {
    if (!validateSlots()) return;
    Map<String, dynamic> map = {};
    map["product_id"] = productElement.id.toString();
    map["quantity"] = map["quantity"] = int.tryParse(productQuantity.value.toString());
    map["key"] = 'fedexRate';
    map["country_id"]= profileController.model.user!= null ? profileController.model.user!.country_id : '117';

    if (isBookingProduct) {
      map["start_date"] = selectedDate.text.trim();
      map["time_sloat"] = selectedSlot.split("--").first;
      map["sloat_end_time"] = selectedSlot.split("--").last;
    }
    if (isVariantType) {
      map["variation"] = selectedVariant!.id.toString();
    }
    repositories.postApi(url: ApiUrls.buyNowDetailsUrl, mapData: map, context: context).then((value) {
      log("Value>>>>>>>$value");
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

  List<String> imagesList = [];
  RxInt currentIndex = 0.obs;
  Variants? selectedVariant;

  @override
  void initState() {
    super.initState();
  productElement = widget.productDetails;
    imagesList.add(productElement.featuredImage.toString());
    imagesList.addAll(productElement.galleryImage ?? []);
    getPublishPostData();
    getProductDetails();
  }

  RxInt productQuantity = 1.obs;
  final cartController = Get.put(CartController());

  bool get checkLoaded => productElement.pName != null && productElement.sPrice != null;

  CarouselController carouselController = CarouselController();
  Rx<ModelGetReview> modelGetReview = ModelGetReview().obs;

  Future getPublishPostData() async {
    repositories.getApi(url: ApiUrls.getReviewUrl + productElement.id.toString()).then((value) {
      modelGetReview.value = ModelGetReview.fromJson(jsonDecode(value));
    });
  }

  RxBool alreadyReview = false.obs;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: checkLoaded
          ? Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20).copyWith(bottom: 10).copyWith(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 5,
                          width: context.getSize.width * .22,
                          decoration: BoxDecoration(color: Colors.grey.shade400, borderRadius: BorderRadius.circular(100)),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Flexible(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CarouselSlider(
                              options: CarouselOptions(
                                  height: 180.0,
                                  viewportFraction: .8,
                                  onPageChanged: (daf, sda) {
                                    currentIndex.value = daf;
                                  }),
                              carouselController: carouselController,
                              items: imagesList.map((i) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return GestureDetector(
                                      onTap: () {
                                        showImageViewer(context, Image.network(i).image,
                                            doubleTapZoomable: true,
                                            backgroundColor: AppTheme.buttonColor,
                                            useSafeArea: true,
                                            swipeDismissible: false);
                                      },
                                      child: CachedNetworkImage(
                                          imageUrl: i,
                                          height: 180,
                                          fit: BoxFit.cover,
                                          errorWidget: (_, __, ___) => Image.asset('assets/images/new_logo.png')),
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Obx(() {
                                return AnimatedSmoothIndicator(
                                  activeIndex: currentIndex.value,
                                  count: imagesList.length,
                                  effect: WormEffect(
                                      dotWidth: 10,
                                      dotColor: Colors.grey.shade200,
                                      dotHeight: 10,
                                      activeDotColor: AppTheme.buttonColor),
                                );
                              }),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    productElement.discountOff!= "0.00"? Text(
                                      "${productElement.discountOff} ${'%'} Off",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14, fontWeight: FontWeight.w500, color: const Color(0xffC22E2E)),
                                    ): const SizedBox.shrink(),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      productElement.pName.toString().capitalize!,
                                      style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    productElement.inStock == "-1"?SizedBox.shrink():
                                    Text(
                                      '${productElement.inStock.toString()} pieces',
                                      style: GoogleFonts.poppins(color: const Color(0xff858484), fontSize: 17),
                                    ),
                                    productElement.itemType != 'giveaway'?    const SizedBox(
                                      height: 5,
                                    ): const   SizedBox.shrink(),

                                   productElement.itemType != 'giveaway'
                                        ? Row(
                                      children: [
                                        productElement.pPrice ==  productElement.discountPrice ? const Text('') :
                                        Text(
                                          'KWD ${productElement.pPrice.toString()}',
                                          style: GoogleFonts.poppins(
                                              decorationColor: Colors.red,
                                              decorationThickness: 2,
                                              decoration: TextDecoration.lineThrough,
                                              color: const Color(0xff19313B),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                        Text.rich(
                                          TextSpan(
                                            text: '${productElement.discountPrice.toString().split('.')[0]}.',
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
                                                        print("date:::::::::::" + productElement.shippingDate);
                                                      },
                                                      child: Text(
                                                        '${productElement.discountPrice.toString().split('.')[1]}',
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
                                    )
                                        : const SizedBox.shrink(),
                                  ],
                                )),
                                if (isVirtualProduct)
                                  if (isVirtualProductAudio)
                                    SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: Image.asset(
                                          "assets/icons/voice_icon.jpg",
                                          // color: Colors.red,
                                        ))
                                  else
                                    SizedBox(width: 40, height: 40, child: SvgPicture.asset("assets/svgs/pdf.svg"))
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            if (isVariantType) ...[
                              Text(
                                'Variants',
                                style: normalStyle,
                              ),
                              if (modelSingleProduct.product != null && modelSingleProduct.product!.variants != null)
                                DropdownButtonFormField(
                                  value: selectedVariant,
                                  isExpanded: true,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      enabled: true,
                                      enabledBorder: InputBorder.none,
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      hintText: "Select Variant",
                                      hintStyle: normalStyle),
                                  validator: (value) {
                                    if (selectedVariant == null) {
                                      return "Please select variation";
                                    }
                                    return null;
                                  },
                                  items: modelSingleProduct.product!.variants!
                                      .map((e) => DropdownMenuItem(
                                          value: e,
                                          child: Row(
                                            children: [
                                              Expanded(child: Text(e.comb.toString().capitalize!)),
                                              Text("kwd ${e.price}"),
                                              const SizedBox(
                                                width: 4,
                                              )
                                            ],
                                          )))
                                      .toList(),
                                  onChanged: (newValue) {
                                    if (newValue == null) return;
                                    selectedVariant = newValue;
                                    carouselController.animateToPage(imagesList
                                        .indexWhere((element) => element.toString() == selectedVariant!.image.toString()));
                                    setState(() {});
                                  },
                                ),
                            ],
                            const SizedBox(
                              height: 20,
                            ),
                            if(modelSingleProduct.product!= null)
                            modelSingleProduct.product?.shippingDate != "No Internation Shipping Available"?
                            Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'shipping',
                                  style: GoogleFonts.poppins(
                                      color: const Color(0xff858484),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                ),
                                if(modelSingleProduct.product!= null)
                                if(modelSingleProduct.product?.lowestDeliveryPrice!=null)
                                  Text(
                                    'KWD${modelSingleProduct.product!.lowestDeliveryPrice.toString()}',
                                    style: GoogleFonts.poppins(
                                        color: const Color(0xff858484),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                  ),
                                if(modelSingleProduct.product!= null)
                                if(modelSingleProduct.product!.shippingDate!=null)
                                  Text(
                                    modelSingleProduct.product!.shippingDate.toString(),
                                    style: GoogleFonts.poppins(
                                        color: const Color(0xff858484),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                  ),
                              ],
                            ): GestureDetector(
                              onTap: () {
                                Get.to(() => const ContactUsScreen());
                              },
                              child: RichText(
                                text: TextSpan(
                                    text: 'vendor doesn\'t ship internationally',
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
                                              color: const Color(0xff858484), fontSize: 13, fontWeight: FontWeight.w500)),
                                    ]),
                              ),
                            ),
                            // Text("No Internation Shipping Available",
                            //   style: GoogleFonts.poppins(
                            //     shadows: [const Shadow(color: Colors.black, offset: Offset(0, -4))],
                            //     color: Colors.transparent,
                            //     fontSize: 18,
                            //     fontWeight: FontWeight.w500,
                            //     decoration: TextDecoration.underline,
                            //   ),),
                            const SizedBox(height: 15,),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'DESCRIPTION'.tr,
                                style: GoogleFonts.poppins(
                                  shadows: [const Shadow(color: Colors.black, offset: Offset(0, -4))],
                                  color: Colors.transparent,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              Bidi.stripHtmlIfNeeded(productElement.shortDescription ?? ''),
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'CUSTOMER REVIEWS (${modelGetReview.value.reviewCount != null ? modelGetReview.value.reviewCount.toString() : '0'})'
                                    .tr,
                                style: GoogleFonts.poppins(
                                  shadows: [const Shadow(color: Colors.black, offset: Offset(0, -4))],
                                  color: Colors.transparent,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Obx(() {
                              return modelGetReview.value.status == true
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: modelGetReview.value.data!.length,
                                      itemBuilder: (context, index) {
                                        final item = modelGetReview.value.data![index];
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            10.spaceY,
                                            Text(
                                              item.name.toString(),
                                              style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            10.spaceY,
                                            Text(
                                              item.comment.toString(),
                                              style: GoogleFonts.poppins(
                                                  fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black87),
                                            ),
                                          ],
                                        );
                                      },
                                    )
                                  : const SizedBox();
                            }),
                            20.spaceY,
                            productElement.beforePurchase == true &&
                                productElement.alreadyReview == false &&
                                    alreadyReview.value == false
                                ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Leave A Review',
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      15.spaceY,
                                      Padding(
                                        padding: const EdgeInsets.all(8.0).copyWith(
                                          bottom: MediaQuery.of(context).viewInsets.bottom + 01.0,
                                        ),
                                        child: CommonTextField(
                                          hintText: 'Write a review',
                                          controller: reviewController,
                                          isMulti: true,
                                        ),
                                      ),
                                      15.spaceY,
                                      ElevatedButton(
                                        onPressed: () {
                                          Map<String, String> map = {};
                                          map['comment'] = reviewController.text.toString();
                                          map['product_id'] = productElement.id.toString();
                                          repositories.postApi(url: ApiUrls.addReviewUrl, mapData: map).then((value) {
                                            modelAddReview = ModelAddReview.fromJson(jsonDecode(value));
                                            if (modelAddReview.status == true) {
                                              showToast(modelAddReview.message.toString());
                                              setState(() {
                                                alreadyReview.value = true;
                                              });
                                              getPublishPostData();
                                              reviewController.text = '';
                                            } else {
                                              showToast(modelAddReview.message.toString());
                                            }
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppTheme.buttonColor,
                                          surfaceTintColor: AppTheme.buttonColor,
                                        ),
                                        child: FittedBox(
                                          child: Text(
                                            "POST A REVIEW".tr,
                                            style: GoogleFonts.poppins(
                                                fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                            const SizedBox(
                              height: 16,
                            ),
                            if (isBookingProduct)
                              if (modelSingleProduct.product != null &&
                                  modelSingleProduct.product!.serviceTimeSloat != null) ...[
                                Text(
                                  "Select Date".tr,
                                  style: normalStyle,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                TextFormField(
                                  onTap: () {
                                    pickDate(
                                        onPick: (DateTime gg) {
                                          if (dateFormat
                                              .parse((modelSingleProduct.product!.productAvailability!.fromDate ??
                                                      modelSingleProduct.product!.productAvailability!.toDate)
                                                  .toString())
                                              .isAfter(gg)) {
                                            showToast("This date is not available".tr);
                                            return;
                                          }
                                          selectedDate.text = dateFormat.format(gg);
                                          selectedDateTime = gg;
                                        },
                                        initialDate: selectedDateTime,
                                        firstDate: DateTime.now(),
                                        lastDate: dateFormat.parse(
                                            (modelSingleProduct.product!.productAvailability!.toDate ??
                                                    modelSingleProduct.product!.productAvailability!.fromDate)
                                                .toString()));
                                  },
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value!.trim().isEmpty) {
                                      return "Please select date".tr;
                                    }
                                    return null;
                                  },
                                  readOnly: true,
                                  controller: selectedDate,
                                  key: selectedDate.getKey,
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                    enabled: true,
                                    suffixIcon: Icon(
                                      CupertinoIcons.calendar,
                                      color: Colors.grey.shade800,
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                    enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                    hintText: "Select Date".tr,
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  "Available Slot".tr,
                                  style: normalStyle,
                                ),
                                Wrap(
                                  key: slotKey,
                                  spacing: 14,
                                  children: modelSingleProduct.product!.serviceTimeSloat!
                                      .map((e) => FilterChip(
                                          label: Text(
                                              "${e.timeSloat.toString().convertToFormatTime} - ${e.timeSloatEnd.toString().convertToFormatTime}"),
                                          side: BorderSide(
                                            color: showValidation && selectedSlot.isEmpty
                                                ? Theme.of(context).colorScheme.error
                                                : Colors.grey,
                                          ),
                                          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                                          selected: selectedSlot == "${e.timeSloat}--${e.timeSloatEnd}",
                                          onSelected: (value) {
                                            selectedSlot = "${e.timeSloat}--${e.timeSloatEnd}";
                                            setState(() {});
                                          }))
                                      .toList(),
                                ),
                                if (showValidation && selectedSlot.isEmpty)
                                  Text(
                                    "Please select available slots".tr,
                                    style: normalStyle.copyWith(color: Theme.of(context).colorScheme.error, fontSize: 13),
                                  ),
                                const SizedBox(
                                  height: 16,
                                ),
                              ] else
                                const LoadingAnimation()
                          ],
                        ),
                      ),
                    ),
                    if (canBuyProduct)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (productQuantity.value > 1) {
                                    productQuantity.value--;
                                  }
                                },
                                child: CircleAvatar(
                                  radius: 22,
                                  backgroundColor: const Color(0xffEAEAEA),
                                  child: Center(
                                      child: Text(
                                        "━",
                                        style: GoogleFonts.poppins(
                                            fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
                                      )),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Obx(() {
                                return Text(
                                  productQuantity.value.toString(),
                                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18),
                                );
                              }),
                              SizedBox(
                                width: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (productElement.inStock ==0) {
                                    showToast("Out Of Stock".tr);

                                  } else {
                                    productQuantity.value++;
                                  }
                                },
                                child: CircleAvatar(
                                  radius: 22,
                                  backgroundColor: const Color(0xffEAEAEA),
                                  child: Center(
                                      child: Text(
                                        "+",
                                        style: GoogleFonts.poppins(
                                            fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
                                      )),
                                ),
                              ),
                            ],
                          ),
                          16.spaceY,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {

                                    directBuyProduct();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppTheme.buttonColor,
                                    surfaceTintColor: AppTheme.buttonColor,
                                  ),
                                  child: FittedBox(
                                    child: Text(
                                      "Buy Now".tr,
                                      style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              5.spaceX,
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
                                      style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            )
          : const LoadingAnimation(),
    );
  }
}
