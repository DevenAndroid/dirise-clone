import 'dart:convert';

import 'package:dirise/repository/repository.dart';
import 'package:dirise/screens/order_screens/selectd_order_screen.dart';
import 'package:dirise/utils/api_constant.dart';
import 'package:dirise/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../controller/profile_controller.dart';
import '../../language/app_strings.dart';
import '../../model/model_all_order.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});
  static var route = "/myOrdersScreen";

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  final Repositories repositories = Repositories();
  ModelDataOrder ordersList = ModelDataOrder();

  Future getOrdersList() async {
    await repositories.postApi(url: ApiUrls.myOrdersListUrl).then((value) {
      ordersList = ModelDataOrder.fromJson(jsonDecode(value));
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    getOrdersList();
  }
  final profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xffEBF1F4).withOpacity(.7),
          surfaceTintColor: Colors.white,
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
          titleSpacing: 0,
          title: Text(
            AppStrings.order.tr,
            style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 22),
          ),
        ),
        body: ordersList.order != null
            ? ordersList.order!.isNotEmpty
                ? RefreshIndicator(
                    onRefresh: () async {
                      await getOrdersList();
                    },
                    child: ListView.builder(
                        itemCount: ordersList.order!.length,
                        padding: const EdgeInsets.all(20),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          final order = ordersList.order![index];
                          return Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xffD9D9D9).withOpacity(.7), width: 1.3),
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.all(15),
                            margin: const EdgeInsets.only(bottom: 20),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 40,
                                      width: 40,
                                      child: Image.network(
                                        order.quantity.toString(),
                                        errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // Text(
                                          //   "${order.totalPrice.toString()} ${order.currencyCode.toString().toUpperCase()}",
                                          //   style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 17),
                                          // ),
                                          Text(
                                            order.productName.toString(),
                                            style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 17),
                                          ),
                                          Text(
                                            "#${order.orderId.toString()}",
                                            style: GoogleFonts.poppins(
                                                color: const Color(0xffA6A6A6), fontWeight: FontWeight.w400, fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Get.to(SelectedOrderScreen(modelDataOrder: order,));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: const Color(0xffE8E8E8).withOpacity(.6),
                                            borderRadius: BorderRadius.circular(22)),
                                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                                        child: Text(
                                          AppStrings.view.tr,
                                          style: GoogleFonts.poppins(
                                              fontSize: 16, fontWeight: FontWeight.w500, color: const Color(0xff014E70)),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 5, bottom: 4),
                                  child: Divider(
                                    thickness: .5,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      order.status.toString().capitalize!,
                                      style: GoogleFonts.poppins(
                                          color: order.status == 'payment failed'? Colors.red :const Color(0xff616161),
                                          fontWeight: FontWeight.w400, fontSize: 16),
                                    ),
                                    Expanded(
                                      child: Text(
                                        order.createdAtDateTime != null
                                            ? DateFormat("dd-MM-yyyy").format(order.createdAtDateTime!)
                                            : "",
                                        textAlign: TextAlign.end,
                                        style: GoogleFonts.poppins(
                                            color: const Color(0xff616161), fontWeight: FontWeight.w400, fontSize: 16),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        }),
                  )
                : Center(
                    child: Text(
                      AppStrings.notOrdered.tr,
                      style: normalStyle,
                    ),
                  )
            : const Center(
                child: CircularProgressIndicator.adaptive(),
              ));
  }
}
