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
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.arrow_back_ios_new)),
      ),
    );
  }
}
