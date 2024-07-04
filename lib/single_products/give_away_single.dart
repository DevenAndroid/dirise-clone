import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/profile_controller.dart';
class GiveAwayProduct extends StatefulWidget {
  const GiveAwayProduct({super.key});

  @override
  State<GiveAwayProduct> createState() => _GiveAwayProductState();
}

class _GiveAwayProductState extends State<GiveAwayProduct> {
  final profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  backgroundColor: Colors.white,
  surfaceTintColor: Colors.white,
  elevation: 0,
  leading:Row(
    children: [
      GestureDetector(
        onTap: (){
          Get.back();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            profileController.selectedLAnguage.value != 'English' ?
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
          ],
        ),
      ),
      InkWell(
        onTap: () {
          // setState(() {
          //   search.value = !search.value;
          // });
        },
        child: SvgPicture.asset(
          'assets/svgs/search_icon_new.svg',
          width: 38,
          height: 38,
          // color: Colors.white,
        ),
        // child : Image.asset('assets/images/search_icon_new.png')
      ),
    ],
  ),

  titleSpacing: 0,

)
    );
  }
}
