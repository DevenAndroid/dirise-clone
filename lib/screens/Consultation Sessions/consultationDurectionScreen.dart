import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConsultationDurectionScreen extends StatefulWidget {
  const ConsultationDurectionScreen({super.key});

  @override
  State<ConsultationDurectionScreen> createState() => _ConsultationDurectionScreenState();
}

class _ConsultationDurectionScreenState extends State<ConsultationDurectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sponsors'),
        leading: GestureDetector(
          onTap: (){
            Get.back();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/back_icon_new.png',
                height: 19,
                width: 19,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
