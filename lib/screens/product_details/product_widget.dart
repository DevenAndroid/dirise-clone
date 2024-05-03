import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dirise/model/common_modal.dart';
import 'package:dirise/repository/repository.dart';
import 'package:dirise/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/cart_controller.dart';
import '../../controller/wish_list_controller.dart';
import '../../model/product_model/model_product_element.dart';
import '../../utils/api_constant.dart';
import '../../widgets/like_button.dart';
import 'single_product.dart';

class ProductUI extends StatefulWidget {
  final ProductElement productElement;
  final Function(bool gg) onLiked;

  const ProductUI({super.key, required this.productElement, required this.onLiked});

  @override
  State<ProductUI> createState() => _ProductUIState();
}

class _ProductUIState extends State<ProductUI> {
  final cartController = Get.put(CartController());
  final wishListController = Get.put(WishListController());

  Size size = Size.zero;
  final Repositories repositories = Repositories();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
  }

  addToWishList() {
    repositories
        .postApi(
            url: ApiUrls.addToWishListUrl,
            mapData: {
              "product_id": widget.productElement.id.toString(),
            },
            context: context)
        .then((value) {
      widget.onLiked(true);
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message);
      if (response.status == true) {
        wishListController.getYourWishList();
        wishListController.favoriteItems.add(widget.productElement.id.toString());
        wishListController.updateFav;
      }
    });
  }

  removeFromWishList() {
    repositories
        .postApi(
            url: ApiUrls.removeFromWishListUrl,
            mapData: {
              "product_id": widget.productElement.id.toString(),
            },
            context: context)
        .then((value) {
      widget.onLiked(false);
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message);
      if (response.status == true) {
        wishListController.getYourWishList();
        wishListController.favoriteItems.removeWhere((element) => element == widget.productElement.id.toString());
        wishListController.updateFav;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        bottomSheet(productDetails: widget.productElement, context: context);
      },
      child: Container(
        constraints: BoxConstraints(
          minWidth: 0,
          maxWidth: size.width * .45,
        ),
        // color: Colors.red,
        margin: const EdgeInsets.only(right: 18),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: CachedNetworkImage(
                            imageUrl: widget.productElement.featuredImage.toString(),
                            height: 100,
                            fit: BoxFit.cover,
                              errorWidget: (_, __, ___) => Image.asset('assets/images/new_logo.png')
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "${widget.productElement.discountPercentage ?? ((((widget.productElement.pPrice.toString().toNum - widget.productElement.sPrice.toString().toNum) / widget.productElement.pPrice.toString().toNum) * 100).toStringAsFixed(2))}${'%'} Off",
                  style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: const Color(0xffC22E2E)),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  widget.productElement.pName.toString(),
                  maxLines: 2,
                  style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  '${widget.productElement.inStock.toString()} ${'pieces'.tr}',
                  style: GoogleFonts.poppins(color: Colors.grey.shade700, fontSize: 15,fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  'KWD ${widget.productElement.sPrice.toString()}',
                  style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                Text(
                  'KWD ${widget.productElement.pPrice.toString()}',
                  style: GoogleFonts.poppins(
                      decoration: TextDecoration.lineThrough,
                      color: const Color(0xff858484),
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                ),
                widget.productElement.shippingDate!="No Internation Shipping Available"?
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'shipping',
                      style: GoogleFonts.poppins(
                          color: const Color(0xff858484),
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    ),
                    if(widget.productElement.lowestDeliveryPrice!=null)
                    Text(
                      'KWD${widget.productElement.lowestDeliveryPrice.toString()}',
                      style: GoogleFonts.poppins(
                          color: const Color(0xff858484),
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    ),
                    if(widget.productElement.shippingDate!=null)
                    Text(
                      '${widget.productElement.shippingDate.toString()}',
                      style: GoogleFonts.poppins(
                          color: const Color(0xff858484),
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                )
:Text("No Internation Shipping Available",  style: GoogleFonts.poppins(
                    color: const Color(0xff858484),
                    fontSize: 13,
                    fontWeight: FontWeight.w500),),
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Obx(() {
                if (wishListController.refreshFav.value > 0) {}
                return LikeButtonCat(
                  onPressed: () {
                    if (wishListController.favoriteItems.contains(widget.productElement.id.toString())) {
                      removeFromWishList();
                    } else {
                      addToWishList();
                    }
                  },
                  isLiked: wishListController.favoriteItems.contains(widget.productElement.id.toString()),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}

Future bottomSheet({required ProductElement productDetails, required BuildContext context}) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      constraints: BoxConstraints(maxHeight: context.getSize.height * .9, minHeight: context.getSize.height * .4),
      builder: (context) {
        return SingleProductDetails(
          productDetails: productDetails,
        );
      });
}
