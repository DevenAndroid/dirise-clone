import 'package:dirise/language/app_strings.dart';
import 'package:dirise/screens/product_details/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                SizedBox(height: 60,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(),
                      Text(
                        AppStrings.trendingProducts.tr.toUpperCase(),
                        style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                   SizedBox()
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  "All what you need for a fun and exciting day in",
                  style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(
                        onTap: () {
                          // index1 = index1 + 1;
                          // setState(() {
                          //   if (index1 == homeController.trendingModel.value.product!.product!.length - 1) {
                          //     index1 = 0;
                          //   }
                          // });
                          // scrollToItem(index1);
                        },
                        child:Image.asset("assets/svgs/forward.png")
                    ),
                    SizedBox(width: 20,)
                  ],

                ),
                SizedBox(height: 20,),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    height: 440,
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
