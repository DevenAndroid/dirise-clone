import 'package:cached_network_image/cached_network_image.dart';
import 'package:dirise/language/app_strings.dart';
import 'package:dirise/screens/product_details/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/home_controller.dart';
import '../../widgets/common_colour.dart';

class ShowCaseProducts extends StatefulWidget {
  const ShowCaseProducts({super.key});

  @override
  State<ShowCaseProducts> createState() => _ShowCaseProductsState();
}

class _ShowCaseProductsState extends State<ShowCaseProducts> {
  final homeController = Get.put(TrendingProductsController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return
      Obx(() {
      return homeController.getShowModal.value.showcaseProduct != null
          ?
      Column(
        children: [
          SizedBox(height: 60,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                Text(
                  AppStrings.showProducts.tr.toUpperCase(),
                  style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                SizedBox()
              ],
            ),
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
                  child:Image.asset("assets/icons/new_arrow.png",width: 35,height: 35,)
              ),
              SizedBox(width: 20,)
            ],

          ),
          SizedBox(height: 20,),
          SizedBox(
            height: 250,
          // margin: const EdgeInsets.fromLTRB(15, 20, 15, 0),
            child: ListView.builder(
                itemCount:
                 homeController.getShowModal.value.showcaseProduct!.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
              final item = homeController.getShowModal.value.showcaseProduct![index];
                  return  InkWell(
                    onTap: () {
                      // bottomSheet(productDetails: widget.productElement, context: context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Stack(
                        children: [
                          Container(
                                               width: size.width*.92,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(

                                    blurStyle: BlurStyle.outer,
                                    offset: Offset(1,1),
                                    color: Colors.black12,
                                    blurRadius:3,

                                  )
                                ]
                            ),
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
SizedBox(height: 20,),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CachedNetworkImage(
                                        imageUrl: item.featuredImage.toString(),
                                        height: 150,
                                        width: 150,
                                        fit: BoxFit.contain,
                                        errorWidget: (_, __, ___) => Image.asset('assets/images/new_logo.png')),

SizedBox(width: 20,),
                                    Column(
                                      children: [
                                        SizedBox(height: 15,),
                                        Row(
                                          children: [
                                             Image.asset('assets/svgs/flagk.png'),
                                            SizedBox(width: 5,),
                                            Text("Kuwait City", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400,color: Color(0xFF19313C)),
                                            ),
                                            SizedBox(width: 5,),
                                            Icon(
                                            Icons.favorite_border_rounded,
                                              // color: widget.isLiked ? Colors.red : Colors.grey.shade700,
                                              color:  Colors.red,
                                              size: 20,
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        Text(item.pname.toString(), style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400,color: Color(0xFF19313C)),
                                        ),
                                        SizedBox(height: 15,),
                                        Row(
                                          children: [
                                            Text("yokun", style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w400,color: Color(0xFF19313C)),
                                            ),
                                           SizedBox(width: 6,),
                                            Text("gmc", style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w400,color: Color(0xFF19313C)),
                                            ),
                                            SizedBox(width: 6,),
                                            Text("used", style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w400,color: Color(0xFF19313C)),
                                            ),
                                            SizedBox(width: 6,),
                                            Text("2024", style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w400,color: Color(0xFF19313C)),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 15,),
                                        Text.rich(
                                          TextSpan(
                                            text: '${item.discountPrice.toString().split('.')[0]}.',

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
                                                      child: Text(
                                                        '${item.discountPrice.toString().split('.')[1]}',
                                                        style: const TextStyle(
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
                                      child: Text(item.shortDescription.toString(), style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w400,color: Color(0xFF19313C)),
                                      ),
                                    ),

                                    Image.asset('assets/svgs/phonee.png'),
                                    SizedBox(width: 10,),
                                    Image.asset('assets/svgs/msgg.png'),
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
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(

                                      // blurStyle: BlurStyle.outer,
                                      offset: Offset(2,3),
                                      color: Colors.black26,
                                      blurRadius:3,

                                    )
                                  ],
                                borderRadius: BorderRadius.only(topRight: Radius.circular(8)),
                                  color: Color(0xFF27D6FF).withOpacity(0.6)
                              ),
                              child: Text(" Advertising ", style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w400,color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      )
       : const SizedBox.shrink();
    }
     );
  }
}
