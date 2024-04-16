import 'dart:io';
import 'package:dirise/utils/api_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
      widget.filePicked(value);
      file = value;
      setState(() {});
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
            pickImage();
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
