import 'dart:convert';
import 'package:dirise/model/common_modal.dart';
import 'package:dirise/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../controller/profile_controller.dart';
import '../../model/model_all_order.dart';
import '../../model/model_single_product.dart';
import '../../model/order_models/model_single_order_response.dart';
import '../../model/product_model/model_product_element.dart';
import '../../repository/repository.dart';
import '../../utils/api_constant.dart';
import '../../utils/styles.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_colour.dart';
import '../product_details/single_product.dart';
import '../virtual_assets/virtual_assets_screen.dart';

class SelectedOrderScreen extends StatefulWidget {
  Order? modelDataOrder;

  SelectedOrderScreen({super.key, this.modelDataOrder});

  static var route = "/selectedOrderScreen";

  @override
  State<SelectedOrderScreen> createState() => _SelectedOrderScreenState();
}

class _SelectedOrderScreenState extends State<SelectedOrderScreen> {
  final Repositories repositories = Repositories();

  // String orderId = "";
  ModelSingleOrderResponse singleOrder = ModelSingleOrderResponse();
  ModelSingleProduct modelSingleProduct = ModelSingleProduct();

  Future getOrderDetails() async {
    await repositories.postApi(url: ApiUrls.orderDetailsUrl, mapData: {
      "order_id": widget.modelDataOrder!.orderId,
    },showResponse: true).then((value) {
      singleOrder = ModelSingleOrderResponse.fromJson(jsonDecode(value));
      setState(() {});
    });
  }

