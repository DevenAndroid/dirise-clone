import 'dart:convert';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dirise/language/app_strings.dart';
import 'package:dirise/utils/helper.dart';
import 'package:dirise/utils/styles.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:dirise/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../controller/cart_controller.dart';
import '../../../controller/location_controller.dart';
import '../../../controller/profile_controller.dart';
import '../../../controller/single_product_controller.dart';
import '../../../model/filter_by_price_model.dart';
import '../../../model/model_category_stores.dart';
import '../../../model/model_store_products.dart';
import '../../../model/product_model/model_product_element.dart';

// import '../../../model/social_links_model.dart';
import '../../../model/vendor_models/model_single_vendor.dart';
import '../../../repository/repository.dart';
import '../../../utils/api_constant.dart';
import '../../../widgets/cart_widget.dart';
import '../../../widgets/common_button.dart';
import '../../app_bar/common_app_bar.dart';
import '../../app_bar/custom_blue_button.dart';
import '../../check_out/add_bag_screen.dart';
import '../../product_details/product_widget.dart';

class SingleStoreScreen extends StatefulWidget {
  const SingleStoreScreen({super.key, required this.storeDetails,});

  final VendorStoreData storeDetails;

  @override
  State<SingleStoreScreen> createState() => _SingleStoreScreenState();
}

class _SingleStoreScreenState extends State<SingleStoreScreen> {
  final Repositories repositories = Repositories();
  int paginationPage = 1;
  VendorStoreData gg = VendorStoreData();
  SocialLinks ee = SocialLinks();
  ModelCategoryStores ss = ModelCategoryStores();

  SocialLinks get socialLinksData => ee;

  VendorStoreData get storeInfo => gg;

  ModelCategoryStores get allStoreInfo => ss;

  String get vendorId => widget.storeDetails.id.toString();

  String get vendorName => widget.storeDetails.storeName.toString();

  String get vendorStatus => widget.storeDetails.status.toString();
  final controller = Get.put(SingleCategoryController());

  /* void onShare(code) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.share(code, subject: "link", sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }*/
  bool allLoaded = false;
  RxBool paginationLoading = false.obs;
  RxBool isDataLoading = false.obs;
  ScrollController scrollController = ScrollController();
  ModelStoreProducts modelProductsList = ModelStoreProducts(vendorProducts: VendorProducts(data: []));
  Rx<ModelFilterByPrice> filterModel = ModelFilterByPrice().obs;

  filterProduct({productId}) {
    repositories
        .postApi(
      url: ApiUrls.filterByPriceUrl,
      context: context,
      mapData: {
        "min_price": controller.currentRangeValues.start.toInt(),
        "max_price": controller.currentRangeValues.end.toInt(),
        "vendor_id": productId,
      },)
        .then((value) {
      print('object${value.toString()}');
      filterModel.value = ModelFilterByPrice.fromJson(jsonDecode(value));
      if (filterModel.value.status == true) {
        showToast(filterModel.value.message);
        print(filterModel.value.product.toString());
      }
    });
  }

  final profileController = Get.put(ProfileController());
  final locationController = Get.put(LocationController());
  final cartController = Get.put(CartController());

