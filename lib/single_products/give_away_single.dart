import 'dart:convert';
import 'dart:developer';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:dirise/utils/helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../controller/cart_controller.dart';
import '../controller/profile_controller.dart';
import '../model/add_review_model.dart';
import '../model/common_modal.dart';
// import '../model/filter_by_price_model.dart';
import '../model/get_review_model.dart';
import '../model/model_single_product.dart';
import '../model/order_models/model_direct_order_details.dart';
import '../model/product_model/model_product_element.dart';
import '../repository/repository.dart';
import '../screens/check_out/direct_check_out.dart';
import '../utils/api_constant.dart';
import '../utils/styles.dart';
import '../widgets/cart_widget.dart';
import '../widgets/common_colour.dart';
class GiveAwayProduct extends StatefulWidget {

  const GiveAwayProduct({super.key,required this.productDetails});
  final ProductElement productDetails;
  @override
  State<GiveAwayProduct> createState() => _GiveAwayProductState();
}

class _GiveAwayProductState extends State<GiveAwayProduct> {



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
        showToast("Please select variation");
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
    map["country_id"]= profileController.model.user!= null && cartController.countryId.isEmpty ? profileController.model.user!.country_id : cartController.countryId.toString();

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
    cartController.productElementId = productElement.id.toString();
    cartController.productQuantity =  productQuantity.value.toString();
    cartController.isBookingProduct =  isBookingProduct;
    cartController.selectedDate =  selectedDate.text.trim();
    cartController.selectedSlot =  selectedSlot.split("--").first;
    cartController.selectedSlotEnd = selectedSlot.split("--").last;
    cartController.isVariantType = isVariantType;
    if (isVariantType) {
      cartController.selectedVariant = selectedVariant!.id.toString();
    }
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
      print('singleee');
      cartController.directOrderResponse.value = ModelDirectOrderResponse.fromJson(jsonDecode(value));

