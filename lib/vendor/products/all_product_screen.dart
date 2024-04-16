import 'dart:async';
import 'package:dirise/repository/repository.dart';
import 'package:dirise/utils/helper.dart';
import 'package:dirise/utils/shimmer_extension.dart';
import 'package:dirise/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/vendor_controllers/add_product_controller.dart';
import '../../controller/vendor_controllers/products_controller.dart';
import '../../widgets/common_colour.dart';
import '../../widgets/dimension_screen.dart';
import 'add_product/add_product_screen.dart';

class VendorProductScreen extends StatefulWidget {
  static String route = "/VendorProductScreen";

  const VendorProductScreen({Key? key}) : super(key: key);

  @override
  State<VendorProductScreen> createState() => _VendorProductScreenState();
}

class _VendorProductScreenState extends State<VendorProductScreen> {
  final productController = Get.put(ProductsController());

  final controller = Get.put(AddProductController(),permanent: true);
  final Repositories repositories = Repositories();

  Timer? timer;

  debounceSearch() {
    if (timer != null) timer!.cancel();
    timer = Timer(const Duration(milliseconds: 500), () {
      productController.getProductList();
    });
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      productController.getProductList();
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (timer != null) {
      timer!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF4F4F4),
        appBar: AppBar(
          title: Text('All Product'.tr,
              style: GoogleFonts.poppins(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: const Color(0xff423E5E),
              )),
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Image.asset(
                'assets/icons/backicon.png',
                height: 20,
              ),
            ),
          ),
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding10),
            child: Column(children: [
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        decoration:
                            BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10), boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade300,
                              // offset: Offset(2, 2),
                              blurRadius: 05)
                        ]),
                        child: TextField(
                          controller: productController.textEditingController,
                          maxLines: 1,
                          style: GoogleFonts.poppins(fontSize: 17),
                          textAlignVertical: TextAlignVertical.center,
                          textInputAction: TextInputAction.search,
                          onChanged: (value) {
                            debounceSearch();
                          },
                          decoration: InputDecoration(
                              filled: true,
                              suffixIcon: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.search,
                                  color: AppTheme.lightblack,
                                  size: AddSize.size25,
                                ),
                              ),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(10))),
                              fillColor: Colors.white,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: AddSize.padding20, vertical: AddSize.padding10),
                              hintText: 'Search Products'.tr,
                              hintStyle: GoogleFonts.poppins(
                                  fontSize: AddSize.font16, color: Colors.black, fontWeight: FontWeight.w400)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(()=> const AddProductScreen());
                      },
                      child: Container(
                        height: AddSize.size20 * 2.5,
                        width: AddSize.size20 * 2.5,
                        decoration: BoxDecoration(
                          color: AppTheme.buttonColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                            child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: AddSize.size25,
                        )),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await productController.getProductList();
                  },
                  child: Obx(() {
                    if (productController.refreshInt.value > 0) {}
                    return ListView.builder(
                      itemCount: productController.apiLoaded
                          ? productController.model.product!.isEmpty
                              ? 1
                              : productController.model.product!.length
                          : 5,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        if (!productController.apiLoaded) {
                          return shimmerLoader(index);
                        }
                        if (productController.model.product!.isEmpty) {
                          return  Center(
                            child: Text("No Product Added".tr),
                          );
                        }
                        final item = productController.model.product![index];
                        return Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding10),
                                  child: Row(children: [
                                    SizedBox(
                                        height: AddSize.size80,
                                        width: AddSize.size80,
                                        child: Image.network(item.featuredImage ?? "")),
                                    SizedBox(
                                      width: AddSize.size10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  item.pname ?? "${'Product'.tr} ${item.id}",
                                                  style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Get.to(()=> AddProductScreen(productId: (item.id ?? "").toString(),));
                                                },
                                                child: Container(
                                                    height: AddSize.size25,
                                                    width: AddSize.size25,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(40),
                                                        border: Border.all(color: AppTheme.buttonColor)),
                                                    child: Center(
                                                      child: Icon(
                                                        Icons.edit,
                                                        color: AppTheme.buttonColor,
                                                        size: AddSize.size15,
                                                      ),
                                                    )),
                                              ),
                                              10.spaceX,
                                              GestureDetector(
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context1) {
                                                        return AlertDialog(
                                                          title: Text(
                                                            "Are you sure you want to delete this product?".tr,
                                                            style: titleStyle,
                                                          ),
                                                          actions: [
                                                            ElevatedButton(
                                                                onPressed: () {
                                                                  Get.back();
                                                                },
                                                                child:  Text("Cancel".tr)),
                                                            ElevatedButton(
                                                                onPressed: () {
                                                                  controller.productId = item.id.toString();
                                                                  controller.deleteProductForAll(context);

                                                                },
                                                                child: Text("Delete".tr)),
                                                          ],
                                                        );
                                                      });
                                                },
                                                child: Container(
                                                    height: AddSize.size25,
                                                    width: AddSize.size25,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(40),
                                                        border: Border.all(color: Colors.red)),
                                                    child: Center(
                                                      child: Icon(
                                                        Icons.delete,
                                                        color: Colors.red,
                                                        size: AddSize.size15,
                                                      ),
                                                    )),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            (item.categoryName ?? "").toString(),
                                            style: normalStyle,
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            '${'QTY'}: ${item.inStock} ${'piece'}',
                                            style: normalStyle,
                                          ),
                                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                            Expanded(
                                              child: Text(
                                                "KWD ${item.sPrice ?? "0"}",
                                                style: GoogleFonts.poppins(
                                                  color: AppTheme.buttonColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                            FlutterSwitch(
                                              showOnOff: true,
                                              width: AddSize.size30 * 2.2,
                                              height: AddSize.size20 * 1.4,
                                              padding: 2,
                                              valueFontSize: AddSize.font12,
                                              activeTextFontWeight: FontWeight.w600,
                                              inactiveText: " Out",
                                              activeText: "  In",
                                              inactiveTextColor: const Color(0xFFEBEBEB),
                                              activeTextColor: const Color(0xFFFFFFFF),
                                              inactiveTextFontWeight: FontWeight.w600,
                                              inactiveColor: Colors.grey.shade400,
                                              activeColor: AppTheme.buttonColor,
                                              onToggle: (val) {
                                                productController.updateProductStatus(
                                                    changed: (bool value1) {
                                                      if (value1 == true) {
                                                        productController.model.product![index].isPublish =
                                                            !productController.model.product![index].isPublish!;
                                                        setState(() {});
                                                      }
                                                    },
                                                    context: context,
                                                    productID: item.id.toString());
                                              },
                                              value: item.isPublish!,
                                            )
                                          ]),
                                          Text(
                                            "${("${item.productType ?? ""}".capitalize!).toString().replaceAll("_product", "").replaceAll("Single", "Simple")} Product",
                                            style: GoogleFonts.poppins(
                                              color: AppTheme.buttonColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ])),
                            ),
                            const SizedBox(
                              height: 14,
                            )
                          ],
                        );
                      },
                    );
                  }),
                ),
              ),
            ])),
    );
  }

  Container shimmerLoader(int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.only(bottom: 14),
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding10),
          child: Row(children: [
            SizedBox(
                height: AddSize.size80,
                width: AddSize.size80,
                child: const Image(
                  image: AssetImage('assets/images/voicebook.png'),
                )).convertToShimmer,
            SizedBox(
              width: AddSize.size10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          'Testate Book'.tr,
                          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
                        ).convertToShimmerWithContainer,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                          height: AddSize.size25,
                          width: AddSize.size25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40), border: Border.all(color: AppTheme.buttonColor)),
                          child: Center(
                            child: Icon(
                              Icons.edit,
                              color: AppTheme.buttonColor,
                              size: AddSize.size15,
                            ),
                          )).convertToShimmer
                    ],
                  ),
                  3.spaceY,
                  Text(
                    'History Logic'.tr,
                    style: GoogleFonts.poppins(
                      color: const Color(0xff676E73),
                      fontSize: 14,
                    ),
                  ).convertToShimmerWithContainer,
                  4.spaceY,
                  Text('5 ${'piece'}',
                      style: GoogleFonts.poppins(
                        color: const Color(0xff676E73),
                        fontSize: 14,
                      )).convertToShimmerWithContainer,
                  4.spaceY,
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text(
                      'KWD 6.350',
                      style: GoogleFonts.poppins(
                        color: AppTheme.buttonColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ).convertToShimmerWithContainer,
                    FlutterSwitch(
                      showOnOff: true,
                      width: AddSize.size30 * 2.2,
                      height: AddSize.size20 * 1.4,
                      padding: 2,
                      valueFontSize: AddSize.font12,
                      activeTextFontWeight: FontWeight.w600,
                      inactiveText: " Out",
                      activeText: "  In",
                      inactiveTextColor: const Color(0xFFEBEBEB),
                      activeTextColor: const Color(0xFFFFFFFF),
                      inactiveTextFontWeight: FontWeight.w600,
                      inactiveColor: Colors.grey.shade400,
                      activeColor: AppTheme.buttonColor,
                      onToggle: (val) {
                        setState(() {
                          // state1 = val;
                        });
                      },
                      value: index.isEven,
                    ).convertToShimmer
                  ])
                ],
              ),
            ),
          ])),
    );
  }
}
