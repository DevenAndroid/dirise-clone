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
      if (sizeInMb > 10){
        showToast("Document must be smaller then 10 Mb".tr);
        return;
      }
      if (widget.imageOnly == false && !value.path.endsWith('.mp4')) {
        showToast("Please select a video file".tr);
        return;
      }
      widget.filePicked(value);
      file = value;
      setState(() {});
    });
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
              Helpers.addImagePicker(imageSource: ImageSource.camera, imageQuality: 75).then((value) async {
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
                    ),
                    WebUiSettings(
                      context: context,
                    ),
                  ],
                );
                if (croppedFile != null) {
                  file = File(croppedFile.path);
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
                    ),
                    WebUiSettings(
                      context: context,
                    ),
                  ],
                );
                if (croppedFile != null) {
                  file = File(croppedFile.path);
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
            showActionSheet(context);
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
                        "${'Select'} ${widget.title}",
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
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500, color: const Color(0xff2F2F2F), fontSize: 16),
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
                Text(
                  "${'Select'} ${widget.title}",
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
                : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.upload),
                Text(file.path.toString().split("/").last)
              ],
            ),
          ),
        ),
        14.spaceY,
      ],
    );
  }
}