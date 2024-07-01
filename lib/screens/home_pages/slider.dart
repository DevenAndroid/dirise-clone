import 'dart:convert';

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
import '../../model/model_category_list.dart';
import '../../model/model_category_stores.dart';
import '../../model/model_news_trend.dart';
import '../../model/vendor_models/vendor_category_model.dart';
import '../../posts/post_ui_player.dart';
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

  Rx<ModelNewsTrends> getNewsTrendModel = ModelNewsTrends().obs;
  Rx<ModelSingleCategoryList> modelSingleCategoryList = ModelSingleCategoryList().obs;

  Future getNewsTrendData() async {
    repositories.getApi(url: ApiUrls.getNewsTrendsUrl).then((value) {
      getNewsTrendModel.value = ModelNewsTrends.fromJson(jsonDecode(value));
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
            Text(
             "What are you looking for",
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 20, color: AppTheme.buttonColor),
            )
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            //   child: Row(
            //     children: [
            //       Container(
            //         height: 60,
            //         width: context.getSize.width * .40,
            //         decoration:  BoxDecoration(
            //             color: const Color(0xffF0F0F0),
            //             borderRadius: profileController.selectedLAnguage.value == 'English' ? const BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)) :
            //             const BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10))
            //         ),
            //         child: Padding(
            //           padding: const EdgeInsets.only(left: 8.0, right: 8),
            //           child: Row(
            //             children: [
            //               GestureDetector(
            //                 onTap: (){
            //                   Get.toNamed(ExtraInformation.route);
            //                    // Get.toNamed(ShippingPolicyScreen.route);
            //                    // Get.toNamed(AddAddressScreen.route);
            //                 },
            //                 child: Text(
            //                   AppStrings.newsAndTrend.tr,
            //                   style: GoogleFonts.poppins(
            //                     color: AppTheme.buttonColor,
            //                     fontWeight: FontWeight.w500,
            //                   ),
            //                 ),
            //               ),
            //               const SizedBox(
            //                 width: 8,
            //               ),
            //               profileController.selectedLAnguage.value == 'English' ?  const Expanded(child: Image(height: 20, image: AssetImage('assets/icons/trends.png'))) :
            //               const Expanded(child:
            //               Image(height: 20,
            //                   image: AssetImage('assets/icons/arabic_trends.png')))
            //             ],
            //           ),
            //         ),
            //       ),
            //       Expanded(
            //         child: Container(
            //           height: 60,
            //           width: 200,
            //           decoration: BoxDecoration(
            //               border: Border.all(
            //                 color: const Color(0xffF0F0F0),
            //               ),
            //               borderRadius:  profileController.selectedLAnguage.value == 'English' ? const BorderRadius.only(bottomRight: Radius.circular(10), topRight: Radius.circular(10)) :
            //               const BorderRadius.only(bottomLeft: Radius.circular(10), topLeft: Radius.circular(10))
            //           ) ,
            //           child: Obx(() {
            //             return  getNewsTrendModel.value.data != null ? Padding(
            //               padding:     profileController.selectedLAnguage.value == 'English' ?  const EdgeInsets.only(top: 5, left: 7) : const EdgeInsets.only(top: 5, right: 7),
            //               child: InkWell(
            //                 onTap: () {
            //                   showModalBottomSheet(
            //                       isScrollControlled: true,
            //                       context: context,
            //                       builder: (context) {
            //                         return SizedBox(
            //                           height: context.getSize.height * .7,
            //                           child: Padding(
            //                             padding: const EdgeInsets.only(top: 30, right: 18, left: 18),
            //                             child: Obx(() {
            //                               return getNewsTrendModel.value.data != null ?
            //                               ListView.builder(
            //                                 physics: const AlwaysScrollableScrollPhysics(),
            //                                 shrinkWrap: true,
            //                                 itemCount: getNewsTrendModel.value.data!.length,
            //                                 itemBuilder: (context, index) {
            //                                   var item = getNewsTrendModel.value.data![index];
            //                                   return Column(
            //                                     mainAxisAlignment: MainAxisAlignment.start,
            //                                     crossAxisAlignment: CrossAxisAlignment.start,
            //                                     children: [
            //                                       Container(
            //                                         decoration: BoxDecoration(color: Colors.white, boxShadow: [
            //                                           BoxShadow(
            //                                             color: const Color(0xFF5F5F5F).withOpacity(0.4),
            //                                             offset: const Offset(0.0, 0.2),
            //                                             blurRadius: 2,
            //                                           ),
            //                                         ]),
            //                                         padding: const EdgeInsets.all(15),
            //                                         child: Column(
            //                                           crossAxisAlignment: CrossAxisAlignment.start,
            //                                           children: [
            //                                             Row(
            //                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                                               crossAxisAlignment: CrossAxisAlignment.start,
            //                                               children: [
            //                                                 Expanded(
            //                                                   child: Row(
            //                                                     crossAxisAlignment: CrossAxisAlignment.start,
            //                                                     mainAxisAlignment: MainAxisAlignment.start,
            //                                                     children: [
            //                                                       ClipRRect(
            //                                                         borderRadius: BorderRadius.circular(100),
            //                                                         child: CachedNetworkImage(
            //                                                           imageUrl: item.userIds!.profileImage.toString(),
            //                                                           height: 45,
            //                                                           width: 45,
            //                                                           fit: BoxFit.cover,
            //                                                           errorWidget: (context, url, error) =>
            //                                                               Image.asset('assets/images/post_img.png'),
            //                                                         ),
            //                                                       ),
            //                                                       const SizedBox(
            //                                                         width: 15,
            //                                                       ),
            //                                                       Expanded(
            //                                                         child: Text(
            //                                                           item.userIds!.name == '' ? item.userIds!.email.toString() : item.userIds!.name.toString(),
            //                                                           style: GoogleFonts.poppins(
            //                                                               color: Colors.black, fontWeight: FontWeight.w500, fontSize: 15),
            //                                                         ),
            //                                                       )
            //                                                     ],
            //                                                   ),
            //                                                 ),
            //                                                 const SizedBox(
            //                                                   width: 10,
            //                                                 ),
            //                                               ],
            //                                             ),
            //                                             const SizedBox(
            //                                               height: 18,
            //                                             ),
            //                                             Text(
            //                                               item.discription ?? '',
            //                                               style: GoogleFonts.poppins(
            //                                                 color: const Color(0xFF5B5B5B),
            //                                                 fontWeight: FontWeight.w500,
            //                                                 fontSize: 13,
            //                                                 letterSpacing: 0.24,
            //                                               ),
            //                                             ),
            //                                             const SizedBox(
            //                                               height: 15,
            //                                             ),
            //                                             item.fileType!.contains('image')
            //                                                 ? GestureDetector(
            //                                               onTap: () {
            //                                                 showImageViewer(context, Image.network(item.file.toString()).image,
            //                                                     swipeDismissible: false);
            //                                               },
            //                                                   child: SizedBox(
            //                                                     width: double.maxFinite,
            //                                                     height: 170,
            //                                                     child: CachedNetworkImage(
            //                                                       imageUrl: item.file.toString(),
            //                                                       fit: BoxFit.cover,
            //                                                       width: AddSize.screenWidth,
            //                                                       errorWidget: (context, url, error) => Image.asset(
            //                                                         'assets/images/Rectangle 39892.png',
            //                                                         fit: BoxFit.fitWidth,
            //                                                       ),
            //                                                     ),
            //                                                   ),
            //                                                 )
            //                                                 : item.fileType == 'directory'
            //                                                 ? const SizedBox()
            //                                                 : item.fileType == ''
            //                                                 ? const SizedBox()
            //                                                 : AspectRatio(
            //                                               aspectRatio: 16 / 9,
            //                                               child:  PostVideoPlayer(
            //                                                 fileUrl: item.file.toString() ,
            //                                               ),
            //                                             ),
            //                                           ],
            //                                         ),
            //                                       ),
            //                                       const SizedBox(
            //                                         height: 15,
            //                                       )
            //
            //                                     ],
            //                                   );
            //                                 },
            //                               ) : const LoadingAnimation();
            //                             }),
            //                           ),
            //                         );
            //                       });
            //                 },
            //                 child: ScrollLoopAutoScroll(
            //                   scrollDirection: Axis.vertical,
            //                   delay: const Duration(seconds: 0),
            //                   duration: const Duration(minutes: 3),
            //                   gap: 0,
            //                   reverseScroll: false,
            //                   duplicateChild: 1,
            //                   enableScrollInput: true,
            //                   delayAfterScrollInput: const Duration(seconds: 1),
            //                   child: getNewsTrendModel.value.data!= null && getNewsTrendModel.value.data!.isNotEmpty?
            //                   ListView.builder(
            //                      shrinkWrap: true,
            //                        itemCount: getNewsTrendModel.value.data!.length,
            //                       itemBuilder: (context, index) {
            //                         return  getNewsTrendModel.value.data![index].discription != null ?
            //                           Text(
            //                           getNewsTrendModel.value.data![index].discription.toString(),
            //                           style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 13),
            //                         ): const SizedBox.shrink();
            //                       },
            //                   ): Text('No Data Found',
            //                     style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 13),
            //                   )
            //                 ),
            //               ),
            //             ) :const SizedBox();
            //           }),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
                    ],
                  ).animate().fade(duration: 400.ms),
          )
          : const LoadingAnimation();
    });
  }
}
