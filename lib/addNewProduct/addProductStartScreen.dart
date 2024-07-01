import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../controller/profile_controller.dart';
import '../screens/tell_us_about_yourself.dart';
import '../vendor/products/multiple_Product_screen.dart';
import 'addProductFirstImageScreen.dart';

class AddProductOptionScreen extends StatefulWidget {
  const AddProductOptionScreen({super.key});

  @override
  State<AddProductOptionScreen> createState() => _AddProductOptionScreenState();
}

class _AddProductOptionScreenState extends State<AddProductOptionScreen> {
  final profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
        centerTitle: true,
        leading: GestureDetector(
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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 100,),
            // InkWell(
            //   onTap: (){
            //     Get.to(const AddProductFirstImageScreen());
            //   },
            //   child: Container(
            //     padding: const EdgeInsets.all(15),
            //     width: Get.width,
            //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(11), color: Colors.grey.shade200),
            //     child: const Column(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text(
            //           'Single products',
            //           style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500, color: Color(0xff272E41)),
            //         ),
            //         SizedBox(
            //           height: 20,
            //         ),
            //         Text(
            //           'I want to add a single product at a time',
            //           style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Color(0xff272E41)),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            GestureDetector(
              onTap: (){
                Get.to(const AddProductFirstImageScreen());
              },
              child: Image.asset('assets/images/single.png'),
            ),
            const SizedBox(
              height: 40,
            ),
            // InkWell(
            //   onTap: (){
            //     Get.to(()=> const AddMultipleProductScreen());
            //   },
            //   child: Container(
            //     padding: const EdgeInsets.all(15),
            //     width: Get.width,
            //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(11), color: Colors.grey.shade200),
            //     child: const Column(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text(
            //           'Multiple products',
            //           style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500, color: Color(0xff272E41)),
            //         ),
            //         SizedBox(
            //           height: 20,
            //         ),
            //         Text(
            //           'I want to add Multiple Product',
            //           style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Color(0xff272E41)),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            GestureDetector(
              onTap: (){
                Get.to(()=> const AddMultipleProductScreen());
              },
              child: Image.asset('assets/images/multiple.png'),
            ),
          ],
        ),
      ),
    );
  }
}