      showToast(cartController.directOrderResponse.value.message.toString());
      if (cartController.directOrderResponse.value.status == true) {

        cartController.directOrderResponse.value.prodcutData!.inStock = productQuantity.value;
        if (kDebugMode) {
          print(cartController.directOrderResponse.value.prodcutData!.inStock);
        }
        Get.toNamed(DirectCheckOutScreen.route);
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


























  // final profileController = Get.put(ProfileController());
  int _counter = 0;

  void incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  Size size = Size.zero;
  void decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  backgroundColor: Colors.white,
  surfaceTintColor: Colors.white,
  elevation: 0,
  leadingWidth: 120,
  leading:Row(
    children: [
      SizedBox(width: 20,),
      GestureDetector(
        onTap: (){
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
      SizedBox(width: 20,),
      InkWell(
        onTap: () {
          // setState(() {
          //   search.value = !search.value;
          // });
        },
        child: SvgPicture.asset(
          'assets/svgs/search_icon_new.svg',
          width: 38,
          height: 38,
          // color: Colors.white,
        ),
        // child : Image.asset('assets/images/search_icon_new.png')
      ),
    ],
  ),
  actions: [
    // ...vendorPartner(),
    const CartBagCard(),
    Icon(Icons.more_vert,color: Color(0xFF014E70),),
    SizedBox(width: 10,)
  ],
  titleSpacing: 0,

),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 7,horizontal: 25),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Color(0xFFFFDF33)),
                      color: Color(
                        0xFFFFDF33
                      ).withOpacity(.25)
                    ),
                    child:  Text(
                       "Free",
                       style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 11, color:Colors.black),
        
                     ),
                  ),
                  Spacer(),
                  Text(
                    "512 ",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 12, color:Color(0xFf000000).withOpacity(.50)),
        
                  ),
                  Icon(Icons.favorite_border,color: Colors.red,),
                ],
              ),
              Center(child: Image.asset("assets/svgs/single.png")),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8,horizontal: 18),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    // border: Border.all(color: Colors.white),
                    color: Colors.white,
                  boxShadow:[ BoxShadow(
                    offset: Offset(1,1),
                    blurRadius: 2,
                    color: Colors.grey
                  )
             ]   ),
        
                child:  Text(
                  "1/10",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 10, color:Color(0xFF014E70)),
        
                ),
              ),
              SizedBox(height: 20,),
              SizedBox(
                height: 58,
                child: ListView.builder(
                    itemCount: 10,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return  Image.asset("assets/svgs/single.png",height: 56,width: 86,);
                    },
        
                ),
              ),
              SizedBox(height: 20,),
              Text(
                "Set of essentials of fun",
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18, color:Color(0xFF19313C)),
        
              ),
              Text(
                "All what you need for a fun and exciting day in the park with your family All what you need for the day at park.. Read ",
                style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 12, color:Color(0xFF19313C)),
        
              ),
        
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     Text("Cashback : ", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14, color:Colors.black),),
              //     Text("1.5% ", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14, color:Color(0xFFFF0000)),),
              //     Text("dicoins", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14, color:Colors.black),),
              //   ],
              // ),
              SizedBox(height: 6,),
        
        
        
              // Row(
              //   children: [
              //     widget.productElement.discountOff !=  '0.00'? Expanded(
              //       child: Text(
              //         'KWD ${widget.productElement.pPrice.toString()}',
              //         style: GoogleFonts.poppins(
              //             decorationColor: Colors.red,
              //             decorationThickness: 2,
              //             decoration: TextDecoration.lineThrough,
              //             color: const Color(0xff19313B),
              //             fontSize: 16,
              //             fontWeight: FontWeight.w600),
              //       ),
              //     ): const SizedBox.shrink(),
              //     const SizedBox(
              //       width: 7,
              //     ),
              //     Expanded(
              //       child: Text.rich(
              //         TextSpan(
              //           text: '${widget.productElement.discountPrice.toString().split('.')[0]}.',
              //           style: const TextStyle(
              //             fontSize: 24,
              //             fontWeight: FontWeight.w600,
              //             color: Color(0xFF19313B),
              //           ),
              //           children: [
              //             WidgetSpan(
              //               alignment: PlaceholderAlignment.middle,
              //               child: Column(
              //                 mainAxisAlignment: MainAxisAlignment.start,
              //                 children: [
              //                   const Text(
              //                     'KWD',
              //                     style: TextStyle(
              //                       fontSize: 8,
              //                       fontWeight: FontWeight.w500,
              //                       color: Color(0xFF19313B),
              //                     ),
              //                   ),
              //                   InkWell(
              //                     onTap: () {
              //                       print("date:::::::::::" + widget.productElement.shippingDate);
              //                     },
              //                     child: Text(
              //                       '${widget.productElement.discountPrice.toString().split('.')[1]}',
              //                       style: const TextStyle(
              //                         fontSize: 8,
              //                         fontWeight: FontWeight.w600,
              //                         color: Color(0xFF19313B),
              //                       ),
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ],
              // )
        
              Row(
                children: [
                Text(
                  'KWD ${"9999999000"}',
                  style: GoogleFonts.poppins(
                      decorationColor: Colors.red,
                      decorationThickness: 2,
                      decoration: TextDecoration.lineThrough,
                      color: const Color(0xff19313B),
                      fontSize: 11,
                      fontWeight: FontWeight.w600),
                ),
                  const SizedBox(
                    width: 7,
                  ),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: '${"100000990"}.',
                        style: const TextStyle(
                          fontSize: 28,
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
                                    '${"00"}',
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
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RatingBar.builder(
                    initialRating: 5,
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
                  SizedBox(width: 10,),
                  Image.asset("assets/svgs/rils.png"),
                ],
              ),
              Text(
                "Dirise Welcome deal  ",
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18, color:Color(0xFF014E70)),
        
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Icon(Icons.circle,color: Colors.grey,size: 10,),
                  const SizedBox(
                    width: 7,
                  ),
                  Text(
                    'Up to 70% off. Free shipping on 1st order',
                    style: GoogleFonts.poppins(
        
                        color:  Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
        
        
        
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Icon(Icons.circle,color: Colors.grey,size: 10,),
                  const SizedBox(
                    width: 7,
                  ),
                  Text(
                    'Fedex Fast delivery by ',
                    style: GoogleFonts.poppins(
        
                        color:  Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'May 12-15',
                    style: GoogleFonts.poppins(
        
                        color:  Color(0xFf014E70),
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
        
        
        
                ],
              ),
              Row(
                children: [
        
                  Text(
                    'Quantity : ',
                    style: GoogleFonts.poppins(
        
                        color:  Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  Text(
                    '15 Left',
                    style: GoogleFonts.poppins(
        
                        color:  Color(0xFfFF0000),
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
        
                  IconButton(
                    icon: Icon(Icons.remove,color: Color(0xFF014E70),),
                    onPressed: decrementCounter,
                  ),
                  Text(
                    '$_counter',
                    style: GoogleFonts.poppins(
        
                        color:  Color(0xFF014E70),
                        fontSize: 26,
                        fontWeight: FontWeight.w500),
                  ),
                  IconButton(
                    icon: Icon(Icons.add,color: Color(0xFF014E70),),
                    onPressed: incrementCounter,
                  ),
        
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 40),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.red

                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text("Buy Now",
                      style: GoogleFonts.poppins(

                          color:  Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 40),
                    decoration: BoxDecoration(
                      color:  Color(0xFF014E70),
                      border: Border.all(
                        color: Color(0xFF014E70),

                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text("ADD TO CART",
                      style: GoogleFonts.poppins(

                          color:  Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),),
                  ),

                ],

              ),

              SizedBox(height: 10,),
              Text(
                'Specifications',
                style: GoogleFonts.poppins(
        
                    color:  Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 16,),
              Row(
                children: [
                  Text(
                    'Brand :',
                    style: GoogleFonts.poppins(

                        color:  Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),

                  const SizedBox(
                    width: 20,
                  ),
                  Icon(Icons.circle,color: Colors.grey,size: 6,),
                  const SizedBox(
                    width: 7,
                  ),
                  Text(
                    'Fedex Fast delivery by ',
                    style: GoogleFonts.poppins(

                        color:  Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),



                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Text(
                    'SKU :',
                    style: GoogleFonts.poppins(

                        color:  Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),

                  const SizedBox(
                    width: 20,
                  ),
                  Icon(Icons.circle,color: Colors.grey,size: 6,),
                  const SizedBox(
                    width: 7,
                  ),
                  Text(
                    '4664548844874844',
                    style: GoogleFonts.poppins(

                        color:  Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),



                ],
              ),
              SizedBox(height: 10,),
              Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Brand :',
                    style: GoogleFonts.poppins(

                        color:  Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),

                  const SizedBox(
                    width: 20,
                  ),
                Expanded(
                  child: Column(
                    children: [
                     Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       // crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Icon(Icons.circle,color: Colors.grey,size: 6,),
                         const SizedBox(
                           width: 7,
                         ),
                         Expanded(
                           child: Text(
                             '(7 days free & easy return) Seller Policy',
                             style: GoogleFonts.poppins(
                                             
                                 color:  Colors.grey,
                                 fontSize: 14,
                                 fontWeight: FontWeight.w500),
                           ),
                         ),
                       ],
                     ),
                     SizedBox(height: 10,),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       // crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Icon(Icons.circle,color: Colors.grey,size: 6,),
                         const SizedBox(
                           width: 7,
                         ),
                         Expanded(
                           child: Text(
                             'No Warranty available',
                             style: GoogleFonts.poppins(
                                             
                                 color:  Colors.grey,
                                 fontSize: 14,
                                 fontWeight: FontWeight.w500),
                           ),
                         ),
                       ],
                     ),
                      
                  
                  
                  
                    ],
                  ),
                )

                ],
              ),
              SizedBox(height: 10,),
              Divider(
                color: Colors.grey.withOpacity(.5),
                thickness: 1,
              ),


              SizedBox(height: 10,),

              Text(
                'Delivery',
                style: GoogleFonts.poppins(

                    color:  Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 16,),
              Row(
                children: [
                  Text(
                    'Your Location :',
                    style: GoogleFonts.poppins(

                        color:  Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),

                  const SizedBox(
                    width: 20,
                  ),
                  Icon(Icons.circle,     color:  Color(0xFF014E70),size: 6,),
                  const SizedBox(
                    width: 7,
                  ),
                  Text(
                    'Kuwait City ',
                    style: GoogleFonts.poppins(

                        color:  Color(0xFF014E70),
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '(Choose MAP)',
                    style: GoogleFonts.poppins(

                        color:  Colors.red,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),



                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Text(
                    'Standerd Delivery :',
                    style: GoogleFonts.poppins(

                        color:  Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),

                  const SizedBox(
                    width: 20,
                  ),
                  Icon(Icons.circle, color:  Color(0xFF014E70),size: 6,),
                  const SizedBox(
                    width: 7,
                  ),
                  Text(
                    '15 May - 20 May',
                    style: GoogleFonts.poppins(

                        color:  Color(0xFF014E70),
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),



                ],
              ),
              SizedBox(height: 10,),
              Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Delivery Charges :',
                    style: GoogleFonts.poppins(

                        color:  Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),

                  const SizedBox(
                    width: 20,
                  ),
                  Icon(Icons.circle, color:  Color(0xFF014E70),size: 6,),
                  const SizedBox(
                    width: 7,
                  ),
                  Expanded(
                    child: Text(
                      '5 KWD',
                      style: GoogleFonts.poppins(

                          color:  Color(0xFF014E70),
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),


                ],
              ),
              SizedBox(height: 10,),
              Divider(
                color: Colors.grey.withOpacity(.5),
                thickness: 1,
              ),
              SizedBox(height: 10,),


              Text(
                'Customer Reviews',
                style: GoogleFonts.poppins(

                    color:  Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10,),
              Text(
                'DIRISE Review Score',
                style: GoogleFonts.poppins(

                    color:  Color(0xFF0D5877),
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
              
              
              SizedBox(height: 10,),
              Row(
                children: [

                  Image.asset("assets/svgs/top.png"),
                  SizedBox(width: 20,),
                  RatingBar.builder(
                    initialRating: 5,
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
                  SizedBox(width: 10,),
                  Image.asset("assets/svgs/rils.png"),
                ],
              ),


              SizedBox(height: 15,),


              Row(
                children: [
                  Text(
                    'All (10)',
                    style: GoogleFonts.poppins(

                        color:  Color(0xFF014E70),
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
SizedBox(width: 15,),
                  Icon(Icons.image_outlined,size: 20,      color:  Color(0xFF014E70),),
                  Text(
                    ' (10)',
                    style: GoogleFonts.poppins(

                        color:  Color(0xFF014E70),
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(width: 15,),
                  Icon(Icons.message,size: 20,      color:  Color(0xFF014E70),),
                  Text(
                    ' (10)',
                    style: GoogleFonts.poppins(

                        color:  Color(0xFF014E70),
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),

                ],
              ),
              SizedBox(height: 15,),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    size: 14,
                    color: Colors.amber,
                  ),
                  Text(
                    '5 (10)',
                    style: GoogleFonts.poppins(

                        color:  Color(0xFF014E70),
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(width: 20,),
                  Icon(
                    Icons.star,
                    size: 14,
                    color: Colors.amber,
                  ),
                  Text(
                    '5 (10)',
                    style: GoogleFonts.poppins(

                        color:  Color(0xFF014E70),
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(width: 20,),
                  Icon(
                    Icons.star,
                    size: 14,
                    color: Colors.amber,
                  ),
                  Text(
                    '5 (10)',
                    style: GoogleFonts.poppins(

                        color:  Color(0xFF014E70),
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(width: 20,),
                  Icon(
                    Icons.star,
                    size: 14,
                    color: Colors.amber,
                  ),
                  Text(
                    '5 (10)',
                    style: GoogleFonts.poppins(

                        color:  Color(0xFF014E70),
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(width: 20,),
                  Icon(
                    Icons.star,
                    size: 14,
                    color: Colors.amber,
                  ),
                  Text(
                    '5 (10)',
                    style: GoogleFonts.poppins(

                        color:  Color(0xFF014E70),
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(width: 20,),
                ],
              ),
              SizedBox(height: 10,),
              Text(
                'Most Recent',
                style: GoogleFonts.poppins(

                    color:  Color(0xFF014E70),
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),


              SizedBox(height: 10,),
              Divider(
                color: Colors.grey.withOpacity(.5),
                thickness: 1,
              ),
              SizedBox(height: 10,),

              Row(
                children: [
                  RatingBar.builder(
                    initialRating: 5,
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
                  Text(" R**a",
                    style: GoogleFonts.poppins(

                        color:  Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),),
                  Spacer(),
                  Text("1 Day ago",
                    style: GoogleFonts.poppins(

                        color:  Color(0xFF014E70),
                        fontSize: 14,
                        fontWeight: FontWeight.w400),),
                ],
              ),
              SizedBox(height: 15,),
              Row(
                children: [

                  Text("Color Family: Blue",
                    style: GoogleFonts.poppins(

                        color:  Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),),
                  SizedBox(width: 20,),
                  Text("Size: 40",
                    style: GoogleFonts.poppins(

                        color:  Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),),

                ],
              ),
              SizedBox(height: 10,),
              Text("great running Shoes for Long Runs, recommended Shoes for Long Runs,",
                style: GoogleFonts.poppins(

                    color:  Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),),

              SizedBox(height: 26,),

              Row(
                children: [
                  RatingBar.builder(
                    initialRating: 5,
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
                  Text(" R**a",
                    style: GoogleFonts.poppins(

                        color:  Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),),
                  Spacer(),
                  Text("1 Day ago",
                    style: GoogleFonts.poppins(

                        color:  Color(0xFF014E70),
                        fontSize: 14,
                        fontWeight: FontWeight.w400),),
                ],
              ),
              SizedBox(height: 15,),
              Row(
                children: [

                  Text("Color Family: Blue",
                    style: GoogleFonts.poppins(

                        color:  Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),),
                  SizedBox(width: 20,),
                  Text("Size: 40",
                    style: GoogleFonts.poppins(

                        color:  Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),),

                ],
              ),
              SizedBox(height: 10,),
              Text("great running Shoes for Long Runs, recommended Shoes for Long Runs,",
                style: GoogleFonts.poppins(

                    color:  Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),),
SizedBox(height: 20,),
              Center(
                child: Container(
                  width: 130,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF014E70),width: 1.5),
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child:   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("View More ",
                        style: GoogleFonts.poppins(

                            color:  Color(0xFF014E70),
                            fontSize: 14,
                            fontWeight: FontWeight.w500),),
                      Image.asset("assets/svgs/down.png")
                    ],
                  ) ,
                ),
              ),
              SizedBox(height: 20,),

              Divider(
                color: Colors.grey.withOpacity(.5),
                thickness: 1,
              ),
              SizedBox(height: 10,),




              Text(
                'Description',
                style: GoogleFonts.poppins(

                    color:  Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10,),
              Text(
                'great running Shoes for Long Runs, recommended Shoes for Long Runs,',
                style: GoogleFonts.poppins(

                    color:  Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 10,),
              Divider(
                color: Colors.grey.withOpacity(.5),
                thickness: 1,
              ),
              SizedBox(height: 10,),

              Row(
                children: [
                  Text(
                    'Rana Co., Ltd.',
                    style: GoogleFonts.poppins(

                        color:  Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(width: 20,),
                  
                  Image.asset("assets/svgs/verified.png")
                ],
              ),
              SizedBox(height: 10,),


              Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Seller id :',
                    style: GoogleFonts.poppins(

                        color:  Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),

                  const SizedBox(
                    width: 16,
                  ),


                  Expanded(
                    child: Text(
                      '1235114949119',
                      style: GoogleFonts.poppins(

                          color:  Color(0xFF014E70),
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),


                ],
              ),

SizedBox(height: 15,),
Row(
  children: [
    Image.asset("assets/svgs/pak.png"),

    Text(
      '   PAK',
      style: GoogleFonts.poppins(

          color:  Colors.grey,
          fontSize: 14,
          fontWeight: FontWeight.w600),
    ),

    Text(
      '     Custom manufacturer',
      style: GoogleFonts.poppins(

          color:  Colors.grey,
          fontSize: 14,
          fontWeight: FontWeight.w500),
    ),
  ],
),
SizedBox(height: 13,),
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
  Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      Text(
        'Store rating ',
        style: GoogleFonts.poppins(

            color:  Colors.grey,
            fontSize: 12,
            fontWeight: FontWeight.w400),
      ),
    ],

  ),

  ],
),



              SizedBox(height: 10,),
              Divider(
                color: Colors.grey.withOpacity(.5),
                thickness: 1,
              ),
              SizedBox(height: 10,),
              Text(
                'Seller Commercial Licence',
                style: GoogleFonts.poppins(

                    color:  Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 20,),
              Center(child: Image.asset("assets/svgs/licence.png")),

              SizedBox(height: 25,),
              Text(
                'Translated Commercial Licence',
                style: GoogleFonts.poppins(

                    color:  Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 20,),
              Center(child: Image.asset("assets/svgs/licence.png")),





              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 130,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF014E70),width: 1.5),
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child:   Center(
                    child: Text("Seller profile",
                      style: GoogleFonts.poppins(

                          color:  Color(0xFF014E70),
                          fontSize: 14,
                          fontWeight: FontWeight.w500),),
                  ) ,
                ),
              ),
              SizedBox(height: 20,),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 130,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF014E70),width: 1.5),
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child:   Center(
                    child: Text("Take Below",
                      style: GoogleFonts.poppins(

                          color:  Color(0xFF014E70),
                          fontSize: 14,
                          fontWeight: FontWeight.w500),),
                  ) ,
                ),
              ),


              SizedBox(height: 10,),
              Divider(
                color: Colors.grey.withOpacity(.5),
                thickness: 1,
              ),
              SizedBox(height: 30,),

              Text(
                'Similar products',
                style: GoogleFonts.poppins(

                    color:  Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),




              // Container(
              //   padding: const EdgeInsets.all(8),
              //   decoration: const BoxDecoration(
              //       color: Colors.white, boxShadow: [
              //     BoxShadow(
              //       blurStyle: BlurStyle.outer,
              //       offset: Offset(1, 1),
              //       color: Colors.black12,
              //       blurRadius: 3,
              //     )
              //   ]),
              //   constraints: BoxConstraints(
              //     // maxHeight: 100,
              //     minWidth: 0,
              //     maxWidth: size.width * .8,
              //   ),
              //   // color: Colors.red,
              //   margin: const EdgeInsets.only(right: 9),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //
              //           Container(
              //             padding: const EdgeInsets.all(4),
              //             decoration: BoxDecoration(color: const Color(0xFFFF6868), borderRadius: BorderRadius.circular(10)),
              //             child: Row(
              //               children: [
              //                 Text(
              //                   " SALE".tr,
              //                   style: GoogleFonts.poppins(
              //                       fontSize: 12, fontWeight: FontWeight.w700, color: const Color(0xFFFFDF33)),
              //                 ),
              //                 Text(
              //                   " ${"10"}${'%'}  ",
              //                   style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white),
              //                 ),
              //               ],
              //             ),
              //           ) ,
              //          Icon(Icons.favorite_border),
              //         ],
              //       ),
              //       const SizedBox(
              //         height: 10,
              //       ),
              //       Expanded(
              //         child: Row(
              //           children: [
              //             Expanded(
              //               child: Align(
              //                 alignment: Alignment.center,
              //                 child: Center(
              //                   child:  Image.asset('assets/images/new_logo.png')),
              //                 ),
              //               ),
              //
              //         ]),
              //       ),
              //       const SizedBox(
              //         height: 10,
              //       ),
              //       const SizedBox(
              //         height: 3,
              //       ),
              //       Text(
              //         "Testing Product",
              //         maxLines: 2,
              //         style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: const Color(0xFF19313C)),
              //       ),
              //       const SizedBox(
              //         height: 3,
              //       ),
              //
              //  Row(
              //         children: [
              //            Expanded(
              //             child: Text(
              //               'KWD ${"100000"}',
              //               style: GoogleFonts.poppins(
              //                   decorationColor: Colors.red,
              //                   decorationThickness: 2,
              //                   decoration: TextDecoration.lineThrough,
              //                   color: const Color(0xff19313B),
              //                   fontSize: 16,
              //                   fontWeight: FontWeight.w600),
              //             ),
              //           ),
              //           const SizedBox(
              //             width: 7,
              //           ),
              //           Expanded(
              //             child: Text.rich(
              //               TextSpan(
              //                 text: '${"100044"}.',
              //                 style: const TextStyle(
              //                   fontSize: 24,
              //                   fontWeight: FontWeight.w600,
              //                   color: Color(0xFF19313B),
              //                 ),
              //                 children: [
              //                   WidgetSpan(
              //                     alignment: PlaceholderAlignment.middle,
              //                     child: Column(
              //                       mainAxisAlignment: MainAxisAlignment.start,
              //                       children: [
              //                         const Text(
              //                           'KWD',
              //                           style: TextStyle(
              //                             fontSize: 8,
              //                             fontWeight: FontWeight.w500,
              //                             color: Color(0xFF19313B),
              //                           ),
              //                         ),
              //                         InkWell(
              //                           onTap: () {
              //                             // print("date:::::::::::" + widget.productElement.shippingDate);
              //                           },
              //                           child: Text(
              //                             '${"000"}',
              //                             style: const TextStyle(
              //                               fontSize: 8,
              //                               fontWeight: FontWeight.w600,
              //                               color: Color(0xFF19313B),
              //                             ),
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //
              //
              //       const SizedBox(
              //         height: 8,
              //       ),
              //
              //
              //       Text(
              //
              //         '${'QTY'}: ${"10"} ${'piece'}',
              //         style: normalStyle,
              //       ),
              //       // if (canBuyProduct)
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Expanded(
              //             child: Column(
              //               mainAxisAlignment: MainAxisAlignment.start,
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 RatingBar.builder(
              //                   initialRating:4,
              //                   minRating: 1,
              //                   direction: Axis.horizontal,
              //                   updateOnDrag: true,
              //                   tapOnlyMode: false,
              //                   ignoreGestures: true,
              //                   allowHalfRating: true,
              //                   itemSize: 20,
              //                   itemCount: 5,
              //                   itemBuilder: (context, _) => const Icon(
              //                     Icons.star,
              //                     size: 8,
              //                     color: Colors.amber,
              //                   ),
              //                   onRatingUpdate: (rating) {
              //                     print(rating);
              //                   },
              //                 ),
              //                 // ,Text(
              //                 //   '${widget.productElement.inStock.toString()} ${'pieces'.tr}',
              //                 //   style: GoogleFonts.poppins(color: Colors.grey.shade700, fontSize: 15,fontWeight: FontWeight.w500),
              //                 // ),
              //                 const SizedBox(
              //                   height: 7,
              //                 ),
              //              Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     Text(
              //                       'shipping',
              //                       style: GoogleFonts.poppins(
              //                           color: const Color(0xff858484), fontSize: 13, fontWeight: FontWeight.w500),
              //                     ),
              //
              //                       Text(
              //                         'KWD${"1000"}',
              //                         style: GoogleFonts.poppins(
              //                             color: const Color(0xff858484), fontSize: 13, fontWeight: FontWeight.w500),
              //                       ),
              //
              //                       Text(
              //                        "10/12/2023",
              //                         style: GoogleFonts.poppins(
              //                             color: const Color(0xff858484), fontSize: 13, fontWeight: FontWeight.w500),
              //                       ),
              //                   ],
              //                 )
              //
              //                 // Text("vendor doesn't ship internationally, contact us for the soloution",  style: GoogleFonts.poppins(
              //                 //     color: const Color(0xff858484),
              //                 //     fontSize: 13,
              //                 //     fontWeight: FontWeight.w500),),
              //               ],
              //             ),
              //           ),
              //           // if (canBuyProduct)
              //           Expanded(
              //             child: Column(
              //               children: [
              //                 ElevatedButton(
              //                   onPressed: () {
              //
              //                   },
              //                   style: ElevatedButton.styleFrom(
              //                     backgroundColor: Colors.red,
              //                     surfaceTintColor: Colors.red,
              //                   ),
              //                   child: FittedBox(
              //                     child: Text(
              //                       "  Buy Now  ".tr,
              //                       style:
              //                       GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
              //                     ),
              //                   ),
              //                 ),
              //                 ElevatedButton(
              //                   onPressed: () {
              //
              //                   },
              //                   style: ElevatedButton.styleFrom(
              //                     backgroundColor: AppTheme.buttonColor,
              //                     surfaceTintColor: AppTheme.buttonColor,
              //                   ),
              //                   child: FittedBox(
              //                     child: Text(
              //                       "Add to Cart".tr,
              //                       style:
              //                       GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
              //                     ),
              //                   ),
              //                 ),
              //
              //
              //
              //                Row(
              //                   mainAxisAlignment: MainAxisAlignment.center,
              //                   crossAxisAlignment: CrossAxisAlignment.center,
              //                   children: [
              //                     GestureDetector(
              //                       onTap: () {
              //
              //                       },
              //                       child: Center(
              //                           child: Text(
              //                             "-",
              //                             style: GoogleFonts.poppins(
              //                                 fontSize: 40, fontWeight: FontWeight.w300, color: const Color(0xFF014E70)),
              //                           )),
              //                     ),
              //                     SizedBox(
              //                       width: size.width * .02,
              //                     ),
              //
              //                        Text(
              //                        "1",
              //                         style: GoogleFonts.poppins(
              //                             fontSize: 26, fontWeight: FontWeight.w500, color: const Color(0xFF014E70)),
              //                       ),
              //
              //                     SizedBox(
              //                       width: size.width * .02,
              //                     ),
              //                     GestureDetector(
              //                       onTap: () {
              //
              //                       },
              //                       child: Center(
              //                           child: Text(
              //                             "+",
              //                             style: GoogleFonts.poppins(
              //                                 fontSize: 30, fontWeight: FontWeight.w300, color: const Color(0xFF014E70)),
              //                           )),
              //                     ),
              //                   ],
              //                 )
              //
              //               ],
              //             ),
              //
              //           )
              //
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
            ],

        
          ),
        ),
      ),
    );
  }
}
