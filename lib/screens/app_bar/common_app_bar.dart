import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/profile_controller.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? titleText;
  final List<Widget>? actions;
  final Color? backGroundColor;
  final Color? textColor;
  final PreferredSizeWidget? bottom;
  const CommonAppBar({super.key, required this.titleText, this.actions, this.backGroundColor, this.textColor, this.bottom});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfileController());
    return AppBar(
      elevation: 0,
      surfaceTintColor: backGroundColor ?? Colors.white,
      backgroundColor: backGroundColor ?? Colors.white,
      leading: textColor != null
          ? IconButton(
              onPressed: () {
                Get.back();
              },
        icon: Image.asset(
          'assets/images/back_icon_new.png',
          height: 19,
          width: 19,
        ),
      )
          : Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Hero(
                tag: "backButton",
                child: Material(
                  color: Colors.transparent,
                  surfaceTintColor: Colors.transparent,
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon:  profileController.selectedLAnguage.value != 'English' ?
                    Image.asset(
                      'assets/images/forward_icon.png',
                      height: 19,
                      width: 19,
                    ) :
                    Image.asset(
                      'assets/images/back_icon_new.png',
                      height: 19,
                      width: 19,
                    ),
                  ),
                ),
              ),
            ),
      title: Text(
        titleText!.tr,
        style: GoogleFonts.poppins(color: textColor ?? Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
      ),
      actions: [...actions ?? []],
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => bottom == null ?  const Size(double.maxFinite, kToolbarHeight) : bottom!.preferredSize;
}
