import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dirise/iAmHereToSell/requiredDocumentsScreen.dart';
import 'package:dirise/iAmHereToSell/securityDetailsScreen.dart';
import 'package:dirise/personalizeyourstore/returnpolicyScreen.dart';
import 'package:dirise/screens/my_account_screens/return_policy_screen.dart';
import 'package:dirise/utils/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/profile_controller.dart';
import '../controller/service_controller.dart';
import '../model/common_modal.dart';
import '../model/vendor_models/model_vendor_details.dart';
import '../newAddress/customeraccountcreatedsuccessfullyScreen.dart';
import '../personalizeyourstore/bannersScreen.dart';
import '../personalizeyourstore/differentPolicyScreen.dart';
import '../personalizeyourstore/operatinghourScreen.dart';
import '../personalizeyourstore/personalizeAddressScreen.dart';
import '../personalizeyourstore/socialMediaScreen.dart';
import '../personalizeyourstore/vendorinformationScreen.dart';
import '../repository/repository.dart';
import '../screens/check_out/address/add_address.dart';
import '../screens/return_policy.dart';
import '../screens/vendorinformation_screen.dart';
import '../utils/api_constant.dart';
import '../vendor/dashboard/store_open_time_screen.dart';
import '../widgets/common_button.dart';
import '../widgets/common_colour.dart';
import '../widgets/common_textfield.dart';

class PersonalizeyourstoreScreen extends StatefulWidget {
  const PersonalizeyourstoreScreen({super.key});

  @override
  State<PersonalizeyourstoreScreen> createState() => _PersonalizeyourstoreScreenState();
}

class _PersonalizeyourstoreScreenState extends State<PersonalizeyourstoreScreen> {
  bool showValidation = false;
  bool showValidationImg = false;
  Rx<List<File>> images = Rx<List<File>>([]);
  Rx<File> categoryFile = File("").obs;
  String? categoryValue;
  void showActionSheet(BuildContext context) async {
    File? selectedImage = await Helpers.addImagePicker();
    if (selectedImage != null) {
      setState(() {
        controller.image1 = selectedImage;
      });
    }
  }

  final controller = Get.put(ServiceController());
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

  Map<String, File> picture = {};
  void updateProfile() {
    Map<String, String> map = {};
    map['store_banner_desccription'] =  controller.detailsController.text;
    picture["store_logo"] = controller.image1;

    repositories
        .multiPartApi(
        mapData: map,
        images: picture,
        context: context,
        url: ApiUrls.editVendorDetailsUrl,
        onProgress: (int bytes, int totalBytes) {

        })
        .then((value) {
      if(controller.detailsController.text.isNotEmpty){
        Get.to(RequiredDocumentsScreen());
      }
      else{
        showToast('please enter details'.tr);
      }

    });
  }
  final profileController = Get.put(ProfileController());
 @override
  void initState() {
    super.initState();
    profileController.getVendorDetails();
  }
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
              'Personalize your store'.tr,
              style: GoogleFonts.poppins(color: const Color(0xff292F45), fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, border: Border.all(color: profileCircleColor, width: 1.2)),
                    height: 140,
                    width: 140,
                  ).animate().scale(
                      duration: const Duration(seconds: 1), begin: const Offset(0.6, 0.6), end: const Offset(1, 1)),
                  // if(false)
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, border: Border.all(color: profileCircleColor, width: 1.2)),
                    height: 125,
                    width: 125,
                  ).animate(delay: const Duration(milliseconds: 1000)).fade(delay: 200.ms).then().scale(
                      duration: const Duration(milliseconds: 600),
                      begin: const Offset(1.12, 1.12),
                      end: const Offset(1, 1)),
                  // if(false)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10000),
                    child: SizedBox(
                      height: 110,
                      width: 110,
                      child: controller.image1.path.isNotEmpty
                          ? ClipOval(
                              child: Image.file(
                                controller.image1,
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                color: AppTheme.primaryColor,
                              ),
                              child: ClipOval(
                                child: controller.image1.path.isNotEmpty
                                    ? Image.file(
                                  controller.image1,
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.cover,
                                )
                                    : CachedNetworkImage(
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.cover,
                                  imageUrl: controller.image1.toString(),
                                  placeholder: (context, url) => const SizedBox(),
                                  errorWidget: (context, url, error) => const SizedBox(),
                                ),
                              ),
                            ),
                    ),
                  ),
                  SizedBox(
                    width: 140,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap :(){
                            showActionSheet(context);
                  },
                            child: SvgPicture.asset("assets/svgs/profile_edit.svg")),
                        const SizedBox(
                          width: 4,
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Store Logo'.tr,
                style: GoogleFonts.poppins(color: const Color(0xff808384), fontWeight: FontWeight.w400, fontSize: 14),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Tell us about your store'.tr,
                style: GoogleFonts.poppins(color: const Color(0xff1F1F1F), fontWeight: FontWeight.w400, fontSize: 14),
              ),
              const SizedBox(
                height: 10,
              ),
              CommonTextField(
                hintText: 'Details'.tr,
                controller: controller.detailsController,
                textInputAction: TextInputAction.done,
                // minLines: 2,
                // maxLines: 2,
              ),
              15.spaceY,
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: (){
                  Get.to(const SocialMediaStore());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Social media'.tr,
                      style: GoogleFonts.poppins(color: Colors.black, fontSize: 14),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 15,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Divider(
                thickness: 1,
                color: Colors.grey.shade300,
              ),
              const SizedBox(
                height: 5,
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: (){
                  Get.to(const SetTimeScreen());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Operating hour'.tr,
                      style: GoogleFonts.poppins(color: Colors.black, fontSize: 14),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 15,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Divider(
                thickness: 1,
                color: Colors.grey.shade300,
              ),
              const SizedBox(
                height: 5,
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: (){
                  Get.to(const VendorInformation());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Vendor information'.tr,
                      style: GoogleFonts.poppins(color: Colors.black, fontSize: 14),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 15,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Divider(
                thickness: 1,
                color: Colors.grey.shade300,
              ),
              const SizedBox(
                height: 5,
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: (){
                  Get.to(AddAddressScreen());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Addresses'.tr,
                      style: GoogleFonts.poppins(color: Colors.black, fontSize: 14),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 15,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Divider(
                thickness: 1,
                color: Colors.grey.shade300,
              ),
              const SizedBox(
                height: 5,
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: (){
                  Get.to(const BannersScreen());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Banners'.tr,
                      style: GoogleFonts.poppins(color: Colors.black, fontSize: 14),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 15,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Divider(
                thickness: 1,
                color: Colors.grey.shade300,
              ),
              const SizedBox(
                height: 5,
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: (){
                  Get.to(DifferentPolicyScreen());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select Policy'.tr,
                      style: GoogleFonts.poppins(color: Colors.black, fontSize: 14),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 15,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: (){
                  updateProfile();

                },
                child: Container(
                  width: Get.width,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xffF5F2F2),
                    borderRadius: BorderRadius.circular(2), // Border radius
                  ),
                  padding: const EdgeInsets.all(10), // Padding inside the container
                  child:  Center(
                    child: Text(
                      'Save'.tr,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff514949), // Text color
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomOutlineButton(
                title: "Skip".tr,
                onPressed: () {
                  Get.to(const RequiredDocumentsScreen());
                },
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
