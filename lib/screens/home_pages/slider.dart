import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:dirise/language/app_strings.dart';
import 'package:dirise/routers/my_routers.dart';
import 'package:dirise/utils/helper.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scroll_loop_auto_scroll/scroll_loop_auto_scroll.dart';
import '../../controller/home_controller.dart';
import '../../controller/profile_controller.dart';
import '../../model/get_publish_model.dart';
import '../../model/model_category_list.dart';
import '../../model/model_category_stores.dart';
import '../../model/model_news_trend.dart';
import '../../model/vendor_models/vendor_category_model.dart';
import '../../posts/post_ui_player.dart';
import '../../posts/posts_ui.dart';
import '../../repository/repository.dart';
import '../../tellaboutself/ExtraInformation.dart';
import '../../utils/api_constant.dart';
import '../../vendor/shipping_policy.dart';
import '../../widgets/common_colour.dart';
import '../../widgets/dimension_screen.dart';
import '../../widgets/loading_animation.dart';
import '../categories/single_category_with_stores/single_categorie.dart';
import '../categories/single_category_with_stores/single_store_screen.dart';
import '../check_out/address/add_address.dart';

class SliderWidget extends StatefulWidget {
  const SliderWidget({super.key});

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  final homeController = Get.put(TrendingProductsController());
  final profileController = Get.put(ProfileController());

  Rx<GetPublishPostModel> getPublishModel = GetPublishPostModel().obs;
  Rx<ModelSingleCategoryList> modelSingleCategoryList = ModelSingleCategoryList().obs;

  Future getNewsTrendData() async {
    repositories.getApi(url: ApiUrls.getPublishUrl).then((value) {
      getPublishModel.value = GetPublishPostModel.fromJson(jsonDecode(value));
      log('news feed ${  getPublishModel.value.toJson()}');
    });
  }


  final Repositories repositories = Repositories();

  @override
  void initState() {
    super.initState();
    getNewsTrendData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Obx(() {
      return homeController.homeModal.value.home != null
          ? Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurStyle: BlurStyle.outer,
                offset: Offset(0,0),
                color: Colors.black12,
                blurRadius:1,

              )
            ]
        ),
            child: Column(
                    children: [
                      SizedBox(height: 5,),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                child: SizedBox(
                  height: size.height * 0.25,
                  child: Swiper(
                    autoplay: true,
                    outer: false,
                    autoplayDelay: 5000,
                    autoplayDisableOnInteraction: false,
                    onTap: (index) {
                      print('valueee:::::::${homeController.homeModal.value.home!.slider![index].id.toString()}');
                      Get.to(() =>
                          SingleCategories(
                            vendorCategories:  VendorCategoriesData(id: homeController.homeModal.value.home!.slider![index].id.toString(),
                                bannerProfile: homeController.homeModal.value.home!.slider![index].bannerMobile.toString(),
                              name: homeController.homeModal.value.home!.slider![index].name.toString()
                            ),
                          ));

                    },
                    // pagination:  const SwiperPagination(
                    //     margin: EdgeInsets.only(top: 40),
                    //   builder: DotSwiperPaginationBuilder(
                    //     color: Colors.grey,
                    //    space: 4,
                    //     // Inactive dot color
                    //     activeColor: AppTheme.buttonColor,
                    //   ),
                    // ),
                    itemBuilder: (BuildContext context, int index) {
                      return CachedNetworkImage(
                        // height: 130,
                        // width: 200,
                          imageUrl: homeController.homeModal.value.home!.slider![index].bannerMobile.toString(),
                          fit: BoxFit.fill,
                          placeholder: (context, url) => const SizedBox(),
                          errorWidget: (context, url, error) => const SizedBox());
                    },
                    itemCount: homeController.homeModal.value.home!.slider!.length,
                    // pagination: const SwiperPagination(),
                    control: const SwiperControl(size: 0),

                  ),
                )
            ),
              Container(
              height: 50,
              width: Get.width,
              decoration: BoxDecoration(
                  border: Border.all(
                    color:  Color(0xff014E70).withOpacity(.13),
                    width: 2
                  ),
                borderRadius: BorderRadius.circular(10)
              ) ,
              child: Obx(() {
                return  getPublishModel.value.allNews != null ? Padding(
                  padding:     profileController.selectedLAnguage.value == 'English' ?  const EdgeInsets.only(top: 5, left: 7) : const EdgeInsets.only(top: 5, right: 7),
                  child: InkWell(
                    onTap: (){
                      Get.toNamed(PublishPostScreen.route);
                    },
                    child: ScrollLoopAutoScroll(
                        scrollDirection: Axis.vertical,
                        delay: const Duration(seconds: 0),
                        duration: const Duration(minutes: 3),
                        gap: 0,
                        reverseScroll: false,
                        duplicateChild: 1,
                        enableScrollInput: true,
                        delayAfterScrollInput: const Duration(seconds: 1),
                        child: getPublishModel.value.allNews!= null && getPublishModel.value.allNews!.isNotEmpty?
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: getPublishModel.value.allNews!.length,
                          itemBuilder: (context, index) {
                            return  getPublishModel.value.allNews![index].discription != null ?
                            Center(
                              child: Text(
                                getPublishModel.value.allNews![index].discription.toString(),
                                style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 13),
                              ),
                            ): const SizedBox.shrink();
                          },
                        ): Text('No Data Found',
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 13),
                        )
                    ),
                  ),
                ) :const SizedBox();
              }),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
             "What are you looking for".tr,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 20, color: AppTheme.buttonColor),
            ),
                    ],
                  ).animate().fade(duration: 400.ms),
          )
          : const LoadingAnimation();
    });
  }
}
