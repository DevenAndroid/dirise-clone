import 'package:dirise/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controller/vendor_controllers/add_product_controller.dart';
import '../../../widgets/common_colour.dart';

class EditCategoriesScreen extends StatefulWidget {
  const EditCategoriesScreen({Key? key}) : super(key: key);

  @override
  State<EditCategoriesScreen> createState() => _EditCategoriesScreenState();
}

class _EditCategoriesScreenState extends State<EditCategoriesScreen> {
  final controller = Get.put(AddProductController(),permanent: true);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getProductsCategoryList();
  }
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.categoryLoadingInt.value > 0) {}
      if (controller.modelCategoryList == null) {
        return const SizedBox();
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: controller.modelCategoryList!.data!
            .map((e) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      e.title.toString(),
                      style: normalStyle,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    DropdownButtonFormField<int>(
                      isExpanded: true,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      iconDisabledColor: const Color(0xff97949A),
                      iconEnabledColor: const Color(0xff97949A),
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
                      items: e.childCategory!
                          .asMap()
                          .entries
                          .map((ee) => DropdownMenuItem(
                                value: ee.key,
                                child: Text(
                                  ee.value.title.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xff463B57),
                                  ),
                                ),
                              ))
                          .toList(),
                      validator: (value) {
                        if (!e.childCategory!.map((k) => k.selected).toList().contains(true)) {
                          return "Please select any one category".tr;
                        }
                        return null;
                      },
                      hint:  Text('Select Category'.tr),
                      onChanged: (value) {
                        e.childCategory![value!].selected = true;
                        setState(() {});
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Wrap(
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      runAlignment: WrapAlignment.start,
                      spacing: 6,
                      children: e.childCategory!
                          .where((element) => element.selected == true)
                          .map((ee) => Chip(
                              visualDensity: const VisualDensity(vertical: -2, horizontal: -4),
                              label: Text(
                                ee.title.toString(),
                                style: normalStyle,
                              ),
                              onDeleted: () {
                                ee.selected = false;
                                setState(() {});
                              }))
                          .toList(),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                  ],
                ))
            .toList(),
      );
    });
  }
}
