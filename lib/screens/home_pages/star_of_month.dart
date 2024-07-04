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
      final filteredData = getStarVendorModel.value.data?.where((item) => item.ofTheMonth != null).toList() ?? [];

      return filteredData.isNotEmpty
          ? Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 18),
            child: SizedBox(
              height: size.height * 0.35,
              child: Swiper(
                autoplay: true,
                outer: false,
                autoplayDelay: 5000,
                autoplayDisableOnInteraction: false,
                // pagination: const SwiperPagination(
                //   builder: DotSwiperPaginationBuilder(
                //     color: Colors.black,
                //     activeColor: AppTheme.buttonColor,
                //   ),
                // ),
                onTap: (value) {
                  Get.to(() => SingleStoreScreen(
                    storeDetails: VendorStoreData(id: filteredData[value].ofTheMonth!.id.toString()),
                  ));
                },
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(1),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 13),
                      decoration: BoxDecoration(
                        color: Color(0xFFE7F8FD),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF5F5F5F).withOpacity(0.4),
                            offset: const Offset(0.0, 0.5),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Trending This Months'.tr.toUpperCase().toString(),
                            style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w600,color: Color(0xFF041D28)),
                          ),
                          SizedBox(height: 25,),
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
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 8.0,right: 10),
                                            child: RichText(
                                              text: TextSpan(
                                                children: [
                                              TextSpan(
                                                 text: 'IN '.tr,
                                                 style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w500,color: Colors.black),
                                               ),
                                                  TextSpan(
                                                    text: filteredData[index].name.toString(),
                                                    style: GoogleFonts.poppins(fontSize: 26, fontWeight: FontWeight.w600, color: Colors.black),
                                                  ),
                                                  // TextSpan(
                                                  //   text: ' Of The Month  '.tr,
                                                  //   style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w500,color: Colors.black),
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    10.spaceY,
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      // borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        imageUrl: filteredData[index].ofTheMonth!.storeLogoApp.toString(),
                                        fit: BoxFit.cover,
                                        width: 180,
                                        height: 150,
                                        placeholder: (context, url) => const SizedBox(),
                                        errorWidget: (_, __, ___) => ClipRRect(
                                          // borderRadius: BorderRadius.circular(10),
                                          child: Image.asset('assets/images/new_logo.png' ,   fit: BoxFit.cover,   width: 180,
                                            height: 150,),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: filteredData.length,
                control: const SwiperControl(size: 0),
              ),
            ).animate().fade(duration: 400.ms),
          ),
        ],
      )
          : const SizedBox.shrink();
    });

  }

}
