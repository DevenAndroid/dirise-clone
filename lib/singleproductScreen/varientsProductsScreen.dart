import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dirise/utils/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/vendor_controllers/add_product_controller.dart';
import '../model/common_modal.dart';
import '../model/vendor_models/model_attribute.dart';
import '../model/vendor_models/model_varient.dart';
import '../repository/repository.dart';
import '../utils/api_constant.dart';
import '../utils/notification_service.dart';
import '../utils/styles.dart';
import '../vendor/authentication/image_widget.dart';
import '../vendor/products/add_product/variant_product/varient_product.dart';
import '../widgets/common_colour.dart';
import '../widgets/dimension_screen.dart';
import '../widgets/loading_animation.dart';
import '../widgets/vendor_common_textfield.dart';

class VarientProductsScreen extends StatefulWidget {
  String? productType;
  VarientProductsScreen({super.key, this.productType});

  @override
  State<VarientProductsScreen> createState() => _VarientProductsScreenState();
}

class _VarientProductsScreenState extends State<VarientProductsScreen> {
  final controller = Get.put(AddProductController(), permanent: true);
  final addProductController = Get.put(AddProductController());

  TextEditingController variant_skuController = TextEditingController();
  TextEditingController variant_priceController = TextEditingController();
  TextEditingController variant_stockController = TextEditingController();
  TextEditingController variant_valueController = TextEditingController();
  TextEditingController shortDescriptionController = TextEditingController();
  TextEditingController longDescriptionController = TextEditingController();

  File? image;

