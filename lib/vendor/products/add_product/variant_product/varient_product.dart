import 'dart:developer';
import 'dart:io';
import 'package:dirise/utils/helper.dart';
import 'package:dirise/utils/styles.dart';
import 'package:dirise/widgets/loading_animation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../controller/vendor_controllers/add_product_controller.dart';
import '../../../../model/vendor_models/model_attribute.dart';
import '../../../../model/vendor_models/model_varient.dart';
import '../../../../widgets/common_colour.dart';
import '../../../../widgets/vendor_common_textfield.dart';
import '../../../authentication/image_widget.dart';

extension ToSimpleMap on Map<String, GetAttrvalues> {
  Map<String, String> get toSimpleMap {
    Map<String, String> gg = {};
    for (var element in entries) {
      gg[element.key] = element.value.id.toString();
    }
    return gg;
  }
}

class ProductVarient extends StatefulWidget {
  const ProductVarient({super.key});

  @override
  State<ProductVarient> createState() => _ProductVarientState();
}

class _ProductVarientState extends State<ProductVarient> {
  final controller = Get.put(AddProductController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.attributeRefresh.value > 0) {}
      if (controller.refreshInt.value > 0) {}
      if (controller.variation.value > 0) {}
      return controller.modelAttributes.data != null
          ? Card(
              margin: const EdgeInsets.symmetric(vertical: 18, horizontal: 4),
              child: Padding(
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
                      key: controller.attributeListKey,
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
                        if (controller.attributeList.isEmpty && controller.addMultipleItems.isEmpty) {
                          return "Please select variants";
                        }
                        return null;
                      },
                      items: controller.modelAttributes.data!
                          .map((e) => DropdownMenuItem(value: e, child: Text(e.name.toString())))
                          .toList(),
                      onChanged: (value) {
                        if (value == null) return;
                        AttributeData kk = value;
                        for (var element in kk.getAttrvalues!) {
                          element.aboveParentSlug = kk.slug.toString();
                        }
                        controller.attributeList.add(kk);
                        controller.attributeList = controller.attributeList.toSet().toList();
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
                      key: controller.attributeEmptyListKey,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: controller.attributeList
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
                                            controller.attributeList.remove(e);
                                            if (controller.attributeList
                                                .map((e) => e.getAttrvalues!
                                                    .map((e2) => e2.selectedVariant)
                                                    .toList()
                                                    .contains(true))
                                                .toList()
                                                .contains(true)) {
                                              controller.filterClearAttributes();
                                              combinations(controller.attributeList
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
                                                controller.addMultipleItems.add(AddMultipleItems(
                                                  attributes: tempMap,
                                                ));
                                              });
                                              setState(() {});
                                            } else {
                                              controller.filterClearAttributes();
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
                    if (controller.attributeList
                        .map((e) => e.getAttrvalues!.map((e2) => e2.selectedVariant).toList().contains(true))
                        .toList()
                        .contains(true))
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: ElevatedButton(
                            key: controller.createAttributeButton,
                            onPressed: () {
                              controller.filterClearAttributes();
                              List<Map<String, GetAttrvalues>> previousList = [];
                              for (var element in controller.addMultipleItems) {
                                Map<String, GetAttrvalues> tempMap1 = {};
                                if (element.attributes != null) {
                                  for (var element1 in element.attributes!.entries) {
                                    tempMap1[element1.key] = element1.value;
                                  }
                                }

                                log(tempMap1.toSimpleMap.toString());
                                previousList.add(tempMap1);
                              }
                              combinations(controller.attributeList
                                      .map((e) =>
                                          e.getAttrvalues!.where((element) => element.selectedVariant == true).toList())
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
                                  controller.addMultipleItems.add(AddMultipleItems(
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
                      children: controller.addMultipleItems
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
                                            controller.addMultipleItems.remove(e);
                                            setState(() {});
                                          },
                                          icon: const Icon(Icons.clear))
                                    ],
                                  ),
                                  ImageWidget(
                                    title: "Variant Image",
                                    key: e.variantImageKey,
                                    file: e.variantImages,
                                    imageOnly: true,
                                    filePicked: (File gg) {
                                      e.variantImages = gg;
                                    },
                                    validation: e.variantImages.path.isEmpty,
                                  ),
                                  2.spaceY,
                                  VendorCommonTextfield(
                                      controller: e.variantSku,
                                      key: e.variantSku.getKey,
                                      hintText: "Variant SKU",
                                      validator: (value) {
                                        if (value!.trim().isEmpty) {
                                          return "Variant sku is required";
                                        }
                                        return null;
                                      }),
                                  18.spaceY,
                                  VendorCommonTextfield(
                                      controller: e.variantPrice,
                                      key: e.variantPrice.getKey,
                                      hintText: "Variant Price",
                                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                      validator: (value) {
                                        if (value!.trim().isEmpty) {
                                          return "Variant price is required";
                                        }
                                        return null;
                                      }),
                                  18.spaceY,
                                  VendorCommonTextfield(
                                      controller: e.variantStock,
                                      key: e.variantStock.getKey,
                                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                      hintText: "Variant Stock",
                                      validator: (value) {
                                        if (value!.trim().isEmpty) {
                                          return "Variant stock is required";
                                        }
                                        return null;
                                      }),
                                  18.spaceY,
                                ],
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            )
          : const LoadingAnimation();
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
