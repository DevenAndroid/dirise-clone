import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dirise/repository/repository.dart';
import 'package:dirise/screens/app_bar/common_app_bar.dart';
import 'package:dirise/screens/product_details/product_widget.dart';
import 'package:dirise/screens/service_single_ui.dart';
import 'package:dirise/utils/api_constant.dart';
import 'package:dirise/utils/helper.dart';
import 'package:dirise/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/model_virtual_assets.dart';
import '../model/product_model/model_product_element.dart';
import '../model/search_model.dart';
import '../single_products/bookable_single.dart';
import '../single_products/give_away_single.dart';
import '../single_products/simple_product.dart';
import '../single_products/variable_single.dart';
import '../single_products/vritual_product_single.dart';
import '../widgets/common_colour.dart';

class SearchProductsScreen extends StatefulWidget {
  final String searchText;

  const SearchProductsScreen({Key? key, required this.searchText}) : super(key: key);

  @override
  State<SearchProductsScreen> createState() => _SearchProductsScreenState();
}

class _SearchProductsScreenState extends State<SearchProductsScreen> {
  late TextEditingController textEditingController;
  final Repositories repositories = Repositories();
  ModelVirtualAssets modelProductsList = ModelVirtualAssets(product: []);
  Rx<ModelSearch> modelSearch = ModelSearch().obs;
  RxInt refreshInt = 0.obs;
  int page = 1;
  bool allLoaded = false;
  bool paginating = false;
  final ScrollController scrollController = ScrollController();
  Timer? timer;

  debounceSearch() {
    if (timer != null) {
      timer!.cancel();
    }
    searchProducts(reset: true);
  }

  addScrollListener() {
    scrollController.addListener(() {
      if (scrollController.offset > (scrollController.position.maxScrollExtent - 10)) {
        searchProducts();
      }
    });
  }

