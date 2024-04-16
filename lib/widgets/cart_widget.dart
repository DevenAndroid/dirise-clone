import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
          child: Container(
            alignment: Alignment.center,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: widget.isBlackTheme == true ? AppTheme.buttonColor : Colors.white
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 10,
                ),
                Image(
                  height: 25,
                  image: const AssetImage(
                    'assets/icons/whishlist.png',
                  ),
                  color: widget.isBlackTheme == true ? Colors.white : AppTheme.buttonColor,
                ),
                const SizedBox(
                  width: 5,
                ),
                cartController.apiLoaded
                    ? Text(
                  key: ValueKey(DateTime.now().millisecondsSinceEpoch),
                    cartController.cartModel.totalProducts.toString(),
                        style: GoogleFonts.poppins(color: widget.isBlackTheme == true ? Colors.white : AppTheme.buttonColor, fontSize: 20),
                      ).animate().scale(duration: 200.ms)
                    : const SizedBox(),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