  Future returnRequest() async {
    await repositories.postApi(url: ApiUrls.returnRequest, mapData: {
      "order_id": widget.modelDataOrder!.orderId,
      'product_id': widget.modelDataOrder!.productId,
      'reason': _selectedReason.value.toString(),
    }).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToastCenter(response.message.toString());
      setState(() {});
    });
  }

  Rx<String> _selectedReason = 'Defective item'.obs;

  final List<String> _reasons = [
    'Defective item',
    'Wrong product shipped',
    'Arrived too late',
    'Item does not match the description',
    'Wrong item delivered',
    'Bad customer support',
  ];

  @override
  void initState() {
    super.initState();
    getOrderDetails();
    // if (Get.arguments != null) {
    //   orderId = Get.arguments;
    //
    // }
  }

  final profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Order Details".tr,
              style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 22),
            ),
          ],
        ),
      ),
      body: singleOrder.order != null
          ? RefreshIndicator(
        onRefresh: () async {
          await getOrderDetails();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "${'Order'.tr}: #" + widget.modelDataOrder!.orderId.toString(),
                    style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                ),
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: singleOrder.order!.orderItem!.length,
                        (context, index) {
                      final item = singleOrder.order!.orderItem![index];
                      return GestureDetector(
                        onTap: () {
                          repositories.postApi(
                              url: ApiUrls.singleProductUrl,
                              mapData: {"id": item.productId.toString()}).then((value) {
                            modelSingleProduct = ModelSingleProduct.fromJson(jsonDecode(value));
                            if (modelSingleProduct.product != null) {
                              // log("modelSingleProduct.product!.toJson().....      ${modelSingleProduct.product!.toJson()}");
                              bottomSheet(productDetails: modelSingleProduct.product!, context: context);
                            }
                            setState(() {});
                          });
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            border: Border(bottom: BorderSide(color: Color(0xffD9D9D9))),
                          ),
                          padding: const EdgeInsets.only(bottom: 12, top: 12),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: const Color(0xffEEEEEE),
                                child: Text("${item.quantity.toString()}x"),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Image.network(
                                height: size.height * .12,
                                width: size.height * .12,
                                item.featuredImage.toString(),
                                errorBuilder: (_, __, ___) =>
                                    Image.asset("assets/images/new_logo.png",
                                        height: size.height * .12,
                                        width: size.height * .12),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.productName.toString(),
                                      style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 14),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      'KWD ${item.productPrice}',
                                      style: GoogleFonts.poppins(
                                          fontSize: 14, fontWeight: FontWeight.w500, color: const Color(0xff014E70)),
                                    ),
                                    if (item.orderTrackData != null) ...[
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      item.productPrice == 0?
                                        SizedBox.shrink():
                                      Text(
                                        '${item.orderTrackData!
                                            .reversed
                                            .toList()
                                            .firstWhere((element) => element.completed.toString() == "true",
                                            orElse: () => OrderTrackData(title: "Order Placed"))
                                            .title
                                            .toString()
                                            .capitalize}',
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xff014E70)),
                                      ),

                                    ],
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      '${item.quantity.toString()} ${'piece'.tr}',
                                      style: GoogleFonts.poppins(color: const Color(0xff858484)),
                                    ),
                                    const SizedBox(
                                      height: 14,
                                    ),
                                    item.isReturnExpire == true ?
                                    InkWell(
                                      onTap: () {
                                        bottomSheetReturn();

                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: AppTheme.newPrimaryColor,
                                            borderRadius: BorderRadius.circular(22)),
                                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                                        child: Text(
                                          'Return',
                                          style: GoogleFonts.poppins(
                                              fontSize: 16, fontWeight: FontWeight.w500, color: const Color(0xff014E70)),
                                        ),
                                      ),
                                    ) : const SizedBox.shrink(),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    if (item.isVirtualProduct)
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                Get.toNamed(VirtualAssetsScreen.route);
                                                // if (item.isVirtualProductPDF) {
                                                //   Get.to(() => PDFOpener(
                                                //         pdfUrl: item,
                                                //       ));
                                                // } else {
                                                //   656erwfa
                                                //   print(item.toJson());
                                                //   Get.to(
                                                //       () => SingleCategoryScreen(
                                                //         product: VirtualProductData.fromJson(item.toJson()),
                                                //           ));
                                                // }
                                              },
                                              child: Text(
                                                "View".tr,
                                                style: normalStyle,
                                              )),
                                        ],
                                      ),
                                    if (item.selectedSlotDate.toString() != "" &&
                                        item.selectedSlotStart.toString() != "")
                                      GestureDetector(
                                        behavior: HitTestBehavior.translucent,
                                        onTap: () {
                                          item.showDetails.value = !item.showDetails.value;
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 6),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                    "Booking Details".tr,
                                                    style: normalStyle,
                                                  )),
                                              Obx(() {
                                                return item.showDetails.value
                                                    ? const Icon(
                                                  Icons.keyboard_arrow_down_rounded,
                                                  color: AppTheme.buttonColor,
                                                  size: 22,
                                                )
                                                    : const Icon(
                                                  Icons.arrow_forward_ios_rounded,
                                                  size: 16,
                                                );
                                              }),
                                              const SizedBox(
                                                width: 4,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    Obx(() {
                                      return item.showDetails.value
                                          ? Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                    "${'Date'.tr}: ${item.selectedSlotDate}",
                                                    style: normalStyle,
                                                  )),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                    "${'Time'.tr}: ${item.selectedSlotStart} - ${item.selectedSlotEnd}",
                                                    style: normalStyle,
                                                  )),
                                            ],
                                          ),

                                        ],
                                      )
                                          : const SizedBox.shrink();
                                    }),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Order Date".tr,
                            style: GoogleFonts.poppins(
                                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                          Text(
                            widget.modelDataOrder!.createdAtDateTime != null
                                ? DateFormat("dd-MM-yyyy").format(widget.modelDataOrder!.createdAtDateTime!)
                                : "",
                            style: GoogleFonts.poppins(
                                color: const Color(0xff9B9B9B), fontWeight: FontWeight.w500, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Status".tr,
                            style: GoogleFonts.poppins(
                                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                          Text(
                            singleOrder.order!
                                .status
                                .toString()
                                .capitalize!,
                            style: GoogleFonts.poppins(
                                color: singleOrder.order!.status == 'payment failed'
                                    ? Colors.red
                                    : const Color(0xff9B9B9B),
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Payment".tr,
                            style: GoogleFonts.poppins(
                                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                          Text(
                            "${singleOrder.order!.orderMeta!.totalPrice.toString()} ${singleOrder.order!.orderMeta!
                                .currencySign.toString() == '\$' ? 'kwd' : 'kwd'}",
                            style: GoogleFonts.poppins(
                                color: const Color(0xff9B9B9B), fontWeight: FontWeight.w500, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Delivery".tr,
                            style: GoogleFonts.poppins(
                                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                          Text(
                            '${singleOrder.order!.orderShipping!.shippingPrice.toString()} kwd',

                            style: GoogleFonts.poppins(
                                color: const Color(0xff9B9B9B), fontWeight: FontWeight.w500, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    20.spaceY,
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            offset: const Offset(
                              .1,
                              .1,
                            ),
                            blurRadius: 19.0,
                            spreadRadius: 1.0,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Tracking".tr,
                              style: GoogleFonts.poppins(
                                  color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                            20.spaceY,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Ordered".tr,
                                  style: GoogleFonts.poppins(
                                      color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 15),
                                ),
                                Text(
                                  "Picked".tr,
                                  style: GoogleFonts.poppins(
                                      color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 15),
                                ),
                                Text(
                                  "Shipped".tr,
                                  style: GoogleFonts.poppins(
                                      color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 15),
                                ),
                                Text(
                                  "Delivery".tr,
                                  style: GoogleFonts.poppins(
                                      color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 15),
                                ),
                              ],
                            ),
                            20.spaceY,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                3.spaceY,
                                CircleAvatar(
                                  backgroundColor: widget.modelDataOrder!.status == 'order placed'
                                      ? AppTheme.buttonColor
                                      : Colors.red,
                                  radius: 8,
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 7, right: 8),
                                    color: AppTheme.buttonColor,
                                    height: 2,
                                  ),
                                ),
                                CircleAvatar(
                                  backgroundColor: widget.modelDataOrder!.status == 'shipped'
                                      ? AppTheme.buttonColor
                                      : Colors.red,
                                  radius: 8,
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 7, right: 8),
                                    color: AppTheme.buttonColor,
                                    height: 2,
                                  ),
                                ),
                                CircleAvatar(
                                  backgroundColor: widget.modelDataOrder!.status == 'out of delivery'
                                      ? AppTheme.buttonColor
                                      : Colors.red,
                                  radius: 8,
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 7, right: 8),
                                    color: AppTheme.buttonColor,
                                    height: 2,
                                  ),
                                ),
                                CircleAvatar(
                                  backgroundColor: widget.modelDataOrder!.status == 'delivered'
                                      ? AppTheme.buttonColor
                                      : Colors.red,
                                  radius: 8,
                                ),
                              ],
                            ),
                            10.spaceY,
                          ],
                        ),
                      ),
                    ),

                    50.spaceY,
                  ],
                ),
              ),
            ],
          ),
        ),
      )
          : const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
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

  Future bottomSheetReturn() {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        constraints: BoxConstraints(maxHeight: context.getSize.height * .9, minHeight: context.getSize.height * .4),
        builder: (context) {
          return Obx(() {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: _reasons.map((reason) {
                return RadioListTile<String>(
                  title: Text(reason),
                  value: reason,
                  groupValue: _selectedReason.value,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedReason.value = value!;
                      returnRequest();
                      Get.back();
                    });
                  },
                );
              }).toList(),
            );
          });
        });
  }
}
