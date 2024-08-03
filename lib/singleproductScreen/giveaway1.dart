import 'dart:convert';
import 'dart:io';

import 'package:dirise/addNewProduct/itemdetailsScreen.dart';
import 'package:dirise/controller/profile_controller.dart';
import 'package:dirise/utils/api_constant.dart';
import 'package:dirise/utils/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Services/whatServiceDoYouProvide.dart';
import '../controller/vendor_controllers/add_product_controller.dart';
import '../iAmHereToSell/whichplantypedescribeyouScreen.dart';
import '../jobOffers/tellusaboutyourselfScreen.dart';
import '../language/app_strings.dart';
import '../model/common_modal.dart';
import '../newAddress/pickUpAddressScreen.dart';
import '../repository/repository.dart';
import '../singleproductScreen/product_information_screen.dart';
import '../widgets/common_button.dart';

class Giveway1Screen extends StatefulWidget {
  static String route = "/TellUsAboutYourSelf";
  File? featureImage;
  Giveway1Screen({Key? key,this.featureImage}) : super(key: key);

  @override
  State<Giveway1Screen> createState() => _Giveway1ScreenState();
}

class _Giveway1ScreenState extends State<Giveway1Screen> {
  String selectedRadio = '';
  final profileController = Get.put(ProfileController());

  List<String> itemTexts = [
    'working',
    'need_maintenance',
    'scrap',

  ];
  final Repositories repositories = Repositories();
  final addProductController = Get.put(AddProductController());
  addGiveAwayType() {
    Map<String, dynamic> map = {};
    map['id'] = addProductController.idProduct.value.toString();
    map['giveaway_item_condition'] = selectedRadio;

    FocusManager.instance.primaryFocus!.unfocus();
    repositories.postApi(url: ApiUrls.giveawayProductAddress, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      print('API Response Status Code: ${response.status}');
      showToast(response.message.toString());
      if (response.status == true) {
        navigateNext();
      }
    });
  }
  void navigateNext() {
    if (profileController.model.user!.isVendor == true) {
      // If user is a vendor, allow all radio buttons
      if (selectedRadio == 'working' ||
          selectedRadio == 'need_maintenance' ||
          selectedRadio == 'scrap') {
        Get.to(ItemDetailsScreens());
      } else {
        // Handle the case where the selected radio doesn't match any case
        showToast('Please select a valid option.');
      }
    } else {
      // If user is not a vendor, navigate to ItemDetailsScreens regardless of the selected radio
      Get.to(ItemDetailsScreens());
    }
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
              'My Item is a'.tr,
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              30.spaceY,
              GestureDetector(
                onTap: (){
                  selectedRadio = 'working';
                  addProductController.selectedRadio = selectedRadio;
                  addGiveAwayType();
                  setState(() {});
                },
                  child: Image.asset('assets/images/working_logo.png')),
              20.spaceY,
              GestureDetector(
                  onTap: (){
                    selectedRadio = 'need_maintenance';
                    addProductController.selectedRadio = selectedRadio;
                    addGiveAwayType();
                    setState(() {});
                  },
                  child: Image.asset('assets/images/need_maintenance.png')),
              20.spaceY,
              GestureDetector(
                  onTap: (){
                    selectedRadio = 'scrap';
                    addProductController.selectedRadio = selectedRadio;
                    addGiveAwayType();
                    setState(() {});
                  },
                  child: Image.asset('assets/images/scrap_img.png')),
              // Expanded(
              //   child: GridView.builder(
              //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 2,
              //       crossAxisSpacing: 5,
              //       mainAxisSpacing: 5,
              //       mainAxisExtent: 200,
              //       childAspectRatio: 2, // Aspect ratio can be adjusted
              //     ),
              //     itemCount: itemTexts.length, // Number of grid items
              //     itemBuilder: (BuildContext context, int index) {
              //       return buildStack(itemTexts[index]);
              //     },
              //   ),
              // ),


              // 30.spaceY,
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: GestureDetector(
              //     onTap: () {
              //       if(selectedRadio.isNotEmpty){
              //         navigateNext();
              //       }
              //       else{
              //         showToast('Please select any item type');
              //       }
              //     },
              //     child: Container(
              //       width: Get.width,
              //       height: 55,
              //       decoration: BoxDecoration(
              //         border: Border.all(
              //           color: Colors.black, // Border color
              //           width: 1.0, // Border width
              //         ),
              //         borderRadius: BorderRadius.circular(1), // Border radius
              //       ),
              //       padding: const EdgeInsets.all(10), // Padding inside the container
              //       child: const Center(
              //         child: Text(
              //           'Next',
              //           style: TextStyle(
              //             fontSize: 16,
              //             fontWeight: FontWeight.bold,
              //             color: Colors.black, // Text color
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStack(String text) {
    return Stack(
      children: [
        Container(
         width: Get.width,
          height: 300,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11),
            color: Colors.grey.shade100,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                text,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  color: Colors.black, // Text color
                ),
              ),
              SizedBox(height: 10,),

            ],
          ),
        ),
        Positioned(
          top: 2,
          right: 3,
          child: Radio(
            value: text,
            groupValue: selectedRadio,
            onChanged: (value) {
              setState(() {

                selectedRadio = value.toString();
              });
            },
          ),
        ),
      ],
    );
  }
}
