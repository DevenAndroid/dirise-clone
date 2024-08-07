import 'package:cached_network_image/cached_network_image.dart';
import 'package:dirise/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../../addNewProduct/addProductStartScreen.dart';
import '../../controller/home_controller.dart';
import '../../controller/profile_controller.dart';
import '../auth_screens/login_screen.dart';

class AdBannerUI extends StatefulWidget {
  const AdBannerUI({super.key});

  @override
  State<AdBannerUI> createState() => _AdBannerUIState();
}

class _AdBannerUIState extends State<AdBannerUI> {
  final homeController = Get.put(TrendingProductsController());
  final profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return homeController.homeModal.value.home != null && homeController.popularProdModal.value.product != null
          ? Column(
              children: [
                const SizedBox(height: 30,),
                GestureDetector(
                  onTap: () {
                    if (profileController.userLoggedIn) {
                      Get.to(const AddProductOptionScreen());
                    } else {
                      Get.to(const LoginScreen());
                    }
                  },
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 12),
                      child: SizedBox(
                        child: CachedNetworkImage(
                          imageUrl: homeController.homeModal.value.home!.bannerImg.toString(),
                          fit: BoxFit.cover,
                          width: context.getSize.width,
                        ),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ).animate().fade(duration: 300.ms)
          : const SizedBox.shrink();
    });
  }
}
