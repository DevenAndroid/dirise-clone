import 'package:dirise/utils/helper.dart';
import 'package:dirise/utils/styles.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:dirise/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/cart_controller.dart';
import '../../model/model_cart_response.dart';
import '../../model/product_model/model_product_element.dart';
import '../../utils/api_constant.dart';
import '../product_details/product_widget.dart';
import 'check_out_screen.dart';

class BagsScreen extends StatefulWidget {
  const BagsScreen({super.key});

  static var route = "/AddBagScreen";

  @override
  State<BagsScreen> createState() => _BagsScreenState();
}

class _BagsScreenState extends State<BagsScreen> {
  final cartController = Get.put(CartController());

  @override
  void initState() {
    super.initState();
    cartController.getCart();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      cartController.getCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: customAppBar(title: "Cart".tr),
        body: RefreshIndicator(
          onRefresh: () async {
            await cartController.getCart();
          },
          child: Obx(() {
            if (cartController.refreshInt.value > 0) {}
            return cartController.apiLoaded
                ? cartController.cartModel.cart!.carsShowroom!.isNotEmpty
                    ? CustomScrollView(
                        shrinkWrap: true,
                        slivers: cartController.cartModel.cart!.carsShowroom!.entries.map((e) => SliverList(
                            delegate: SliverChildBuilderDelegate(
                              childCount: e.value.products!.length,
                                  (context, ii) {
                                    Products product = e.value.products![ii];
                                return GestureDetector(
                                  onTap: (){
                                    bottomSheet(productDetails: ProductElement.fromJson(e.value.products![ii].toJson()), context: context);
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                    //   border: ii != product.length - 1
                                    //       ? const Border(bottom: BorderSide(color: Color(0xffD9D9D9)))
                                    //       : null,
                                    ),
                                    margin: EdgeInsets.only(top: ii == 0 ? 16 : 0),
                                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        if (ii == 0)
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 16),
                                            child: Text(
                                              "${'Sold By'.tr} ${e.key}",
                                              style: titleStyle,
                                            ),
                                          ),
                                        IntrinsicHeight(
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 75,
                                                height: 75,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(12),
                                                  child: Image.network(
                                                    product.featuredImage.toString(),
                                                    fit: BoxFit.contain,
                                                    errorBuilder: (_, __, ___) =>  Image.asset(
                                                        'assets/images/new_logo.png'
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 16,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    Text(
                                                      product.pname.toString(),
                                                      style: titleStyle.copyWith(fontWeight: FontWeight.w400),
                                                      textAlign: TextAlign.start,
                                                    ),
                                                    const SizedBox(
                                                      height: 6,
                                                    ),
                                                     Text(
                                                      'KWD ${product.discountPrice}',
                                                      style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w400),
                                                    ),
                                                    // Text(
                                                    //   'KWD ${product.discountPrice}',
                                                    //   style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w400),
                                                    // ),
                                                    const SizedBox(
                                                      height: 4,
                                                    ),
                                                    IntrinsicHeight(
                                                      child: Row(
                                                        children: [
                                                          product.qty.toString() != '1' ? IconButton(
                                                              onPressed: () {
                                                                if (product.qty.toString().toNum > 1) {
                                                                  cartController.updateCartQuantity(
                                                                      context: context,
                                                                      productId: product.id.toString(),
                                                                      quantity: (product.qty.toString().toNum - 1).toString());
                                                                } else {
                                                                  cartController.removeItemFromCart(
                                                                      productId: product.id.toString(), context: context);
                                                                }
                                                              },
                                                              style: IconButton.styleFrom(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(2)),
                                                                backgroundColor: AppTheme.buttonColor,
                                                              ),
                                                              constraints: const BoxConstraints(minHeight: 0),
                                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                                                              visualDensity: VisualDensity.compact,
                                                              icon: const Icon(
                                                                Icons.remove,
                                                                color: Colors.white,
                                                                size: 20,
                                                              )) :
                                                          IconButton(
                                                              onPressed: () {},
                                                              style: IconButton.styleFrom(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(2)),
                                                                backgroundColor: AppTheme.primaryColor,
                                                              ),
                                                              constraints: const BoxConstraints(minHeight: 0),
                                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                                                              visualDensity: VisualDensity.compact,
                                                              icon: const Icon(
                                                                Icons.remove,
                                                                color: Colors.white,
                                                                size: 20,
                                                              )),
                                                          5.spaceX,
                                                          Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(2),
                                                                // color: Colors.grey,
                                                                border: Border.all(color: Colors.grey.shade800)),
                                                            margin: const EdgeInsets.symmetric(vertical: 6),
                                                            padding: const EdgeInsets.symmetric(horizontal: 15),
                                                            alignment: Alignment.center,
                                                            child: Text(
                                                              product.qty.toString(),
                                                              style: normalStyle,
                                                            ),
                                                          ),
                                                          5.spaceX,
                                                          IconButton(
                                                              onPressed: () {
                                                                if (product.qty.toString().toNum <
                                                                    product.inStock.toString().toNum) {
                                                                  cartController.updateCartQuantity(
                                                                      context: context,
                                                                      productId: product.id.toString(),
                                                                      quantity: (product.qty.toString().toNum + 1).toString());
                                                                }else{
                                                                  showToastCenter("Out Of Stock".tr);
                                                                }
                                                              },
                                                              style: IconButton.styleFrom(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(2)),
                                                                backgroundColor: AppTheme.buttonColor,
                                                              ),
                                                              constraints: const BoxConstraints(minHeight: 0),
                                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                                                              visualDensity: VisualDensity.compact,
                                                              icon: const Icon(
                                                                Icons.add,
                                                                color: Colors.white,
                                                                size: 20,
                                                              )),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    showDialog<String>(
                                                        context: context,
                                                        builder: (BuildContext context) => AlertDialog(
                                                      title: const Text('Remove Cart'),
                                                      content: const Text('Do You Want To Remove From Your Cart.'),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          onPressed: () => Get.back(),
                                                          child: const Text('Cancel'),
                                                        ),
                                                        TextButton(
                                                          onPressed: () async {
                                                            Get.back();
                                                            cartController.removeItemFromCart(
                                                                productId: product.id.toString(), context: context);
                                                          },
                                                          child: const Text('OK'),
                                                        ),
                                                      ],
                                                    ));
                                                  },
                                                  visualDensity: VisualDensity.compact,
                                                  icon: SvgPicture.asset(
                                                    "assets/svgs/delete.svg",
                                                    height: 18,
                                                    width: 18,
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ))).toList()


                        // slivers: List.generate(cartController.cartModel.cart!.carsShowroom!.length, (i) {
                        //   List<SellersData> items = cartController.cartModel.cart!.getAllProducts[i];
                        //   return SliverList(
                        //       delegate: SliverChildBuilderDelegate(
                        //     childCount: items.length,
                        //     (context, ii) {
                        //       SellersData product = items[ii];
                        //       return Container(
                        //         decoration: BoxDecoration(
                        //           color: Colors.white,
                        //           border: ii != items.length - 1
                        //               ? const Border(bottom: BorderSide(color: Color(0xffD9D9D9)))
                        //               : null,
                        //         ),
                        //         margin: EdgeInsets.only(top: ii == 0 ? 16 : 0),
                        //         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        //         child: Column(
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           children: [
                        //             if (ii == 0)
                        //               Padding(
                        //                 padding: const EdgeInsets.only(bottom: 16),
                        //                 child: Text(
                        //                   "${'Sold By'.tr} ${product.storeName}",
                        //                   style: titleStyle,
                        //                 ),
                        //               ),
                        //             IntrinsicHeight(
                        //               child: Row(
                        //                 crossAxisAlignment: CrossAxisAlignment.start,
                        //                 children: [
                        //                   Container(
                        //                     width: 75,
                        //                     height: 75,
                        //                     decoration: BoxDecoration(
                        //                       borderRadius: BorderRadius.circular(12),
                        //                     ),
                        //                     child: ClipRRect(
                        //                       borderRadius: BorderRadius.circular(12),
                        //                       child: Image.network(
                        //                         product.featuredImage.toString(),
                        //                         fit: BoxFit.contain,
                        //                         errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                   const SizedBox(
                        //                     width: 16,
                        //                   ),
                        //                   Expanded(
                        //                     child: Column(
                        //                       crossAxisAlignment: CrossAxisAlignment.start,
                        //                       // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //                       children: [
                        //                         Text(
                        //                           product.pName.toString(),
                        //                           style: titleStyle.copyWith(fontWeight: FontWeight.w400),
                        //                           textAlign: TextAlign.start,
                        //                         ),
                        //                         const SizedBox(
                        //                           height: 6,
                        //                         ),
                        //                         Text(
                        //                           '\$${product.sPrice}',
                        //                           style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w400),
                        //                         ),
                        //                         const SizedBox(
                        //                           height: 4,
                        //                         ),
                        //                         IntrinsicHeight(
                        //                           child: Row(
                        //                             children: [
                        //                               IconButton(
                        //                                   onPressed: () {
                        //                                     if (product.qty.toString().toNum > 1) {
                        //                                       cartController.updateCartQuantity(
                        //                                           context: context,
                        //                                           productId: product.id.toString(),
                        //                                           quantity: (product.qty.toString().toNum - 1).toString());
                        //                                     } else {
                        //                                       cartController.removeItemFromCart(
                        //                                           productId: product.id.toString(), context: context);
                        //                                     }
                        //                                   },
                        //                                   style: IconButton.styleFrom(
                        //                                     shape: RoundedRectangleBorder(
                        //                                         borderRadius: BorderRadius.circular(2)),
                        //                                     backgroundColor: AppTheme.buttonColor,
                        //                                   ),
                        //                                   constraints: const BoxConstraints(minHeight: 0),
                        //                                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                        //                                   visualDensity: VisualDensity.compact,
                        //                                   icon: const Icon(
                        //                                     Icons.remove,
                        //                                     color: Colors.white,
                        //                                     size: 20,
                        //                                   )),
                        //                               5.spaceX,
                        //                               Container(
                        //                                 decoration: BoxDecoration(
                        //                                     borderRadius: BorderRadius.circular(2),
                        //                                     // color: Colors.grey,
                        //                                     border: Border.all(color: Colors.grey.shade800)),
                        //                                 margin: const EdgeInsets.symmetric(vertical: 6),
                        //                                 padding: const EdgeInsets.symmetric(horizontal: 15),
                        //                                 alignment: Alignment.center,
                        //                                 child: Text(
                        //                                   product.qty.toString(),
                        //                                   style: normalStyle,
                        //                                 ),
                        //                               ),
                        //                               5.spaceX,
                        //                               IconButton(
                        //                                   onPressed: () {
                        //                                     if (product.qty.toString().toNum <
                        //                                         product.stockAlert.toString().toNum) {
                        //                                       cartController.updateCartQuantity(
                        //                                           context: context,
                        //                                           productId: product.id.toString(),
                        //                                           quantity: (product.qty.toString().toNum + 1).toString());
                        //                                     }
                        //                                   },
                        //                                   style: IconButton.styleFrom(
                        //                                     shape: RoundedRectangleBorder(
                        //                                         borderRadius: BorderRadius.circular(2)),
                        //                                     backgroundColor: AppTheme.buttonColor,
                        //                                   ),
                        //                                   constraints: const BoxConstraints(minHeight: 0),
                        //                                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                        //                                   visualDensity: VisualDensity.compact,
                        //                                   icon: const Icon(
                        //                                     Icons.add,
                        //                                     color: Colors.white,
                        //                                     size: 20,
                        //                                   )),
                        //                             ],
                        //                           ),
                        //                         )
                        //                       ],
                        //                     ),
                        //                   ),
                        //                   IconButton(
                        //                       onPressed: () {
                        //                         cartController.removeItemFromCart(
                        //                             productId: product.id.toString(), context: context);
                        //                       },
                        //                       visualDensity: VisualDensity.compact,
                        //                       icon: SvgPicture.asset(
                        //                         "assets/svgs/delete.svg",
                        //                         height: 18,
                        //                         width: 18,
                        //                       ))
                        //                 ],
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       );
                        //     },
                        //   ));
                        // }),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/cart_img.png',width: 173,height: 200,),
                          Center(
                            child: Text(
                              "${'Your cart is currently empty'.tr}\n"
                              "Checkout products to added them in cart".tr,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: AppTheme.buttonColor
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child:  Text("Continue shopping".tr,style: const TextStyle(
                                  color: Colors.white
                                ),)),
                          ),
                        ],
                      )
                : const LoadingAnimation();
          }),
        ),
        bottomNavigationBar: Obx(() {
          if (cartController.refreshInt.value > 0) {}
          return cartController.apiLoaded
              ? cartController.cartModel.cart!.carsShowroom!.isNotEmpty
                  ? GestureDetector(
                      onTap: () {
                        Get.toNamed(CheckOutScreen.route);
                      },
                      behavior: HitTestBehavior.translucent,
                      child: Container(
                        height: 63,
                        decoration: const BoxDecoration(color: Color(0xff014E70)),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                          child: Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                                          padding: const EdgeInsets.fromLTRB(20, 7, 20, 7),
                                          child: Text(
                                            cartController.cartModel.totalProducts.toString(),
                                            style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 18),
                                          )),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text("KWD ${'cartController.cartModel.subtotal'}",
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white)),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text("Checkout".tr,
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white)),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Image(
                                      height: 25,
                                      image: AssetImage(
                                        'assets/icons/whishlist.png',
                                      ),
                                      color: Colors.white,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink()
              : const SizedBox.shrink();
        }));
  }

  AppBar customAppBar({required String title}) {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 0,
      leading: IconButton(
          icon: Image.asset(
        'assets/icons/backicon.png',
        height: 25,
        width: 25,
      ),
        onPressed: () => Get.back(),
      ),
      titleSpacing: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title.tr,
            style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 22),
          ),
        ],
      ),
    );
  }
}
