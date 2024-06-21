import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:dirise/language/app_strings.dart';
import 'package:dirise/utils/helper.dart';
import 'package:dirise/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
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
  void launchURLl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Obx(() {
      return homeController.getFeaturedModel.value.data != null
          ? Column(
             crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
                      Text(
                        AppStrings.authersProducts.tr.toUpperCase(),
                        style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox()
                    ],
                  ),
                ),
                homeController.getFeaturedModel.value.data != null &&  homeController.getFeaturedModel.value.data!.isNotEmpty
                    ?  Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 18),
                  child: SizedBox(
                    height: size.height * 0.29,
                    child: ListView.builder(
                        itemCount: homeController.getFeaturedModel.value.data!.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all( 12),
                            child: InkWell(
                              onTap: (){
                                Get.to(()=> SingleStoreScreen(
                                  storeDetails: VendorStoreData(id: homeController.getFeaturedModel.value.data![index].user!.id.toString()),
                                ));
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 13),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF5F5F5F).withOpacity(0.4),
                                        offset: const Offset(0.0, 0.5),
                                        blurRadius: 5,),
                                    ]
                                ),
                                constraints: BoxConstraints(
                                  // maxHeight: 100,
                                  minWidth: 0,
                                  maxWidth: size.width * .85,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(width: 10),
                                    CachedNetworkImage(
                                      imageUrl: homeController.getFeaturedModel.value.data![index].user!.bannerProfileApp.toString(),
                                      height: 140,
                                      fit: BoxFit.fill,
                                      errorWidget: (_, __, ___) => Image.asset('assets/images/Dirise-App-Logo.png',
                                      height: 50,
                                        width: 50,
                                      ),
                                      placeholder: (context, url) => Image.asset('assets/images/Dirise-App-Logo.png',
                                        height: 50,
                                        width: 50,
                                      ),
                                    ),
                                    const SizedBox(width: 30,),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                           homeController.getFeaturedModel.value.data![index].user!.storeName.toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600),
                                          ),
                                          10.spaceY,
                                          Text(
                                            homeController.getFeaturedModel.value.data![index].user!.description ?? '',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w300),
                                          ),const SizedBox(height: 10,),
                                          Wrap(
                                            spacing: 3.0,
                                            runSpacing: 5.0,
                                            children: [
                                              if (homeController.getFeaturedModel.value.data![index].user!.email != '')
                                                GestureDetector(
                                                  onTap: () {
                                                    launchURLl('mailto:${homeController.getFeaturedModel.value.data![index].user!.email.toString()}');
                                                  },
                                                  child: Image.asset(
                                                    "assets/svgs/mg.png",
                                                    height: 28,
                                                    width: 28,
                                                  ),
                                                ),
                                              if (homeController.getFeaturedModel.value.data![index].user!.storePhone != '')
                                                GestureDetector(
                                                  onTap: () {
                                                    launchURLl('tel:${homeController.getFeaturedModel.value.data![index].user!.storePhone.toString()}');
                                                  },
                                                  child: Image.asset(
                                                    "assets/svgs/cl.png",
                                                    height: 28,
                                                    width: 28,
                                                  ),
                                                ),
                                              if (homeController.getFeaturedModel.value.data![index].socialLoginKeys!.pinterest != '')
                                                GestureDetector(
                                                  onTap: () {
                                                    launchURLl(homeController.getFeaturedModel.value.data![index].socialLoginKeys!.pinterest.toString());
                                                  },
                                                  child: Image.asset(
                                                    "assets/svgs/fg.png",
                                                    height: 28,
                                                    width: 28,
                                                  ),
                                                ),
                                              if (homeController.getFeaturedModel.value.data![index].socialLoginKeys!.twitter != '')
                                                GestureDetector(
                                                  onTap: () {
                                                    launchURLl(homeController.getFeaturedModel.value.data![index].socialLoginKeys!.twitter.toString());
                                                  },
                                                  child: SvgPicture.asset(
                                                    "assets/svgs/x.svg",
                                                    height: 30,
                                                    width: 30,
                                                  ),
                                                ),
                                              if (homeController.getFeaturedModel.value.data![index].socialLoginKeys!.instagram != '')
                                                GestureDetector(
                                                  onTap: () {
                                                    launchURLl(homeController.getFeaturedModel.value.data![index].socialLoginKeys!.instagram.toString());
                                                  },
                                                  child: SvgPicture.asset(
                                                    "assets/svgs/ins.svg",
                                                    height: 30,
                                                    width: 30,
                                                  ),
                                                ),
                                              if (homeController.getFeaturedModel.value.data![index].socialLoginKeys!.linkedin != '')
                                                GestureDetector(
                                                  onTap: () {
                                                    launchURLl(homeController.getFeaturedModel.value.data![index].socialLoginKeys!.linkedin.toString());
                                                  },
                                                  child: SvgPicture.asset(
                                                    "assets/svgs/in.svg",
                                                    height: 30,
                                                    width: 30,
                                                  ),
                                                ),
                                              if (homeController.getFeaturedModel.value.data![index].socialLoginKeys!.tiktok != '')
                                                GestureDetector(
                                                  onTap: () {
                                                    launchURLl(homeController.getFeaturedModel.value.data![index].socialLoginKeys!.tiktok.toString());
                                                  },
                                                  child: SvgPicture.asset(
                                                    "assets/svgs/tik.svg",
                                                    height: 30,
                                                    width: 30,
                                                  ),
                                                ),
                                              if (homeController.getFeaturedModel.value.data![index].socialLoginKeys!.youtube != '')
                                                GestureDetector(
                                                  onTap: () {
                                                    launchURLl(homeController.getFeaturedModel.value.data![index].socialLoginKeys!.youtube.toString());
                                                  },
                                                  child: SvgPicture.asset(
                                                    "assets/svgs/yt.svg",
                                                    height: 30,
                                                    width: 30,
                                                  ),
                                                ),
                                              if (homeController.getFeaturedModel.value.data![index].socialLoginKeys!.facebook != '')
                                                GestureDetector(
                                                  onTap: () {
                                                    launchURLl(homeController.getFeaturedModel.value.data![index].socialLoginKeys!.facebook.toString());
                                                  },
                                                  child: SvgPicture.asset(
                                                    "assets/svgs/fb.svg",
                                                    height: 30,
                                                    width: 30,
                                                  ),
                                                ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                    // homeController.authorModal.value.data != null?
                                    // Expanded(
                                    //   child: Column(
                                    //     children: [
                                    //       // SizedBox(height: 20,),
                                    //       CachedNetworkImage(
                                    //           imageUrl:homeController.authorModal.value.data![index].profileImage.toString(),
                                    //           fit: BoxFit.cover,
                                    //           width: 150,
                                    //           height : 130,
                                    //           placeholder: (context, url) => const SizedBox(),
                                    //           errorWidget: (_, __, ___) =>
                                    //               Image.asset(
                                    //                   'assets/images/new_logo.png'
                                    //               )),
                                    //       // Text(
                                    //       //   getStarVendorModel.value.data![index].ofTheMonth!.storeName.toString(),
                                    //       //   maxLines: 1,
                                    //       //   style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
                                    //       // ),
                                    //     ],
                                    //   ),
                                    // ): const SizedBox(),
                                    // SizedBox(width: 10,),
                                    // Expanded(
                                    //   flex: 2,
                                    //   child: Column(
                                    //     crossAxisAlignment: CrossAxisAlignment.start,
                                    //     mainAxisAlignment: MainAxisAlignment.start,
                                    //     children: [
                                    //
                                    //       Row(
                                    //         crossAxisAlignment: CrossAxisAlignment.start,
                                    //         children: [
                                    //           // SvgPicture.asset('assets/svgs/star_xmas.svg',height: 20,),
                                    //           // 10.spaceX,  // SvgPicture.asset('assets/svgs/star_xmas.svg',height: 20,),
                                    //           // 10.spaceX,
                                    //           Expanded(
                                    //             child: Text(
                                    //               homeController.authorModal.value.data![index].name.toString(),
                                    //               style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w500),
                                    //             ),
                                    //           ),
                                    //         ],
                                    //       ),
                                    //       10.spaceY,
                                    //
                                    //     ],
                                    //   ),
                                    // ),


                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                    )
                  )
              ): const SizedBox.shrink()
                            ])  : const SizedBox.shrink();

    });
  }
}
