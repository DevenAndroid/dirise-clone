import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dirise/language/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
          ? GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: min(homeController.vendorCategory.usphone!.length + 1,12),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20).copyWith(top: 0),
              gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: Get.width*.220,
                childAspectRatio: .75,
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
                        child: InkWell(
                          onTap: () {
                            bottomController.pageIndex.value = 1;
                          },
                          child: Container(
                              height: 70,
                              decoration:
                                  BoxDecoration(borderRadius: BorderRadius.circular(10), color: const Color(0xffF0F0F0)),
                              child: Padding(
                                padding: const EdgeInsets.all(18),
                                child: Container(
                                  // height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle, border: Border.all(color: AppTheme.buttonColor, width: 1.2)),
                                  child: const Icon(
                                    Icons.arrow_forward,
                                    color: AppTheme.buttonColor,
                                    size: 14,
                                  ),
                                ),
                              )),
                        ),
                      ),
                      // ignore: prefer_const_constructors
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                       AppStrings.more.tr,
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 15, color: AppTheme.buttonColor),
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
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(1500),
                            child: Hero(
                              tag: item.bannerProfile.toString(),
                              child: Material(
                                color: Colors.transparent,
                                surfaceTintColor: Colors.transparent,
                                child: CachedNetworkImage(
                                    imageUrl: item.bannerProfile.toString(),
                                    height: 65,
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
                        Text(
                          profileController.selectedLAnguage.value == 'English' ?  item.name.toString() : item.arabName.toString(),
                          maxLines: 1,
                          // overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 14, color: AppTheme.buttonColor),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  )
                      .animate(delay: Duration(milliseconds: index * 200))
                      .scale(duration: 500.ms);
                }
              },
            )
          : const SizedBox.shrink();
    });
  }
}
