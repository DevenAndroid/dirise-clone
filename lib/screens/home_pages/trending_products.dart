import 'package:dirise/language/app_strings.dart';
import 'package:dirise/screens/product_details/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/home_controller.dart';
import '../../widgets/common_colour.dart';

class TrendingProducts extends StatefulWidget {
  const TrendingProducts({super.key});

  @override
  State<TrendingProducts> createState() => _TrendingProductsState();
}

class _TrendingProductsState extends State<TrendingProducts> {
  final homeController = Get.put(TrendingProductsController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return homeController.trendingModel.value.product != null
          ? Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.trendingProducts.tr,
                        style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      // InkWell(
                      //   onTap: () {
                      //     // index1 = index1 + 1;
                      //     // setState(() {
                      //     //   if (index1 == homeController.trendingModel.value.product!.product!.length - 1) {
                      //     //     index1 = 0;
                      //     //   }
                      //     // });
                      //     // scrollToItem(index1);
                      //   },
                      //   child: Container(
                      //     padding: const EdgeInsets.all(2),
                      //     decoration: BoxDecoration(
                      //         shape: BoxShape.circle, border: Border.all(color: AppTheme.buttonColor, width: 1.2)),
                      //     child: const Icon(
                      //       Icons.arrow_forward,
                      //       color: AppTheme.buttonColor,
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    height: 220,
                    margin: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                    child: ListView.builder(
                        itemCount: homeController.trendingModel.value.product!.product!.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          final item = homeController.trendingModel.value.product!.product![index];
                          return ProductUI(
                            productElement: item,
                            onLiked: (value) {
                              homeController.trendingModel.value.product!.product![index].inWishlist = value;
                            },
                          ).animate(delay: 50.ms).fade(duration: 400.ms);
                        }),
                  ),
                ),
              ],
            )
          : const SizedBox.shrink();
    });
  }
}
