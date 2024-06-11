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
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (cartController.refreshInt.value > 0) {}
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          Get.toNamed(BagsScreen.route);

        },
        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 15,bottom: 10),
          child:      Stack(children:[
            SvgPicture.asset("assets/svgs/cart_new.svg",
              width: 35,
              height: 35,
              // color: widget.isBlackTheme == true ? Colors.white : AppTheme.buttonColor,
            ),
            cartController.apiLoaded
              ? Positioned(
            right: 5,
            top: 7,
            child: Text(
              key: ValueKey(DateTime.now().millisecondsSinceEpoch),
              cartController.cartModel.totalProducts.toString(),
              style: GoogleFonts.poppins(color: widget.isBlackTheme == true ? Colors.white :Colors.white, fontSize: 11),
            ).animate().scale(duration: 200.ms),
          )
              : const SizedBox(),]),
        ),
      );
    });
  }
}
