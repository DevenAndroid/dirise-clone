import 'package:cached_network_image/cached_network_image.dart';
import 'package:dirise/language/app_strings.dart';
import 'package:dirise/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/home_controller.dart';
import '../../model/model_category_stores.dart';
import '../../widgets/common_colour.dart';
import '../categories/single_category_with_stores/single_store_screen.dart';

class AuthorScreen extends StatefulWidget {
  const AuthorScreen({super.key});

  @override
  State<AuthorScreen> createState() => _AuthorScreenState();
}

class _AuthorScreenState extends State<AuthorScreen> {
  final homeController = Get.put(TrendingProductsController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return homeController.authorModal.value.data != null
          ? Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      homeController.authorModal.value.data!.isNotEmpty ?
                      Text(
                        AppStrings.shopByAuthor.tr,
                        style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500),
                      ) : const SizedBox.shrink(),
                      // Container(
                      //   padding: const EdgeInsets.all(2),
                      //   decoration: BoxDecoration(
                      //       shape: BoxShape.circle, border: Border.all(color: AppTheme.buttonColor, width: 1.2)),
                      //   child: InkWell(
                      //     onTap: () {
                      //       // index1 = index1 + 1;
                      //       // setState(() {
                      //       //   if (index1 == homeController.authorModal.value.data!.length - 1) {
                      //       //     index1 = 0;
                      //       //   }
                      //       // });
                      //       // scrollToItem2(index1);
                      //     },
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
                  height: 20,
                ),
                Container(
                  height: 230,
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: ListView.builder(
                    itemCount: homeController.authorModal.value.data!.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: (){
                          Get.to(()=> SingleStoreScreen(
                            storeDetails: VendorStoreData(id: homeController.authorModal.value.data![index].id.toString()),
                          ));
                        },
                        child: Container(
                            width: context.getSize.width * .5,
                            margin: const EdgeInsets.only(right: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: CachedNetworkImage(
                                      imageUrl: homeController.authorModal.value.data![index].profileImage.toString(),
                                      fit: BoxFit.cover,
                                      errorWidget: (_, __, ___) => Image.asset('assets/images/vendor_img.png')
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  homeController.authorModal.value.data![index].name.toString(),
                                  style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
                                ),
                              ],
                            )),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
              ],
            )
          : const SizedBox.shrink();
    });
  }
}