  final Repositories repositories = Repositories();
  void initState() {
    super.initState();
    controller.productId = "";
    controller.galleryImages.clear();
    controller.productImage = File("");
    controller.pdfFile = File("");
    controller.addMultipleItems.clear();
    controller.languageController.clear();
    controller.getProductsCategoryList();
    controller.productType = "variants";
    controller.getReturnPolicyData();
    controller.resetValues();
    controller.productDurationValueController.text = "";
    controller.productDurationTypeValue = "";
    controller.valuesAssigned = false;
    controller.apiLoaded = false;
    controller.getProductDetails(idd: addProductController.idProduct.value.toString()).then((value) {
      setState(() {});
    });
    controller.getProductAttributes();
    controller.getTaxData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Variable Product'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Obx(() {
        if (addProductController.refreshInt.value > 0) {}
        return controller.apiLoaded
            ? RefreshIndicator(
                onRefresh: () async {
                  await addProductController.getProductsCategoryList();
                  await addProductController.getTaxData();
                  await addProductController.getProductAttributes();
                },
                child: SingleChildScrollView(
                    child: Form(
                  key: addProductController.formKey,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(children: [
                        Obx(() {
                          if (addProductController.attributeRefresh.value > 0) {}
                          if (addProductController.refreshInt.value > 0) {}
                          if (addProductController.variation.value > 0) {}
                          return addProductController.modelAttributes.data != null
                              ? Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Product Variants",
                                        style: titleStyle,
                                      ),
                                      10.spaceY,
                                      DropdownButtonFormField<AttributeData>(
                                        key: addProductController.attributeListKey,
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        isExpanded: true,
                                        iconDisabledColor: const Color(0xff97949A),
                                        iconEnabledColor: const Color(0xff97949A),
                                        decoration: InputDecoration(
                                          border: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(8)),
                                            borderSide: BorderSide(color: AppTheme.secondaryColor),
                                          ),
                                          enabled: true,
                                          filled: true,
                                          hintText: "Select Variants",
                                          labelStyle: GoogleFonts.poppins(color: Colors.black),
                                          labelText: "Select Variants",
                                          fillColor: const Color(0xffE2E2E2).withOpacity(.35),
                                          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                                          enabledBorder: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(8)),
                                            borderSide: BorderSide(color: AppTheme.secondaryColor),
                                          ),
                                        ),
                                        validator: (gg) {
                                          if (addProductController.attributeList.isEmpty &&
                                              addProductController.addMultipleItems.isEmpty) {
                                            return "Please select variants";
                                          }
                                          return null;
                                        },
                                        items: addProductController.modelAttributes.data!
                                            .map((e) => DropdownMenuItem(value: e, child: Text(e.name.toString())))
                                            .toList(),
                                        onChanged: (value) {
                                          if (value == null) return;
                                          AttributeData kk = value;
                                          for (var element in kk.getAttrvalues!) {
                                            element.aboveParentSlug = kk.slug.toString();
                                          }
                                          addProductController.attributeList.add(kk);
                                          addProductController.attributeList =
                                              addProductController.attributeList.toSet().toList();
                                          setState(() {});
                                        },
                                      ),
                                      10.spaceY,
                                      Text(
                                        "Product Variants",
                                        style: titleStyle,
                                      ),
                                      5.spaceY,
                                      Column(
                                        key: addProductController.attributeEmptyListKey,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: addProductController.attributeList
                                            .map((e) => Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            e.name.toString().capitalize!,
                                                            style: normalStyle,
                                                          ),
                                                        ),
                                                        IconButton(
                                                            onPressed: () {
                                                              addProductController.attributeList.remove(e);
                                                              if (addProductController.attributeList
                                                                  .map((e) => e.getAttrvalues!
                                                                      .map((e2) => e2.selectedVariant)
                                                                      .toList()
                                                                      .contains(true))
                                                                  .toList()
                                                                  .contains(true)) {
                                                                addProductController.filterClearAttributes();
                                                                combinations(addProductController.attributeList
                                                                        .map((e) => e.getAttrvalues!
                                                                            .where((element) =>
                                                                                element.selectedVariant == true)
                                                                            .toList())
                                                                        .toList())
                                                                    .forEach((element) {
                                                                  log(element
                                                                      .map((e) => e.aboveParentSlug)
                                                                      .toList()
                                                                      .toString());
                                                                  Map<String, GetAttrvalues> tempMap = {};
                                                                  for (var element1 in element) {
                                                                    tempMap[element1.aboveParentSlug] = element1;
                                                                  }
                                                                  addProductController.addMultipleItems
                                                                      .add(AddMultipleItems(
                                                                    attributes: tempMap,
                                                                  ));
                                                                });
                                                                setState(() {});
                                                              } else {
                                                                addProductController.filterClearAttributes();
                                                              }
                                                              setState(() {});
                                                            },
                                                            visualDensity: VisualDensity.compact,
                                                            icon: const Icon(Icons.clear))
                                                      ],
                                                    ),
                                                    // SizedBox(
                                                    //   height: ,
                                                    // ),
                                                    Wrap(
                                                      spacing: 6,
                                                      children: e.getAttrvalues!
                                                          .map((e2) => FilterChip(
                                                              label: Text(e2.attrValueName.toString().capitalize!),
                                                              selected: e2.selectedVariant,
                                                              onSelected: (va) {
                                                                e2.selectedVariant = !e2.selectedVariant;
                                                                setState(() {});
                                                              }))
                                                          .toList(),
                                                    ),
                                                  ],
                                                ))
                                            .toList(),
                                      ),
                                      if (addProductController.attributeList
                                          .map((e) =>
                                              e.getAttrvalues!.map((e2) => e2.selectedVariant).toList().contains(true))
                                          .toList()
                                          .contains(true))
                                        Padding(
                                          padding: const EdgeInsets.only(top: 6),
                                          child: ElevatedButton(
                                              key: addProductController.createAttributeButton,
                                              onPressed: () {
                                                addProductController.filterClearAttributes();
                                                List<Map<String, GetAttrvalues>> previousList = [];
                                                for (var element in addProductController.addMultipleItems) {
                                                  Map<String, GetAttrvalues> tempMap1 = {};
                                                  if (element.attributes != null) {
                                                    for (var element1 in element.attributes!.entries) {
                                                      tempMap1[element1.key] = element1.value;
                                                    }
                                                  }

                                                  log(tempMap1.toSimpleMap.toString());
                                                  previousList.add(tempMap1);
                                                }
                                                combinations(addProductController.attributeList
                                                        .map((e) => e.getAttrvalues!
                                                            .where((element) => element.selectedVariant == true)
                                                            .toList())
                                                        .toList())
                                                    .forEach((element) {
                                                  log(element.map((e) => e.aboveParentSlug).toList().toString());
                                                  Map<String, GetAttrvalues> tempMap = {};
                                                  for (var element1 in element) {
                                                    tempMap[element1.aboveParentSlug] = element1;
                                                  }
                                                  for (var element2 in previousList) {
                                                    log(element2.toSimpleMap.toString());
                                                    log(tempMap.toSimpleMap.toString());
                                                  }
                                                  if (!previousList
                                                      .map((e) => mapEquals(e.toSimpleMap, tempMap.toSimpleMap))
                                                      .toList()
                                                      .contains(true)) {
                                                    addProductController.addMultipleItems.add(AddMultipleItems(
                                                      attributes: tempMap,
                                                    ));
                                                  }
                                                });
                                                setState(() {});
                                              },
                                              style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                backgroundColor: AppTheme.buttonColor,
                                                surfaceTintColor: AppTheme.buttonColor,
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      child: Text(
                                                    "Create Variations",
                                                    textAlign: TextAlign.center,
                                                    style: titleStyle.copyWith(color: Colors.white),
                                                  )),
                                                ],
                                              )),
                                        ),
                                      Column(
                                        children: addProductController.addMultipleItems
                                            .map((e) => Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    8.spaceY,
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            "Variation: \n${e.attributes!.entries.map((e) => "${e.key.capitalizeFirst}: ${e.value.attrValueName.toString().capitalizeFirst}").toList().join("\n")}",
                                                            style: GoogleFonts.poppins(
                                                                fontWeight: FontWeight.w500,
                                                                color: const Color(0xff2F2F2F),
                                                                fontSize: 14),
                                                          ),
                                                        ),
                                                        IconButton(
                                                            onPressed: () {
                                                              addProductController.addMultipleItems.remove(e);
                                                              setState(() {});
                                                            },
                                                            icon: const Icon(Icons.clear))
                                                      ],
                                                    ),
                                                    ImageWidget(
                                                      title: "Variant Image",
                                                      // key: e.variantImageKey,
                                                      file: e.variantImages,
                                                      imageOnly: true,
                                                      filePicked: (File gg) {
                                                        e.variantImages = gg;
                                                      },
                                                      validation: e.variantImages.path.isEmpty,
                                                    ),
                                                    2.spaceY,
                                                    VendorCommonTextfield(
                                                        controller: variant_skuController,
                                                        // key: e.variantSku.getKey,
                                                        hintText: "Variant SKU",
                                                        validator: (value) {
                                                          if (value!.trim().isEmpty) {
                                                            return "Variant sku is required";
                                                          }
                                                          return null;
                                                        }),
                                                    18.spaceY,
                                                    VendorCommonTextfield(
                                                        controller: variant_priceController,
                                                        // key: e.variantPrice.getKey,
                                                        hintText: "Variant Price",
                                                        keyboardType:
                                                            const TextInputType.numberWithOptions(decimal: true),
                                                        validator: (value) {
                                                          if (value!.trim().isEmpty) {
                                                            return "Variant price is required";
                                                          }
                                                          return null;
                                                        }),
                                                    18.spaceY,
                                                    VendorCommonTextfield(
                                                        controller: variant_stockController,
                                                        // key: e.variantStock.getKey,
                                                        keyboardType:
                                                            const TextInputType.numberWithOptions(decimal: true),
                                                        hintText: "Variant Stock",
                                                        validator: (value) {
                                                          if (value!.trim().isEmpty) {
                                                            return "Variant stock is required";
                                                          }
                                                          return null;
                                                        }),
                                                    18.spaceY,
                                                    VendorCommonTextfield(
                                                        controller: shortDescriptionController,
                                                        // key: e.shortDescription.getKey,
                                                        keyboardType:
                                                            const TextInputType.numberWithOptions(decimal: true),
                                                        hintText: "Short Description",
                                                        validator: (value) {
                                                          if (value!.trim().isEmpty) {
                                                            return "Short Description is required";
                                                          }
                                                          return null;
                                                        }),
                                                    18.spaceY,
                                                    VendorCommonTextfield(
                                                        controller: longDescriptionController,
                                                        // key: e.longDescription.getKey,
                                                        keyboardType:
                                                            const TextInputType.numberWithOptions(decimal: true),
                                                        hintText: "Long Description",
                                                        validator: (value) {
                                                          if (value!.trim().isEmpty) {
                                                            return "Long Description is required";
                                                          }
                                                          return null;
                                                        }),
                                                  ],
                                                ))
                                            .toList(),
                                      ),
                                    ],
                                  ),
                                )
                              : const LoadingAnimation();
                        }),
                        ElevatedButton(
                            onPressed: () {
                              addProduct(context: context);
                            },
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.maxFinite, 60),
                                backgroundColor: AppTheme.buttonColor,
                                elevation: 0,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AddSize.size10)),
                                textStyle: GoogleFonts.poppins(fontSize: AddSize.font20, fontWeight: FontWeight.w600)),
                            child: Text(
                              controller.productId.isEmpty ? "Create".tr : "Update".tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(color: Colors.white, fontWeight: FontWeight.w500, fontSize: AddSize.font18),
                            )),
                        10.spaceY,
                      ])),
                )),
              )
            : const LoadingAnimation();
      }),
    );
  }

  List<AddMultipleItems> addMultipleItems = [];
  addProduct({required BuildContext context}) {
    Map<String, String> map = {};

    addMultipleItems.asMap().entries.forEach((element) {
      map["variant_sku[${element.key}]"] = element.value.variantSku.text.trim();
      map["variant_price[${element.key}]"] = element.value.variantPrice.text.trim();
      map["variant_stock[${element.key}]"] = element.value.variantStock.text.trim();
      Map<String, String> kk = {};
      for (var element11 in element.value.attributes!.entries) {
        kk[element11.key] = element11.value.id.toString();
      }
      map["variant_value[${element.key}]"] = jsonEncode(kk);
    });

    log("Map Data: $map");
    Map<String, File> imageMap = {};

    addMultipleItems.asMap().entries.forEach((element) {
      if (element.value.variantImages.path.checkHTTP.isEmpty) {
        imageMap["variant_images[${element.key}]"] = element.value.variantImages;
      } else {
        map["variant_images[${element.key}]"] = element.value.variantImages.path;
      }
    });

    log("Image Map Data: $imageMap");

    repositories
        .multiPartApi(
            mapData: map,
            images: imageMap,
            url: ApiUrls.addVendorProductUrl,
            context: context,
            onProgress: (int bytes, int totalBytes) {})
        .then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());

      if (response.status == true) {
        showToast('message');
        showToast(response.message.toString());
      }
    }).catchError((e) {
      NotificationService().hideAllNotifications();
    });
  }
}

Iterable<List<T>> combinations<T>(
  List<List<T>> lists, [
  int index = 0,
  List<T>? prefix,
]) sync* {
  prefix ??= <T>[];

  if (lists.length == index) {
    yield prefix.toList();
  } else {
    for (final value in lists[index]) {
      yield* combinations(lists, index + 1, prefix..add(value));
      prefix.removeLast();
    }
  }
}
