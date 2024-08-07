import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/cart_controller.dart';
import '../screens/check_out/add_bag_screen.dart';
import 'common_colour.dart';

class CartBagCard extends StatefulWidget {
  const CartBagCard({Key? key, this.isBlackTheme}) : super(key: key);
  final bool? isBlackTheme;

  @override
  State<CartBagCard> createState() => _CartBagCardState();
}

class _CartBagCardState extends State<CartBagCard> {
  final cartController = Get.put(CartController());
  String totalProducts = '0';
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (cartController.refreshInt.value > 0) {}
      if(cartController.apiLoaded == true) {
       totalProducts = cartController.cartModel.totalProducts ?? '0';
      }
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          cartController.getCart();
          Get.toNamed(BagsScreen.route);

        },
        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 15,bottom: 10),
          child:      Stack(children:[
            totalProducts.length != 1 ?  SvgPicture.asset("assets/svgs/cart_new.svg",
              width: 32,
              height: 32,
              // color: widget.isBlackTheme == true ? Colors.white : AppTheme.buttonColor,
            ):
            SvgPicture.asset("assets/svgs/bag_2digit.svg",
              width: 32,
              height: 32,
              // color: widget.isBlackTheme == true ? Colors.white : AppTheme.buttonColor,
            ),
            cartController.apiLoaded
              ? Positioned.fill(
            bottom: 0,
            left:  totalProducts.length != 1 ?  15 : 13,
            top: totalProducts.length != 1 ? 15 : 15,
            child: Center(
              child: Text(
                key: ValueKey(DateTime.now().millisecondsSinceEpoch),
                  cartController.cartModel.cart == null ? '0' :   cartController.cartModel.totalProducts.toString(),
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(color: widget.isBlackTheme == true ? Colors.white :Colors.white, fontSize: 8),
              ).animate().scale(duration: 200.ms),
            ),
          )
              : const SizedBox(),]),
        ),
      );
    });
  }
}
