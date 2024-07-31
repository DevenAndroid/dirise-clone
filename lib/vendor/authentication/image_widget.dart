import 'dart:io';
import 'package:dirise/utils/api_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../../utils/helper.dart';
import '../../widgets/dimension_screen.dart';

class ImageWidget extends StatefulWidget {
  const ImageWidget(
      {super.key,
      required this.file,
      required this.title,
      required this.validation,
      required this.filePicked,
      this.imageOnly});
  final File file;
  final String title;
  final bool validation;
  final bool? imageOnly;
  final Function(File file) filePicked;

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  File file = File("");

  bool get validation => widget.validation
      ? file.path.isNotEmpty
          ? false
          : widget.validation
      : false;

  pickImage() {
    if (widget.imageOnly == true) {
      NewHelper.showImagePickerSheet(
          context: context,
          gotImage: (File value) {
            widget.filePicked(value);
            file = value;
            setState(() {});
            return;
          });
      return;
    }
    NewHelper().addFilePicker().then((value) {
      if (value == null) return;

      int sizeInBytes = value.lengthSync();
      double sizeInMb = sizeInBytes / (1024 * 1024);
      if (sizeInMb > 10) {
        showToast("Document must be smaller then 10 Mb".tr);
        return;
      }
      if (widget.imageOnly == false &&
          !value.path.endsWith('.mp4') &&
          !value.path.endsWith('.pdf') &&
          !value.path.endsWith('.xlsx')) {
        showToast("Please select a correct type of file".tr);
        return;
      }
      widget.filePicked(value);
      file = value;
      setState(() {});
    });
  }

  Future<void> pickImagesNew() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Files'),
                onTap: () async {
                  Get.back();
                  if (widget.imageOnly == true) {
                    NewHelper.showImagePickerSheet(
                        context: context,
                        gotImage: (File value) {
                          widget.filePicked(value);
                          file = value;
                          setState(() {});
                          return;
                        });
                    return;
                  }
                  NewHelper().addFilePicker().then((value) {
                    if (value == null) return;

                    int sizeInBytes = value.lengthSync();
                    double sizeInMb = sizeInBytes / (1024 * 1024);
                    if (sizeInMb > 10) {
                      showToast("Document must be smaller then 10 Mb".tr);
                      return;
                    }
                    if (widget.imageOnly == false &&
                        !value.path.endsWith('.mp4') &&
                        !value.path.endsWith('.pdf') &&
                        !value.path.endsWith('.xlsx')) {
                      showToast("Please select a correct type of file".tr);
                      return;
                    }
                    widget.filePicked(value);
                    file = value;
                    setState(() {});
                  });
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
                onTap: () async {
                  Get.back();
                  final pickedFile = await ImagePicker().pickImage(
                    source: ImageSource.camera,
                    imageQuality: 80,
                  );
                  if (pickedFile != null) {
                    setState(() {
                      file = File(pickedFile.path);
                    });
                    widget.filePicked(file);
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.cancel),
                title: Text('Cancel'),
                onTap: () {
                  Get.back();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    file = widget.file;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        8.spaceY,
        Text(
          widget.title,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w500, color: const Color(0xff2F2F2F), fontSize: 16),
        ),
        8.spaceY,
        GestureDetector(
          onTap: () {
            // pickImage();
            pickImagesNew();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding16),
            width: AddSize.screenWidth,
            height: context.getSize.width * .38,
            decoration: BoxDecoration(
                color: const Color(0xffE2E2E2).withOpacity(.4),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: !validation ? Colors.grey.shade300 : Colors.red,
                )),
            child: file.path == ""
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${'Select'.tr} ${widget.title}",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: validation ? Theme.of(context).colorScheme.error : const Color(0xff463B57),
                            fontSize: 15),
                      ),
                      SizedBox(
                        height: AddSize.size10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: validation ? Theme.of(context).colorScheme.error : Colors.grey,
                              width: 1.8,
                            )),
                        padding: const EdgeInsets.all(6),
                        child: Icon(
                          Icons.upload_file_outlined,
                          size: 24,
                          color: validation ? Theme.of(context).colorScheme.error : Colors.grey,
                        ),
                      )
                    ],
                  )
                : Image.file(
                    file,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => Image.network(
                      file.path,
                      errorBuilder: (_, __, ___) => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.upload),
                          Text(
                            file.path.toString().split("/").last,
                          )
                        ],
                      ),
                    ),
                  ),
          ),
        ),
        14.spaceY,
      ],
    );
  }
}

class ImageWidget1 extends StatefulWidget {
  const ImageWidget1(
      {super.key,
      required this.file,
      required this.title,
      required this.validation,
      required this.filePicked,
      this.imageOnly});
  final File file;
  final String title;
  final bool validation;
  final bool? imageOnly;
  final Function(File file) filePicked;

  @override
  State<ImageWidget1> createState() => _ImageWidget1State();
}

class _ImageWidget1State extends State<ImageWidget1> {
  File file = File("");

  bool get validation => widget.validation
      ? file.path.isNotEmpty
          ? false
          : widget.validation
      : false;

