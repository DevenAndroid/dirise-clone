import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class WhichplantypedescribeyouScreen extends StatefulWidget {
  const WhichplantypedescribeyouScreen({super.key});

  @override
  State<WhichplantypedescribeyouScreen> createState() => _WhichplantypedescribeyouScreenState();
}

class _WhichplantypedescribeyouScreenState extends State<WhichplantypedescribeyouScreen> {

  bool showValidation = false;
  bool? _isValue = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: const Icon(
          Icons.arrow_back_ios_new,
          color: Color(0xff0D5877),
          size: 16,
        ),
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Which plan type describe you?'.tr,
              style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 20,right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                'Individuals:'.tr,
                style: GoogleFonts.poppins(color: const Color(0xff0D5877), fontWeight: FontWeight.w600, fontSize: 16),
              ),
              Text(
                'Limited to advertising only, any payments will be done outside the platform.'.tr,
                style: GoogleFonts.poppins(color: const Color(0xff514949), fontWeight: FontWeight.w400, fontSize: 13),
              ),
              Text(
                'Startups:'.tr,
                style: GoogleFonts.poppins(color: const Color(0xff0D5877), fontWeight: FontWeight.w600, fontSize: 16),
              ),
              Text(
                'For start ups that want to sell their products in the Dirise platform.'.tr,
                style: GoogleFonts.poppins(color: const Color(0xff514949), fontWeight: FontWeight.w400, fontSize: 13),
              ),
              Text(
                'Enterprise:'.tr,
                style: GoogleFonts.poppins(color: const Color(0xff0D5877), fontWeight: FontWeight.w600, fontSize: 16),
              ),
              Text(
                'For companies with commercial license and corporate bank account.'.tr,
                style: GoogleFonts.poppins(color: const Color(0xff514949), fontWeight: FontWeight.w400, fontSize: 13),
              ),
              SizedBox(height: 20,),
              Text(
                'Click here for Full comparison'.tr,
                style: GoogleFonts.poppins(color: const Color(0xff0D5877), fontWeight: FontWeight.w400, fontSize: 16),
              ),
              SizedBox(height: 20,),
              Container(
                width: Get.width,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade200
                ),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Individuals:'.tr,
                            style: GoogleFonts.poppins(color: const Color(0xff0D5877), fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                          Text(
                            'Advertising only'.tr,
                            style: GoogleFonts.poppins(color: const Color(0xff0D5877), fontWeight: FontWeight.w400, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    const Radio(
                      value: 1,
                      groupValue: 1,
                      onChanged: null,
                    ),
                  ],
                ),

              ),
              SizedBox(height: 20,),
              Container(
                width: Get.width,

                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade200
                ),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Startup stores'.tr,
                            style: GoogleFonts.poppins(color: const Color(0xff0D5877), fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                          Text(
                            'Just started the business journey'.tr,
                            style: GoogleFonts.poppins(color: const Color(0xff0D5877), fontWeight: FontWeight.w400, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    const Radio(
                      value: 1,
                      groupValue: 1,
                      onChanged: null,
                    ),
                  ],
                ),

              ),
              SizedBox(height: 20,),
              Container(
                width: Get.width,

                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade200
                ),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Individuals:'.tr,
                            style: GoogleFonts.poppins(color: const Color(0xff0D5877), fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                          Text(
                            'Advertising only'.tr,
                            style: GoogleFonts.poppins(color: const Color(0xff0D5877), fontWeight: FontWeight.w400, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    const Radio(
                      value: 1,
                      groupValue: 1,
                      onChanged: null,
                    ),
                  ],
                ),

              ),
              SizedBox(height: 20,),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Our Plans'.tr,
                  style: GoogleFonts.poppins(color: const Color(0xff014E70), fontWeight: FontWeight.w600, fontSize: 24),
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              Container(
                color: Colors.white,
                padding: EdgeInsets.all(20.0),
                child: Table(
                  border: TableBorder.all(color: Colors.black),
                  children: [
                    TableRow(children: [
                      Text('Cell 1'),
                      Text('Cell 2'),
                      Text('Cell 3'),
                      Text('Cell 3'),
                    ]),
                    TableRow(children: [
                      Text('Cell 4'),
                      Text('Cell 5'),
                      Text('Cell 6'),
                      Text('Cell 6'),
                    ])
                  ],
                ),
              ),




              Align(
                alignment: Alignment.center,
                child: Text(
                  'Contact  +965 6555 6490 if you need assistance'.tr,
                  style: GoogleFonts.poppins(color: const Color(0xff014E70), fontWeight: FontWeight.w400, fontSize: 10),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Transform.translate(
                    offset: const Offset(-6, 0),
                    child: Checkbox(
                        visualDensity: const VisualDensity(horizontal: -1, vertical: -3),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        value: _isValue,
                        side: BorderSide(
                          color: showValidation == false ? const Color(0xff0D5877) : Colors.red,
                        ),
                        onChanged: (bool? value) {
                          setState(() {
                            _isValue = value;
                          });
                        }),
                  ),
                  Expanded(
                    child: Text(
                      'I agree to DIRISE terms & conditions, privacy policy and DIRISE free program*'.tr,
                      style: GoogleFonts.poppins(color: const Color(0xff7B7D7C), fontWeight: FontWeight.w500, fontSize: 13),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: Get.width,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xff0D5877), // Border color
                    width: 1.0, // Border width
                  ),
                  borderRadius: BorderRadius.circular(2), // Border radius
                ),
                padding: const EdgeInsets.all(10), // Padding inside the container
                child: const Center(
                  child: Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Text color
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
