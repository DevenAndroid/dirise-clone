import 'package:dirise/utils/helper.dart';
import 'package:dirise/utils/styles.dart';
import 'package:dirise/widgets/loading_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../controller/vendor_controllers/add_product_controller.dart';
import '../../../utils/api_constant.dart';
import '../../../widgets/common_colour.dart';
import '../../../widgets/dimension_screen.dart';
import '../../../widgets/vendor_common_textfield.dart';
import 'edit_categories.dart';

class AddProductDescriptionScreen extends StatefulWidget {
  const AddProductDescriptionScreen({super.key});

  @override
  State<AddProductDescriptionScreen> createState() => _AddProductDescriptionScreenState();
}

class _AddProductDescriptionScreenState extends State<AddProductDescriptionScreen> {
  final controller = Get.put(AddProductController(),permanent: true);
  String taxValue = 'Select Tax Type';
  List<String> productTypes = [
    "Simple Product",
    "Virtual Product",
    "Booking Product",
    "Variants Product",
  ];
  void launchURLl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  @override
  void initState() {
    super.initState();
    controller.getProductsCategoryList();
    controller.getTaxData();
  }

  showPolicyDialog() {
    FocusManager.instance.primaryFocus!.unfocus();
    controller.getReturnPolicyData();
    showDialog(context: context,
        useSafeArea: true,
        builder: (context) {
      return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 25),
        child: Obx(() {
          if(controller.returnPolicyLoaded.value > 0){}
          return controller.modelReturnPolicy != null ?
          Padding(
            padding: const EdgeInsets.all(18.0),
            child:   controller.modelReturnPolicy!.returnPolicy!.isNotEmpty ?
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Select Return Policy".tr,style: titleStyle,),
                StatefulBuilder(
                  builder: (context, newState) {
                    return Container(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.width*1.2
                      ),
                      child: ListView.builder(
                        itemCount: controller.modelReturnPolicy!.returnPolicy!.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index){
                          final item = controller.modelReturnPolicy!.returnPolicy![index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: ListTile(
                            visualDensity: VisualDensity.compact,
                            contentPadding: EdgeInsets.zero,
                            minVerticalPadding: 0,
                            title: Text(item.title.toString(),style: titleStyle,),
                            trailing: Radio<String>(
                              value: item.id.toString(),

                              visualDensity: const VisualDensity(horizontal: -4,vertical: -4),
                              groupValue: controller.selectedReturnPolicy != null ?
                              controller.selectedReturnPolicy!.id.toString() : "",
                              onChanged: (lkjasd){
                                controller.selectedReturnPolicy = item;
                                controller.returnDaysController.text = item.title.toString();
                                newState(() {});
                              },
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${item.days} ${'Days'}",style: titleStyle,),
                                Text(item.policyDiscreption.toString(),style: normalStyle,),
                              ],
                            ),
                          ),
                        );
                      }),
                    );
                  }
                ),
              ],
            ) :  Text("Please login in web and create return policy".tr,style: titleStyle,textAlign: TextAlign.center),
          ) : const LoadingAnimation();
        }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 3,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding20),
            child: Obx(() {
              if (controller.refreshInt.value > 0) {}
              return Column(children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  DropdownButtonFormField<String>(
                    icon: const Icon(Icons.keyboard_arrow_down),
                    iconDisabledColor: const Color(0xff97949A),
                    iconEnabledColor: const Color(0xff97949A),
                    value: controller.productType,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      fillColor: const Color(0xffE2E2E2).withOpacity(.35),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                      focusedErrorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: AppTheme.secondaryColor)),
                      errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Color(0xffE2E2E2))),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: AppTheme.secondaryColor)),
                      disabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: AppTheme.secondaryColor),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: AppTheme.secondaryColor),
                      ),
                    ),
                    items: productTypes
                        .map((label) =>
                        DropdownMenuItem(
                          value: label,
                          child: Text(
                            label.toString(),
                            style: GoogleFonts.poppins(
                              color: const Color(0xff463B57),
                            ),
                          ),
                        ))
                        .toList(),
                    hint:  Text('Rating'.tr),
                    onChanged: (value) {
                      if (value == null) return;
                      controller.productType = value;
                      controller.updateUI;
                      setState(() {});
                    },
                  ),
                  10.spaceY,
                  const EditCategoriesScreen(),
                  10.spaceY,
                  VendorCommonTextfield(
                      controller: controller.productNameController,
                      key: controller.productNameController.getKey,
                      hintText: "Enter Product Name".tr,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Product name is required".tr;
                        }
                        return null;
                      }),
                  18.spaceY,
                  VendorCommonTextfield(
                      controller: controller.skuController,
                      key: controller.skuController.getKey,
                      hintText: "Enter SKU".tr,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "SKU is required".tr;
                        }
                        return null;
                      }),
                  // 18.spaceY,
                  // VendorCommonTextfield(
                  //     controller: controller.priceController,
                  //     key: controller.priceController.getKey,
                  //     keyboardType: TextInputType.number,
                  //     hintText: "Price",
                  //     validator: (value) {
                  //       if (value!.trim().isEmpty) {
                  //         return "Price is required";
                  //       }
                  //       if ((num.tryParse(value.trim()) ?? 0) < 1) {
                  //         return "Enter valid price";
                  //       }
                  //       return null;
                  //     }),
                  18.spaceY,
                  VendorCommonTextfield(
                      controller: controller.purchasePriceController,
                      key: controller.purchasePriceController.getKey,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      hintText: "Normal Price".tr,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Normal price is required".tr;
                        }
                        if ((num.tryParse(value.trim()) ?? 0) < 1) {
                          return "Enter valid purchased price".tr;
                        }
                        return null;
                      }),
                  18.spaceY,
                  VendorCommonTextfield(
                      controller: controller.sellingPriceController,
                      key: controller.sellingPriceController.getKey,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      hintText: "After Sell Price".tr,
                      onChanged: (value) {
                        double sellingPrice = double.tryParse(value) ?? 0.0;
                        double purchasePrice = double.tryParse(controller.purchasePriceController.text) ?? 0.0;
                        if (controller.purchasePriceController.text.isEmpty) {
                          FocusManager.instance.primaryFocus!.unfocus();
                          controller.sellingPriceController.clear();
                          showToast('Enter normal price first');
                          return;
                        }
                        if (sellingPrice > purchasePrice) {
                          FocusManager.instance.primaryFocus!.unfocus();
                          controller.sellingPriceController.clear();
                          showToast('After sell price cannot be higher than normal price');
                        }
                      },
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "After Sell price is required".tr;
                        }
                        if ((num.tryParse(value.trim()) ?? 0) < 1) {
                          return "Enter valid After Sell price".tr;
                        }
                        return null;
                      }),
                  18.spaceY,
                  DropdownButtonFormField<String>(
                    key: controller.taxKey,
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
                      hintText: "Tax Apply".tr,
                      labelStyle: GoogleFonts.poppins(color: Colors.black),
                      //labelText: "Tax Apply",
                      fillColor: const Color(0xffE2E2E2).withOpacity(.35),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: AppTheme.secondaryColor),
                      ),
                    ),
                    value: controller.tax,
                    validator: (gg) {
                      if (controller.tax.isEmpty) {
                        return "Please select tax ".tr;
                      }
                      return null;
                    },
                    items: <String>['Including tax', 'Without tax']
                        .map((label) =>
                        DropdownMenuItem(
                          value: label,
                          child: Text(
                            label
                                .toString(),
                            style: GoogleFonts.poppins(
                              color: const Color(0xff463B57),
                            ),
                          ),
                        ))
                        .toList(),
                    onChanged: (value) {
                      if (value == null) return;
                      print('value....'+controller.tax);
                      controller.tax = value;
                      setState(() {

                      });
                    },
                  ),
                  controller.tax == 'Including tax' ?
                  18.spaceY :
                  const SizedBox(),
                  controller.tax == 'Including tax' ?
                  DropdownButtonFormField<dynamic>(
                    // key: controller.weightUnitKey,
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
                      hintText: "Tax (in %)".tr,
                      labelStyle: GoogleFonts.poppins(color: Colors.black),
                      //labelText: "Tax Apply",
                      fillColor: const Color(0xffE2E2E2).withOpacity(.35),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: AppTheme.secondaryColor),
                      ),
                    ),
                    // value: controller.taxId,
                  /*   validator: (gg) {
                      if (controller.weightUnit.isEmpty) {
                        return "Please select weight unit";
                      }
                      return null;
                    },*/
                    items: controller.taxData.value.tax?.toList()
                        .map((label) =>
                        DropdownMenuItem(
                          value:  label.id.toString(),
                          child: Text(
                            label.title
                                .toString(),
                            style: GoogleFonts.poppins(
                              color: const Color(0xff463B57),
                            ),
                          ),
                        ))
                        .toList(),
                    onChanged: (value) {
                      if (value == null) return;
                      print(controller.taxId,);
                      setState(() {
                        controller.taxId = value;
                      });
                    },
                  ) :
                  const SizedBox(),
                  18.spaceY,
                  VendorCommonTextfield(
                      controller: controller.stockController,
                      key: controller.stockController.getKey,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      hintText: "Stock Quantity".tr,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Stock quantity is required".tr;
                        }
                        if ((num.tryParse(value.trim()) ?? 0) < 1) {
                          return "Enter valid stock quantity".tr;
                        }
                        return null;
                      }),
                  18.spaceY,
                  VendorCommonTextfield(
                      controller: controller.stockAlertController,
                      //key: controller.stockController.getKey,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      hintText: "Stock Alert".tr,
                      onChanged: (value) {
                        double stockAlert = double.tryParse(value) ?? 0.0;
                        double stockQuantity = double.tryParse(controller.stockController.text) ?? 0.0;
                        if (controller.stockController.text.isEmpty) {
                          FocusManager.instance.primaryFocus!.unfocus();
                          controller.stockAlertController.clear();
                          showToast('Enter stock quantity first');
                          return;
                        }
                        if (stockAlert > stockQuantity) {
                          FocusManager.instance.primaryFocus!.unfocus();
                          controller.stockAlertController.clear();
                          showToast('Stock alert cannot be higher than Stock quantity');
                        }
                      },
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Stock alert is required".tr;
                        }
                        if ((num.tryParse(value.trim()) ?? 0) < 1) {
                          return "Enter valid stock alert".tr;
                        }
                        return null;
                      }),
                  18.spaceY,
                  VendorCommonTextfield(
                      controller: controller.returnDaysController,
                      key: controller.returnDaysController.getKey,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      readOnly: true,
                      onTap: () {
                        // showPolicyDialog();
                        launchURLl('https://backend.diriseapp.com/dashboard/return-policy');
                      },
                      hintText: "Return Policy".tr,
                      validator: (value) {
                        return null;
                      }),
                  if (controller.productType == "Simple Product" || controller.productType == "Variants Product") ...[
                    18.spaceY,
                    VendorCommonTextfield(
                        controller: controller.weightController,
                        key: controller.weightController.getKey,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        hintText: "Weight".tr,
                        validator: (value) {
                          // if (value!.trim().isEmpty) {
                          //   return "Product weight is required";
                          // }
                          // if (double.tryParse(value.trim()) == null) {
                          //   return "Please enter valid weight";
                          // }
                          // if ((num.tryParse(value.trim()) ?? 0) < 1) {
                          //   return "Enter valid return days";
                          // }
                          return null;
                        }),
                    18.spaceY,
                    DropdownButtonFormField<String>(
                      key: controller.weightUnitKey,
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
                        hintText: "Weight Unit".tr,
                        labelStyle: GoogleFonts.poppins(color: Colors.black),
                        labelText: "Weight Unit".tr,
                        fillColor: const Color(0xffE2E2E2).withOpacity(.35),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: AppTheme.secondaryColor),
                        ),
                      ),
                      value: controller.weightUnit.isEmpty ? null : controller.weightUnit,
                      validator: (gg) {
                        // if (controller.weightUnit.isEmpty) {
                        //   return "Please select weight unit";
                        // }
                        return null;
                      },
                      items: controller.gg
                          .map((label) =>
                          DropdownMenuItem(
                            value: label,
                            child: Text(
                              label
                                  .toString()
                                  .capitalize!,
                              style: GoogleFonts.poppins(
                                color: const Color(0xff463B57),
                              ),
                            ),
                          ))
                          .toList(),
                      onChanged: (value) {
                        if (value == null) return;
                        controller.weightUnit = value;
                      },
                    ),
                  ],
                  18.spaceY,
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: VendorCommonTextfield(
                              controller: controller.productDurationValueController,
                              key: controller.productDurationValueController.getKey,
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              hintText: "Preparation Time".tr,
                              labelText: "Preparation Time".tr,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              validator: (value) {
                                return null;
                              }),
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            value: controller.productDurationTypeValue.isEmpty
                                ? null
                                : controller.productDurationTypeValue,
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
                              errorMaxLines: 2,
                              labelStyle: GoogleFonts.poppins(color: Colors.black, fontSize: 12),
                              labelText: "Preparation Duration".tr,
                              fillColor: const Color(0xffE2E2E2).withOpacity(.35),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                borderSide: BorderSide(color: AppTheme.secondaryColor),
                              ),
                            ),
                            validator: (gg) {
                              if (controller.productDurationValueController.text
                                  .trim()
                                  .isNotEmpty &&
                                  controller.productDurationTypeValue.isEmpty) {
                                return "Please select preparation duration".tr;
                              }
                              return null;
                            },
                            items: controller.productDurationType
                                .map((label) =>
                                DropdownMenuItem(
                                  value: label.toLowerCase(),
                                  child: Text(
                                    label
                                        .toString()
                                        .capitalize!,
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xff463B57),
                                    ),
                                  ),
                                ))
                                .toList(),
                            onChanged: (value) {
                              if (value == null) return;
                              controller.productDurationTypeValue = value;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 18.spaceY,
                  // Obx(() {
                  //   if (controller.refreshCategory.value > 0) {}
                  //   return DropdownButtonFormField<String>(
                  //     key: controller.categoryKey,
                  //     icon: controller.refreshCategory.value == -2
                  //         ? const CupertinoActivityIndicator()
                  //         : const Icon(Icons.keyboard_arrow_down),
                  //     autovalidateMode: AutovalidateMode.onUserInteraction,
                  //     isExpanded: true,
                  //     iconDisabledColor: const Color(0xff97949A),
                  //     iconEnabledColor: const Color(0xff97949A),
                  //     decoration: InputDecoration(
                  //       border: const OutlineInputBorder(
                  //         borderRadius: BorderRadius.all(Radius.circular(8)),
                  //         borderSide: BorderSide(color: AppTheme.secondaryColor),
                  //       ),
                  //       enabled: true,
                  //       filled: true,
                  //       hintText: "Category",
                  //       labelStyle: GoogleFonts.poppins(color: Colors.black),
                  //       labelText: "Category",
                  //       fillColor: const Color(0xffE2E2E2).withOpacity(.35),
                  //       contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                  //       enabledBorder: const OutlineInputBorder(
                  //         borderRadius: BorderRadius.all(Radius.circular(8)),
                  //         borderSide: BorderSide(color: AppTheme.secondaryColor),
                  //       ),
                  //     ),
                  //     value: controller.selectedCategory.isEmpty ? null : controller.selectedCategory,
                  //     validator: (gg) {
                  //       if (controller.selectedCategory.isEmpty) {
                  //         return "Please select product category";
                  //       }
                  //       return null;
                  //     },
                  //     items: controller.productCategory.data!
                  //         .map((label) =>
                  //         DropdownMenuItem(
                  //           value: label.id.toString(),
                  //           child: Text(
                  //             label.title.toString(),
                  //             style: GoogleFonts.poppins(
                  //               color: const Color(0xff463B57),
                  //             ),
                  //           ),
                  //         ))
                  //         .toList(),
                  //     onChanged: (value) {
                  //       if (value == null) return;
                  //       controller.selectedCategory = value;
                  //     },
                  //   );
                  // }),
                  18.spaceY,
                  VendorCommonTextfield(
                      controller: controller.shortDescriptionController,
                      key: controller.shortDescriptionController.getKey,
                      hintText: "Short Description".tr,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Short description is required".tr;
                        }
                        return null;
                      }),
                  18.spaceY,
                  VendorCommonTextfield(
                      controller: controller.longDescriptionController,
                      key: controller.longDescriptionController.getKey,
                      maxLength: 5000,
                      isMulti: true,
                      hintText: "Long Description".tr,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Long description is required".tr;
                        }
                        return null;
                      }),
                ])
              ]);
            })));
  }
}
