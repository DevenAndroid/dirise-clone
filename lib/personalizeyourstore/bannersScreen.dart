import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dirise/iAmHereToSell/personalizeyourstoreScreen.dart';
import 'package:dirise/utils/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/vendor_models/model_vendor_details.dart';
import '../repository/repository.dart';
import '../utils/api_constant.dart';
import '../vendor/authentication/image_widget.dart';
import '../widgets/common_button.dart';

class BannersScreen extends StatefulWidget {
  const BannersScreen({super.key});

  @override
  State<BannersScreen> createState() => _BannersScreenState();
}

class _BannersScreenState extends State<BannersScreen> {
  File idProof = File("");
  bool checkValidation(bool bool1, bool2) {
    if (bool1 == true && bool2 == true) {
      return true;
    } else {
      return false;
    }
  }

  ModelVendorDetails model = ModelVendorDetails();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey categoryKey = GlobalKey();
  final GlobalKey idProofKey = GlobalKey();
  final Repositories repositories = Repositories();
  bool apiLoaded = false;
  RxInt refreshInt = 0.obs;

  get updateUI => refreshInt.value = DateTime.now().millisecondsSinceEpoch;

  Map<String, File> images = {};
  void updateProfile() {
    Map<String, String> map = {};
    images["banner_profile"] = idProof;

    repositories
        .multiPartApi(
            mapData: map,
            images: images,
            context: context,
            url: ApiUrls.editVendorDetailsUrl,
            onProgress: (int bytes, int totalBytes) {})
        .then((value) {
      Get.to(const PersonalizeyourstoreScreen());
      showToast('Add Banner successfully');
    });
  }

  Future getVendorDetails() async {
    await repositories.getApi(url: ApiUrls.getVendorDetailUrl).then((value) {
      model = ModelVendorDetails.fromJson(jsonDecode(value));
      setState(() {

      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVendorDetails();


  }

  RxBool showValidation = false.obs;
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
              'Banners'.tr,
              style: GoogleFonts.poppins(color: Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              ImageWidget(
                // key: paymentReceiptCertificateKey,
                title: "Banner".tr,
                file: idProof,
                validation: checkValidation(showValidation.value, idProof.path.isEmpty),
                filePicked: (File g) {
                  idProof = g;
                },
              ),
              CustomOutlineButton(
                title: 'Add Banners',
                onPressed: () {
                  if(idProof.path.isEmpty){
                    showToast('Please select Banner');
                  }else{
                    updateProfile();
                  }
                  
                },
              ),
          SizedBox(height: 30,),
          model.user != null ?
         CachedNetworkImage(
            imageUrl: model.user!.bannerProfile.toString(),
            errorWidget: (context, url, error) {
              return SizedBox.shrink();
            },
            height: 200,width: Get.width,) : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
