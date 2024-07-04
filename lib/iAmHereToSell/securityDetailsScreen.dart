import 'package:dirise/iAmHereToSell/paymentMethodScreen.dart';
import 'package:dirise/iAmHereToSell/requiredDocumentsScreen.dart';
import 'package:dirise/iAmHereToSell/vendoraccountcreatedsuccessfullyScreen.dart';
import 'package:dirise/utils/api_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/cart_controller.dart';
import '../controller/profile_controller.dart';
import '../widgets/common_button.dart';
import '../widgets/dimension_screen.dart';

class SecurityDetailsScreen extends StatefulWidget {
  const SecurityDetailsScreen({super.key});

  @override
  State<SecurityDetailsScreen> createState() => _SecurityDetailsScreenState();
}

class _SecurityDetailsScreenState extends State<SecurityDetailsScreen> {
  bool showValidation = false;
  bool? _isValue = false;


  final profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
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
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Security Details'.tr,
              style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20,),
              Text(
                'If your card have not been refunded then kindly call us at +965 6555 6490 and we should return this amount back'.tr,
                style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w500, fontSize: 13),
              ),
              const SizedBox(height: 20,),
              const Image(
                height: 100,
                width: double.maxFinite,
                image: AssetImage('assets/images/vectorone.png'),
                fit: BoxFit.contain,
                opacity: AlwaysStoppedAnimation(.80),
              ),
              const SizedBox(height: 20,),
              Text(
                'We use your credit card to limit  spam and theft.'.tr,
                style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w500, fontSize: 13),
              ),
              const SizedBox(height: 20,),
              const Image(
                height: 100,
                width: double.maxFinite,
                image: AssetImage('assets/images/vectortwo.png'),
                fit: BoxFit.contain,
                opacity: AlwaysStoppedAnimation(.80),
              ),
              const SizedBox(height: 20,),
              Text(
                'We will never charge for the free version.'.tr,
                style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w500, fontSize: 13),
              ),
              const SizedBox(height: 30,),
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
                      'I understood that dirise will never charge me and it’s only for security'.tr,
                      style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w500, fontSize: 13),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30,),
              CustomOutlineButton(
                title: "Next".tr,
                onPressed: () {
                  if(_isValue == true){
                    Get.to(const PaymentMethodScreen());
                  }else{
                    showToast('Please select security details'.tr);
                  }

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
