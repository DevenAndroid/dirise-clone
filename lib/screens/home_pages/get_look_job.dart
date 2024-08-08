import 'dart:convert';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dirise/utils/helper.dart';
import 'package:dirise/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../controller/profile_controller.dart';
import '../../controller/wish_list_controller.dart';
import '../../language/app_strings.dart';
import '../../model/common_modal.dart';
import '../../model/get_job_model.dart';
import '../../repository/repository.dart';
import '../../single_products/job_details_single.dart';
import '../../single_products/job_offer_details.dart';
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
        jobTypeApi();
        wishListController.getYourWishList();
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
  final profileController = Get.put(ProfileController());
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
              profileController.selectedLAnguage.value != 'English' ?
              Image.asset(
                'assets/images/forward_icon.png',
                height: 19,
                width: 19,
              ) :
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
          'I am here to find jobs'.tr,
          style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
        ),
      ),
      body: Obx(() {
        return  getJobModel.value.jobProduct!= null ?
          SingleChildScrollView(
            child: Column(
              children: [
                if( getJobModel.value.jobProduct!.isEmpty)
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
                          'No jobs found at this moment'.tr,
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 22),
                        ),
                      ),
                    ],
                  ),
                ListView.builder(
                itemCount: getJobModel.value.jobProduct!.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var item =  getJobModel.value.jobProduct![index];
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.to(
                                  () => JobOfferDetailsSingleScreen(),
                                  arguments: item.id.toString(),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: size.width * .92,
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(8),
                                          boxShadow: const [
                                            BoxShadow(
                                              blurStyle: BlurStyle.outer,
                                              offset: Offset(1, 1),
                                              color: Colors.black12,
                                              blurRadius: 3,
                                            )
                                          ]),
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
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      item.pname.toString(),
                                                      style: GoogleFonts.poppins(
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.w500,
                                                          color: const Color(0xFF19313C)),
                                                    ),
                                                    Text(
                                                      item.jobCat.toString(),
                                                      style: GoogleFonts.poppins(
                                                          fontSize: 11,
                                                          fontWeight: FontWeight.w400,
                                                          color: const Color(0xFF19313C)),
                                                    ),
                                                    10.spaceY,
                                                    Text(
                                                      item.aboutYourself.toString(),
                                                      maxLines: 3,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: GoogleFonts.poppins(
                                                          fontSize: 11,
                                                          fontWeight: FontWeight.w400,
                                                          color: const Color(0xFF19313C)),
                                                    ),
                                                  ],
                                                ),
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
                                                          id = item.id.toString();
                                                          if (wishListController.favoriteItems.contains(item.id.toString())) {
                                                            repositories
                                                                .postApi(
                                                                    url: ApiUrls.removeFromWishListUrl,
                                                                    mapData: {
                                                                      "product_id": id.toString(),
                                                                    },
                                                                    context: context)
                                                                .then((value) {
                                                              ModelCommonResponse response =
                                                                  ModelCommonResponse.fromJson(jsonDecode(value));
                                                              showToast(response.message);
                                                              if (response.status == true) {
                                                                wishListController.getYourWishList();
                                                                wishListController.favoriteItems
                                                                    .removeWhere((element) => element == item.id.toString());
                                                                wishListController.updateFav;
                                                              }
                                                            });
                                                          } else {
                                                            repositories
                                                                .postApi(
                                                                    url: ApiUrls.addToWishListUrl,
                                                                    mapData: {
                                                                      "product_id": item.id,
                                                                    },
                                                                    context: context)
                                                                .then((value) {
                                                              ModelCommonResponse response =
                                                                  ModelCommonResponse.fromJson(jsonDecode(value));
                                                              showToast(response.message);
                                                              setState(() {});
                                                              wishListController.getYourWishList();
                                                              wishListController.favoriteItems.add(item.id.toString());
                                                              wishListController.updateFav;
                                                            });
                                                          }
                                                          setState(() {});
                                                        },
                                                        isLiked: wishListController.favoriteItems.contains(item.id.toString()),
                                                      ),
                                                    );
                                                  }),
                                                  Text(
                                                    item.jobType.toString(),
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w500,
                                                        color: const Color(0xFF19313C)),
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
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Expanded(
                                                child: CachedNetworkImage(
                                                    imageUrl: item.featuredImage.toString(),
                                                    height: 150,
                                                    width: 150,
                                                    fit: BoxFit.contain,
                                                    errorWidget: (_, __, ___) => Image.asset('assets/images/new_logo.png')),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    const Icon(Icons.location_on_outlined),
                                                    10.spaceY,
                                                    Text(
                                                      item.jobCountryId.toString(),
                                                      style: GoogleFonts.poppins(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w400,
                                                          color: const Color(0xFF19313C)),
                                                    ),
                                                    2.spaceY,
                                                    Text(
                                                      item.jobModel.toString(),
                                                      textAlign: TextAlign.center,
                                                      style: GoogleFonts.poppins(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w400,
                                                          color: const Color(0xFF19313C)),
                                                    ),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        // SvgPicture.asset(
                                                        //   'assets/svgs/phonee.svg',
                                                        //   width: 20,
                                                        //   height: 20,
                                                        // ),
                                                        // const SizedBox(
                                                        //   width: 10,
                                                        // ),
                                                        // SvgPicture.asset(
                                                        //   'assets/svgs/chat-dots.svg',
                                                        //   width: 20,
                                                        //   height: 20,
                                                        // ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            launchUrlString(item.linkdinUrl.toString());
                                                          },
                                                          child: Image.asset(
                                                            'assets/images/linkdin_new.png',
                                                            width: 20,
                                                            height: 20,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          10.spaceY,
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Account Status'.tr,
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: GoogleFonts.poppins(
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.bold,
                                                          color: const Color(0xFF19313C)),
                                                    ),
                                                    3.spaceY,
                                                    Text(
                                                      maxLines: 1,
                                                      item.accountStatus.toString(),
                                                      overflow: TextOverflow.ellipsis,
                                                      style: GoogleFonts.poppins(
                                                          fontSize: 13,
                                                          fontWeight: FontWeight.w500,
                                                          color: const Color(0xFF14DC10)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Asking Salary'.tr,
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: GoogleFonts.poppins(
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.bold,
                                                          color: const Color(0xFF19313C)),
                                                    ),
                                                    3.spaceY,
                                                    Text(
                                                      maxLines: 1,
                                                      '${item.salary.toString()} KWD',
                                                      overflow: TextOverflow.ellipsis,
                                                      style: GoogleFonts.poppins(
                                                          fontSize: 13,
                                                          fontWeight: FontWeight.w500,
                                                          color: const Color(0xFF14DC10)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Experience'.tr,
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: GoogleFonts.poppins(
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.bold,
                                                          color: const Color(0xFF19313C)),
                                                    ),
                                                    3.spaceY,
                                                    Text(
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      item.experience.toString(),
                                                      style: GoogleFonts.poppins(
                                                          fontSize: 13,
                                                          fontWeight: FontWeight.w500,
                                                          color: const Color(0xFF14DC10)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
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
                                            color: Color(0xFF255459)),
                                        child: Text(
                                          " Looking for a job ".tr,
                                          style: GoogleFonts.poppins(
                                              fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },),
              ],
            ),
          ):
          const SizedBox.shrink();
      }),
    );
  }
}
