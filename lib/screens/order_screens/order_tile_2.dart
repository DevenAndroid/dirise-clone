import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../model/vendor_models/model_vendor_orders.dart';
import '../../vendor/orders/orderdetailsscreen.dart';
import '../../widgets/dimension_screen.dart';

class OrderTile1 extends StatelessWidget {
  const OrderTile1({super.key, required this.order});
  final OrderData order;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.to(()=> OrderDetails(orderId: order.orderId.toString(),));
        log('order detailssss${order.toJson()}');
      },
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(
              height: AddSize.size5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        "#${order.orderId.toString()}",
                        style: GoogleFonts.poppins(
                            color: const Color(0xFF454B5C),
                            height: 1.5,
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      if (DateTime.tryParse(
                          order.updatedAt.toString()) !=
                          null)
                        Text(
                          DateFormat("HH:mm a - dd MMM, yyyy")
                              .format(DateTime.tryParse(
                              order.updatedAt.toString())!),
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: const Color(0xFF8C9BB2)),
                        ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    order.status.toString().capitalize!,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color:   order.status == 'payment failed' ? Colors.red : const Color(0xFFFFB26B)),
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    "kwd${order.totalPrice}",
                    textAlign: TextAlign.end,
                    style: GoogleFonts.poppins(
                        height: 1.5,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: const Color(0xFF454B5C)),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: AddSize.size5,
            ),
            const Divider(
              color: Color(0xffEFEFEF),
            ),
          ],
        ),
      ),
    );
  }
}