  searchProducts({bool? reset}) {
    if (reset == true) {
      allLoaded = false;
      paginating = false;
      page = 1;
    }

    if (allLoaded) return;
    if (paginating) return;
    paginating = true;
    refreshInt.value = -2;
    repositories.postApi(url: ApiUrls.searchProductUrl, mapData: {
      'search': textEditingController.text.trim(),
      'page': page,
      'limit': "20",
    },showResponse: true).then((value) {
      log('objecttttt${value.toString()}');
      paginating = false;
      if (reset == true) {
        modelProductsList.product = [];
      }
      modelSearch.value = ModelSearch.fromJson(jsonDecode(value));
      // ModelVirtualAssets response = ModelVirtualAssets.fromJson(jsonDecode(value));
      // log('dataaaaaaa${response.product.toString()}');
      // response.product ??= [];
      // if (response.product!.isNotEmpty) {
      //   modelProductsList.product!.addAll(response.product!);
      //   page++;
      // }
      // else {
      //   allLoaded = true;
      // }
      // refreshInt.value = DateTime
      //     .now()
      //     .millisecondsSinceEpoch;
    });
  }

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController(text: widget.searchText);
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      searchProducts();
      addScrollListener();
    });
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
        appBar: CommonAppBar(
          titleText: "Search".tr,
          backGroundColor: AppTheme.newPrimaryColor,
          textColor: Colors.black,
        ),
        body: RefreshIndicator(
            onRefresh: () async {
              // await getAllAsync();
            },
            child: Obx(() {
              return modelSearch.value.status == 'success' ?
                Column(
                children: [
                  Container(
                    color: AppTheme.newPrimaryColor,
                    child: Column(
                      children: [
                        Hero(
                          tag: "search_tag",
                          child: Material(
                            color: Colors.transparent,
                            surfaceTintColor: Colors.transparent,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: TextField(
                                controller: textEditingController,
                                style: GoogleFonts.poppins(fontSize: 16),
                                textInputAction: TextInputAction.search,
                                onChanged: (value) {
                                  debounceSearch();
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
                                    hintText: 'Search in Dirise'.tr,
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
                      child: Obx(() {
                        if (refreshInt.value > 0) {}
                        return GridView.builder(
                          controller: scrollController,
                          shrinkWrap: true,
                          itemCount: modelSearch.value.data!.items!.length,
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 20,
                              childAspectRatio:
                              MediaQuery
                                  .of(context)
                                  .size
                                  .width / (MediaQuery
                                  .of(context)
                                  .size
                                  .height / 1.3)),
                          itemBuilder: (BuildContext context, int index) {
                            final item = modelSearch.value.data!.items![index];
                            return GestureDetector(
                              onTap: () {
                                print(item.id);

                                if (item.itemType == 'giveaway') {
                                  Get.to(() => const GiveAwayProduct(), arguments: item.id.toString());
                                }
                                else if (item.productType == 'variants'&& item.itemType == 'product') {
                                  Get.to(() => const VarientsProductScreen(), arguments: item.id.toString());
                                }
                                else if (item.productType == 'booking'&& item.itemType == 'product') {
                                  Get.to(() => const BookableProductScreen(), arguments: item.id.toString());
                                }
                                else if (item.productType == 'virtual_product'&& item.itemType == 'virtual_product') {
                                  Get.to(() =>  VritualProductScreen(), arguments: item.id.toString());
                                }
                 
                                else if (item.itemType == 'product') {

                                  Get.to(() => const SimpleProductScreen(), arguments: item.id.toString());
                                }else if(item.itemType =='service'){
                                  Get.to(() => const ServiceProductScreen(), arguments: item.id.toString());
                                }

                              },
                              // onTap: (){
                              //
                              //   bottomSheet(productDetails:  ProductElement.fromJson(modelSearch.value.data!.items![index].toJson()), context: context);
                              // },
                              child: item.itemType != 'giveaway' ?
                              Container(
                                constraints: BoxConstraints(
                                  minWidth: 0,
                                  maxWidth: size.width * .45,
                                ),
                                // color: Colors.red,
                                margin: const EdgeInsets.only(right: 18),
                                child: Stack(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: CachedNetworkImage(
                                                    imageUrl: item.featuredImage.toString(),
                                                    height: 100,
                                                    fit: BoxFit.cover,
                                                    errorWidget: (context, url, error) =>
                                                        Icon(Icons.report_gmailerrorred_rounded, color: Theme
                                                            .of(context)
                                                            .colorScheme
                                                            .error,),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          // "${item.discountPercentage ?? ((((item.pPrice.toString().toNum - item.sPrice.toString().toNum) / item.pPrice.toString().toNum) * 100).toStringAsFixed(2))}${''} Off",
                                          '${item.discountOff.toString()}% Off',
                                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: const Color(0xffC22E2E)),
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          item.pname.toString(),
                                          maxLines: 2,
                                          style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        item.inStock == "-1"? SizedBox():
                                        Text(
                                          '${item.inStock.toString()} ${'pieces'.tr}',
                                          style: GoogleFonts.poppins(
                                              color: Colors.grey.shade700, fontSize: 15, fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'KWD ${item.discountPrice.toString()}',
                                                style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
                                              ),
                                            ),
                                            Text(
                                              'KWD ${item.pPrice.toString()}',
                                              style:GoogleFonts.poppins(
                                                  decoration: TextDecoration.lineThrough,
                                                  color: const Color(0xff858484),
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    // Positioned(
                                    //   top: 0,
                                    //   right: 10,
                                    //   child: Obx(() {
                                    //     if (wishListController.refreshFav.value > 0) {}
                                    //     return LikeButton(
                                    //       onPressed: () {
                                    //         if (wishListController.favoriteItems.contains(widget.productElement.id.toString())) {
                                    //           removeFromWishList();
                                    //         } else {
                                    //           addToWishList();
                                    //         }
                                    //       },
                                    //       isLiked: wishListController.favoriteItems.contains(widget.productElement.id.toString()),
                                    //     );
                                    //   }),
                                    // )
                                  ],
                                ),
                              )
                              : Container(
                                constraints: BoxConstraints(
                                  minWidth: 0,
                                  maxWidth: size.width * .45,
                                ),
                                // color: Colors.red,
                                margin: const EdgeInsets.only(right: 18),
                                child: Stack(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        18.spaceY,
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: CachedNetworkImage(
                                                    imageUrl: item.featuredImage.toString(),
                                                    height: 100,
                                                    fit: BoxFit.cover,
                                                    errorWidget: (context, url, error) =>
                                                        Icon(Icons.report_gmailerrorred_rounded, color: Theme
                                                            .of(context)
                                                            .colorScheme
                                                            .error,),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        // Text(
                                        //   // "${item.discountPercentage ?? ((((item.pPrice.toString().toNum - item.sPrice.toString().toNum) / item.pPrice.toString().toNum) * 100).toStringAsFixed(2))}${''} Off",
                                        //   '${item.discountOff.toString()}% Off',
                                        //   style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: const Color(0xffC22E2E)),
                                        // ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          item.pname.toString(),
                                          maxLines: 2,
                                          style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        item.inStock == "-1"? SizedBox():
                                        Text(
                                          '${item.inStock.toString()} ${'pieces'.tr}',
                                          style: GoogleFonts.poppins(
                                              color: Colors.grey.shade700, fontSize: 15, fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'KWD ${item.discountPrice.toString()}',
                                                style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
                                              ),
                                            ),
                                            // Text(
                                            //   'KWD ${item.pPrice.toString()}',
                                            //   style:GoogleFonts.poppins(
                                            //       decoration: TextDecoration.lineThrough,
                                            //       color: const Color(0xff858484),
                                            //       fontSize: 13,
                                            //       fontWeight: FontWeight.w500),
                                            // ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Positioned(
                                      right: 0,
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
                          },
                        );
                      }),
                    ),
                  ),
                ],
              ) : const LoadingAnimation();
            })));
  }
}
