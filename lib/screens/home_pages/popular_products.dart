import 'package:dirise/language/app_strings.dart';
import 'package:dirise/screens/product_details/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/home_controller.dart';
import '../../widgets/common_colour.dart';

class PopularProducts extends StatefulWidget {
  const PopularProducts({super.key});

  @override
  State<PopularProducts> createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  final homeController = Get.put(TrendingProductsController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return homeController.popularProdModal.value.product != null
          ? Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(),
                      Text(
                        "Popular Products",
                        style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500),
                      ),
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
                      )
                    ],
                  ),
                ),
                Text(
                  "All what you need for a fun and exciting day in",
                  style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (homeController.popularProdModal.value.product != null)
                  Container(
                    height: 350,
                    margin: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                    child: ListView.builder(
                        itemCount: homeController.popularProdModal.value.product!.product!.length,
                        // itemScrollController: itemController1,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          final item = homeController.popularProdModal.value.product!.product![index];
                          return ProductUI(
                            productElement: item,
                            onLiked: (value) {
                              homeController.popularProdModal.value.product!.product![index].inWishlist = value;
                            },
                          );
                        }),
                  ),
              ],
            )
          : const SizedBox.shrink();
    });
  }
}
