import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../screens/tell_us_about_yourself.dart';
import 'addProductFirstImageScreen.dart';

class AddProductOptionScreen extends StatefulWidget {
  const AddProductOptionScreen({super.key});

  @override
  State<AddProductOptionScreen> createState() => _AddProductOptionScreenState();
}

class _AddProductOptionScreenState extends State<AddProductOptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 100,),
            InkWell(
              onTap: (){
                Get.to(const AddProductFirstImageScreen());
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                width: Get.width,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(11), color: Colors.grey.shade200),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Single products',
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500, color: Color(0xff272E41)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'I want to add a single product at a time',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Color(0xff272E41)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: (){
                Get.to(()=> const TellUsYourSelfScreen());
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                width: Get.width,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(11), color: Colors.grey.shade200),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Multiple products',
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500, color: Color(0xff272E41)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'I want to add Multiple Product',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Color(0xff272E41)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
