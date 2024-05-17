import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:dirise/language/app_strings.dart';
import 'package:dirise/screens/product_details/product_widget.dart';
import 'package:dirise/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

import '../../controller/home_controller.dart';
import '../../model/get_star_vendor_Model.dart';
import '../../model/model_category_stores.dart';
import '../../repository/repository.dart';
import '../../utils/api_constant.dart';
import '../../widgets/common_colour.dart';
import '../../widgets/loading_animation.dart';
import '../categories/single_category_with_stores/single_store_screen.dart';

class StarOfMonthScreen extends StatefulWidget {
  const StarOfMonthScreen({super.key});

  @override
  State<StarOfMonthScreen> createState() => _StarOfMonthScreenState();
}

class _StarOfMonthScreenState extends State<StarOfMonthScreen> {

  Rx<GetStarVendorModel> getStarVendorModel = GetStarVendorModel().obs;

  Future getNewsTrendData() async {
    repositories.getApi(url: ApiUrls.starVendorUrl).then((value) {
      getStarVendorModel.value = GetStarVendorModel.fromJson(jsonDecode(value));
      print(getStarVendorModel.value.toString());
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
    Size size = MediaQuery.of(context).size;
    return Obx(() {
      return getStarVendorModel.value.data != null
          ? Column(
        children: [
          getStarVendorModel.value.data!.isNotEmpty ?
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 18),
              child: SizedBox(
                height: size.height * 0.29,
                child: Swiper(
                  autoplay: true,
                  outer: false,
                  autoplayDelay: 5000,

                  autoplayDisableOnInteraction: false, pagination:  const SwiperPagination(
                  // margin: EdgeInsets.only(top: 30),
                  builder: DotSwiperPaginationBuilder(
                    color: Colors.black,
                    // Inactive dot color
                    activeColor: AppTheme.buttonColor, // Active dot color
                  ),
                ),

                  onTap: (value){
                      Get.to(()=> SingleStoreScreen(
                        storeDetails: VendorStoreData(id: getStarVendorModel.value.data![value].ofTheMonth!.id.toString()),
                      ));
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all( 1),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 13),
                        decoration: BoxDecoration(
                          color: Color(0xFFE7F8FD),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF5F5F5F).withOpacity(0.4),
                                offset: const Offset(0.0, 0.5),
                                blurRadius: 5,),
                            ]
                        ),
                        child: Column(

                          children: [
                            Text(
                              ' Trending This Months'.tr,
                              style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w500),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [

                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // SvgPicture.asset('assets/svgs/star_xmas.svg',height: 20,),
                                          // 10.spaceX,  // SvgPicture.asset('assets/svgs/star_xmas.svg',height: 20,),
                                          // 10.spaceX,
                                          Expanded(
                                            child: Text(
                                              getStarVendorModel.value.data![index].name.toString()+' Stars Of The Month'.tr,
                                              style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ],
                                      ),
                                      10.spaceY,

                                    ],
                                  ),
                                ),

                                getStarVendorModel.value.data![index].ofTheMonth!= null?
                                Expanded(
                                  child: Column(
                                    children: [
                                      // SizedBox(height: 20,),
                                      CachedNetworkImage(
                                          imageUrl: getStarVendorModel.value.data![index].ofTheMonth!.storeLogoApp.toString(),
                                          fit: BoxFit.cover,
                                          width: 150,
                                          height : 170,
                                          placeholder: (context, url) => const SizedBox(),
                                          errorWidget: (_, __, ___) =>
                                              Image.asset(
                                                  'assets/images/new_logo.png'
                                              )),
                                      // Text(
                                      //   getStarVendorModel.value.data![index].ofTheMonth!.storeName.toString(),
                                      //   maxLines: 1,
                                      //   style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
                                      // ),
                                    ],
                                  ),
                                ): const SizedBox(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount:  getStarVendorModel.value.data!.length,
                  // pagination: const SwiperPagination(),
                  control: const SwiperControl(size: 0),

                ),
              )
          ) .animate().fade(duration: 400.ms)
          : const LoadingAnimation(),
        ],
      )
          : const SizedBox.shrink();
    });
  }

}
