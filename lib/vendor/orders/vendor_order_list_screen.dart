import 'dart:convert';
import 'package:dirise/repository/repository.dart';
import 'package:dirise/utils/api_constant.dart';
import 'package:dirise/utils/helper.dart';
import 'package:dirise/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/vendor_controllers/vendor_profile_controller.dart';
import '../../model/vendor_models/model_vendor_orders.dart';
import '../../widgets/common_colour.dart';
import '../../widgets/dimension_screen.dart';
import '../dashboard/sliver_bar.dart';
import '../payment_info/withdrawal_screen.dart';
import 'order_tile.dart';

class VendorOrderList extends StatefulWidget {
  const VendorOrderList({Key? key}) : super(key: key);
  static var route = "/vendorOrderList";

  @override
  State<VendorOrderList> createState() => _VendorOrderListState();
}

class _VendorOrderListState extends State<VendorOrderList> {
  final vendorProfileController = Get.put(VendorProfileController());
  final Repositories repositories = Repositories();
  bool loaded = false;
  bool paginationLoading = false;
  bool allLoaded = false;
  List<OrderData> data = [];
  final ScrollController scrollController = ScrollController();

  final TextEditingController searchController = TextEditingController();
  RxBool isValue = false.obs;
  int page = 1;

  addListener() {
    scrollController.addListener(() {
      if (scrollController.offset > (scrollController.position.maxScrollExtent - 10)) {
        getOrdersList();
      }
    });
  }

  Future getOrdersList({
    bool? reset,
  }) async {
    if (reset == true) {
      allLoaded = false;
      paginationLoading = false;
      page = 1;
    }
    if (allLoaded) return;
    if (paginationLoading == true) return;
    paginationLoading = true;
    String url = "vendor-order?page=$page&pagination=20";
    await repositories.getApi(url: ApiUrls.baseUrl + url).then((value) {
      if (reset == true) {
        data = [];
      }
      loaded = true;
      paginationLoading = false;
      ModelVendorOrders response = ModelVendorOrders.fromJson(jsonDecode(value));
      if (response.order != null) {
        if (response.order!.data != null && response.order!.data!.isNotEmpty) {
          data.addAll(response.order!.data!);
          page++;
        } else {
          allLoaded = false;
        }
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    getOrdersList(reset: true);
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      addListener();
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color(0xff014E70),
                Colors.white,
                Colors.white,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.clamp,
              stops: [.06, .061, 1])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: RefreshIndicator(
          onRefresh: () async {
            await getOrdersList(reset: true);
          },
          child: SafeArea(
            child: CustomScrollView(
              controller: scrollController,
              shrinkWrap: true,
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    decoration: const BoxDecoration(
                        color: AppTheme.buttonColor,
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/images/orderlitscontainer.png',
                          ),
                          fit: BoxFit.cover,
                        )),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: AddSize.padding10),
                      child: Column(
                        children: [
                          Row(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: Image.asset('assets/images/back_icon_new.png',
                                    color : Colors.white,
                                  height: 20,
                                  width: 20,
                                )
                              ),
                              // addWidth(20),
                              Text(
                                'Orders List'.tr,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(.1),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: Colors.white24),
                              ),
                              margin: const EdgeInsets.symmetric(horizontal: 16),
                              child: Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Obx(() {
                                            if (vendorProfileController.refreshInt.value > 0) {}
                                      
                                            return Text(
                                              vendorProfileController.model.user != null
                                                  ? "kwd${vendorProfileController.model.user!.earnedBalance.toString()}"
                                                  : "",
                                              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                                  fontWeight: FontWeight.w600, fontSize: 28, color: Colors.white),
                                            );
                                          }),
                                          SizedBox(
                                            height: AddSize.size5,
                                          ),
                                          Text(
                                            "Your earning this month".tr,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                                fontWeight: FontWeight.w400,
                                                fontSize: AddSize.font14,
                                                color: Colors.white),
                                          ),

                                        ],
                                      ),
                                    ),
                                    4.spaceX,
                                    // GestureDetector(
                                    //   onTap: () {
                                    //     Get.toNamed(WithdrawMoney.route);
                                    //   },
                                    //   child: Container(
                                    //       padding: EdgeInsets.symmetric(
                                    //           horizontal: AddSize.padding20, vertical: AddSize.padding12),
                                    //       decoration: BoxDecoration(
                                    //           color: Colors.white, borderRadius: BorderRadius.circular(10)),
                                    //       child: Text(
                                    //         "Withdrawal".tr,
                                    //         style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                    //             fontWeight: FontWeight.w600,
                                    //             fontSize: AddSize.font16,
                                    //             color: AppTheme.buttonColor),
                                    //       )),
                                    // )
                                  ],
                                ),
                              )),
                          const SizedBox(
                            height: 16,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: TextField(
                              // onTap: (){
                              //   vendorOrderListController.searchController.value=vendorOrderListController.model.value.data.orderList.length;
                              // },
                              maxLines: 1,
                              // controller:
                              // vendorOrderListController.searchController,
                              style: GoogleFonts.poppins(
                                fontSize: 17,
                                color: Colors.white,
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              textInputAction: TextInputAction.search,
                              onSubmitted: (value) {},
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(.1),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white.withOpacity(.2)),
                                      borderRadius: const BorderRadius.all(Radius.circular(6))),
                                  enabled: true,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white.withOpacity(.2)),
                                      borderRadius: const BorderRadius.all(Radius.circular(6))),
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: AddSize.padding20, vertical: AddSize.padding10),
                                  hintText: 'Search'.tr,
                                  hintStyle: GoogleFonts.poppins(
                                      fontSize: AddSize.font16, color: Colors.white, fontWeight: FontWeight.w400)),
                            ),
                          ),
                          SizedBox(
                            height: AddSize.size12,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const LatestSalesAppBar(),
                if (loaded)
                  SliverList.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final order = data[index];
                        return OrderTile(
                          order: order,
                        );
                      })
                else
                  const SliverToBoxAdapter(
                    child: LoadingAnimation(),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