  pickFile() {
    NewHelper().addFilePicker().then((value) {
      if (value == null) return;

      // List of allowed file extensions
      List<String> allowedExtensions = ['.csv', '.xlsx', '.xls'];

      // Check if the file has an allowed extension
      String fileExtension = value.path.split('.').last;
      if (allowedExtensions.contains('.$fileExtension')) {
        int sizeInBytes = value.lengthSync();
        double sizeInMb = sizeInBytes / (1024 * 1024);
        if (sizeInMb > 10) {
          showToast("Document must be smaller than 10 MB".tr);
          return;
        }
        widget.filePicked(value);
        file = value;
        setState(() {});
      } else {
        showToast("Please upload a CSV, XLSX, or XLS file.".tr);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    file = widget.file;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        8.spaceY,
        Text(
          widget.title,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w500, color: const Color(0xff2F2F2F), fontSize: 16),
        ),
        8.spaceY,
        GestureDetector(
          onTap: () {
            pickFile();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding16),
            width: AddSize.screenWidth,
            height: context.getSize.width * .38,
            decoration: BoxDecoration(
                color: const Color(0xffE2E2E2).withOpacity(.4),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: !validation ? Colors.grey.shade300 : Colors.red,
                )),
            child: file.path == ""
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Text(
                      //   "${'Select'} ${widget.title}",
                      //   style: GoogleFonts.poppins(
                      //       fontWeight: FontWeight.w500,
                      //       color: validation ? Theme.of(context).colorScheme.error : const Color(0xff463B57),
                      //       fontSize: 15),
                      // ),
                      // SizedBox(
                      //   height: AddSize.size10,
                      // ),
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: validation ? Theme.of(context).colorScheme.error : Colors.grey,
                              width: 1.8,
                            )),
                        padding: const EdgeInsets.all(6),
                        child: Icon(
                          Icons.upload_file_outlined,
                          size: 40,
                          color: validation ? Theme.of(context).colorScheme.error : Colors.grey,
                        ),
                      )
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [const Icon(Icons.upload), Text(file.path.toString().split("/").last)],
                  ),
          ),
        ),
        14.spaceY,
      ],
    );
  }
}

class ProductImageWidget extends StatefulWidget {
  const ProductImageWidget(
      {super.key,
      required this.file,
      required this.title,
      required this.validation,
      required this.filePicked,
      this.imageOnly});
  final File file;
  final String title;
  final bool validation;
  final bool? imageOnly;
  final Function(File file) filePicked;

  @override
  State<ProductImageWidget> createState() => _ProductImageWidgetState();
}

class _ProductImageWidgetState extends State<ProductImageWidget> {
  File file = File("");

  bool get validation => widget.validation
      ? file.path.isNotEmpty
          ? false
          : widget.validation
      : false;

  Future<void> _cropImage(File pickedFile) async {
    final CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
    );

    if (croppedFile != null) {
      final File file = File(croppedFile.path);
      widget.filePicked(file);
      setState(() {
        this.file = file;
      });
    }
  }

  Future<void> pickImagesNew() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Files'),
                onTap: () async {
                  Get.back();
                  final pickedFile = await ImagePicker().pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 80,
                  );
                  if (pickedFile != null) {
                    _cropImage(File(pickedFile.path));
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
                onTap: () async {
                  Get.back();
                  final pickedFile = await ImagePicker().pickImage(
                    source: ImageSource.camera,
                    imageQuality: 80,
                  );
                  if (pickedFile != null) {
                    _cropImage(File(pickedFile.path));
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.cancel),
                title: Text('Cancel'),
                onTap: () {
                  Get.back();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    file = widget.file;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        Text(
          widget.title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            color: const Color(0xff2F2F2F),
            fontSize: 16,
          ),
        ),
        SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            pickImagesNew();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding16),
            width: AddSize.screenWidth,
            height: context.getSize.width * .38,
            decoration: BoxDecoration(
              color: const Color(0xffE2E2E2).withOpacity(.4),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: !validation ? Colors.grey.shade300 : Colors.red,
              ),
            ),
            child: file.path == ""
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Text(
                      //   "${'Select'.tr} ${widget.title}",
                      //   style: GoogleFonts.poppins(
                      //     fontWeight: FontWeight.w500,
                      //     color: validation ? Theme.of(context).colorScheme.error : const Color(0xff463B57),
                      //     fontSize: 15,
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: AddSize.size10,
                      // ),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: validation ? Theme.of(context).colorScheme.error : Colors.grey,
                            width: 1.8,
                          ),
                        ),
                        padding: const EdgeInsets.all(6),
                        child: Icon(
                          Icons.upload_file_outlined,
                          size: 40,
                          color: validation ? Theme.of(context).colorScheme.error : Colors.grey,
                        ),
                      )
                    ],
                  )
                : Image.file(
                    file,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => Image.network(
                      file.path,
                      errorBuilder: (_, __, ___) => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.upload),
                          Text(
                            file.path.toString().split("/").last,
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ),
        SizedBox(height: 14),
      ],
    );
  }
}
