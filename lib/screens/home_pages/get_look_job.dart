import 'dart:convert';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dirise/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../controller/wish_list_controller.dart';
import '../../language/app_strings.dart';
import '../../model/common_modal.dart';
import '../../model/get_job_model.dart';
import '../../repository/repository.dart';
import '../../utils/api_constant.dart';
import '../../widgets/like_button.dart';

class GetLookJob extends StatefulWidget {
  const GetLookJob({super.key});

  @override
  State<GetLookJob> createState() => _GetLookJobState();
}

class _GetLookJobState extends State<GetLookJob> {
  Rx<GetJobModel> getJobModel = GetJobModel().obs;
  final Repositories repositories = Repositories();
  jobTypeApi() {
    repositories.getApi(url: ApiUrls.getJobList, context: context).then((value) {
      getJobModel.value = GetJobModel.fromJson(jsonDecode(value));
      log('dada${getJobModel.value.toJson()}');
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      jobTypeApi();
    });
  }
  String id = '';
  final wishListController = Get.put(WishListController());
  removeFromWishList() {
    repositories
        .postApi(
        url: ApiUrls.removeFromWishListUrl,
        mapData: {
          "product_id": id.toString(),
        },
        context: context)
        .then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message);
      if (response.status == true) {
        wishListController.getYourWishList();
        wishListController.updateFav;
      }
    });
  }
  addToWishList() {
    repositories
        .postApi(
        url: ApiUrls.addToWishListUrl,
        mapData: {
          "product_id": id.toString(),
        },
        context: context)
        .then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message);
      if (response.status == true) {
        wishListController.getYourWishList();
        wishListController.updateFav;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: (){
            Get.back();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/back_icon_new.png',
                height: 19,
                width: 19,
              ),
            ],
          ),
        ),
        centerTitle: true,
        titleSpacing: 0,
        title: Text(
          'Get Jobs'.tr,
          style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
        ),
      ),
      body: Obx(() {
        return  getJobModel.value.jobProduct!= null ?
          ListView.builder(
          itemCount: getJobModel.value.jobProduct!.data!.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            var item =  getJobModel.value.jobProduct!.data![index];
            return  getJobModel.value.jobProduct!.data!.isEmpty ?
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image(
                //     height: context.getSize.height * .24,
                //     image: const AssetImage(
                //       'assets/images/bucket.png',
                //     )),
                Lottie.asset("assets/loti/wishlist.json"),
                Center(
                  child: Text(
                    'Job\'s not found'.tr,
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 22),
                  ),
                ),
              ],
            ):Column(
              children: [
                InkWell(
                  onTap: () {
                    // bottomSheet(productDetails: widget.productElement, context: context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Stack(
                      children: [
                        Container(
                          width: size.width * .92,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: const [
                            BoxShadow(
                              blurStyle: BlurStyle.outer,
                              offset: Offset(1, 1),
                              color: Colors.black12,
                              blurRadius: 3,
                            )
                          ]),
                          // constraints: BoxConstraints(
                          //   // maxHeight: 100,
                          //   minWidth: 0,
                          //   maxWidth: size.width,
                          // ),
                          // color: Colors.red,
                          // margin: const EdgeInsets.only(right: 9,left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.describeJobRole.toString(),
                                        style: GoogleFonts.poppins(
                                            fontSize: 15, fontWeight: FontWeight.w500, color: const Color(0xFF19313C)),
                                      ),
                                      Text(
                                        item.describeJobRole.toString(),
                                        style: GoogleFonts.poppins(
                                            fontSize: 15, fontWeight: FontWeight.w500, color: const Color(0xFF19313C)),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Obx(() {
                                        if (wishListController.refreshFav.value > 0) {}
                                        return Padding(
                                          padding: const EdgeInsets.only(top: 8.0),
                                          child: LikeButtonCat(
                                            onPressed: () {
                                              item.id = id.toString();
                                              if (wishListController.favoriteItems.contains(item.id.toString())) {
                                                removeFromWishList();
                                              } else {
                                                addToWishList();
                                              }
                                            },
                                            isLiked: wishListController.favoriteItems.contains(item.id.toString()),
                                          ),
                                        );
                                      }),
                                      Text(
                                        item.jobType.toString(),
                                        style: GoogleFonts.poppins(
                                            fontSize: 15, fontWeight: FontWeight.w500, color: const Color(0xFF19313C)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CachedNetworkImage(
                                      imageUrl: item.prodectImage.toString(),
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.contain,
                                      errorWidget: (_, __, ___) => Image.asset('assets/images/new_logo.png')),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    children: [
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          Image.asset('assets/svgs/flagk.png'),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "Kuwait City",
                                            style: GoogleFonts.poppins(
                                                fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0xFF19313C)),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          const Icon(
                                            Icons.favorite_border_rounded,
                                            // color: widget.isLiked ? Colors.red : Colors.grey.shade700,
                                            color: Colors.red,
                                            size: 20,
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(item.pname.toString(),
                                        style: GoogleFonts.poppins(
                                            fontSize: 16, fontWeight: FontWeight.w400, color: const Color(0xFF19313C)),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "yokun",
                                            style: GoogleFonts.poppins(
                                                fontSize: 10, fontWeight: FontWeight.w400, color: const Color(0xFF19313C)),
                                          ),
                                          const SizedBox(
                                            width: 6,
                                          ),
                                          Text(
                                            "gmc",
                                            style: GoogleFonts.poppins(
                                                fontSize: 10, fontWeight: FontWeight.w400, color: const Color(0xFF19313C)),
                                          ),
                                          const SizedBox(
                                            width: 6,
                                          ),
                                          Text(
                                            "used",
                                            style: GoogleFonts.poppins(
                                                fontSize: 10, fontWeight: FontWeight.w400, color: const Color(0xFF19313C)),
                                          ),
                                          const SizedBox(
                                            width: 6,
                                          ),
                                          Text(
                                            "2024",
                                            style: GoogleFonts.poppins(
                                                fontSize: 10, fontWeight: FontWeight.w400, color: const Color(0xFF19313C)),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text.rich(
                                        TextSpan(
                                          text: '${item.discountPrice.toString()}.',
                                          style: const TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF19313B),
                                          ),
                                          children: [
                                            WidgetSpan(
                                              alignment: PlaceholderAlignment.middle,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'KWD',
                                                    style: TextStyle(
                                                      fontSize: 8,
                                                      fontWeight: FontWeight.w500,
                                                      color: Color(0xFF19313B),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      // print("date:::::::::::" + widget.productElement.shippingDate);
                                                    },
                                                    child:  Text(
                                                      '${item.discountPrice.toString()}',
                                                      style: TextStyle(
                                                        fontSize: 8,
                                                        fontWeight: FontWeight.w600,
                                                        color: Color(0xFF19313B),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      item.shortDescription.toString(),
                                      style: GoogleFonts.poppins(
                                          fontSize: 11, fontWeight: FontWeight.w400, color: const Color(0xFF19313C)),
                                    ),
                                  ),
                                  SvgPicture.asset(
                                    'assets/svgs/phonee.svg',
                                    width: 20,
                                    height: 20,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SvgPicture.asset(
                                    'assets/svgs/chat-dots.svg',
                                    width: 20,
                                    height: 20,
                                  ),
                                ],
                              ),

                              // SizedBox(height: 10,),
                              // Align(
                              //   alignment: Alignment.center,
                              //   child: Center(
                              //     child: CachedNetworkImage(
                              //         imageUrl: item.featuredImage.toString(),
                              //         height: 150,
                              //         fit: BoxFit.fill,
                              //         errorWidget: (_, __, ___) => Image.asset('assets/images/new_logo.png')
                              //     ),
                              //   ),
                              // ),
                              // const SizedBox(
                              //   height: 10,
                              // ),
                              //
                              // const SizedBox(
                              //   height: 3,
                              // ),
                              // Text(
                              //   item.pname.toString(),
                              //   maxLines: 2,
                              //   style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500,color: Color(0xFF19313C)),
                              // ),
                              // const SizedBox(
                              //   height: 3,
                              // ),
                              // Text(
                              //   item.shortDescription.toString(),
                              //   maxLines: 2,
                              //   style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500,color: Color(0xFF19313C)),
                              // ),
                              // const SizedBox(
                              //   height: 3,
                              // ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    // blurStyle: BlurStyle.outer,
                                    offset: Offset(2, 3),
                                    color: Colors.black26,
                                    blurRadius: 3,
                                  )
                                ],
                                borderRadius: BorderRadius.only(topRight: Radius.circular(8)),
                                color: Color(0xFF27D6FF)),
                            child: Text(
                              " Job Offer ",
                              style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          },):
          const SizedBox.shrink();
      }),
    );
  }
}
