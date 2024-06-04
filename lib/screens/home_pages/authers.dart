import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:dirise/language/app_strings.dart';
import 'package:dirise/utils/helper.dart';
import 'package:dirise/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    Size size = MediaQuery.of(context).size;
    return Obx(() {
      return homeController.authorModal.value.data != null
          ? Column(
              children: [
                homeController.authorModal.value.data != null &&  homeController.authorModal.value.data!.isNotEmpty
                    ?  Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 18),
                  child: SizedBox(
                    height: size.height * 0.28,
                    child: Swiper(
                      autoplay: true,
                      outer: false,
                      autoplayDelay: 5000,

                      autoplayDisableOnInteraction: false,

                      //                   onTap: (value){
                      // Get.to(()=> SingleStoreScreen(
                      // storeDetails: VendorStoreData(id: homeController.authorModal.value.data![value].id.toString()),
                      // ));
                      //                   },
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all( 12),
                          child: InkWell(
                            onTap: (){
                              Get.to(()=> SingleStoreScreen(
                                storeDetails: VendorStoreData(id: homeController.authorModal.value.data![index].id.toString()),
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
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  Expanded(
                                    child: Column(
                                      children: [
                                        // SizedBox(height: 20,),

                                                Image.asset(
                                                    'assets/svgs/man.png',
                                                  height: 160,
                                               fit: BoxFit.fill,
                                                ),
                                        // Text(
                                        //   getStarVendorModel.value.data![index].ofTheMonth!.storeName.toString(),
                                        //   maxLines: 1,
                                        //   style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
                                        // ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [

                                        Text(
                                         "YOUSEF AHMAD NASEER JABER MNAWER",
                                          style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600),
                                        ),
                                        10.spaceY,
                                        Text(
                                         "Padded liea’s built-in bra vest tank top Padded liea’s built-in",
                                          style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w300),
                                        ),SizedBox(height: 10,),
Row(
  children: [
Image.asset("assets/svgs/mg.png",height: 28,width: 28,),
    SizedBox(width: 8,),
    Image.asset("assets/svgs/cl.png",height: 28,width: 28,),
    SizedBox(width: 8,),
    Image.asset("assets/svgs/fg.png",height: 28,width: 28,),SizedBox(width: 8,),
    SvgPicture.asset("assets/svgs/x.svg",height: 30,width: 30,),
  ],
),
SizedBox(height: 5,),
Row(
  children: [


SvgPicture.asset("assets/svgs/ins.svg",height: 30,width: 30,), SizedBox(width: 8,),
SvgPicture.asset("assets/svgs/in.svg",height: 30,width: 30,), SizedBox(width: 8,),
SvgPicture.asset("assets/svgs/tik.svg",height: 30,width: 30,), SizedBox(width: 8,),
SvgPicture.asset("assets/svgs/yt.svg",height: 30,width: 30,), SizedBox(width: 8,),
SvgPicture.asset("assets/svgs/fb.svg",height: 30,width: 30,),
  ],
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
                      itemCount:  homeController.authorModal.value.data!.length,
                      // pagination: const SwiperPagination(),
                      control: const SwiperControl(size: 0),

                    ),
                  )
              ): const SizedBox.shrink()
                            ])  : const SizedBox.shrink();

    });
  }
}