  void _scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      // homeController.page.value = homeController.page.value + 1;
      getCategoryStores(page: paginationPage);
      print("callghgfhgfhk/g;flhklgfhkgfh");
    } else {
      print("Don't callhg'h;lgfkhg;flhgfhgfhg");
    }
  }

  Future getCategoryStores({required int page, String? search, bool? resetAll}) async {
    if (resetAll == true) {
      isDataLoading.value = false;
      allLoaded = false;
      paginationLoading.value = false;
      paginationPage = 1;
      modelProductsList.vendorProducts!.data = null;
      page = 1;
    }
    if (allLoaded) return;
    //  if (paginationLoading) return;

    String url = "vendor_id=$vendorId";
    paginationLoading.value = true;
    await repositories.getApi(url: "${ApiUrls.vendorProductListUrl}$url&country_id=${profileController.model.user != null &&
        cartController.countryId.isEmpty ? profileController.model.user!.country_id : cartController.countryId
        .toString()}&key=fedexRate&zip_code=${locationController.zipcode.value
        .toString()}pagination=10&page=$paginationPage").then((value) {
      paginationLoading.value = false;
      isDataLoading.value = true;
      modelProductsList.vendorProducts!.data ??= [];
      final response = ModelStoreProducts.fromJson(jsonDecode(value));
      print('mapmapmap${response.toJson()}');
      if (response.vendorProducts!.data != null && response.vendorProducts!.data!.isNotEmpty) {
        modelProductsList.vendorProducts!.data!.addAll(response.vendorProducts!.data!);
        page++;
        paginationPage++;
        log('pagination++++${paginationPage.toString()}');
        setState(() {

        });
      } else {
        allLoaded = true;
      }
      setState(() {});
    });
  }

  _makingPhoneCall(call) async {
    var url = Uri.parse(call);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // _instagramLink() async {
  //   var url = Uri.parse(socialLinksData.socialLinks!.instagram.toString());
  //   if (await canLaunchUrl(url)) {
  //     await launchUrl(url, mode: LaunchMode.externalApplication);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  String productCount = '';
  String description = '';
  String bannerString = '';
  String storeLogo = '';

  // String categoryName = Get.arguments;
  void launchURLl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  linkedinLink() async {
    var url = Uri.parse(allStoreInfo.socialLinks!.linkedin.toString());
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  youTubeLink() async {
    var url = Uri.parse(allStoreInfo.socialLinks!.youtube.toString());
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  facebookLink() async {
    var url = Uri.parse(allStoreInfo.socialLinks!.facebook.toString());
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  String storeUrl = '';
  Rx<ModelCategoryStores> getCategoryStoresModel = ModelCategoryStores().obs;
  Rx<VendorAvailability> vendorAvailabilityModel = VendorAvailability().obs;

  getVendorInfo() {
    print('function call ');
    repositories.getApi(url: ApiUrls.getVendorInfoUrl + vendorId).then((value) {
      ModelSingleVendor response = ModelSingleVendor.fromJson(jsonDecode(value));
      productCount = response.productCount.toString();
      description = response.user!.storeBannerDesccription ?? 'Description wasn\'t submitted'.tr;
      bannerString = response.user!.bannerProfileApp.toString();
      storeLogo = response.user!.storeLogo.toString();
      storeUrl = response.user!.storeUrl.toString();
      gg = VendorStoreData.fromJson(response.user!.toJson());
      log('vendorrrrrr${gg.toJson()}');
      log('vendorrrrr ulr${storeUrl.toString()}');
      ee = SocialLinks.fromJson(response.toJson());
      ss = ModelCategoryStores.fromJson(response.user!.toJson());
      setState(() {});
    });
  }

  getVendorInfoSocial() {
    print('function call vendor ava');
    repositories.getApi(url: ApiUrls.getVendorInfoUrl + vendorId).then((value) {
      getCategoryStoresModel.value = ModelCategoryStores.fromJson(jsonDecode(value));
      print('function call iss vendor avaa${getCategoryStoresModel.value.socialLinks!.toJson()}');
      vendorAvailabilityModel.value = VendorAvailability.fromJson(jsonDecode(value));
      print('vendor ava ${vendorAvailabilityModel.value.toJson()}');
      print('vendor ava ${getCategoryStoresModel.value.user!.status.toString()}');
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    // print('insta urll -------'+allStoreInfo.socialLinks!.instagram.toString());
    gg = widget.storeDetails;
    //ee = widget.socialLink;
    getVendorInfo();
    getVendorInfoSocial();
    // getCategoryStores(page: paginationPage);
    scrollController.addListener((_scrollListener));
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      scrollController.addListener(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: CommonAppBar(
          titleText: getCategoryStoresModel.value.vendorCategory ?? '....',
          actions: const [
            CartBagCard(isBlackTheme: true),
          ],
        ),
      ),
      body: Obx(() {
        return getCategoryStoresModel.value.status == true ?
        CustomScrollView(
          controller: scrollController,
          shrinkWrap: true,
          slivers: [
            if (gg.storeName != null && gg.email != null) ...[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16).copyWith(top: 10),
                  child: Column(
                    children: [
                      SizedBox(
                          width: Get.width,
                          height: context.getSize.width * .5,
                          child: Hero(
                            tag: bannerString.toString(),
                            child: Material(
                              color: Colors.transparent,
                              surfaceTintColor: Colors.transparent,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: bannerString.toString(),
                                    errorWidget: (_, __, ___) =>
                                        Image.asset(
                                            'assets/images/new_logo.png'
                                        )
                                ),
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16).copyWith(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 84,
                                width: 104,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: CachedNetworkImage(
                                      imageUrl: storeLogo.toString(),
                                      fit: BoxFit.cover,
                                      errorWidget: (_, __, ___) =>
                                          Image.asset(
                                              'assets/images/new_logo.png'
                                          )
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      storeInfo.storeName
                                          .toString()
                                          .capitalize!,
                                      style: GoogleFonts.poppins(
                                          color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                                      child: Text(
                                        '${productCount.toString() ?? '0'} ${AppStrings.items.tr}'.toString(),
                                        maxLines: 1,
                                        style: GoogleFonts.poppins(
                                            color: const Color(0xFF014E70), fontSize: 14, fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            // print(ee.instagram.toString());
                                            launchURLl(getCategoryStoresModel.value.socialLinks!.instagram.toString());
                                            // onShare('instagram');
                                            //_instagramLink();
                                          },
                                          child: getCategoryStoresModel.value.socialLinks != null &&
                                              getCategoryStoresModel.value.socialLinks!.instagram != null &&
                                              getCategoryStoresModel.value.socialLinks!.instagram!.isEmpty ?
                                          const SizedBox() :
                                          CircleAvatar(
                                              radius: 16,
                                              backgroundColor: const Color(0xFF014E70),
                                              child: SvgPicture.asset(
                                                'assets/svgs/insta_img.svg',
                                                width: 15,
                                                height: 15,
                                              )
                                          ),
                                        ),
                                        getCategoryStoresModel.value.socialLinks != null &&
                                            getCategoryStoresModel.value.socialLinks!.instagram != null &&
                                            getCategoryStoresModel.value.socialLinks!.instagram!.isEmpty ?
                                        const SizedBox() : const SizedBox(
                                          width: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            launchURLl(getCategoryStoresModel.value.socialLinks!.linkedin.toString());
                                            // onShare('linkedin');
                                            // linkedinLink();
                                          },
                                          child: getCategoryStoresModel.value.socialLinks != null &&
                                              getCategoryStoresModel.value.socialLinks!.linkedin != null &&
                                              getCategoryStoresModel.value.socialLinks!.linkedin!.isEmpty ?
                                          const SizedBox() :
                                          CircleAvatar(
                                              radius: 16,
                                              backgroundColor: const Color(0xFF014E70),
                                              child: SvgPicture.asset(
                                                'assets/svgs/linkedin_img.svg',
                                                width: 15,
                                                height: 15,
                                              )),
                                        ),
                                        getCategoryStoresModel.value.socialLinks != null &&
                                            getCategoryStoresModel.value.socialLinks!.linkedin != null &&
                                            getCategoryStoresModel.value.socialLinks!.linkedin!.isEmpty ?
                                        const SizedBox() : const SizedBox(
                                          width: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            launchURLl(getCategoryStoresModel.value.socialLinks!.youtube.toString());
                                            // onShare('youtube');
                                            // youTubeLink();
                                          },
                                          child: getCategoryStoresModel.value.socialLinks != null &&
                                              getCategoryStoresModel.value.socialLinks!.youtube != null &&
                                              getCategoryStoresModel.value.socialLinks!.youtube!.isEmpty ?
                                          const SizedBox() :
                                          CircleAvatar(
                                              radius: 16,
                                              backgroundColor: const Color(0xFF014E70),
                                              child: SvgPicture.asset(
                                                'assets/svgs/youtube_img.svg',
                                                width: 15,
                                                height: 15,
                                              )),
                                        ),
                                        getCategoryStoresModel.value.socialLinks != null &&
                                            getCategoryStoresModel.value.socialLinks!.facebook != null &&
                                            getCategoryStoresModel.value.socialLinks!.facebook!.isEmpty ?
                                        const SizedBox() : const SizedBox(
                                          width: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            launchURLl(getCategoryStoresModel.value.socialLinks!.facebook.toString());
                                            //  onShare('facebook');
                                            //facebookLink();
                                          },
                                          child: getCategoryStoresModel.value.socialLinks != null &&
                                              getCategoryStoresModel.value.socialLinks!.facebook != null &&
                                              getCategoryStoresModel.value.socialLinks!.facebook!.isEmpty ?
                                          const SizedBox() :
                                          CircleAvatar(
                                              radius: 16,
                                              backgroundColor: const Color(0xFF014E70),
                                              child: SvgPicture.asset(
                                                'assets/svgs/facebook_img.svg',
                                                width: 15,
                                                height: 15,
                                              )),
                                        ),

                                      ],
                                    )
                                    /* Text(
                                    storeInfo.description.toString(),
                                    style: GoogleFonts.poppins(
                                        color:  Colors.grey.shade800, fontSize: 14, fontWeight: FontWeight.w500),
                                  )*/
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 10,),
                          /*  if (storeInfo.description.toString().trim().isNotEmpty) ...[
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            storeInfo.description.toString(),
                            style: normalStyle.copyWith(color: AppTheme.buttonColor),
                          )
                        ],*/
                          GestureDetector(
                            onTap: () {
                              //   if (allStoreInfo.socialLinks != null)
                              // print('innsta url--------' + socialLinksData.socialLinks!.instagram.toString(),);
                            },
                            child: Text(
                              'Description'.tr,
                              style: GoogleFonts.poppins(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            description.isNotEmpty ? description : 'Description wasn\'t submitted'.tr,
                            style: GoogleFonts.poppins(
                                color: const Color(0xFF014E70), fontSize: 14, fontWeight: FontWeight.w500),
                          ),

                          if (storeInfo.email
                              .toString()
                              .trim()
                              .isNotEmpty || storeInfo.storePhone
                              .toString()
                              .trim()
                              .isNotEmpty) ...[
                            const SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                if (storeUrl.isNotEmpty && storeUrl != '')
                                  Expanded(
                                    child: MaterialButton(
                                      onPressed: () async {

                                      },
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                      child: Row(
                                        //  crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Store-Url".tr,
                                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            child: Text(
                                              "${storeUrl.toString()}",
                                              style: normalStyle.copyWith(
                                                color: const Color(0xFF7D7D7D),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                if (storeInfo.storePhone
                                    .toString()
                                    .trim()
                                    .isNotEmpty)
                                  Expanded(
                                    child: MaterialButton(
                                      onPressed: () async {
                                        await Clipboard.setData(
                                            ClipboardData(text: storeInfo.storePhone.toString().trim()));
                                        final snackBar = SnackBar(
                                          content: Text(
                                            "Phone no. copied".tr,
                                            style: normalStyle,
                                          ),
                                          action: SnackBarAction(
                                              label: "Make Call".tr,
                                              onPressed: () {
                                                Helpers.makeCall(phoneNumber: storeInfo.storePhone.toString().trim());
                                              }),
                                          backgroundColor: AppTheme.buttonColor,
                                        );
                                        if (!mounted) return;
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      },
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SvgPicture.asset("assets/svgs/phone_call.svg"),
                                          Text(
                                            "+${storeInfo.storePhone}",
                                            style: normalStyle.copyWith(
                                              color: const Color(0xFF7D7D7D),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 10,),
                            Row(
                              children: [
                                if (storeInfo.email
                                    .toString()
                                    .trim()
                                    .isNotEmpty)
                                  Expanded(
                                    child: MaterialButton(
                                      onPressed: () async {
                                        await Clipboard.setData(ClipboardData(text: storeInfo.email.toString().trim()));
                                        final snackBar = SnackBar(
                                          content: Text(
                                            "Email copied".tr,
                                            style: normalStyle,
                                          ),
                                          action: SnackBarAction(
                                              label: "Send Mail".tr,
                                              onPressed: () {
                                                Helpers.launchEmail(email: storeInfo.email.toString().trim());
                                              }),
                                          backgroundColor: AppTheme.buttonColor,
                                        );
                                        if (!mounted) return;
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      },
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                      child: Row(
                                        //  crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "@",
                                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            child: Text(
                                              "${storeInfo.email}",
                                              style: normalStyle.copyWith(
                                                color: const Color(0xFF7D7D7D),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                if (storeInfo.storePhone
                                    .toString()
                                    .trim()
                                    .isNotEmpty)
                                  Expanded(
                                    child: MaterialButton(
                                      onPressed: () async {
                                        await Clipboard.setData(
                                            ClipboardData(text: storeInfo.storePhone.toString().trim()));
                                        final snackBar = SnackBar(
                                          content: Text(
                                            "Phone no. copied".tr,
                                            style: normalStyle,
                                          ),
                                          action: SnackBarAction(
                                              label: "Make Call".tr,
                                              onPressed: () {
                                                Helpers.makeCall(phoneNumber: storeInfo.storePhone.toString().trim());
                                              }),
                                          backgroundColor: AppTheme.buttonColor,
                                        );
                                        if (!mounted) return;
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      },
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SvgPicture.asset("assets/svgs/phone_call.svg"),
                                          Text(
                                            "+${storeInfo.storePhone}",
                                            style: normalStyle.copyWith(
                                              color: const Color(0xFF7D7D7D),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 10,),
                            if (storeInfo.day != '' || storeInfo.start != '' || storeInfo.end != '' )
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 17),

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Operating hours'.tr, style: normalStyle.copyWith(
                                      color: Colors.black,
                                    ),),
                                    10.spaceY,
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            log('storeeeeeeee${storeInfo.toJson()}');
                                            print(storeInfo.status.toString());
                                            print(getCategoryStoresModel.value.user!.status.toString());
                                          },
                                          child: SvgPicture.asset(
                                            'assets/svgs/watch_icon.svg',
                                            width: 20,
                                            height: 20,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(storeInfo.day.toString(), style: normalStyle.copyWith(
                                          color: const Color(0xFF7D7D7D),
                                        ),),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        storeInfo.start != null ? Text(
                                          '${storeInfo.start.toString()} - ${storeInfo.end.toString()}',
                                          style: normalStyle.copyWith(
                                            color: const Color(0xFF7D7D7D),
                                          ),) : const SizedBox(),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            const SizedBox(height: 20,),
                            if ( storeInfo.startBreakTime != '' || storeInfo.endBreakTime != '' )
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 17),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('Break Period'.tr, style: normalStyle.copyWith(
                                      color: Colors.black,
                                    ),),
                                    10.spaceY,
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            print(storeInfo.status.toString());
                                            print(getCategoryStoresModel.value.user!.status.toString());
                                          },
                                          child: SvgPicture.asset(
                                            'assets/svgs/watch_icon.svg',
                                            width: 20,
                                            height: 20,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(storeInfo.day.toString(), style: normalStyle.copyWith(
                                          color: const Color(0xFF7D7D7D),
                                        ),),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '${storeInfo.startBreakTime.toString()} - ${storeInfo.startBreakTime.toString()}',
                                          style: normalStyle.copyWith(
                                            color: const Color(0xFF7D7D7D),
                                          ),),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ],
                      ),
                    ),
                    20.spaceY,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text('FILTER BY PRICE'.tr,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 17
                            ),),
                        ),
                        RangeSlider(
                          values: controller.currentRangeValues,
                          max: 200000,
                          divisions: 99,
                          labels: RangeLabels(
                            controller.currentRangeValues.start.round().toString(),
                            controller.currentRangeValues.end.round().toString(),
                          ),
                          onChanged: (RangeValues values) {
                            setState(() {
                              controller.currentRangeValues = values;
                            });
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Price : '.tr),
                              Text('KWD :'.tr,
                                style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  ' ${controller.currentRangeValues.start.toInt()} - ${controller.currentRangeValues
                                      .end.toInt()}',
                                  style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              15.spaceX,
                              Expanded(
                                flex: 2,
                                child: ElevatedButton(
                                  onPressed: () {
                                    filterProduct(productId: storeInfo.id.toString());
                                    controller.isFilter.value = true;
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppTheme.buttonColor,
                                    surfaceTintColor: AppTheme.buttonColor,
                                  ),
                                  child: FittedBox(
                                    child: Text(
                                      "Filter".tr,
                                      style:
                                      GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                                    ),
                                  ),
                                ),),
                              10.spaceX,
                              Expanded(
                                flex: 2,
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      controller.isFilter.value = false;
                                      controller.currentRangeValues = const RangeValues(0, 0);
                                      print('valee${controller.isFilter.value}');
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppTheme.buttonColor,
                                    surfaceTintColor: AppTheme.buttonColor,
                                  ),
                                  child: FittedBox(
                                    child: Text(
                                      "Clear".tr,
                                      style:
                                      GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                                    ),
                                  ),
                                ),),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                      color: Color(0xFFD9D9D9),
                    )
                  ],
                ),
              ),
            ],

            /*SliverAppBar(
            primary: false,
            pinned: true,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            leading: const SizedBox.shrink(),
            titleSpacing: 0,
            leadingWidth: 16,
            title: InkWell(
              onTap: () {},
              child: Container(
                height: 36,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xff014E70)),
                    color: const Color(0xffEBF1F4),
                    borderRadius: BorderRadius.circular(22)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 10),
                      child: Text(
                        "${storeInfo.storeName.toString()} ${AppStrings.type}",
                        style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: const Color(0xff014E70)),
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_down_outlined, color: Color(0xff014E70))
                  ],
                ),
              ),
            ),
          ),*/
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            if(filterModel.value.product != null && controller.isFilter.value == true)
              filterModel.value.product!.isNotEmpty
                  ? SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, // Set crossAxisCount to 1 to show one item per row
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: .82,
                ),
                itemCount: filterModel.value.product!.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = filterModel.value.product![index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child:
                    ProductUI(
                      productElement: item,
                      isSingle: true,
                      onLiked: (value) {
                        filterModel.value.product![index].inWishlist = value;
                      },
                    ),
                  );
                },
              )
                  : SliverToBoxAdapter(
                child: Center(
                  child: Text('Store is empty'.tr),
                ),),
            if (modelProductsList.vendorProducts!.data != null && controller.isFilter.value == false )
              isDataLoading.value
                  ? Obx(() {
                return SliverGrid.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: .82,
                  ),
                  itemCount: paginationLoading.value ?
                  modelProductsList.vendorProducts!.data!.length + 1 :
                  modelProductsList.vendorProducts!.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (index < modelProductsList.vendorProducts!.data!.length) {
                      final item = modelProductsList.vendorProducts!.data![index];
                      log('index is::::$index');
                      log('index Api is::::${modelProductsList.vendorProducts!.data!.length}');

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: ProductUI(
                          isSingle: true,
                          productElement: item,
                          onLiked: (value) {
                            modelProductsList.vendorProducts!.data![index].inWishlist = value;
                          },
                        ),
                      );
                    }
                    else {
                      return Column(
                        children: [
                          //  if(paginationLoading.value)
                          const LoadingAnimation(),
                        ],
                      );
                    }
                  },
                );
              })
                  : const SliverToBoxAdapter(
                child: Center(
                  // child: Text('Store is empty'.tr),
                  child: LoadingAnimation(),
                ),)
            else
              SliverToBoxAdapter(child: controller.isFilter.value == false ? const LoadingAnimation() : const SizedBox()),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 30,
              ),
            ),
            // const SizedBox(
            //   height: 10,
            // ),
            // const Image(
            //   image: AssetImage('assets/images/collectionbooks.png'),
            // ),
          ],
        ) : const LoadingAnimation();
      }),
    );
  }

  bottemSheet() {
    Size size = MediaQuery
        .of(context)
        .size;
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        builder: (context) {
          return SizedBox(
            width: size.width,
            height: size.height * .77,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          height: size.height * .2,
                          width: size.width * .7,
                          'assets/images/bag.png',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        AppStrings.fiftyOff.tr,
                        style: GoogleFonts.poppins(
                            fontSize: 18, fontWeight: FontWeight.w500, color: const Color(0xffC22E2E)),
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'Ecstasy 165 days '.tr,
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        '1 piece'.tr,
                        style: GoogleFonts.poppins(color: const Color(0xff858484), fontSize: 16),
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'KWD 6.350',
                                style: GoogleFonts.poppins(
                                    fontSize: 16, fontWeight: FontWeight.w500, color: const Color(0xff014E70)),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'KWD 12.700',
                                style: GoogleFonts.poppins(
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xff858484)),
                              ),
                            ],
                          ),
                          Text(
                            'Add to list'.tr,
                            style: GoogleFonts.poppins(
                              shadows: [const Shadow(color: Colors.black, offset: Offset(0, -4))],
                              color: Colors.transparent,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Description'.tr,
                        style: GoogleFonts.poppins(
                          shadows: [const Shadow(color: Colors.black, offset: Offset(0, -4))],
                          color: Colors.transparent,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'to the rich father and the poor father; What the rich teach and the poor and middle class do not teach their children about to the Publisher s Synopsis: This book will shatter the myth that you need a big income to get rich... -Challenging'
                            .tr,
                        style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w400, height: 1.7),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                Card(
                  elevation: 10,
                  child: Container(
                    color: Colors.white,
                    width: size.width,
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 18,
                                backgroundColor: const Color(0xffEAEAEA),
                                child: Center(
                                    child: Text(
                                      "━",
                                      style: GoogleFonts.poppins(
                                          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
                                    )),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "1",
                                style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 20),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              CircleAvatar(
                                radius: 18,
                                backgroundColor: const Color(0xffEAEAEA),
                                child: Center(
                                    child: Text(
                                      "+",
                                      style: GoogleFonts.poppins(
                                          fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
                                    )),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              Get.offNamed(BagsScreen.route);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xff014E70), borderRadius: BorderRadius.circular(22)),
                              padding: const EdgeInsets.fromLTRB(20, 9, 20, 9),
                              child: Text(
                                "Add to Cart".tr,
                                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
