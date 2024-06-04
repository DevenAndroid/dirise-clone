import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dirise/language/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/home_controller.dart';
import '../../controller/homepage_controller.dart';
import '../../controller/profile_controller.dart';
import '../../widgets/common_colour.dart';
import '../categories/single_category_with_stores/single_categorie.dart';

class CategoryItems extends StatefulWidget {
  const CategoryItems({super.key});

  @override
  State<CategoryItems> createState() => _CategoryItemsState();
}

class _CategoryItemsState extends State<CategoryItems> {
  final homeController = Get.put(TrendingProductsController());
  final profileController = Get.put(ProfileController());
  final bottomController = Get.put(BottomNavBarController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (homeController.updateCate.value > 0) {}
      return homeController.updateCate.value != 0
          ? Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(

                blurStyle: BlurStyle.outer,
                offset: Offset(1,1),
                color: Colors.black12,
                blurRadius:1,

              )
            ]
        ),
            child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: min(homeController.vendorCategory.usphone!.length + 1,12),
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20).copyWith(top: 0),
                gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: Get.width*.230,
                  childAspectRatio: .55,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 16,
                ),
                itemBuilder: (BuildContext context, int index) {
                  if (index ==  min(homeController.vendorCategory.usphone!.length + 1,12)-1) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          flex: 2,
                          child: InkWell(
                            onTap: () {
                              bottomController.pageIndex.value = 1;
                            },
                            child: Container(

                                height: 70,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFFF0EEEE),
                                    border: Border.all(color: Color(0xFFCCCCCC))
                                ),
                                child: Image.asset("assets/svgs/more.png")),
                          ),
                        ),
                        // ignore: prefer_const_constructors
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: Text(
                           AppStrings.more.tr,
                            style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 12, color: AppTheme.buttonColor),
                          ),
                        )
                      ],
                    )
                        .animate(delay: Duration(milliseconds: index * 200))
                        .scale(duration: 500.ms);
                  }
                  else {
                    final item = homeController.vendorCategory.usphone![index];
                    return InkWell(
                      key: ValueKey(index * DateTime.now().millisecondsSinceEpoch),
                      onTap: () {
                        Get.to(() => SingleCategories(
                              vendorCategories: item,
                            )
                        );
                      },
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
            padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                              shape: BoxShape.circle,
                                color: Color(0xFFF0EEEE),
                                border: Border.all(color: Color(0xFFCCCCCC))
                              ),
                              child: Hero(
                                tag: item.bannerProfile.toString(),
                                child: Material(
                                  color: Colors.transparent,
                                  surfaceTintColor: Colors.transparent,
                                  child: CachedNetworkImage(
                                      imageUrl: item.bannerProfile.toString(),
                                      // height: 65,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => const SizedBox(),
                                      errorWidget: (context, url, error) => const SizedBox()),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: Text(
                              profileController.selectedLAnguage.value == 'English'
                                  ? item.name.toString()
                                  : item.arabName.toString(),
                              maxLines: 2,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: AppTheme.buttonColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    )
                        .animate(delay: Duration(milliseconds: index * 200))
                        .scale(duration: 500.ms);
                  }
                },
              ),
          )
          : const SizedBox.shrink();
    });
  }
}
