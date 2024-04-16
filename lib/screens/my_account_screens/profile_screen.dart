import 'package:cached_network_image/cached_network_image.dart';
import 'package:dirise/language/app_strings.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/profile_controller.dart';
import 'editprofile_screen.dart';

class ProfileScreen extends StatefulWidget {
  static String route = "/ProfileScreen";
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    profileController.getDataProfile();
    profileController.getCountryList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.myProfile1.tr,
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: AppTheme.buttonColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (profileController.refreshInt.value > 0) {}
        return profileController.apiLoaded
            ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: profileCircleColor, width: 1.2)),
                                  height: 140,
                                  width: 140,
                                ).animate().scale(
                                    duration: const Duration(seconds: 1),
                                    begin: const Offset(0.6, 0.6),
                                    end: const Offset(1, 1)),
                                // if(false)
                                Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: profileCircleColor, width: 1.2)),
                                  height: 125,
                                  width: 125,
                                ).animate(delay: const Duration(milliseconds: 800)).fade(delay: 200.ms).then().scale(
                                    duration: const Duration(milliseconds: 600),
                                    begin: const Offset(1.12, 1.12),
                                    end: const Offset(1, 1)),
                                // if(false)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10000),
                                  child: SizedBox(
                                    height: 110,
                                    width: 110,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(100)),
                                        color: AppTheme.primaryColor,
                                      ),
                                      child: ClipOval(
                                        child: CachedNetworkImage(
                                          width: 120,
                                          height: 120,
                                          fit: BoxFit.cover,
                                          imageUrl: profileController.model.user!.profileImage.toString(),
                                          placeholder: (context, url) => const SizedBox(),
                                          errorWidget: (context, url, error) => const SizedBox(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                // SizedBox(
                                //   width: 140,
                                //   child: Row(
                                //     mainAxisAlignment: MainAxisAlignment.end,
                                //     children: [
                                //       SvgPicture.asset("assets/svgs/profile_edit.svg"),
                                //       const SizedBox(
                                //         width: 4,
                                //       )
                                //     ],
                                //   ),
                                // )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 18),
                      ...profileCard(
                        imagePath: "assets/svgs/profile.svg",
                        title: AppStrings.firstName.tr,
                        value: profileController.model.user!.firstName.toString(),
                      ),
                      ...profileCard(
                        imagePath: "assets/svgs/profile.svg",
                        title: AppStrings.lastName.tr,
                        value: profileController.model.user!.lastName.toString(),
                      ),
                      ...profileCard(
                        imagePath: "assets/svgs/email.svg",
                        title: AppStrings.email.tr,
                        value: profileController.model.user!.email.toString(),
                      ),
                      ...profileCard(
                        imagePath: "assets/svgs/referral_img.svg",
                        title: AppStrings.referralEmail.tr,
                        value: profileController.model.user!.referralEmail.toString(),
                      ),
                      ...profileCard(
                        imagePath: "assets/svgs/location.svg",
                        title: AppStrings.streetAddress.tr,
                        value: profileController.model.user!.street_name.toString(),
                      ),
                      ...profileCard(
                        imagePath: "assets/svgs/city.svg",
                        title: AppStrings.stateCity.tr,
                        value: "${profileController.model.user!.state_name}, ${profileController.model.user!.city_name}",
                      ),
                      ...profileCard(
                        imagePath: "assets/svgs/country.svg",
                        title: AppStrings.country.tr,
                        value: profileController.model.user!.country_name.toString(),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: size.height * .07,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.buttonColor,
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                              textStyle: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                              )),
                          onPressed: () {
                            Get.toNamed(EditProfileScreen.route);
                          },
                          child: Text(
                           AppStrings.editProfile.tr,
                            style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : const Center(child: CircularProgressIndicator());
      }),
    );
  }

  List<Widget> profileCard({
    required String imagePath,
    required String title,
    required String value,
}) {
    return [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
            width: 50,
            child: SvgPicture.asset(imagePath),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: const Color(0xff454545),
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  value,
                  style: GoogleFonts.poppins(color: const Color(0xff21181A), fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          )
        ],
      ),
      const SizedBox(
        height: 8,
      ),
      const Divider(
        color: Color(0xffEFEFEF),
      ),
      const SizedBox(
        height: 8,
      ),
    ];
  }
}
