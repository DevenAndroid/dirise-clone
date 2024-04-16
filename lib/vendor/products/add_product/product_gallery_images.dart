import 'package:collection/collection.dart';
import 'package:dirise/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../../controller/vendor_controllers/add_product_controller.dart';
import '../../../widgets/common_colour.dart';
import '../../../widgets/dimension_screen.dart';

class ProductGalleryImages extends StatefulWidget {
  const ProductGalleryImages({super.key});

  @override
  State<ProductGalleryImages> createState() => _ProductGalleryImagesState();
}

class _ProductGalleryImagesState extends State<ProductGalleryImages> {
  final controller = Get.put(AddProductController());

  showImagesBottomSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        enableDrag: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              20.spaceY,
              Container(
                width: double.maxFinite,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: MaterialButton(
                              onPressed: () {
                                Get.back();
                                NewHelper().addImagePicker(
                                  imageSource: ImageSource.camera,
                                )
                                    .then((value) {
                                  if (value == null) return;
                                  if (controller.galleryImages.length < 5) {
                                    controller.galleryImages.add(value);
                                    setState(() {});
                                  }
                                });
                              },
                              height: 58,
                              elevation: 0,
                              color: Colors.white,
                              child: Text(
                                "Take picture".tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(color: AppTheme.buttonColor, fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: MaterialButton(
                              onPressed: () {
                                Get.back();
                                NewHelper().multiImagePicker().then((value) {
                                  if (value == null) return;
                                  for (var element in value) {
                                    if (controller.galleryImages.length < 5) {
                                      controller.galleryImages.add(element);
                                    } else {
                                      break;
                                    }
                                  }
                                  setState(() {});
                                });
                              },
                              height: 58,
                              elevation: 0,
                              color: Colors.white,
                              child: Text(
                                "Choose From Gallery".tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(color: AppTheme.buttonColor, fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            // Get.toNamed(thankUScreen);
                          },
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.maxFinite, 60),
                              backgroundColor: AppTheme.buttonColor,
                              elevation: 0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              textStyle: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600)),
                          child: Text(
                            "Submit",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
                          )),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 0, 8),
                child: Obx(() {
                  if (controller.refreshInt.value > 0) {}
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                'Image Gallery'.tr,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF000000),
                                ),
                              ),
                            ),
                            if (controller.showValidations && controller.galleryImages.isEmpty)
                              Padding(
                                padding: const EdgeInsets.only(left: 5, top: 2),
                                child: Icon(
                                  Icons.error_outline_rounded,
                                  color: Theme.of(context).colorScheme.error,
                                  size: 21,
                                ),
                              ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          showImagesBottomSheet();
                        },
                        child: Text(
                          '${'Choose From Gallery'} ${controller.galleryImages.isNotEmpty ? "${controller.galleryImages.length}/5" : ""}',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: AppTheme.buttonColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
              // if (controller.galleryImages.isNotEmpty) ...[
              //   SizedBox(
              //     height: 125,
              //     child: Obx(() {
              //       if (controller.refreshInt.value > 0) {}
              //       return SingleChildScrollView(
              //         scrollDirection: Axis.horizontal,
              //         padding: const EdgeInsets.only(left: 20),
              //         child: Row(
              //           children: controller.galleryImages
              //               .mapIndexed((i, e) => Padding(
              //                     padding: const EdgeInsets.only(right: 18),
              //                     child: GestureDetector(
              //                         onTap: () {
              //                           NewHelper.showImagePickerSheet(
              //                               gotImage: (value) {
              //                                 controller.galleryImages[i] = value;
              //                                 setState(() {});
              //                               },
              //                               context: context,
              //                               removeOption: true,
              //                               removeImage: (fg) {
              //                                 controller.galleryImages.removeAt(i);
              //                                 setState(() {});
              //                               });
              //                         },
              //                         child: Container(
              //                           constraints: const BoxConstraints(minWidth: 50, minHeight: 125),
              //                           child: Image.file(
              //                             e,
              //                             errorBuilder: (_, __, ___) => Image.network(
              //                               e.path,
              //                               errorBuilder: (_, __, ___) => const Icon(
              //                                 Icons.error_outline,
              //                                 color: Colors.red,
              //                               ),
              //                             ),
              //                           ),
              //                         )),
              //                   ))
              //               .toList(),
              //         ),
              //       );
              //     }),
              //   ),
              //   const SizedBox(
              //     height: 12,
              //   ),
              // ],
              SizedBox(
                height: 125,
                child: Obx(() {
                  if (controller.refreshInt.value > 0) {}
                  return  controller.galleryImages.isEmpty ?
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Image(
                          height: 30,
                          image: AssetImage(
                            'assets/icons/pdfdownload.png',
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Upload Product image".tr,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w300, color: const Color(0xff463B57), fontSize: AddSize.font14),
                        ),
                        const SizedBox(
                          height:10,
                        ),
                      ],
                    ),
                  ) :
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: controller.galleryImages
                          .mapIndexed((i, e) => Padding(
                        padding: const EdgeInsets.only(right: 18),
                        child: GestureDetector(
                            onTap: () {
                              NewHelper.showImagePickerSheet(
                                  gotImage: (value) {
                                    controller.galleryImages[i] = value;
                                    setState(() {});
                                  },
                                  context: context,
                                  removeOption: true,
                                  removeImage: (fg) {
                                    controller.galleryImages.removeAt(i);
                                    setState(() {});
                                  });
                            },
                            child: Container(
                              constraints: const BoxConstraints(minWidth: 50, minHeight: 125),
                              child: Image.file(
                                e,
                                errorBuilder: (_, __, ___) => Image.network(
                                  e.path,
                                  errorBuilder: (_, __, ___) => const Icon(
                                    Icons.error_outline,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            )),
                      ))
                          .toList(),
                    ),
                  );
                }),
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          )),
    );
  }
}
