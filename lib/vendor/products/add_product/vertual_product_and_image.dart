import 'dart:io';

import 'package:dirise/utils/helper.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../controller/vendor_controllers/add_product_controller.dart';
import '../../../widgets/dimension_screen.dart';
import '../../../widgets/vendor_common_textfield.dart';

class AddProductImageAndVirtualFile extends StatefulWidget {
  const AddProductImageAndVirtualFile({super.key});

  @override
  State<AddProductImageAndVirtualFile> createState() => _AddProductImageAndVirtualFileState();
}

class _AddProductImageAndVirtualFileState extends State<AddProductImageAndVirtualFile> {
  final controller = Get.put(AddProductController());

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 3,
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  if (controller.refreshInt.value > 0) {}
                  return Row(
                    children: [
                      Flexible(
                        child: Text(
                          "Upload Image".tr,
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.w500, color: const Color(0xff2F2F2F), fontSize: 18),
                        ),
                      ),
                      if (controller.showValidations && controller.productImage.path.isEmpty)
                        Padding(
                          padding: const EdgeInsets.only(left: 5, top: 2),
                          child: Icon(
                            Icons.error_outline_rounded,
                            color: Theme.of(context).colorScheme.error,
                            size: 21,
                          ),
                        ),
                    ],
                  );
                }),
                6.spaceY,
                productImageWidget(context, height),
                Obx(() {
                  if (controller.refreshInt.value > 0) {}
                  if (controller.virtualRefreshInt.value > 0) {}
                  return controller.productType == "Virtual Product"
                      ? Column(
                          children: [
                            6.spaceY,
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          "Upload Digital Reader".tr,
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500, color: const Color(0xff2F2F2F), fontSize: 18),
                                        ),
                                      ),
                                      if (controller.showValidations && controller.pdfFile.path.isEmpty)
                                        Padding(
                                          padding: const EdgeInsets.only(left: 5, top: 1),
                                          child: Icon(
                                            Icons.error_outline_rounded,
                                            color: Theme.of(context).colorScheme.error,
                                            size: 22,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                Checkbox(
                                    value: controller.productFileType.value == "pdf",
                                    onChanged: (value) {
                                      if (value == true) {
                                        controller.productFileType.value = "pdf";
                                      } else {
                                        controller.productFileType.value = "";
                                      }
                                    })
                              ],
                            ),
                            6.spaceY,
                            if (controller.productFileType.value == "pdf") ...[
                              GestureDetector(
                                onTap: () {
                                  controller.pickPDFFile().then((value) {
                                    setState(() {});
                                  });
                                },
                                child: DottedBorder(
                                  radius: const Radius.circular(10),
                                  borderType: BorderType.RRect,
                                  dashPattern: const [3, 5],
                                  color: Colors.grey.shade500,
                                  strokeWidth: 1,
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding16),
                                    width: AddSize.screenWidth,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade50,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: controller.pdfFile.path.isNotEmpty
                                        ? Column(
                                            children: [
                                              Center(
                                                child: Text(
                                                  controller.pdfFile.path.split("/").last,
                                                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16),
                                                ),
                                              ),
                                              // TextButton(
                                              //     onPressed: () {
                                              //       OpenFilex.open(controller.pdfFile.path);
                                              //     },
                                              //     child: const Text("View"))
                                            ],
                                          )
                                        : Column(
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
                                                "Upload PDF File".tr,
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w300,
                                                    color: const Color(0xff463B57),
                                                    fontSize: AddSize.font16),
                                              ),
                                              SizedBox(
                                                height: height * .01,
                                              ),
                                            ],
                                          ),
                                  ),
                                ),
                              ),
                              4.spaceY,
                            ],
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          "Upload Voice".tr,
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500, color: const Color(0xff2F2F2F), fontSize: 18),
                                        ),
                                      ),
                                      if (controller.showValidations && controller.pdfFile.path.isEmpty)
                                        Padding(
                                          padding: const EdgeInsets.only(left: 5, top: 1),
                                          child: Icon(
                                            Icons.error_outline_rounded,
                                            color: Theme.of(context).colorScheme.error,
                                            size: 22,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                Checkbox(
                                    value: controller.productFileType.value == "voice",
                                    onChanged: (value) {
                                      if (value == true) {
                                        controller.productFileType.value = "voice";
                                      } else {
                                        controller.productFileType.value = "";
                                      }
                                    })
                              ],
                            ),
                            8.spaceY,
                            VendorCommonTextfield(
                                controller: controller.languageController,
                                //key: controller.stockController.getKey,
                                keyboardType: TextInputType.text,
                                hintText: "Language".tr,
                                validator: (value) {
                                  if (value!.trim().isEmpty) {
                                    return "Language is required".tr;
                                  }
                                /*  if ((num.tryParse(value.trim()) ?? 0) < 1) {
                                    return "Enter valid Language";
                                  }*/
                                  return null;
                                }),
                            8.spaceY,
                            if (controller.productFileType.value == "voice") ...[
                              4.spaceY,
                              GestureDetector(
                                onTap: () {
                                  controller.pickAudioFile();
                                },
                                child: DottedBorder(
                                  radius: const Radius.circular(10),
                                  borderType: BorderType.RRect,
                                  dashPattern: const [3, 5],
                                  color: Colors.grey.shade500,
                                  strokeWidth: 1,
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding16),
                                    width: AddSize.screenWidth,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade50,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: controller.voiceFile.path.isNotEmpty
                                        ? Column(
                                            children: [
                                              Center(
                                                child: Text(
                                                  controller.voiceFile.path.split("/").last,
                                                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16),
                                                ),
                                              ),
                                              // TextButton(
                                              //     onPressed: () {
                                              //       OpenFilex.open(controller.voiceFile.path);
                                              //     },
                                              //     child: const Text("View"))
                                            ],
                                          )
                                        : Column(
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
                                                "Upload Voice".tr,
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w300,
                                                    color: const Color(0xff463B57),
                                                    fontSize: AddSize.font16),
                                              ),
                                              SizedBox(
                                                height: height * .01,
                                              ),
                                            ],
                                          ),
                                  ),
                                ),
                              )
                            ],
                          ],
                        )
                      : const SizedBox.shrink();
                }),
              ],
            )));
  }
  void showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text(
          'Select Picture from',
          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () {
              Helpers.addImagePicker(imageSource: ImageSource.camera, imageQuality: 50).then((value) async {
                CroppedFile? croppedFile = await ImageCropper().cropImage(
                  sourcePath: value.path,
                  aspectRatioPresets: [
                    // CropAspectRatioPreset.square,
                    // CropAspectRatioPreset.ratio3x2,
                    // CropAspectRatioPreset.original,
                    CropAspectRatioPreset.ratio4x3,
                    // CropAspectRatioPreset.ratio16x9
                  ],
                  uiSettings: [
                    AndroidUiSettings(
                        toolbarTitle: 'Cropper',
                        toolbarColor: Colors.deepOrange,
                        toolbarWidgetColor: Colors.white,
                        initAspectRatio: CropAspectRatioPreset.ratio4x3,
                        lockAspectRatio: true),
                    IOSUiSettings(
                      title: 'Cropper',
                        aspectRatioLockEnabled: true
                    ),
                    WebUiSettings(
                      context: context,
                    ),
                  ],
                );
                if (croppedFile != null) {
                  controller.productImage = File(croppedFile.path);
                  setState(() {});
                }

                Get.back();
              });
            },
            child: const Text("Camera"),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Helpers.addImagePicker(imageSource: ImageSource.gallery, imageQuality: 75).then((value) async {
                CroppedFile? croppedFile = await ImageCropper().cropImage(
                  sourcePath: value.path,
                  aspectRatioPresets: [
                    // CropAspectRatioPreset.square,
                    // CropAspectRatioPreset.ratio3x2,
                    // CropAspectRatioPreset.original,
                    CropAspectRatioPreset.ratio4x3,
                    // CropAspectRatioPreset.ratio16x9
                  ],

                  uiSettings: [
                    AndroidUiSettings(
                        toolbarTitle: 'Cropper',
                        toolbarColor: Colors.deepOrange,
                        toolbarWidgetColor: Colors.white,
                        initAspectRatio: CropAspectRatioPreset.ratio4x3,
                        lockAspectRatio: true),
                    IOSUiSettings(
                      title: 'Cropper',
                      aspectRatioLockEnabled: true,
                      minimumAspectRatio : 4.3,
                    ),
                    WebUiSettings(
                      context: context,
                    ),
                  ],
                );
                if (croppedFile != null) {
                  controller.productImage = File(croppedFile.path);
                  setState(() {});
                }

                Get.back();
              });
            },
            child: const Text('Gallery'),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Get.back();
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  GestureDetector productImageWidget(BuildContext context, double height) {
    return GestureDetector(
      onTap: () {
        // showActionSheet(context);
        NewHelper.showImagePickerSheet(
            context: context,
            gotImage: (File gg) {
              controller.productImage = gg;
              setState(() {});
            });
      },
      child: DottedBorder(
        radius: const Radius.circular(10),
        borderType: BorderType.RRect,
        dashPattern: const [3, 5],
        color: Colors.grey.shade500,
        strokeWidth: 1,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding16),
          width: AddSize.screenWidth,
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: controller.productImage.path.isNotEmpty
              ? Container(
                  constraints: BoxConstraints(minHeight: 0, maxHeight: context.getSize.width * .36),
                  child: Image.file(
                    controller.productImage,
                    errorBuilder: (_, __, ___) => Image.network(
                      controller.productImage.path,
                      errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                    ),
                  ),
                )
              : Column(
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
                    SizedBox(
                      height: height * .01,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
