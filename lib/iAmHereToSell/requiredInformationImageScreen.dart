import 'dart:io';

import 'package:dirise/controller/profile_controller.dart';
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

class RequiredDoucmentFile extends StatefulWidget {
  const RequiredDoucmentFile({super.key});

  @override
  State<RequiredDoucmentFile> createState() => _RequiredDoucmentFileState();
}

class _RequiredDoucmentFileState extends State<RequiredDoucmentFile> {
  final controller = Get.put(AddProductController());
  final profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Column(
      children: [


      ],
    );
  }

}
