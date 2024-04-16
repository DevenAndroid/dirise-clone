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
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.popularProducts.tr,
                        style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      // InkWell(
                      //   onTap: () {
                      //     // index1 = index1 + 1;
                      //     // setState(() {
                      //     //   if (index1 == homeController.popularProdModal.value.product!.product!.length - 1) {
                      //     //     index1 = 0;
                      //     //   }
                      //     // });
                      //     // scrollToItem1(index1);
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
                const SizedBox(
                  height: 10,
                ),
                if (homeController.popularProdModal.value.product != null)
                  Container(
                    height: 230,
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
